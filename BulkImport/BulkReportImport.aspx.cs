using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class BulkImport_BulkReportImport : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Bulk Report Import<br/>(";
            Master.HeadingMessage += WebTools.GetExpr("IMP_REP_TITLE", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            Master.HeadingMessage += ")";

        }
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'");
        string sql = WebTools.GetExpr("GRID_SQL_TEXT", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        itemsDataSource.SelectCommand = sql.Replace("PARAM", user_id);
        sql = WebTools.GetExpr("IMP_ERR_LOG_SQL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        itemsErrorSource.SelectCommand = sql.Replace("PARAM", user_id);
        linkImportFormat.NavigateUrl = WebTools.GetExpr("SAMPLE_FILE_URL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        itemsGrid.DataBind();
    }

    protected void btnValidate_Click(object sender, EventArgs e)
    {

        if (!FileUpload1.HasFile) return;

        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        FileUpload1.SaveAs(FilePath);

        string tbl_name = WebTools.GetExpr("IMP_REP_TABLE", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " Upper(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
        string proj_field = WebTools.GetExpr("IMP_PROJ_ID_FIELD", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        // delete old data
        WebTools.ExecNonQuery("DELETE FROM " + tbl_name + " Where USER_ID = '" + user_id + "'");
        FileStream stream;
        DataTable dt;

        stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

        dt = new DataTable();
        dt = ExcelImport.xlsxToDT2(stream);

        dt.Columns.Add("USER_ID");
        foreach (DataRow r in dt.Rows)
        {
            r["USER_ID"] = user_id;
        }

        ExcelImport.ImportDataTable(dt, tbl_name, "", proj_field, proj_id);

        try
        {
            //WebTools.ExecNonQuery()
            string valid_pkg = WebTools.GetExpr("IMP_VALIDATE_PKG", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            string upd_pkg = WebTools.GetExpr("IMP_UPDATE_PKG", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);

            if (valid_pkg.Trim().Length > 0)
            {
                WebTools.ExecNonQuery("BEGIN " + valid_pkg + "(" + user_id + "); " +
                                                " END;");
            }

            if (upd_pkg.Trim().Length > 0)
            {
                WebTools.ExecNonQuery("BEGIN " + upd_pkg + "(" + user_id + "); " +
                                                " END;");
            }
            //string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'");
            string sql = WebTools.GetExpr("GRID_SQL_TEXT", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            itemsDataSource.SelectCommand = sql.Replace("PARAM", user_id);
            sql = WebTools.GetExpr("IMP_ERR_LOG_SQL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            itemsErrorSource.SelectCommand = sql.Replace("PARAM", user_id);
            linkImportFormat.NavigateUrl = WebTools.GetExpr("SAMPLE_FILE_URL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            itemsGrid.Rebind();

            string err_table = WebTools.GetExpr("IMP_REP_TABLE", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
            int totalRows = dt.Rows.Count - 1;
            int ErrorRows = int.Parse(WebTools.CountExpr("STATUS", err_table, " USER_ID = "+ user_id + "AND STATUS IS NOT NULL")); 
            if (ErrorRows > 0)
            {
                Master.ShowError("Total Records : " + totalRows + " <br/> Successful : " + (totalRows - ErrorRows) + "  <br/> Errors : " + ErrorRows);
            }
            else
            {
                Master.ShowMessage("Total Records : " + totalRows + " <br/> Successful : " + (totalRows - ErrorRows));
            }
            
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally
        {
            stream.Close();
            dt.Dispose();
        }
    }

    protected void btnErrlog_Click(object sender, EventArgs e)
    {
        string filename = WebTools.GetExpr("IMP_REP_TITLE", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        string sql = WebTools.GetExpr("IMP_ERR_LOG_SQL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'");
        itemsErrorSource.SelectCommand = sql.Replace("PARAM", user_id);
        WebTools.ExportDataSetToExcel(itemsErrorSource, filename + ".xls");
    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            item.BackColor = System.Drawing.Color.White;
            if (item["STATUS"].Text.Trim().Length > 6)
                item.BackColor = System.Drawing.Color.LightPink;
            else
                item.BackColor = System.Drawing.Color.White;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        string url = Request.QueryString["RetUrl"].ToString();
        Response.Redirect(url);
    }

}