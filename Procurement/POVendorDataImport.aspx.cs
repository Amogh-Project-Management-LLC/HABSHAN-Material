using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POVendorDataImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import PO Vendor Data");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!FileUpload1.HasFile) return;

            if (RadAsyncUpload1.UploadedFiles.Count == 0)
            {
                Master.show_error("Please Upload File to proceed.");
                return;
            }


            string ImportOption = ImportOptions.SelectedValue;
            string proj_id = Session["PROJECT_ID"].ToString();
            //string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            //string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();
            string FileName = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].FileName);
            string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].FileName);
            string FilePath = FolderPath + FileName;
            //FileUpload1.SaveAs(FilePath);
            RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);
            // delete old data
            

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            switch (ImportOption)
            {
                case "ADD":
                    break;
                case "REPLACE":
                    DataView view = new DataView(dt);                    
                    DeleteExisting(view.ToTable(true, "IRN_NO"));
                    break;
                case "REIMPORT":
                    WebTools.ExecNonQuery("DELETE FROM PO_VENDOR_DATA WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
                    break;
            }

            dt.Columns.Add("CREATE_DATE");
            dt.Columns.Add("CREATE_BY");
            foreach (DataRow r in dt.Rows)
            {
                r["CREATE_DATE"] = System.DateTime.Today;
                r["CREATE_BY"] = Session["USER_NAME"];

            }
            ExcelImport.ImportDataTable(dt, "PO_VENDOR_DATA", "", "PROJECT_ID", proj_id);

            //WebTools.ExecNonQuery("BEGIN PKG_PAGE_VALIDATION.proc_update_idf_mto_data; END;");

            Master.show_success("Vendor Data Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void DeleteExisting(DataTable dt)
    {
        string sql;

        foreach (DataRow r in dt.Rows)
        {
            sql = "Delete from PO_VENDOR_DATA where IRN_NO = '" + r["IRN_NO"] + "'";
            WebTools.ExeSql(sql);
        }
    }
}