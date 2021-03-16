using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Material_MatRFI : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Request For Inspection (RFI)";
            Master.AddModalPopup("~/Material/MatRFINew.aspx", btnNew.ClientID, 500, 750);
            Master.RadGridList = itemsGrid.ClientID;

            try
            {
                if (Session["MAT_RFI_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    itemsGrid.Rebind();

                }
            }
            catch (Exception ex)
            {

            }
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnNew.Visible = false;
            }

        }
    }

    protected void btnMat_Click(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        {
            // Master.ShowAccessDenied();
            RadWindowManager1.RadAlert("Access Denied.", 300, 150, "Warning", "");
            return;
        }

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select RFI Number to continue.");
            RadWindowManager1.RadAlert("Select RFI Number to continue.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("MatRFIDetail.aspx?REQ_ID=" + itemsGrid.SelectedValue);
    }

  

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        {
            //Master.ShowAccessDenied();
            RadWindowManager1.RadAlert("Access Denied.", 400, 150, "Warning", "");
            return;
        }

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            // Master.ShowMessage("Select RFI Number to continue.");
            RadWindowManager1.RadAlert("Select RFI Number to continue.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=10.2&Arg1=" + itemsGrid.SelectedValue);
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            //Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string rfi_id = itemsGrid.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(12, rfi_id, "MAT_RFI", "MAT_RFI_SUPP", Response);

    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string rfi_id = item.GetDataKeyValue("RFI_ID").ToString();
            string rfi_no = WebTools.GetExpr("RFI_NO", "PIP_MAT_INSP_REQUEST", " RFI_ID = " + rfi_id);
            string filename = rfi_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_RFI'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_RFI'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='RFI PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =9 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =9";
            DataTable lbl_dt = WebTools.getDataTable(lbl_query);
            Label[] descLabel = new Label[30];
            int i = 0;
            foreach (DataRow row in lbl_dt.Rows)
            {
                string lbl_col = row["LBL_COL_NAME"].ToString();

                string str = (dataItem[lbl_col].Controls[0] as TextBox).Text;
                descLabel[i] = new Label();
                descLabel[i].Text = str;
                dataItem[lbl_col].Controls.Add(descLabel[i]);
                i++;
            }

        }
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            
            foreach (TableCell cell in item.Cells)
            {
                if (cell.Text.Length > 50)
                {
                    cell.ToolTip = cell.Text;
                    cell.Text = cell.Text.Substring(0, 45) + " ....";

                }
            }
        }
    }

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_RFI_DELETE"))
            {
                RadWindowManager1.RadAlert("Access Denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_RFI_EDIT"))
            {
                RadWindowManager1.RadAlert("Access Denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
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

        SessionStorageProvider.StorageProviderKey = "MAT_RFI_SESSION";
        RadPersistenceManager1.SaveState();
    }

}