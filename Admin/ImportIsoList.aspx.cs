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

public partial class Admin_ImportIsoList : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Iso List";

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
        WebTools.ExecNonQuery("DELETE FROM PIP_ISOMETRIC_IMPORT WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");

        ExcelImport.Import_Excel_File(FilePath, Extension, "PIP_ISOMETRIC_IMPORT", "PIP_ISOMETRIC_IMPORT_PK",
            "PROJECT_ID", Session["PROJECT_ID"].ToString());

        WebTools.ExecNonQuery("BEGIN PKG_IMPORT_ISO.PRC_IMPORT_ISO(" + proj_id + ");END;");
        
        Master.ShowSuccess("Isometric list imported!");
    } // method

}