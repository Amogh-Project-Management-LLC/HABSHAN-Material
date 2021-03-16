using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POBatchImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Manufacturing Batch Detail<br/>";
            heading += WebTools.GetExpr("PO_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            heading += "/";
            heading += WebTools.GetExpr("BATCH_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");

            Master.HeadingMessage = heading;

           hiddenPO_ID.Value= WebTools.GetExpr("PO_ID", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");

        }
    }

    protected void checkHeaderItems_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;

        foreach (GridDataItem item in itemsGrid.Items)
        {
            ((CheckBox)item["checkCol"].FindControl("checkItems")).Checked = cb.Checked;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Procurement/POBatchDetail.aspx?BATCH_ID="+Request.QueryString["BATCH_ID"]);
    }

    protected void btnMove_Click(object sender, EventArgs e)
    {
        //Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter batch = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter();
        //CheckBox cb;
        //decimal mat_id;
        //string batch_qty;
        //decimal po_qty, rel_qty;
        //try
        //{
        //    string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
        //    foreach (GridDataItem item in itemsGrid.Items)
        //    {
        //        cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));
        //        if (cb.Checked)
        //        {
        //            string po_item_id = WebTools.GetExpr("PO_ITEM_ID", "PIP_PO_DETAIL", " WHERE PO_ID='" + po_id + "' AND PO_ITEM='" + item["PO_ITEM_NO"].Text + "'");
        //            mat_id = WebTools.GetMatId(item["MAT_CODE1"].Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
        //            batch_qty = (item["BAL_QTY"].FindControl("BAL_QTYTextBox") as TextBox).Text;
        //          //batch.InsertQuery(decimal.Parse(Request.QueryString["BATCH_ID"]), decimal.Parse(po_item_id), decimal.Parse(batch_qty), null, decimal.Parse(po_id), mat_id);
        //        }
        //    }
        //    Master.ShowMessage("Selected Items Moved.");
        //}
        //catch (Exception ex)
        //{
        //    Master.ShowError(ex.Message);
        //}
        ////////////////////////////////////////////////////////
        Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter batch_dt = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter();
        CheckBox cb;
        decimal mat_id;
        string move_batch_qty;
        int cnt=0;
        try
        {
            string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            foreach (GridDataItem item in itemsGrid.Items)
            {
                cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));
                if (cb.Checked)
                {
                    string po_item_id = WebTools.GetExpr("PO_ITEM_ID", "PIP_PO_DETAIL", " WHERE PO_ID='" + po_id + "' AND PO_ITEM='" + item["PO_ITEM_NO"].Text + "'");
                    mat_id = WebTools.GetMatId(item["MAT_CODE1"].Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
                    move_batch_qty = (item["BATCH_QTY"].FindControl("BATCH_QTYTextBox") as TextBox).Text;
                    string old_batch_no = WebTools.GetExpr("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID=" + Request.QueryString["Batch_ID"]);
                    string new_batch_no = WebTools.GetExpr("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID=" + decimal.Parse(ddlBatchNO.SelectedValue));
                    string remarks = "Moved From Batch: " + old_batch_no + " to Batch: " + new_batch_no;

                    batch_dt.InsertQuery(decimal.Parse(ddlBatchNO.SelectedValue), decimal.Parse(po_item_id), decimal.Parse(move_batch_qty), remarks, decimal.Parse(po_id), mat_id, item["PO_ITEM_NO"].Text);

                    //update existing Batch item qty
                    decimal o_batch_qty = decimal.Parse(item["BATCH_QTY"].Text);
                    
                    string updatequery = "UPDATE PIP_PO_BATCH_PLAN_DT SET BATCH_QTY=" + (o_batch_qty - decimal.Parse(move_batch_qty)) + " WHERE BATCH_ITEM_ID=" + item["BATCH_ITEM_ID"].Text;
                    WebTools.ExeSql(updatequery);
                    cnt++;
                }
            }
            Master.ShowMessage("Selected Items Moved.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally
        {
            //   insp.Dispose();
            itemsGrid.Rebind();
        }



    }

  
}