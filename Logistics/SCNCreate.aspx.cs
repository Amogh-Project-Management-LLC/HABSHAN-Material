using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistics_SCNCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage("Create Shipping Consignment Note");
    }

    protected void txtSubmit_Click(object sender, EventArgs e)
    {
        dsLogistics_ATableAdapters.VIEW_PRC_SCN_MASTERTableAdapter scn = new dsLogistics_ATableAdapters.VIEW_PRC_SCN_MASTERTableAdapter();
        try
        {
            decimal ship_id = decimal.Parse(WebTools.GetExpr("SHIP_ID", "PRC_SHIP_MASTER", " WHERE SHIP_NO = '" + AutoShipNumber.Text + "'"));
            decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'"));

            scn.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtSCNNno.Text, ship_id, dateSCN.SelectedDate,
                txtRemarks.Text, user_id, System.DateTime.Now);
            Master.show_success("Ship Consignment Number " + txtSCNNno.Text + " Created.");            
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}