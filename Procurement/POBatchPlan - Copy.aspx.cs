using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POBatchPlan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Manufacturing Batch Plan";
            Master.AddModalPopup("~/Procurement/POBatchCreate.aspx", btnCreate.ClientID, 450, 600);
            Master.AddModalPopup("~/Procurement/POBatchRevNew.aspx", btnRevision.ClientID, 600, 800);
            Master.AddModalPopup("~/Procurement/BatchItemsSearch.aspx", btnSearchItems.ClientID, 600, 1000);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBatchItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Please select a record to continue.");
            return;
        }
        Response.Redirect("POBatchDetail.aspx?Batch_ID=" + itemsGrid.SelectedValue);
    }


}