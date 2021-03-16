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

public partial class BasicReports_DailyFitupWeldingRepNo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Daily Welding Report";
        }
    }

    protected void btnWelding_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "-1"; }
        else
        { report_id = "29"; }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id +
            "&WELD_REP_NO=" + txtReportNo.Text);

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
}