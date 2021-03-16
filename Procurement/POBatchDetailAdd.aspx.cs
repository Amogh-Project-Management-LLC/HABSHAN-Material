using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POBatchDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Batch Detail - ";
            heading += WebTools.GetExpr("PO_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            heading += "/";
            heading += WebTools.GetExpr("BATCH_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");

            Master.HeadingMessage(heading);
            HiddenPOID.Value = WebTools.GetExpr("PO_ID", "PIP_PO_BATCH_PLAN"," WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter batch_dt = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter();
        try
        {
            //Check Qty 
            string bal_qty = WebTools.GetExpr("BAL_QTY", "VIEW_PO_BATCH_BAL", " WHERE PO_ITEM_ID='" + ddlPOItemList.SelectedValue + "'");
            if (decimal.Parse(txtBatchQty.Text) > decimal.Parse(bal_qty))
            {
                Master.show_error("Batch quantity cannot exceed balance quantity. Balance Qty is " + bal_qty);
                return;
            }
            //batch_dt.InsertQuery(decimal.Parse(Request.QueryString["BATCH_ID"].ToString()), decimal.Parse(ddlPOItemList.SelectedItem.Value),
            //    decimal.Parse(txtBatchQty.Text), txtRemarks.Text);
            Master.show_success("Item Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            batch_dt.Dispose();
            GC.Collect();
        }
    }

    protected void ddlPOItemList_DataBinding(object sender, EventArgs e)
    {
        ddlPOItemList.Items.Clear();
        ddlPOItemList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlPOItemList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtPOQty.Text = WebTools.GetExpr("PO_QTY", "PIP_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlPOItemList.SelectedValue + "'");
        txtBatchQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_PO_BATCH_BAL", " WHERE PO_ITEM_ID='" + ddlPOItemList.SelectedValue + "'");
    }
}