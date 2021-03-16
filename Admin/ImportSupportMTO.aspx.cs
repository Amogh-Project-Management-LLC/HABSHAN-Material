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

public partial class ImportSupportMTO : System.Web.UI.Page
{
    private long file_size = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Support MTO";

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
        if(RadioButtonList1.SelectedItem.Value.ToString() == "1")
        {
            ImportSuppMTO(Extension, FilePath, proj_id);
            msg = "Support MTO Imported";
        }
        else
        {
            ImportSPS(Extension, FilePath, proj_id);
            msg = "SPS Support MTO Imported";
        }

        Master.ShowSuccess(msg);
    }

    private static void ImportSuppMTO(string Extension, string FilePath, string proj_id)
    {
        WebTools.ExecNonQuery("DELETE FROM PIP_SUPP_MTO_LINE_ID WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");

        ExcelImport.Import_Excel_File(FilePath, Extension, "PIP_SUPP_MTO_LINE_ID", "UK_PIP_SUPP_MTO_LINE_ID", "PROJECT_ID", proj_id);

        WebTools.ExecNonQuery("DELETE FROM PIP_SUPP_MTO_LINE_ID WHERE ITEM_NAME='TEXT' OR ITEM_TYPE='TEXT'");
        WebTools.ExecNonQuery("UPDATE PIP_SUPP_MTO_LINE_ID SET NOTE=UPPER(NOTE)");
        WebTools.ExecNonQuery("UPDATE PIP_SUPP_MTO_LINE_ID SET SCOPE_NAME=UPPER(SCOPE_NAME)");
        WebTools.ExecNonQuery("UPDATE PIP_SUPP_MTO_LINE_ID SET AREA_NAME=UPPER(AREA_NAME)");

        WebTools.ExecNonQuery("BEGIN PKG_UPDATE_SUPP_MTO.INSERT_MTO(" + proj_id + ");END;");
    }

    private static void ImportSPS(string Extension, string FilePath, string proj_id)
    {
        WebTools.ExecNonQuery("DELETE FROM PIP_SUPP_MTO_SPS WHERE PROJECT_ID IN (0, -1, " + proj_id + ")");

        ExcelImport.Import_Excel_File(FilePath, Extension, "PIP_SUPP_MTO_SPS", "PK_SUPP_MTO_SPS", "PROJECT_ID", proj_id);

        WebTools.ExecNonQuery("DELETE FROM PIP_SUPP_MTO_SPS WHERE ITEM_NAME='TEXT' OR ITEM_TYPE='TEXT'");
    }

}