using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendors_VendorsNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Register New Vendor");
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsVendorsTableAdapters.VIEW_VENDOR_MASTERTableAdapter vendor = new dsVendorsTableAdapters.VIEW_VENDOR_MASTERTableAdapter();
        try
        {
            string country = WebTools.GetExpr("Country_ID", "Country_List", " Country_Name='" + txtCountry.Text + "'");
            decimal countryID = 0;
            if (!decimal.TryParse(country, out countryID))
            {
                Master.show_error("Invalid Country. " + txtCountry.Text + " Not Registered in Country List.");
                return;
            }

            decimal userid = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'"));
            vendor.InsertQuery(txtVendorCode.Text, txtVendorName.Text, txtAddLine1.Text, txtAddLine2.Text, txtAddLine3.Text, txtAddArea.Text,
                countryID, radApproved.SelectedValue, txtPhone.Text, txtFax.Text, "", userid, decimal.Parse(Session["PROJECT_ID"].ToString()));
            Master.show_success(txtVendorName.Text + " Registered to Vendor Database.");
        }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}