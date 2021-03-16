using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PO_BoughtOutItemsAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po = WebTools.GetExpr("PO_NO", "PIP_PO", " PO_ID = '" + Session["PO_ID"].ToString() + "'");
            Master.HeadingMessage("Inspection of Bought Out Items - " + po);          
        }
    }

    protected void ddlInspType_DataBinding(object sender, EventArgs e)
    {
        ddlInspType.Items.Clear();
        ddlInspType.Items.Add(new ListItem("(Select)", ""));
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Procurement_ATableAdapters.VIEW_PO_BOUGHT_OUT_INSPTableAdapter insp = new Procurement_ATableAdapters.VIEW_PO_BOUGHT_OUT_INSPTableAdapter();
        try
        {
            decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'"));

            insp.InsertQuery(decimal.Parse(Session["PO_ID"].ToString()), decimal.Parse(ddlInspType.SelectedValue), txtInspDate.SelectedDate,
                txtInspRep.Text, radInspResult.SelectedValue, txtRemaeks.Text, System.DateTime.Today, user_id);

            Master.show_success("Inspection Details Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            insp.Dispose();
        }
    }
}