using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsMaterialCTableAdapters;
using System.Data;
using System.Configuration;
using System.Data.OracleClient;

public partial class Material_MaterialRequestItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Request <br/>" + WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", "MAT_REQ_ID=" + Request.QueryString["MAT_REQ_ID"]);
            Master.RadGridList = RadGrid1.ClientID;
            //Master.AddModalPopup("~/Material/MaterialRequestDetail.aspx", ImageButtonDetails.ClientID, 650, 700);
            hiddenreqStoreID.Value = WebTools.GetExpr("REQ_TO_STORE_ID", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + Request.QueryString["MAT_REQ_ID"] + "'");


            decimal mr_item_no = WebTools.DMax("MR_ITEM_NO", "MATERIAL_REQUEST_DETAIL", " WHERE MAT_REQ_ID='" + Request.QueryString["MAT_REQ_ID"] + "'");
            txtMrItem.Text = (mr_item_no + 1).ToString();
            string status_flg = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);

            string USER_ID = WebTools.GetExpr("CREATE_BY", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);
            string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID + "'");
            string USER_NAME = Session["USER_NAME"].ToString();
            if ((CREATE_BY.ToUpper() == USER_NAME.ToUpper() && status_flg != "Y") || WebTools.UserInRole("ADMIN"))
            {
                btnEntry.Visible = true;
            }
            else
            {
                btnEntry.Visible = false;
            }
        }
        if (WebTools.UserInRole("ADMIN"))
        {

            btnDeleteAll.Visible = true;
            this.RadGrid1.Columns[2].Visible = true;
            return;
        }
        else
        {
            this.RadGrid1.Columns[2].Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = WebTools.GetMatId(ddlMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            //Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            RadWindowManager1.RadAlert("There are two materials with the same code! try to use the unique one.", 400, 150, "Warning", "");
            return;
        }
        else if (mat_id == 0)
        {
            // Master.ShowWarn("Material Code not found!");
            RadWindowManager1.RadAlert("Material Code not found!", 400, 150, "Warning", "");
            return;
        }

        VIEW_MATERIAL_REQUEST_DTTableAdapter items = new VIEW_MATERIAL_REQUEST_DTTableAdapter();

        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["MAT_REQ_ID"]), decimal.Parse(txtMrItem.Text),
                mat_id, ddlHeatNo.SelectedValue, txtCabledrum.SelectedValue, decimal.Parse(txtReqQty.Text), txtReqDate.SelectedDate, txtRqrdAtLocation.Text,
                null, null, txtRemarks.Text, decimal.Parse(ddlPO.SelectedValue));
            RadGrid1.DataBind();
            //Master.ShowMessage(txtMatCode.Text + " Saved!");
            RadWindowManager1.RadAlert("Material Added.", 400, 150, "Success", "");
            decimal mr_item_no = WebTools.DMax("MR_ITEM_NO", "MATERIAL_REQUEST_DETAIL", " WHERE MAT_REQ_ID='" + Request.QueryString["MAT_REQ_ID"] + "'");
            txtMrItem.Text = (mr_item_no + 1).ToString();
        }
        catch (Exception ex)
        {
            //Master.ShowWarn(ex.Message);
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
        }
        finally
        {
            items.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialRequest.aspx");
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            //Master.ShowMessage("Row deleted successfully!");
            //itemsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            //Master.ShowWarn(ex.Message);
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //itemsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        //PageList.Items.Clear();
        //for (int i = 0; i < itemsGridView.PageCount; i++)
        //{
        //    ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
        //    PageList.Items.Add(pageListItem);
        //    if (i == itemsGridView.PageIndex)
        //        pageListItem.Selected = true;
        //}
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("MM_INSERT"))
        //{
        //    Master.ShowWarn("Access Denied!");
        //    return;
        //}
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
            RadGrid1.PageSize = 10;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
            RadGrid1.PageSize = 15;
        }

    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        //if (RadGrid1.SelectedIndexes.Count == 0)
        //{
        //    Master.ShowMessage("Select and item!");
        //    return;
        //}
        //string mat_req_id = RadGrid1.SelectedValues["MAT_REQ_ID"].ToString();
        //string mr_item_no = RadGrid1.SelectedValues["MR_ITEM_NO"].ToString();
        //Response.Redirect("MaterialRequestDetail.aspx?MAT_REQ_ID=" + mat_req_id +
        //    "&MR_ITEM_NO=" + mr_item_no);
    }
    protected void itemsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Nothing to do
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            //Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }
   

    private string RadGrid_MatReqID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("MAT_REQ_ID").ToString();
            }
        }
        return string.Empty;
    }

    private string RadGrid_MR_ITEM_NO()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("MR_ITEM_NO").ToString();
            }
        }
        return string.Empty;
    }

    protected void txtMatCode_TextChanged(object sender, EventArgs e)
    {
        //string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");
        //if (mat_id != "")
        //{
        //    string mat_descr = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");
        //    txtItemDescr.Text = mat_descr;
        //}
        //else
        //{
        //    txtItemDescr.Text = string.Empty;
        //}
    }

    protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MAT_REQUEST_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MAT_REQUEST_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                return;
            }
        }

    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string mat_descr = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.Text + "'");
        txtItemDescr.Text = mat_descr;
    }
    protected void txtHeatNo_DataBinding(object sender, EventArgs e)
    {
        ddlHeatNo.Items.Clear();
        ddlHeatNo.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlHeatNo.SelectedIndex = 0;
    }
    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        string status_flg = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);

        if (e.Item is GridDataItem)
        {
            string USER_ID = WebTools.GetExpr("CREATE_BY", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);
            string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID + "'");
            string USER_NAME = Session["USER_NAME"].ToString();
            GridDataItem dataItem = (GridDataItem)e.Item;
            if (status_flg == "Y" && !WebTools.UserInRole("ADMIN"))
            {
                ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                btnEdit.Visible = false;

                ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                btnDelete.Visible = false;
            }
            if (CREATE_BY.ToUpper() != USER_NAME.ToUpper() && !WebTools.UserInRole("ADMIN"))
            {
                ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                btnEdit.Visible = false;

                ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                btnDelete.Visible = false;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =16 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =16";
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

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            Master.ShowWarn(" cannot be deleted (check for MR Items In MTN)  : " + e.Exception.Message);
        }
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {

        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string MR_ITEM_NO = "";
        string MAT_REQ_ID = "";
        
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                MAT_REQ_ID = Request.QueryString["MAT_REQ_ID"];
                MR_ITEM_NO = item["MR_ITEM_NO"].Text;
                
                
                    sql = WebTools.ExeSql("DELETE FROM MATERIAL_REQUEST_DETAIL WHERE  MAT_REQ_ID=" + MAT_REQ_ID + " AND MR_ITEM_NO="+ MR_ITEM_NO);


                Master.ShowSuccess("Successfully Deleted Selected Items");
                RadGrid1.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }

    protected void RadGrid1_PreRender(object sender, EventArgs e)
    {
        string USER_ID = WebTools.GetExpr("CREATE_BY", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID ='" + Request.QueryString["MAT_REQ_ID"] + "'");
        string CREATE_BY = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID ='" + USER_ID + "'");
        string USER_NAME = Session["USER_NAME"].ToString();
        string status_flg = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);
        if ((CREATE_BY.ToUpper() == USER_NAME.ToUpper() && status_flg != "Y") || WebTools.UserInRole("ADMIN"))
        {
            RadGrid1.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClick";
        }
        else
        {
            RadGrid1.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClickCancel";
        }
    }
   
  

}
