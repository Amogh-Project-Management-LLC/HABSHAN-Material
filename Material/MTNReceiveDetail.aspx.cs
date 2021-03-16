using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MTNReceiveDetail : System.Web.UI.Page
{
    decimal trans_qty = 0;
    decimal rcv_qty = 0;
  
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            string heading = "Material Receive Detail<br/>";
            heading += WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
            //HiddenTransfID.Value = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID='" + Request.QueryString["id"]);
            Master.HeadingMessage = heading;
            string RCV_BY = WebTools.GetExpr("RCV_BY", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
            string USER_NAME = Session["USER_NAME"].ToString();

            if (RCV_BY.ToUpper() == USER_NAME.ToUpper() ||WebTools.UserInRole("ADMIN"))
            {
                btnAdd.Visible = true;
                btnAddFromMTN.Visible = true;
                btnImportBarcode.Visible = true;
            }
            

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
        Response.Redirect("MTNReceive.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //Response.Redirect("MTNReceiveDetailImport.aspx?id=" + Request.QueryString["id"]);
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void cboMatCode_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {

        HiddenMatID.Value = WebTools.GetExpr("MAT_ID", "VIEW_STOCK", " WHERE MAT_CODE1='" + cboMatCode.Text + "'");

        //txtReceiveQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_MAT_TRANSFER_RCV_BAL", " WHERE TRANSF_ID = (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = '" + Request.QueryString["id"] + "') and MAT_ID = '" + HiddenMatID.Value + "'");
        txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "VIEW_STOCK", " WHERE MAT_CODE1='" + cboMatCode.Text + "'");
       
        ddlMR.Items.Clear();
        ddlMR.Items.Add(new DropDownListItem("Select", "-1"));
        ddlMR.DataBind();
        ddlMR.SelectedValue = "-1";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        string mr_item = ddlMR.SelectedValue;
        int mat_id = int.Parse(WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + cboMatCode.SelectedItem.Text + "'"));
        int TRANSF_ID = int.Parse(WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSFER_RCV", "RCV_ID=" + Request.QueryString["id"]));

        trans_qty = WebTools.DSum("TRANSF_QTY", "PIP_MAT_TRANSF_DETAIL", " TRANSF_ID=" + TRANSF_ID + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);
        rcv_qty = WebTools.DSum("rcv_qty", "PIP_MAT_TRANSFER_RCV_DT", "RCV_ID=" + Request.QueryString["id"] + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);
        txtReceiveQty.Text = (trans_qty - rcv_qty).ToString();
        decimal result = decimal.Parse(txtReceiveQty.Text);
        if (result > 0)
        {

            try
            {
            decimal excess = 0, shortage = 0, damage = 0;
            bool ex = decimal.TryParse(txtExcess.Text, out excess);
            bool sh = decimal.TryParse(txtShort.Text, out shortage);
            bool dm = decimal.TryParse(txtDamage.Text, out damage);

            dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter receive = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter();
            receive.InsertQuery(decimal.Parse(Request.QueryString["id"]), decimal.Parse(HiddenMatID.Value), decimal.Parse(txtReceiveQty.Text), ddlHeatNo.SelectedText, ddlCableDrum.SelectedText,
                ddlps.SelectedText, "", decimal.Parse(Session["PROJECT_ID"].ToString()), sh?excess:0, dm?damage:0, ex?excess:0,decimal.Parse(ddlPO.SelectedValue)
                , decimal.Parse(mr_item), decimal.Parse(txtPieces.Text));
            Master.ShowMessage("Item Added.");
            itemsGrid.Rebind();
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        }
        else
        {
            Master.ShowError("Receive QTY More than Transfer Qty");
        }
    }

    protected void btnYes_Click(object sender, EventArgs e)
        {

            try
            {
                dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter receive = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter();
                receive.DeleteQuery(decimal.Parse(itemsGrid.SelectedValue.ToString()));
                Master.ShowMessage("Item Deleted.");
                itemsGrid.Rebind();
                btnYes.Visible = false;
                btnNo.Visible = false;
            }
            catch (Exception ex)
            {
                Master.ShowError(ex.Message);
            }

        }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Selen a row to delete.");
            return;
        }

        btnYes.Visible = btnYes.Visible ? false : true;
        btnNo.Visible = btnNo.Visible ? false : true;
    }

    protected void btnNo_Click(object sender, EventArgs e)
    {
        btnYes.Visible = false;
        btnNo.Visible = false ;
    }

    protected void btnImportBarcode_Click(object sender, EventArgs e)
    {
        string doc_no = WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
        string doc_id = Request.QueryString["id"];
        string ret_url = "MTNReceiveDetail.aspx?id=" + doc_id;
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + ret_url);
    }

    protected void btnAddFromMTN_Click(object sender, EventArgs e)
    {
        string transf_id = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID = "+ Request.QueryString["id"]);
        Response.Redirect("ImportFromMTNTransf.aspx?TRANSF_ID=" + transf_id+"&RCV_ID=" + Request.QueryString["id"]);
        //Response.Redirect("MTNReceiveDetailImport.aspx"); 
    }

    protected void txtHeatNo_DataBinding(object sender, EventArgs e)
    {
        ddlHeatNo.Items.Clear();
        ddlHeatNo.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlHeatNo.SelectedIndex = 0;
    }

    protected void txtPS_DataBinding(object sender, EventArgs e)
    {
        ddlps.Items.Clear();
        ddlps.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlps.SelectedIndex = 0;
    }

    protected void txtCableDrum_DataBinding(object sender, EventArgs e)
    {
        ddlCableDrum.Items.Clear();
        ddlCableDrum.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlCableDrum.SelectedIndex = 0;
    }
    protected void ddlMR_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        decimal pieces = 0;
        string mr_item = ddlMR.SelectedValue;
        if (mr_item.Equals("-1"))
            return;
        int mat_id = int.Parse(WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + cboMatCode.SelectedItem.Text + "'"));
        int TRANSF_ID = int.Parse(WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSFER_RCV", "RCV_ID=" + Request.QueryString["id"]));

        trans_qty = WebTools.DSum("TRANSF_QTY", "PIP_MAT_TRANSF_DETAIL", " TRANSF_ID=" + TRANSF_ID + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);

        rcv_qty = WebTools.DSum("rcv_qty", "PIP_MAT_TRANSFER_RCV_DT", "RCV_ID=" + Request.QueryString["id"] + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);
        txtReceiveQty.Text =  (trans_qty- rcv_qty).ToString();
        pieces = WebTools.DSum("NO_OF_PIECE", "PIP_MAT_TRANSF_DETAIL", " TRANSF_ID=" + TRANSF_ID + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);
        txtPieces.Text = pieces.ToString();
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string RCV_ITEM_ID = "";

        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {

                RCV_ITEM_ID = item["RCV_ITEM_ID"].Text;


                sql = WebTools.ExeSql("DELETE FROM PIP_MAT_TRANSFER_RCV_DT WHERE  RCV_ITEM_ID=" + RCV_ITEM_ID);


                Master.ShowSuccess("Successfully Deleted Selected Items");
                itemsGrid.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }



    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        string RCV_BY = WebTools.GetExpr("RCV_BY", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
        string USER_NAME = Session["USER_NAME"].ToString();

        if (e.Item is GridDataItem)
        {

            GridDataItem Item = (GridDataItem)e.Item;
            if (RCV_BY.ToUpper() != USER_NAME.ToUpper() && !WebTools.UserInRole("ADMIN"))
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
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =21 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =21";
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

    protected void itemsGrid_PreRender(object sender, EventArgs e)
    {
        string RCV_BY = WebTools.GetExpr("RCV_BY", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
        string USER_NAME = Session["USER_NAME"].ToString();
        if (RCV_BY.ToUpper() == USER_NAME.ToUpper() || WebTools.UserInRole("ADMIN"))
        {
            itemsGrid.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClick";
        }
        else
        {
            itemsGrid.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClickCancel";
        }
    }
}