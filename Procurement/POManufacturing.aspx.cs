using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POManufacturing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Manufacturing Status";
            Master.AddModalPopup("~/Procurement/POSubOrder.aspx", btnSubOrder.ClientID, 350, 650);
            Master.AddModalPopup("~/Procurement/PO_Assembly.aspx", btnAssembly.ClientID, 250, 450);
        }
    }

    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["PO_ID"] = RadGrid1.SelectedValue;
    }

    protected void btnBoughtOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("PO_BoughtOutItems.aspx");
    }

    protected void btnITPTesting_Click(object sender, EventArgs e)
    {
        Response.Redirect("PO_ITPTesting.aspx");
    }
}