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

public partial class ImportCccMTO : System.Web.UI.Page
{
    private long file_size = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import CCC Data";

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

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile) return;

        string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();
        string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

        string FilePath = FolderPath + FileName;
        FileUpload1.SaveAs(FilePath);

        string proj_id = Session["PROJECT_ID"].ToString();
        string msg = "";
        string sel_val = RadioButtonList1.SelectedItem.Value.ToString();
        if (sel_val == "1")
        {
            ImportCccBOM(Extension, FilePath, proj_id);
            msg = "Spoolgen MTO Imported";
        }
        else if (sel_val == "2")
        {
            ImportCccWelding(Extension, FilePath, proj_id);
            msg = "Spoolgen Welding Imported";
        }
        else if (sel_val == "3")
        {
            ImportCccSpool(Extension, FilePath, proj_id);
            msg = "Spoolgen Spool-data Imported";
        }

        Master.ShowSuccess(msg);
    }

    private void ImportCccBOM(string Extension, string FilePath, string proj_id)
    {
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_BOM WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");
        FileStream fs = new FileStream(FilePath, FileMode.Open);
        ExcelImport.ImporNpoi(fs, "CCC_IMPORT_BOM", "", "PROJECT_ID", proj_id);
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_BOM WHERE ISO_TITLE1='TEXT' OR ISONO='TEXT'");
        WebTools.ExecNonQuery("BEGIN PKG_CCC_IMPORT_MTO.PRC_IMPORT_BOM(" + proj_id + ");END;");
    }

    private void ImportCccWelding(string Extension, string FilePath, string proj_id)
    {
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_WELDING WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");
        FileStream fs = new FileStream(FilePath, FileMode.Open);
        ExcelImport.ImporNpoi(fs, "CCC_IMPORT_WELDING", "CCC_IMPORT_WELDING_UK1", "PROJECT_ID", proj_id);
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_WELDING WHERE ISO_TITLE1='TEXT' OR WELD_NO='TEXT'");
        WebTools.ExecNonQuery("BEGIN PKG_CCC_IMPORT_MTO.PRC_IMPORT_WELDING(" + proj_id + ");END;");
    }

    private void ImportCccSpool(string Extension, string FilePath, string proj_id)
    {
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_SPOOL WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");
        FileStream fs = new FileStream(FilePath, FileMode.Open);
        ExcelImport.ImporNpoi(fs, "CCC_IMPORT_SPOOL", "CCC_IMPORT_SPOOL_UK1", "PROJECT_ID", proj_id);
        WebTools.ExecNonQuery("DELETE FROM CCC_IMPORT_SPOOL WHERE ISO_TITLE1='TEXT' OR SPOOLNO='TEXT'");
        WebTools.ExecNonQuery("BEGIN PKG_CCC_IMPORT_MTO.PRC_IMPORT_SPL(" + proj_id + ");END;");
    }

}