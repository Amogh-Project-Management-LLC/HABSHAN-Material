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

public partial class BasicReports_TracerJointsReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Tracer Joints Report";
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer_B.aspx?ReportID=7&SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
}