using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistics_ShipmentDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "SHIPMENT DETAIL";
            Master.HeadingMessage += "(" + WebTools.GetExpr("SHIP_NO", "PRC_SHIP_MASTER", " WHERE SHIP_ID = '" + Request.QueryString["SHIP_ID"] + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ShipmentMaster.aspx");
    }
}