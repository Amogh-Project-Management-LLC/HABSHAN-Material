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
using dsPO_ShipmentATableAdapters;
using Telerik.Web.UI;

public partial class Material_MatExceptionRepItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        Master.HeadingMessage = "ESD REPORT (";
        Master.HeadingMessage += WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " EXCP_ID='" + Request.QueryString["EXCP_ID"].ToString() + "'");
        Master.HeadingMessage += ")";

        if (!WebTools.UserInRole("MM_DELETE"))
        {
            btnDelete.Enabled = false;
        }
    }
    protected void itemsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }
    protected void itemsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatExceptionRep.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the material!");
            RadWindowManager1.RadAlert("Select the material!", 400, 150, "Warning", "");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        // Master.ShowWarn("Proceed delete the material?");
        RadWindowManager1.RadAlert("Proceed delete the material?", 400, 150, "Warning", "");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
        dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_EXCP_REP_ITEMTableAdapter item = new VIEW_ADAPTER_MAT_EXCP_REP_ITEMTableAdapter();
        item.DeleteQuery(decimal.Parse(itemsGridView.SelectedValue.ToString()));
        itemsGridView.Rebind();
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
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
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            //Master.ShowWarn("Access denied!");
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
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            // Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            RadWindowManager1.RadAlert("There are two materials with the same code! try to use the unique one.", 400, 150, "Warning", "");
            return;
        }
        else if (mat_id == 0)
        {
            // Master.ShowWarn("Material Code not found!");
            RadWindowManager1.RadAlert("Material Code not found!", 400, 150, "Warning", "");
            return;
        }
        if (WebTools.GetExpr("HEAT_NO", "PRC_MAT_INSP_DETAIL", " WHERE HEAT_NO='" + txtHeatNo.Text +
            "'") == "")
        {
            //Master.ShowWarn("Heat number not found!");
            RadWindowManager1.RadAlert("Heat number not found!", 400, 150, "Warning", "");
            return;
        }
        VIEW_ADAPTER_MAT_EXCP_REP_ITEMTableAdapter excp_items = new VIEW_ADAPTER_MAT_EXCP_REP_ITEMTableAdapter();
        try
        {
            excp_items.InsertQuery(decimal.Parse(Request.QueryString["EXCP_ID"]),
                mat_id, cboFalg.SelectedValue.ToString(),
                decimal.Parse(txtQty.Text), txtRemarks.Text, txtHeatNo.Text, cabledrum.SelectedValue.ToString(), txtPOitem.Text, txtMRItem.Text);
            Master.ShowMessage("new exception item added.");
            itemsGridView.DataBind();
        }
        catch (Exception ex)
        {
            // Master.ShowWarn(ex.Message);
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
        }
        finally
        {
            excp_items.Dispose();
        }
    }

    protected void ddlItemList_DataBinding(object sender, EventArgs e)
    {
        ddlItemList.Items.Clear();
        ddlItemList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlItemList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string selectedText = ddlItemList.SelectedItem.Text;
        string mir_id = WebTools.GetExpr("MAT_RCV_ID", "PIP_MAT_EXCEPTION_REP", " WHERE EXCP_ID = " + Request.QueryString["EXCP_ID"]);
        string TYPE_ID = WebTools.GetExpr("TYPE_ID", "PIP_MAT_EXCEPTION_REP", " WHERE EXCP_ID = " + Request.QueryString["EXCP_ID"]);
        string[] t = selectedText.Split('-');
        if (t.Length > 1)
        {
            txtMRItem.Text = t[0];
           // txtMatCode.Text = t[1];

           
            if (TYPE_ID=="2")
            {
                txtPOitem.Text = "0";
                txtHeatNo.Text = WebTools.GetExpr("HEAT_NO", "PIP_MAT_TRANSFER_RCV_DT", " WHERE RCV_ID='" + mir_id + "' AND MR_ITEM_NO = '" + t[0] + "'");
                txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + t[1] + "'");
            }
            else
            {
                txtPOitem.Text = WebTools.GetExpr("PO_ITEM", "VIEW_MRIR_ESD", " WHERE MIR_ID='" + mir_id + "' AND MIR_ITEM = '" + t[0] + "'");
            txtHeatNo.Text = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_ESD", " WHERE MIR_ID='" + mir_id + "' AND MIR_ITEM = '" + t[0] + "'");
            txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "VIEW_MRIR_ESD", " WHERE MIR_ID='" + mir_id + "' AND MIR_ITEM = '" + t[0] + "'");
            }
            
        }
        int start = selectedText.IndexOf("-");
        txtMatCode.Text=  selectedText.Substring(start+1, (selectedText.Length)-(start+1));
       
    }

    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
  
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
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =14 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =14";
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