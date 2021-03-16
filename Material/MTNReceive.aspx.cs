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

public partial class Material_MTNReceive : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Receive - MTN";
            Master.AddModalPopup("~/Material/MTNReceiveNew.aspx", btnRegister.ClientID, 500, 550);
            Master.RadGridList = itemsGrid.ClientID;
            try
            {
                if (Session["MTNReceive_SESSION"] != null)
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
                btnRegister.Visible = false;
            }
        }
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if(itemsGrid.SelectedIndexes.Count == 0)
        {
            //Master.ShowError("Select a receive number to continue.");
            RadWindowManager1.RadAlert("Select a receive number to continue.", 400, 150, "Warning", "");
            return;
        }

        Response.Redirect("MTNReceiveDetail.aspx?id=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            //  Master.ShowError("Select a receive number to continue.");
            RadWindowManager1.RadAlert("Select a receive number to continue.", 400, 150, "Warning", "");
            return;
        }

        Response.Redirect("ReportViewer.aspx?ReportID=33&Arg1=" + itemsGrid.SelectedValue);
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string trans_rcv_id = itemsGrid.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(17, trans_rcv_id, "TRANSF_RCV", "TRANSF_RCV_SUPP", Response);

    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string rcv_id = item.GetDataKeyValue("RCV_ID").ToString();
            string rcv_no = WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " rcv_id = " + rcv_id);
            string filename = rcv_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'TRANSF_RCV'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'TRANSF_RCV'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='Receive PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =20 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =20";
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
    }

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MTN_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MTN_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            object[] gridSettings = new object[2];
            int columnsLength = this.itemsGrid.MasterTableView.Columns.Count + this.itemsGrid.MasterTableView.AutoGeneratedColumns.Length;
            ArrayList allColumns = new ArrayList(columnsLength);
            allColumns.AddRange(this.itemsGrid.MasterTableView.Columns);
            allColumns.AddRange(this.itemsGrid.MasterTableView.AutoGeneratedColumns);

            gridSettings[0] = (object)this.itemsGrid.MasterTableView.FilterExpression;

            ArrayList visibleColumns = new ArrayList(columnsLength);
            ArrayList displayedColumns = new ArrayList(columnsLength);
            Pair[] columnFilter = new Pair[columnsLength];
            int i = 0;
            foreach (GridColumn column in allColumns)
            {

                if (!string.IsNullOrEmpty(column.CurrentFilterValue))
                {
                    columnFilter[i] = new Pair(column.CurrentFilterFunction, column.CurrentFilterValue);
                }
                i++;
            }

            gridSettings[1] = columnFilter;
            Session["MTN_RECV_SESSION"] = gridSettings;
        }



    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MTN_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "TRANSF_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MTN_EDIT"))
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

        SessionStorageProvider.StorageProviderKey = "MTNReceive_SESSION";
        RadPersistenceManager1.SaveState();
    }

}