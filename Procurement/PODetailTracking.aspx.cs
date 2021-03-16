using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PODetailTracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Split Details (";
            Master.HeadingMessage += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PODetailSplit.aspx?PO_ID=" + Request.QueryString["PO_ID"]);
    }
}