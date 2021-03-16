using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistics_ShipmentNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage("REGISTER NEW SHIP");
    }

    protected void ddlCargoType_DataBinding(object sender, EventArgs e)
    {
        ddlCargoType.Items.Clear();
        ddlCargoType.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsLogistics_ATableAdapters.VIEW_PRC_SHIP_MASTERTableAdapter ship = new dsLogistics_ATableAdapters.VIEW_PRC_SHIP_MASTERTableAdapter();
        try
        {
            decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", "USER_NAME = '" + Session["USER_NAME"] + "'"));

            ship.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtShipNo.Text, System.DateTime.Now, txtDocRefNo.Text,
                txtNoOfPages.Text, txtDocRemarks.Text, ddlTransType.SelectedValue, txtShipConsignName.Text,
                txtRemarks.Text, user_id, System.DateTime.Now, decimal.Parse(ddlCargoType.SelectedValue), txtContainerNo.Text,
                txtContract.Text);
            Master.show_success("Ship Create Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}