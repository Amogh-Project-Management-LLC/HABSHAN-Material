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
using dsMaterial_IssueATableAdapters;
using Telerik.Web.UI;

public partial class Erection_Additional_MatItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Issue Detail <br/>" +
                WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID=" + Request.QueryString["ADD_ISSUE_ID"]);            
        }
        if (WebTools.UserInRole("ADMIN"))
        {

            btnDeleteAll.Visible = true;
            this.itemsGridView.Columns[2].Visible = true;
            return;
        }
        else
        {
            this.itemsGridView.Columns[2].Visible = false;
        }
    }

    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
       
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Additional_Mat.aspx");
    }

  

  
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            return;
        }
        
        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = decimal.Parse(ddlMatCode.SelectedValue.ToString());

        if (mat_id == 0)
        {
            //Master.ShowWarn("Material Code not found!");
            RadWindowManager1.RadAlert("Material Code not found!", 400, 150, "Warning", "");
            return;
        }

        //if (ddlMatRequestNo.SelectedValue == "")
        //{
        //    //Master.ShowWarn("Select Material Request Number!");
        //    RadWindowManager1.RadAlert("Select Material Request Number!", 400, 150, "Warning", "");
        //    return;
        //}

        string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
        decimal bal_qty = db_lookup.DSum("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID=" + mat_id + " AND SUB_CON_ID=" + sub_con_id);
        if (bal_qty < decimal.Parse(txtQty.Text))
        {
            // Master.ShowWarn("Material not found in stock!, Please check the quantity carefully.");
            RadWindowManager1.RadAlert("Material not found in stock!, Please check the quantity carefully.", 00, 150, "Warning", "");
            return;
        }

        VIEW_ADAPTER_ISSUE_ADD_DETAILTableAdapter items = new VIEW_ADAPTER_ISSUE_ADD_DETAILTableAdapter();
        try
        {
            items.InsertQuery(
                Decimal.Parse(Request.QueryString["ADD_ISSUE_ID"]),
                mat_id,
                decimal.Parse(ddlPo.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text),
                txtHeatNo.Text,
                txtPaintCode.Text,
                txtRemarks.Text, txtCableDrumNo.Text
               );
            Master.ShowMessage(ddlMatCode.SelectedItem + " Saved.");
            itemsGridView.DataBind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }

    //protected void txtMatCode_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    //{
    //    if (txtMatCode.Text != "")
    //    {
    //        txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + txtMatCode.Text + "'");
    //        string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
    //        txtAvlQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_CODE1='" + txtMatCode.Text + "' and sub_con_id = '" + sub_con_id + "'");
    //    }
    //}

    //protected void ddlMatRequestNo_DataBinding(object sender, EventArgs e)
    //{
    //    ddlMatRequestNo.Items.Clear();
    //    ddlMatRequestNo.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    //}

    protected void btnImportBarcode_Click(object sender, EventArgs e)
    {
        string doc_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID ='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
        string doc_id = Request.QueryString["ADD_ISSUE_ID"];
        string ret_url = "Additional_MatItems.aspx?ADD_ISSUE_ID=" + doc_id;
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + ret_url);
    }

    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }


    }

    protected void itemsGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            itemsGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MM_EDIT"))
        {
            itemsGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGridView.AllowAutomaticUpdates = true;
        }
    }

    protected void itemsGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =23 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =23";
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
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {

        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string ADD_ISSUE_ID = "";
        string MAT_ID = "";
        string HEAT_NO = "";
        string CABLE_DRUM_NO = "";
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGridView.SelectedItems)
            {

                ADD_ISSUE_ID = item["ADD_ISSUE_ID"].Text;
                MAT_ID = item["MAT_ID"].Text;
                HEAT_NO = item["HEAT_NO"].Text;
                CABLE_DRUM_NO = item["CABLE_DRUM_NO"].Text;

                sql = WebTools.ExeSql("DELETE FROM PIP_MAT_ISSUE_ADD_DETAIL WHERE  ADD_ISSUE_ID='" + ADD_ISSUE_ID + "' AND MAT_ID='" + MAT_ID + "' AND HEAT_NO='" + HEAT_NO + "' AND CABLE_DRUM_NO='" + CABLE_DRUM_NO + "'");


                Master.ShowSuccess("Successfully Deleted Selected Items");
                itemsGridView.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (ddlMatCode.SelectedValue != "")
        {
            txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_ID='" + ddlMatCode.SelectedValue + "'");
            string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
            txtAvlQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID='" + ddlMatCode.SelectedValue + "' and sub_con_id = '" + sub_con_id + "'");
        }
    }
}