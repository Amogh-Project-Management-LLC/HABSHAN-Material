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

public partial class BasicReports_SelectArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Select Area";
            if (Request.QueryString["ReportID"] != null)
            {
                for (int i = 0; i < ReportList.Items.Count; i++)
                {
                    if (ReportList.Items[i].Value.ToString() == Request.QueryString["ReportID"])
                    {
                        ReportList.SelectedIndex = i;
                    }
                }
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer_B.aspx?ReportID=" + ReportList.SelectedValue.ToString() +
            "&AREA_L1=" + AreaNameList.SelectedValue.ToString());
    }

    protected void AreaNameList_DataBinding(object sender, EventArgs e)
    {
        AreaNameList.Items.Clear();
        AreaNameList.Items.Add(new ListItem("ALL", "XXX"));
        AreaNameList.Items[0].Selected = true;
    }
}