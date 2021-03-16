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
        Response.Redirect("~/Procurement/POBatchPlan.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter batch = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter();
        CheckBox cb;
        decimal mat_id;
        string batch_qty;
  
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
                    batch_qty = (item["BAL_QTY"].FindControl("BAL_QTYTextBox") as TextBox).Text;
                    batch.InsertQuery(decimal.Parse(Request.QueryString["BATCH_ID"]), decimal.Parse(po_item_id), decimal.Parse(batch_qty), null, decimal.Parse(po_id), mat_id, item["PO_ITEM_NO"].Text);
                }
            }
            Master.ShowMessage("Selected Items Added.");
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