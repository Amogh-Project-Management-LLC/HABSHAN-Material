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

public partial class BasicReports_SelectDateFromTo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Select Date From and To";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer_B.aspx?ReportID=10&DATE_FROM=" + txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") +
            "&DATE_TO=" + txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy"));
    }
}