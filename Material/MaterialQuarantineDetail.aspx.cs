using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MaterialQuarantineDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Quarantine Details";
            Master.HeadingMessage += "<br/>";
            Master.HeadingMessage += WebTools.GetExpr("QRNTINE_NO", "PIP_QUARANTINE", " WHERE QRNTINE_ID='" + Request.QueryString["id"].ToString() + "'");
            decimal  qr_item = WebTools.DMax("QR_ITEM", "PIP_MAT_QUARANTINE", " WHERE QRNTINE_ID='" + Request.QueryString["id"] + "'");
            txtQritem.Text = (qr_item + 1).ToString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void ddlMatItem_OnDataBinding(object sender, EventArgs e)
    {
        ddlMatItem.Items.Clear();
        ddlMatItem.Items.Add(new ListItem("(Select Material)", ""));        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter q = new dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter();
        try
        {
            q.InsertQuery(Decimal.Parse(ddlMatItem.SelectedValue), decimal.Parse(txtQty.Text), decimal.Parse(ddlQuaranCat.SelectedValue),
                txtRemarks.Text, decimal.Parse(Request.QueryString["id"].ToString()),txtHeatno.Text, txtDrumno.Text, txtQritem.Text, decimal.Parse(ddlPO.SelectedValue));
            RadGrid1.Rebind();
             Master.ShowMessage(ddlMatItem.SelectedItem.Text + " Added.");
            //RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
           decimal qr_item = WebTools.DMax("QR_ITEM", "PIP_MAT_QUARANTINE", " WHERE QRNTINE_ID='" + Request.QueryString["id"] + "'");
            txtQritem.Text = (qr_item + 1).ToString();
        }
        catch (Exception ex)
        {
             Master.ShowError(ex.Message);
            //RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
        }
        finally {
            q.Dispose();
        }
    }

    protected void btnHide_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = false;
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialQuarantine.aspx");
    }

    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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

    protected void RadGrid1_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            RadGrid1.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            RadGrid1.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MM_EDIT"))
        {
            RadGrid1.AllowAutomaticUpdates = false;
        }
        else
        {
            RadGrid1.AllowAutomaticUpdates = true;
        }

    }

    protected void ddlMatItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_ID='" + ddlMatItem.SelectedValue + "'");
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =25 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =25";
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