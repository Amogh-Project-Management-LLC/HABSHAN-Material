using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POBatchDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Manufacturing Batch Import<br/>";
            heading += WebTools.GetExpr("PO_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            heading += "/";
            heading += WebTools.GetExpr("BATCH_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");

            Master.HeadingMessage = heading;

          //  Master.AddModalPopup("~/Procurement/POBatchDetailAdd.aspx?Batch_ID=" + Request.QueryString["BATCH_ID"], btnAdd.ClientID, 400, 600);
         //   Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POBatchPlan.aspx");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("POBatchImport.aspx?Batch_ID=" + Request.QueryString["BATCH_ID"]);
    }

    protected void btnMove_Click(object sender, EventArgs e)
    {
        Response.Redirect("POBatchItemsMove.aspx?Batch_ID=" + Request.QueryString["BATCH_ID"]);
    }
}