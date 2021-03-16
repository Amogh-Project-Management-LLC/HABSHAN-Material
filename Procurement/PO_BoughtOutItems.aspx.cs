using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PO_BoughtOutItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po = WebTools.GetExpr("PO_NO", "PIP_PO", " PO_ID = '" + Session["PO_ID"].ToString() + "'");
            Master.HeadingMessage = "Inspection of Bought Out Items - " + po;
            Master.AddModalPopup("~/Procurement/PO_BoughtOutItemsAdd.aspx", btnAdd.ClientID, 450, 650);
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