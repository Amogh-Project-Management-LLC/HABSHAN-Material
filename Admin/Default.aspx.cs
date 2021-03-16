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
using System.Text;

public partial class Admin_Default : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Admin";
            //lblUsers.Text = Application["userCount"].ToString();

            if (!WebTools.IsAdminUser(Session["USER_NAME"].ToString()))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }

            UpdateDeleteLogButtonText();
            Master.AddModalPopup("~/Utilities/PriorityMaster.aspx", btnSetPriority.ClientID, 500, 900);
        }
    }

    private void UpdateDeleteLogButtonText()
    {
        long folder_size = GetDirectorySize(GetSessionFolder());
        string folder_size_text = "";

        if (folder_size >= 1024)
            folder_size_text = string.Format("{0}GB", folder_size / 1024);
        else
            folder_size_text = string.Format("{0}MB", folder_size);

        btnDelSessionData.Text = "Delete Session Logs (" + folder_size_text + ")";
    }

    protected void btnCollectSpoolgenPDF_Click(object sender, EventArgs e)
    {
        if (WebTools.IsAdminUser(Session["USER_NAME"].ToString()))
        {
            Response.Redirect("Collect_PDFs.aspx");
        }
    }

    protected void btnUsers_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("USERS_ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("Users.aspx");
    }

    protected void btnDelSessionData_Click(object sender, EventArgs e)
    {
        string FolderName = GetSessionFolder();
        if (!System.IO.Directory.Exists(FolderName))
        {
            Master.ShowMessage("SessionData folder not found!");
            return;
        }
        string[] sSubFolders;
        sSubFolders = System.IO.Directory.GetDirectories(FolderName);
        try
        {
            for (int i = 0; i < sSubFolders.Length; i++)
            {
                DirectoryInfo info = new DirectoryInfo(sSubFolders[i]);
                if (DateTime.Now.Subtract(info.CreationTime).TotalHours > 6)
                    Directory.Delete(sSubFolders[i], true);
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }

        UpdateDeleteLogButtonText();

        Master.ShowSuccess("Session logs deleted!");
    }

    private string GetSessionFolder()
    {
        return HostingEnvironment.ApplicationPhysicalPath + @"SessionData\";
    }

    private static long GetDirectorySize(string folderPath)
    {
        DirectoryInfo di = new DirectoryInfo(folderPath);
        return di.EnumerateFiles("*.*", SearchOption.AllDirectories).Sum(fi => fi.Length) / 1024 / 1024;
    }

    protected void btnImportBarCodeFitupWelding_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("BAR_CODE_IMPORT"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportBarCode.aspx");
    }

    protected void btnImportFieldDWR_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportFieldWelding.aspx");
    }

    protected void btnImportCmsAvl_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportCmsMatAvlStatus.aspx");
        //ImportCmsMatAvlStatus.aspx
    }

    protected void btnExportData_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ExportTextCsv.aspx");
    }

    protected void btnImportIsoList_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportIsoList.aspx");
    }

    protected void btnAllocation_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("MatAllocation.aspx");
    }

    protected void btnImportSuppMTO_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportSupportMTO.aspx");
    }

    protected void btnImportMSR_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportMSR.aspx");
    }

    protected void btnImportMRR_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportMRR.aspx");
    }

    protected void btnUpdateSuppMTO_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("UpdateSuppMTO.aspx");
    }

    protected void btnUpdateAll_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string set_param = "dbms_scheduler.set_job_argument_value(job_name => 'JOB_UPDATE_ALL', argument_position => {0}, argument_value => {1});";

        string arg_1 = Session["PROJECT_ID"].ToString(); // proj_id

        sb.Append("BEGIN");
        sb.AppendLine();
        sb.Append(string.Format(set_param, 1, arg_1));
        sb.AppendLine();
        sb.Append("dbms_scheduler.enable('JOB_UPDATE_ALL');");
        sb.AppendLine();
        sb.Append("END;");

        WebTools.ExecNonQuery(sb.ToString());
        btnUpdateAll.Enabled = false;

        Master.ShowSuccess("Update Started!");
    }

    protected void btnImportCccMTO_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportCccMTO.aspx");
    }

    protected void btnImportPO_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowAccessDenied();
            return;
        }

        Response.Redirect("ImportPO.aspx");
    }

    protected void btnSetPriority_Click(object sender, EventArgs e)
    {

    }
}