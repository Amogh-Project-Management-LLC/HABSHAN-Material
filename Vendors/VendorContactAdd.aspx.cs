using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendors_VendorContactAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Contact Detail - ";
            heading += WebTools.GetExpr("VENDOR_NAME", "VENDOR_MASTER", " VENDOR_ID='" + Request.QueryString["Arg1"] + "'");

            Master.HeadingMessage(heading);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsVendorsTableAdapters.VENDOR_CONTACTSTableAdapter contact = new dsVendorsTableAdapters.VENDOR_CONTACTSTableAdapter();
        try
        {
            decimal userid = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'"));
            contact.InsertQuery(decimal.Parse(Request.QueryString["Arg1"]), radTitle.SelectedValue, txtFirstName.Text, txtLastName.Text,
                txtEmailID.Text, txtLandline.Text, txtMobile.Text, txtFax.Text, userid);
            Master.show_success(txtFirstName.Text + " " + txtLastName.Text + " Added to Contact List.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}