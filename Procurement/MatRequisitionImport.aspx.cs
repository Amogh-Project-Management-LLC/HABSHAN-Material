using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_MatRequisitionImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import MR Data");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (RadAsyncUpload1.UploadedFiles.Count == 0)
            {
                Master.show_error("Please Upload File to proceed.");
                return;
            }

            string proj_id = Session["PROJECT_ID"].ToString();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE USER_NAME ='" + Session["USER_NAME"] + "'");
            //string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            //string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();
            string FileName = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].FileName);
            string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].FileName);
            string FilePath = FolderPath + FileName;
            //FileUpload1.SaveAs(FilePath);
            RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);
            // delete old data
            WebTools.ExecNonQuery("DELETE FROM PIP_BULK_MR_IMPORT WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");



            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            dt.Columns.Add("USER_ID");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["USER_ID"] = user_id;
            }

            ExcelImport.ImportDataTable(dt, "PIP_BULK_MR_IMPORT", "", "PROJECT_ID", proj_id);

            WebTools.ExecNonQuery("BEGIN PKG_BULK_IMPORT.PROC_MR_IMPORT('" + user_id + "', 'ADD') ; END;");

            Master.show_success("MR Data Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}