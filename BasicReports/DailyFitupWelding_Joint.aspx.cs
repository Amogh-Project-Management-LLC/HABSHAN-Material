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

public partial class BasicReports_DailyWelding_Joint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Daily Welding Report (Joint wise)";
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "1.1"; }
        else
        { report_id = "1.1.1"; }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString() +
            "&MAT_TYPE=" + ddMaterial.SelectedValue.ToString());
    }
    protected void btnWelding_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "1.2"; }
        else
        { report_id = "1.2.1"; }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString() +
            "&MAT_TYPE=" + ddMaterial.SelectedValue.ToString());

    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }

    protected void rblCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            cboSubcon.Items.Clear();
            cboSubcon.Items.Add(new ListItem("-Select-", "99"));

            if (rblCat.SelectedValue.ToString() == "1")
                btnWeldingJGC.Enabled = true;
            else
                btnWeldingJGC.Enabled = false;
        }
    }

    protected void ddMaterial_DataBinding(object sender, EventArgs e)
    {
        ddMaterial.Items.Clear();
        ddMaterial.Items.Add(new ListItem("ANY", "XXX"));
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {

    }

    protected void btnWeldingJGC_Click(object sender, EventArgs e)
    {
        // JGC Format
        string report_id = "";
        report_id = "1.2.2"; // JGC

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString() +
            "&MAT_TYPE=" + ddMaterial.SelectedValue.ToString());
    }
}