using System;
using Telerik.Web.UI;

public partial class BasicReports_Report_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Reports";
        }
    }

    protected void btnViewReport_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count <= 0)
        {
            Master.notify_info("Select a Report!");
            return;
        }
        string asp_url = WebTools.GetExpr("ASP_URL", "REPORT_INDEX", "REPORT_CODE='" + RadGrid_REPORT_CODE() + "'");
        Response.Redirect(asp_url);
    }

    private string RadGrid_REPORT_CODE()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("REPORT_CODE").ToString();
            }
        }
        return string.Empty;
    }
}