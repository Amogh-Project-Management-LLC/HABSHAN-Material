using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_POAddOnImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import Addon Material Details");
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            if (!FileUpload1.HasFile) return;

            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            FileUpload1.SaveAs(FilePath);

            if (RadioButtonList1.SelectedValue == "0")
            {
                // delete old data
                WebTools.ExecNonQuery("DELETE FROM PIP_PPCS_ADD_MAT WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
            }

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            ExcelImport.ImportDataTable(dt, "PIP_PPCS_ADD_MAT", "", "PROJECT_ID", proj_id);

            
            Master.show_success("Data Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}