using System;
using System.Data;
using System.Data.OracleClient;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.IO;
using System.IO.Compression;
using Ionic.Zip;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Home_ExportData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Export Data";
        }
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (SetSqlDataSource() == true)
        {
            ExportToCSV(OutPutDataSource, FileName_HiddenField.Value.ToString());
            //WebTools.ExportDataSetToExcel(OutPutDataSource, FileName_HiddenField.Value.ToString()+".xls");
        }
    }

    private bool SetSqlDataSource()
    {
        try
        {
            if (ExportsListBox1.SelectedItems.Count <= 0)
            {
                Master.ShowMessage("Select an item to export!");
                return false;
            }

            FileName_HiddenField.Value = ExportsListBox1.SelectedItem.Text.Replace(" ", "_");

            string PROJ_FIELD_NAME = WebTools.GetExpr("PROJ_FIELD_NAME", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

            string EXPT_SQL = WebTools.GetExpr("EXPT_SQL", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

            // where
            if (EXPT_SQL.IndexOf("WHERE") > 0)
            {
                EXPT_SQL += " AND " + PROJ_FIELD_NAME + "=" + Session["PROJECT_ID"].ToString();
            }
            else
            {
                EXPT_SQL += " WHERE " + PROJ_FIELD_NAME + "=" + Session["PROJECT_ID"].ToString();
            }

            // order by
            string ORDER_BY = WebTools.GetExpr("ORDER_BY", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            if (!string.IsNullOrEmpty(ORDER_BY))
            {
                EXPT_SQL += " ORDER BY " + ORDER_BY;
            }

            OutPutDataSource.SelectCommand = EXPT_SQL;
            return true;
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
            return false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["BackUrl"] != null)
        {
            Response.Redirect(Request.QueryString["BackUrl"]);
        }
        else
        {
            Response.Redirect("~/Home/Default.aspx");
        }
    }

    public void ExportToCSV(SqlDataSource dataSrc, string fileName)
    {
        //Add Response header

        Response.Clear();
        Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.csv", fileName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        //GET Data From Database

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ");

        OracleCommand cmd = new OracleCommand(query, cn);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
            OracleDataReader dr = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();

            //CSV Header
            for (int count = 0; count < dr.FieldCount; count++)
            {
                if (dr.GetName(count) != null)
                    sb.Append(dr.GetName(count));
                if (count < dr.FieldCount - 1)
                {
                    sb.Append(",");
                }
            }
            Response.Write(sb.ToString() + "\n");
            Response.Flush();

            //CSV Body
            while (dr.Read())
            {
                sb = new StringBuilder();

                for (int col = 0; col < dr.FieldCount - 1; col++)
                {
                    if (!dr.IsDBNull(col))
                    {
                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(col).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " "));
                        }
                    }
                    sb.Append(",");
                }

                if (!dr.IsDBNull(dr.FieldCount - 1))
                {
                    if (!dr.IsDBNull(dr.FieldCount - 1))
                    {
                        if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(dr.FieldCount - 1).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " "));
                        }
                    }
                }

                Response.Write(sb.ToString() + "\n");
                Response.Flush();
            }
            dr.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
        }
        Response.End();
    }

    protected void exportsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        if (SetSqlDataSource() == true)
        {
            ExportToCSV_Zip(OutPutDataSource, FileName_HiddenField.Value.ToString());
        }
    }

    public void ExportToCSV_Zip(SqlDataSource dataSrc, string fileName)
    {
        string path = WebTools.SessionDataPath();
        string excel_file = path + fileName + ".csv";
        string zip_file = path + fileName + ".zip";

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ");

        OracleCommand cmd = new OracleCommand(query, cn);
        StreamWriter sr = new StreamWriter(excel_file);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
            OracleDataReader dr = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();

            //CSV Header
            for (int count = 0; count < dr.FieldCount; count++)
            {
                if (dr.GetName(count) != null)
                    sb.Append(dr.GetName(count));
                if (count < dr.FieldCount - 1)
                {
                    sb.Append(",");
                }
            }
            sr.WriteLine(sb.ToString());

            //CSV Body
            while (dr.Read())
            {
                sb = new StringBuilder();

                for (int col = 0; col < dr.FieldCount - 1; col++)
                {
                    if (!dr.IsDBNull(col))
                    {
                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(col).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " "));
                        }
                    }
                    sb.Append(",");
                }

                if (!dr.IsDBNull(dr.FieldCount - 1))
                {
                    if (!dr.IsDBNull(dr.FieldCount - 1))
                    {
                        if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(dr.FieldCount - 1).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " "));
                        }
                    }
                }

                sr.WriteLine(sb.ToString());
            }

            dr.Dispose();
            sr.Close();

            //ZipFile
            using (ZipFile zip = new ZipFile())
            {
                zip.AddFile(excel_file, "CSV");
                zip.Save(zip_file);

                Response.AppendHeader("content-disposition", "attachment; filename=" + fileName + ".zip");
                Response.ContentType = "application/zip";
                Response.WriteFile(zip_file);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
            sr.Dispose();
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.ToUpper().Trim();
    }
   
    protected void btnRDLC_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("~/Material/ReportViewerDynamic.aspx?ReportID=" + ExportsListBox1.SelectedValue.ToString() );


    }

    protected void ExportsListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        HyperLinkPreview.NavigateUrl = "~/Material/ReportViewerDynamic.aspx?ReportID=" + ExportsListBox1.SelectedValue.ToString();
    }
}
