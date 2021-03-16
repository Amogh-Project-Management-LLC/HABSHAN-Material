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
using NPOI.SS.UserModel;
using System.Collections.Generic;

public partial class ImportMSR : System.Web.UI.Page
{
    private long file_size = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import MSR";

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
        WebTools.ExecNonQuery("DELETE FROM PIP_MSR_IMPORT");
        WebTools.ExecNonQuery("DELETE FROM PIP_PO_DETAIL");
        WebTools.ExecNonQuery("DELETE FROM PIP_PO");

        FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

        ExcelImport.ImporNpoi(stream, "PIP_MSR_IMPORT", "", "PROJECT_ID", proj_id);

        WebTools.ExecNonQuery("DELETE PIP_MSR_IMPORT WHERE PO_NO='TEXT' OR AMD_NO='TEXT' OR MATERIAL_DESCRIPTION1='TEXT'");
        WebTools.ExecNonQuery("UPDATE PIP_MSR_IMPORT SET MATERIAL_DESCRIPTION1=UPPER(MATERIAL_DESCRIPTION1)");
        WebTools.ExecNonQuery("UPDATE PIP_MSR_IMPORT SET MATERIAL_DESCRIPTION2=UPPER(MATERIAL_DESCRIPTION2)");
        WebTools.ExecNonQuery("UPDATE PIP_MSR_IMPORT SET IDENT_CD=MATERIAL_DESCRIPTION1 WHERE IDENT_CD IS NULL AND MATERIAL_DESCRIPTION1 IS NOT NULL");
        WebTools.ExecNonQuery("DELETE PIP_MSR_IMPORT WHERE IDENT_CD IS NULL");
        
        WebTools.ExecNonQuery("BEGIN PKG_IMPORT_PO.APPEND_PO(" + proj_id + ");END;");

        Master.ShowSuccess("PO imported!");
    } // method

}