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

public partial class ImportCmsMatAvlStatus : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import CMS Material Available Status";

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

    protected void btnImport_Click(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile) return;

        string proj_id = Session["PROJECT_ID"].ToString();

        string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        FileUpload1.SaveAs(FilePath);

        // delete old data
        WebTools.ExecNonQuery("DELETE FROM IMPORT_CMS_SPL_AVL WHERE PROJECT_ID IN (0, -1, " + Session["PROJECT_ID"].ToString() + ")");

        FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

        ExcelImport.ImporNpoi(stream, "IMPORT_CMS_SPL_AVL", "PK_IMPORT_CMS_SPL_AVL", "PROJECT_ID", proj_id);
        
        WebTools.ExecNonQuery("BEGIN PKG_IMPORT_CMS_SPL_AVL.UPDATE_SPOOL(" + Session["PROJECT_ID"].ToString() + ");END;");
        
        Master.ShowSuccess("CMS Material Available Status imported!");
    } // method

}