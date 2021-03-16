using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PO_ITPTesting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po = WebTools.GetExpr("PO_NO", "PIP_PO", " PO_ID = '" + Session["PO_ID"].ToString() + "'");
            Master.HeadingMessage = "Testing as per ITP - " + po;
            Master.AddModalPopup("~/Procurement/PO_ITPTestingAdd.aspx", btnAdd.ClientID, 450, 650);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POManufacturing.aspx");
    }

    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }
}