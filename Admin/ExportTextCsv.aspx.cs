using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Web.Hosting;
using System.Linq;
using System.Data.OracleClient;
using System.Globalization;
using System.Data.OleDb;

public partial class ExportTextCsv : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetFilterValueDS();
            Master.HeadingMessage = "Export Data";

            if (!WebTools.UserInRole("ADMIN"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void btnUpdateDate_Click(object sender, EventArgs e)
    {
        if (DataTypeList.SelectedValue.ToString() == "1")
        {
            WebTools.ExecNonQuery("UPDATE PIP_ISOMETRIC SET EXPORT_DATE=TO_CHAR(SYSDATE, 'DD-MON-YYYY') WHERE EXPORT_DATE IS NULL AND PROJ_ID=" +
                Session["PROJECT_ID"].ToString() +
                " AND ISO_ID IN (SELECT DISTINCT ISO_ID FROM PIP_SPOOL)");
        }
        else
        {
            WebTools.ExecNonQuery("UPDATE PIP_SPOOL_JOINTS SET WELDING_EXPORT_DATE=TO_CHAR(SYSDATE, 'DD-MON-YYYY') " +
                "WHERE WELDING_EXPORT_DATE IS NULL AND JOINT_ID IN (SELECT JOINT_ID FROM PIP_SPOOL_WELDING)");

            WebTools.ExecNonQuery("UPDATE PIP_NDE_REQUEST_JOINTS SET NDE_EXPORT_DATE=TO_CHAR(SYSDATE, 'DD-MON-YYYY') " +
                "WHERE NDE_EXPORT_DATE IS NULL AND NDE_DATE IS NOT NULL");
        }

        Master.ShowSuccess("Update!");
    }

    private void SetFilterValVisible()
    {
        if (FilterByList.SelectedValue.ToString() == "2")
        {
            txtFilterValue.Visible = true;
            ddFilterValue.Visible = false;
        }
        else
        {
            txtFilterValue.Visible = false;
            ddFilterValue.Visible = true;
        }
    }
    
    private void SetFilterValueDS()
    {
        string sel_cmd = "";
        string val_fld = "";
        string txt_fld = "";
        bool over_all = false;

        SetFilterValVisible();

        switch (FilterByList.SelectedValue.ToString())
        {
            case "1":
                sel_cmd =
                    "SELECT EXPORT_DATE, to_char(EXPORT_DATE, 'dd-Mon-yyyy') AS EXPORT_DATE_TXT FROM VIEW_CMS_EXP_DATE ORDER BY EXPORT_DATE DESC";
                val_fld = "EXPORT_DATE";
                txt_fld = "EXPORT_DATE_TXT";
                break;

            case "2":
                //sel_cmd =
                //    "SELECT ISO_TITLE1 FROM PIP_ISOMETRIC " +
                //    "WHERE PROJ_ID=" + Session["PROJECT_ID"].ToString() + " ORDER BY ISO_TITLE1";
                //val_fld = "ISO_TITLE1";
                //txt_fld = "ISO_TITLE1";
                break;

            case "3":
                sel_cmd =
                    "SELECT SERIAL_NO FROM PIP_DWG_TRANS " +
                    "WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND PIP_DWG_TRANS.TRANS_CAT<>1 " +
                    "ORDER BY SERIAL_NO";
                val_fld = "SERIAL_NO";
                txt_fld = "SERIAL_NO";
                break;

            default:
                // do nothing
                over_all = true;
                break;
        }

        if (over_all)
        {
            ddFilterValue.Enabled = false;
        }
        else
        {
            ddFilterValue.Enabled = true;
            filterValDataSource.SelectCommand = sel_cmd;
            ddFilterValue.DataValueField = val_fld;
            ddFilterValue.DataTextField = txt_fld;
            ddFilterValue.DataBind();
        }
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (viewsListBox.SelectedIndex < 0)
        {
            Master.ShowMessage("Select an item from list of data!");
            return;
        }

        string ext_id = viewsListBox.SelectedValue.ToString();
        string sql_code;

        string FormatID = WebTools.GetExpr("FORMAT_ID", "EXTERNAL_DATA", "EXT_ID=" + ext_id);
        string DateWise = WebTools.GetExpr("DATE_WISE", "EXTERNAL_DATA", "EXT_ID=" + ext_id);
        string IsoWise = WebTools.GetExpr("ISO_WISE", "EXTERNAL_DATA", "EXT_ID=" + ext_id);
        string strFileName = WebTools.GetExpr("EXT_DATA", "EXTERNAL_DATA", "EXT_ID=" + ext_id);
        string strOrderBy = WebTools.GetExpr("ORDER_BY", "EXTERNAL_DATA", "EXT_ID=" + ext_id);

        string FilterByID = FilterByList.SelectedValue.ToString();

        string FilterValue;
        if (FilterByList.SelectedValue.ToString() == "2")
            FilterValue = txtFilterValue.Text;
        else
            FilterValue = ddFilterValue.SelectedItem.Text;

        // add date to file-name
        if (FilterByID == "1" && !string.IsNullOrEmpty(FilterValue))
            strFileName += " " + DateTime.Parse(ddFilterValue.SelectedValue.ToString()).ToString("yyyymmdd");

        if (FormatID == "1")
        {
            // Text
            strFileName = strFileName + ".txt";
            sql_code = WebTools.GetExpr("EXP_SQL", "VIEW_EXT_DATA_HD", "EXT_ID=" + ext_id);
        }
        else
        {
            // Excel
            strFileName = strFileName + ".xlsx";
            sql_code = WebTools.GetExpr("EXP_SQL_EXL", "VIEW_EXT_DATA_HD", "EXT_ID=" + ext_id);
        }

        if (DateWise == "Y" && FilterByID == "1")
        {
            sql_code += " AND EXPORT_DATE='" + FilterValue + "'";
        }
        else if (FilterByID == "2" && IsoWise == "Y")
        {
            sql_code += " AND ISO_TITLE1='" + FilterValue + "'";
        }
        else if (FilterByID == "3" && IsoWise == "Y")
        {
            sql_code += " AND DWG_TRANS_NO='" + FilterValue + "'";
        }

        if (strOrderBy != "")
            sql_code += " " + strOrderBy;


        string strFilePath = WebTools.SessionDataPath() + strFileName;

        if (FormatID == "1")
        {
            CreateTextFile(strFilePath, sql_code);
        }
        else if (FormatID == "2")
        {
            ExcelImport.ExportToExcelNopi(strFilePath, sql_code);
        }

        DownloadFile(strFilePath);
    }

    private void CreateTextFile(string file_name, string sql)
    {
        StreamWriter sr = new StreamWriter(file_name);
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sr.WriteLine(dr["TEXT_DATA"].ToString());
                    }
                } // dr
            } // cmd
        } // conn

        sr.Close();
        sr.Dispose();

    }

    protected void FilterByList_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetFilterValueDS();
    }

    private void DownloadFile(string file_path)
    {
        FileInfo file = new FileInfo(file_path);
        if (file.Exists)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Type", "application/Excel");
            Response.ContentType = "application/vnd.xls";
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.WriteFile(file.FullName);
            Response.End();
        }
        else
        {
            Response.Write("This file does not exist.");
        }

    }

    protected void DataTypeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            if (DataTypeList.SelectedValue.ToString() == "2")
            {
                FilterByList.Items[1].Enabled = false;
                FilterByList.Items[2].Enabled = false;
                FilterByList.SelectedIndex = 0;
            }
            else
            {
                FilterByList.Items[1].Enabled = true;
                FilterByList.Items[2].Enabled = true;
                FilterByList.SelectedIndex = 0;
            }

            SetFilterValueDS();
        }
    }

}