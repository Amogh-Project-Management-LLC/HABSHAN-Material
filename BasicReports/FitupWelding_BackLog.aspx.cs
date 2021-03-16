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

public partial class BasicReports_Welding_FitupWelding_BackLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Fitup & Welding back log report";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=10&Arg1=" +
            cboJC.SelectedValue.ToString());
    }
    protected void btnPreview1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=11&Arg1=" +
            cboJC.SelectedValue.ToString());
    }
}
