using System;
using System.Web.UI;
using Telerik.Web.UI;

public partial class Home_UploadFileManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Master.HeadingMessage = "Upload Files";

            //set properties according to configuration panel

            RadFileExplorer1.Configuration.SearchPatterns = new string[] { "*.pdf" };

            RadFileExplorer1.VisibleControls = GetVisibleControls();

            RadFileExplorer1.EnableOpenFile = true;

            RadFileExplorer1.DisplayUpFolderItem = true;

            RadFileExplorer1.AllowPaging = true;

            RadFileExplorer1.EnableCreateNewFolder = false;

            if ((RadFileExplorer1.VisibleControls & Telerik.Web.UI.FileExplorer.FileExplorerControls.Grid) == 0) RadFileExplorer1.ExplorerMode = Telerik.Web.UI.FileExplorer.FileExplorerMode.Thumbnails;

            if ((RadFileExplorer1.VisibleControls & Telerik.Web.UI.FileExplorer.FileExplorerControls.ListView) == 0) RadFileExplorer1.ExplorerMode = Telerik.Web.UI.FileExplorer.FileExplorerMode.Default;

            RadFileExplorer1.Configuration.UploadPaths = new string[] { "~/Upload" };

            RadFileExplorer1.InitialPath = Page.ResolveUrl("~/Upload");

        }
    }

    protected Telerik.Web.UI.FileExplorer.FileExplorerControls GetVisibleControls()
    {
        Telerik.Web.UI.FileExplorer.FileExplorerControls explorerControls = 0;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.AddressBox;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Grid;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ListView;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Toolbar;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.TreeView;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ContextMenus;

        return explorerControls;
    }
    protected void RadFileExplorer1_ItemCommand(object sender, Telerik.Web.UI.RadFileExplorerEventArgs e)
    {
        if (e.Command == "Delete")
        {
            //e.Cancel = true;
        }
    }
}