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
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Fitup and Welding Progress Report";
        }
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i <= cboSubcon.Items.Count; i++)
            {
                if (cboSubcon.Items[i].Value.ToString() == conn_as)
                {
                    cboSubcon.SelectedIndex = i;
                    break;
                }
            }
            cboSubcon.Enabled = false;
            rblCat.Enabled = false;
        }
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        string report_id;
        if (rblCat.SelectedValue.ToString() == "1")
        {
            report_id = "3";
        }
        else
        {
            report_id = "3.1";
        }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }
    protected void btnSize_Click(object sender, EventArgs e)
    {
        string report_id;
        if (rblCat.SelectedValue.ToString() == "1")
        {
            report_id = "4";
        }
        else
        {
            report_id = "4.1";
        }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }
    protected void btnMatWise_Click(object sender, EventArgs e)
    {
        string report_id;
        if (rblCat.SelectedValue.ToString() == "1")
        {
            report_id = "2";
        }
        else
        {
            report_id = "2.1";
        }

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/WeldingReports.aspx");
    }
    protected void rblCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            cboSubcon.Items.Clear();
            cboSubcon.Items.Add(new ListItem("-Select-", "99"));
            if (rblCat.SelectedValue.ToString() == "1")
            {
                btnShopWise.Enabled = true;
            }
            else
            {
                btnShopWise.Enabled = false;
            }
        }
    }
    protected void btnShopWise_Click(object sender, EventArgs e)
    {
        string report_id;
        report_id = "4.2";

        Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            txtDateFrom.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" +
            txtDateTo.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg3=" +
            cboSubcon.SelectedValue.ToString());
    }
}