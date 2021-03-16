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

public partial class BasicReports_SupportStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support Status";
            update_page_controls();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        if (ReportTypeList.SelectedValue.ToString() == "1")
        {
            Response.Redirect("ReportViewer_B.aspx?ReportID=10");
        }
        else if (ReportTypeList.SelectedValue.ToString() == "2")
        {
            Response.Redirect("ReportViewer_B.aspx?ReportID=11&AREA_L1=" + AreaNameList.SelectedValue.ToString());
        }
        else if (ReportTypeList.SelectedValue.ToString() == "3")
        {
            Response.Redirect("ReportViewer_B.aspx?ReportID=12&AREA_L2=" + AreaGroupList.SelectedValue.ToString());
        }
    }
    private void update_page_controls()
    {
        if (ReportTypeList.SelectedValue.ToString() == "1")
        {
            AreaNameList.Enabled = false;
            AreaGroupList.Enabled = false;
        }
        else if (ReportTypeList.SelectedValue.ToString() == "2")
        {
            AreaNameList.Enabled = true;
            AreaGroupList.Enabled = false;
        }
        else if (ReportTypeList.SelectedValue.ToString() == "3")
        {
            AreaNameList.Enabled = false;
            AreaGroupList.Enabled = true;
        }
    }
    protected void ReportTypeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        update_page_controls();
    }
    protected void AreaNameList_DataBinding(object sender, EventArgs e)
    {
        AreaNameList.Items.Clear();
        AreaNameList.Items.Add(new ListItem("ALL", "XXX"));
        AreaNameList.Items[0].Selected = true;
    }
}