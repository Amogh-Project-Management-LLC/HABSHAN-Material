using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistics_CreateSRN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Register New SRN");
        }
        txtIssueDate.SelectedDate = System.DateTime.Today;
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        dsLogistics_ATableAdapters.VIEW_PRC_SRN_MASTERTableAdapter srn = new dsLogistics_ATableAdapters.VIEW_PRC_SRN_MASTERTableAdapter();
        try
        {
            decimal irn_id = decimal.Parse(WebTools.GetExpr("IRN_ID", "PIP_PO_IRN", " IRN_NO='" + txtAutoPONo.Text + "'"));
            decimal scn_id = decimal.Parse(WebTools.GetExpr("SCN_ID", "PRC_SCN_MASTER", " SCN_NO='" + txtSCN.Text + "'"));
            decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'"));
            srn.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtSRNNo.Text, irn_id, txtSRNDate.SelectedDate,
                txtSRNDeliveryPoint.Text, scn_id, txtRemarks.Text, decimal.Parse(txtSRNRev.Text), txtSRNDate.SelectedDate,
                user_id, System.DateTime.Now, user_id, txtIssueDate.SelectedDate);
            Master.show_success(txtSRNNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}