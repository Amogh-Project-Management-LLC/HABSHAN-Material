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

using dsGeneralTableAdapters;

public partial class BasicReports_Welder_Performance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Performance";
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=5&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }

    protected void btnMatWise_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=15&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }

    protected void btnPercentWise_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=16&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }

    protected void btnSize_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=17&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }

    protected void btnMonthly_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=5.1&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") +
            "&Arg2=" + txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") +
            "&Arg3=" + cboSubcon.SelectedValue.ToString());
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
}