using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_PODetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Item Details <br/> (";
            Master.HeadingMessage += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ") (" + WebTools.GetExpr("PO_SUBJECT", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ")";

            Master.AddModalPopup("~/Procurement/PODetailsAdd.aspx", btnAdd.ClientID, 500, 600);
        }
        if (!WebTools.UserInRole("PO_ADD"))
        {
            btnImportMR.Visible = false;
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POMaster.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("PODetailsAdd.aspx");
    }

    protected void btnImportMR_Click(object sender, EventArgs e)
    {
        
            Response.Redirect("PODetailsImport.aspx?PO_ID=" + Request.QueryString["PO_ID"]);
        
    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PO_DELETE"))
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
        if (!WebTools.UserInRole("PO_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }


    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }
        
        string po_item= "";
        string po_id = "";
        string po_in_irn = "";
        string PO_ITEM_ID = "";
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                po_id = Request.QueryString["PO_ID"];
                po_item = item["PO_ITEM"].Text;
                PO_ITEM_ID = item["PO_ITEM_ID"].Text;
                po_in_irn = WebTools.GetExpr("IRN_ITEM_ID", "PIP_PO_IRN_DETAIL", " PO_ID=" + po_id + "AND PO_ITEM =" + po_item);
                if (po_in_irn == "")
                {
                    sql = WebTools.ExeSql("DELETE FROM PIP_PO_DETAIL WHERE  PO_ITEM_ID=" + PO_ITEM_ID);
                    
                }

                Master.ShowSuccess("Successfully Deleted all Items, if all items are not deleted then those items should be already added in IRN");
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
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =4 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =4";
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
   
}