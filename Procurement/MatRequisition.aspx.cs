using System;
using System.Collections.Generic;
using System.Collections;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.OracleClient;
using Telerik.Web.UI.PersistenceFramework;

public partial class Procurement_MatRequisition : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Requisition";

            Master.AddModalPopup("~/Procurement/MatRequistionAdd.aspx", btnAdd.ClientID, 450, 650);
            //Master.AddModalPopup("~/Procurement/MatRequisitionImport.aspx", btnImport.ClientID, 400, 600);
            Master.RadGridList = itemsGrid.ClientID;
            try
            {
                if (Session["MR_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    itemsGrid.Rebind();

                }
            }
            catch (Exception ex)
            {
                
            }

        }

        if (!WebTools.UserInRole("MR_ADD"))
        {
            btnAdd.Visible = false;
        }


        //if (!WebTools.UserInRole("MatRequisition"))
        //{
        //    Master.ShowError("Dont have access to this page");
        //    //  Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
        //string user = Session["USER_NAME"].ToString().ToLower();
        //string access_by = WebTools.GetExpr("ACCESS_BY", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        //string all_records = WebTools.GetExpr("ALL_RECORDS", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        //ACCESS_BY.Value = access_by;
        //ALL_RECORDS.Value = all_records;
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select a row to continue.");
            return;
        }
        Response.Redirect("MRDetail.aspx?MR_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlDownload, "Material_Requisition.xls");
    }

    protected void btnPOBal_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlPOBalance, "PO_Balance.xls");
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MR_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MR_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }



    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MR_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MR_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MR_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string mr_id = itemsGrid.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(8, mr_id, "REQUISITION", "MR_SUPP", Response);

    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mr_id = item.GetDataKeyValue("MR_ID").ToString();
            string mr_no = WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " MR_ID = " + mr_id);
            mr_no = mr_no.Replace("/", "-");
            string filename = mr_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'REQUISITION'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'REQUISITION'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='MR PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =1 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =1";
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
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select MR to continue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=12&Arg1=" + itemsGrid.SelectedValue);
    }
    protected void RadGrid_FilterCheckListItems(object sender, GridFilterCheckListItemsRequestedEventArgs e)
    {
        string DataField = (e.Column as IGridDataColumn).GetActiveDataField();

        e.ListBox.DataSource = GetDataTable(DataField);
        e.ListBox.DataKeyField = DataField;
        e.ListBox.DataTextField = DataField;
        e.ListBox.DataValueField = DataField;
        e.ListBox.DataBind();
    }

    public DataTable GetDataTable(string field)
    {
        string query = string.Format("SELECT DISTINCT {0} FROM VIEW_ADAPTER_MR ORDER BY {0}", field);

        String ConnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        OracleConnection conn = new OracleConnection(ConnString);
        OracleDataAdapter adapter = new OracleDataAdapter();
        adapter.SelectCommand = new OracleCommand(query, conn);

        DataTable myDataTable = new DataTable();

        conn.Open();
        
        try
        {
            adapter.Fill(myDataTable);

        }
        finally
        {
            conn.Close();
        }
        conn.Close();
        return myDataTable;
    }
    protected void itemsGrid_PreRender(object sender, System.EventArgs e)
    {

        SessionStorageProvider.StorageProviderKey = "MR_SESSION";
        RadPersistenceManager1.SaveState();
        
        GridHeaderItem header = itemsGrid.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem;
        foreach (GridColumn col in itemsGrid.MasterTableView.RenderColumns
               .OfType<IGridDataColumn>().Where(x => x.AllowFiltering))
        {
            if (!string.IsNullOrEmpty(col.EvaluateFilterExpression()))
            {
                TableCell cell = header[col.UniqueName];
                cell.BackColor = System.Drawing.Color.SpringGreen;
                cell.Style["background-image"] = "none";

                cell.Controls.Add(new Image()
                {
                    ID = "FilterIndicator" + col.UniqueName,
                    //ImageUrl = "~/arrow.png"
                });
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


    protected void btnImportExcel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=5&RetUrl=~/Procurement/MatRequisition.aspx");
    }
}