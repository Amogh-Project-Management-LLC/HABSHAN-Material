using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendors_VendorDocuments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Vendor Documents<br/>";
            Master.HeadingMessage += WebTools.GetExpr("VENDOR_NAME", "VENDOR_MASTER", " VENDOR_ID='" + Request.QueryString["Arg1"] + "'");            
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Vendors.aspx");
    }
}