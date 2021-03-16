using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.OracleClient;
using Telerik.Web.UI.PersistenceFramework;

public partial class Procurement_MRDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Requisition (";
            Master.HeadingMessage += WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " MR_ID='" + Request.QueryString["MR_ID"] + "'");
            Master.HeadingMessage += ") <br/> (";
            Master.HeadingMessage += WebTools.GetExpr("MR_TITLE", "PIP_MAT_REQUISITION", " MR_ID='" + Request.QueryString["MR_ID"] + "'")+")";
            Master.AddModalPopup("~/Procurement/MRItemAdd.aspx?MR_ID=" + Request.QueryString["MR_ID"], btnAdd.ClientID, 450, 650);
            Master.RadGridList = itemsGrid.ClientID;
           
            string USER_ID = WebTools.GetExpr("CREATE_BY", "PIP_MAT_REQUISITION", " WHERE MR_ID ='" + Request.QueryString["MR_ID"] + "'");
            string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID + "'");
            string USER_NAME = Session["USER_NAME"].ToString();
            if ((WebTools.UserInRole("MR_ADD")) && (CREATE_BY.ToUpper() == USER_NAME.ToUpper() || WebTools.UserInRole("ADMIN")))
            {
                btnAdd.Visible = true;
            }

            if (WebTools.UserInRole("Admin"))
            {

                btnDeleteAll.Visible = true;
                this.itemsGrid.Columns[2].Visible = true;
                return;
            }
            else
            {
                this.itemsGrid.Columns[2].Visible = false;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatRequisition.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

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
            datafields[0] = "MAT_CODE1";
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
  
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
      
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }
        string MR_ITEM_NO="";
        string mr_id="";
        string po_id = "";
        string mr_in_po = "";
        string MR_ITEM_ID="";
        string sql = string.Empty;
        mr_id = Request.QueryString["MR_ID"];
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                po_id = WebTools.GetExpr("PO_ID", "PIP_PO", " MR_ID=" + mr_id);
                MR_ITEM_NO = item["MR_ITEM_NO"].Text;
                MR_ITEM_ID = item["MR_ITEM_ID"].Text;
                mr_in_po = WebTools.GetExpr("PO_ITEM_ID", "PIP_PO_DETAIL", " PO_ID=" + po_id + "AND MR_ITEM =" + MR_ITEM_NO);
                if (mr_in_po =="")
                {
                    WebTools.ExeSql("DELETE FROM PIP_MAT_REQUISITION_DETAIL WHERE  MR_ITEM_ID=" + MR_ITEM_ID);

                }

                Master.ShowSuccess("Successfully Deleted all Items, if all items are not deleted then those items should be already added in PO");
                itemsGrid.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        string USER_ID = WebTools.GetExpr("CREATE_BY", "PIP_MAT_REQUISITION", " WHERE MR_ID ='" + Request.QueryString["MR_ID"] + "'");
        string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID  + "'");
        string USER_NAME = Session["USER_NAME"].ToString();

        if (e.Item is GridDataItem)
        {

            GridDataItem Item = (GridDataItem)e.Item;
            if (CREATE_BY.ToUpper() != USER_NAME.ToUpper() && !WebTools.UserInRole("ADMIN"))
            {
                ImageButton btnEdit = (ImageButton)Item["EditCommandColumn"].Controls[0];
                btnEdit.Visible = false;
                ImageButton btnDelete = (ImageButton)Item["DeleteColumn"].Controls[0];
                btnDelete.Visible = false;

            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =2 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =2";
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
        string query = string.Format("SELECT DISTINCT {0} FROM VIEW_ADAPTER_MAT_REQ_DETAILS WHERE MR_ID=" + Request.QueryString["MR_ID"] + "ORDER BY {0}", field);

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

        return myDataTable;
    }
    protected void itemsGrid_PreRender(object sender, System.EventArgs e)
    {

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

        string USER_ID = WebTools.GetExpr("CREATE_BY", "PIP_MAT_REQUISITION", " WHERE MR_ID ='" + Request.QueryString["MR_ID"] + "'");
        string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID + "'");
        string USER_NAME = Session["USER_NAME"].ToString();
        if (CREATE_BY.ToUpper() == USER_NAME.ToUpper() || WebTools.UserInRole("ADMIN"))
        {
           itemsGrid.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClick";
        }
        else
        {
            itemsGrid.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClickCancel";
        }
    }
   
}

