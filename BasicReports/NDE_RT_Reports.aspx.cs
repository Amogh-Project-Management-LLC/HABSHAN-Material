using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class BasicReports_FitupWeldingProg_Reps : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "RT Reports (Shop)";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void rblCat_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer.aspx?ReportID=" + ReportCode.SelectedItem.Value.ToString() +
            "&CAT_ID=" + rblCat.SelectedValue.ToString() +
            "&DATE_FROM=" + txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") +
            "&DATE_TO=" + txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy"));
    }
}