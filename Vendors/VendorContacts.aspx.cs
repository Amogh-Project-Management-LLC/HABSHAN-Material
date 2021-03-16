using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendors_VendorContacts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Vendor Contact Details<br/>";           
            Master.HeadingMessage += WebTools.GetExpr("VENDOR_NAME", "VENDOR_MASTER", " VENDOR_ID='" + Request.QueryString["Arg1"] + "'");
            Master.AddModalPopup("~/Vendors/VendorContactAdd.aspx?Arg1=" + Request.QueryString["Arg1"], btnAdd.ClientID, 450, 650);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Vendors.aspx");
    }
}