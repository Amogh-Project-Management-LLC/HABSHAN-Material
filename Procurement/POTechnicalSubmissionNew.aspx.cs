using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POTechnicalSubmissionNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("PO Technical Submission");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Procurement_ATableAdapters.VIEW_PO_TECHNICAL_SUBMISSIONTableAdapter po = new Procurement_ATableAdapters.VIEW_PO_TECHNICAL_SUBMISSIONTableAdapter();
        try
        {
            decimal po_id;
            bool po_flg = decimal.TryParse((WebTools.GetExpr("PO_ID", "PIP_PO", " PO_NO = '" + txtPO.Text + "'")), out po_id) ;
            if (!po_flg)
            {
                Master.show_error("Invalid PO Number. Specified PO could not be found in database.");
                return;
            }
            decimal userid = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'"));
            po.InsertQuery(po_id, txtITPSubmitDate.SelectedDate, txtITPReview.SelectedDate, txtITPApproved.SelectedDate, txtDWGSub.SelectedDate, txtDWGReview.SelectedDate,
                txtDWGApprove.SelectedDate, DateTime.Today, userid);

            Master.show_success("Technical Submission Details Updated for " + txtPO.Text);
        }
        catch (Exception ex)
        {
            po.Dispose();
            Master.show_error(ex.Message);            
        }
    }
}