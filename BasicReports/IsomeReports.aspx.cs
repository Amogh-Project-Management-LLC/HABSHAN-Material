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

public partial class BasicReports_IsomeReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage = "Isometric Reports";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=18&Arg1=" + txtFilter.Text);
    }
    protected void btnNDE_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=19&Arg1=" + txtFilter.Text);
    }
}