using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Procurement_POInsp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "REQUEST FOR INSPECTION (PO RFI)";
            Master.AddModalPopup("~/Procurement/POInspAdd.aspx", btnNew.ClientID, 500, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
        if (!WebTools.UserInRole("PO_RFI_ADD"))
        {
            btnNew.Visible = false;
        }
        //if (!WebTools.UserInRole("POInsp"))
        //{
        //   // Master.ShowError("Dont have access to this page");
        //     Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
        try
        {
            if (Session["PO_RFI_SESSION"] != null)
            {

                RadPersistenceManager1.LoadState();
                itemsGrid.Rebind();

            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnMat_Click(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        {
            Master.ShowAccessDenied();
            return;
        }

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select RFI Number to continue.");
            return;
        }
        Response.Redirect("POInspDetail.aspx?REQ_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnAddMat_Click(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_INSERT") || WebTools.UserInRole("ADMIN")))
        {
            Master.ShowAccessDenied();
            return;
        }

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select RFI Number to continue.");
            return;
        }
        Response.Redirect("POInspDetailAdd.aspx?RFI_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        {
            Master.ShowAccessDenied();
            return;
        }

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select RFI Number to continue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=10.2&Arg1=" + itemsGrid.SelectedValue);
    }

    protected void SaveUpload_Click(object sender, EventArgs e)
    {

    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PO_RFI_EDIT"))
        {
            itemsGrid.MasterTableView.Columns[0].Visible = false;
        }

        if (!WebTools.UserInRole("PO_RFI_DELETE"))
        {
            itemsGrid.MasterTableView.Columns[1].Visible = false;
        }
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string po_rfi_id = itemsGrid.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(10, po_rfi_id, "PO_RFI", "PO_RFI_SUPP", Response);

    }


    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string rfi_id = item.GetDataKeyValue("RFI_ID").ToString();
            string rfi_no = WebTools.GetExpr("RFI_NO", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + rfi_id + "'");
            string filename = rfi_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_RFI'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_RFI'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='IRN PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

    protected void itemsGrid_DataBinding1(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PO_RFI_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "RFI_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PO_RFI_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_RFI_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_RFI_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }
    public class SessionStorageProvider : IStateStorageProvider
    {
        private System.Web.SessionState.HttpSessionState session = HttpContext.Current.Session;
        static string storageKey;

        public static string StorageProviderKey
        {
            set { storageKey = value; }
        }

        public void SaveStateToStorage(string key, string serializedState)
        {
            session[storageKey] = serializedState;
        }

        public string LoadStateFromStorage(string key)
        {

            return session[storageKey].ToString();
        }
    }
    protected void itemsGrid_PreRender(object sender, System.EventArgs e)
    {

        SessionStorageProvider.StorageProviderKey = "PO_RFI_SESSION";
        RadPersistenceManager1.SaveState();
    }
}