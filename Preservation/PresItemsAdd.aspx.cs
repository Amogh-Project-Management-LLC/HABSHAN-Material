using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PreservationItemsAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "PRESERVATION (";
        Master.HeadingMessage += WebTools.GetExpr("PRESERV_NO", "PRES_MAT", " PRESERV_ID='" + Request.QueryString["PRESERV_ID"].ToString() + "'");
        Master.HeadingMessage += ")";
    }

    protected void HeaderCheck_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        foreach (GridDataItem item in itemsGrid.Items)
        {
            ((CheckBox)item.FindControl("checkPOItem")).Checked = cb.Checked;
        }
    }

    protected void checkPOItem_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Add.");
            return;
        }
        string mrr_no;
        string mat_code1;

        string acpt_qty;
        string presv_qty;
        string bal_to_presv;
        string mir_item_id;
        dsPreservationTableAdapters.VIEW_PRESERVATION_MAT_DETAILTableAdapter presv_item = new dsPreservationTableAdapters.VIEW_PRESERVATION_MAT_DETAILTableAdapter();
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {

                mir_item_id = item["MIR_ITEM_ID"].Text;
                mat_code1 = item["MAT_CODE1"].Text;
                acpt_qty = item["ACPT_QTY"].Text;
                presv_qty = item["PRESV_QTY"].Text.Trim();
                bal_to_presv = ((item["BAL_TO_PRESERV"].FindControl("BAL_TO_PRESERVLabel")) as RadTextBox).Text;

                if (decimal.Parse(acpt_qty) >= ((presv_qty.Trim() == "" ? 0 : decimal.Parse(presv_qty)) + decimal.Parse(bal_to_presv)))
                {
                    presv_item.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),decimal.Parse(Request.QueryString["PRESERV_ID"]), decimal.Parse(mir_item_id),WebTools.GetMatId(mat_code1, decimal.Parse(Session["PROJECT_ID"].ToString())),
                        decimal.Parse(bal_to_presv), null);
                }
                else
                {
                    Master.ShowError("Preservation quantity cannot be more than Accepted qty.");                   
                }
            }
            Master.ShowSuccess("Selected Items added to Preservation");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

        
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Preservation/PresItems.aspx?PRESERV_ID="+Request.QueryString["PRESERV_ID"]);
    }
}