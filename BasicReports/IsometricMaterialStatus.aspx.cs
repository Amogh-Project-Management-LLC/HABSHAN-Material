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

public partial class BasicReports_IsometricMaterialStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Isometric Material Status Report";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        string ISO_TITLE1 = (txtIsomeNo.Text.Length == 0 ? "XXX" : txtIsomeNo.Text);
        Response.Redirect("ReportViewer_B.aspx?ReportID=20&ISO_TITLE1=" + ISO_TITLE1 +
            "&AREA_L1=" + AreaNameList.SelectedValue.ToString());
    }

    protected void AreaNameList_DataBinding(object sender, EventArgs e)
    {
        AreaNameList.Items.Clear();
        AreaNameList.Items.Add(new ListItem("ALL", "XXX"));
        AreaNameList.Items[0].Selected = true;
    }
}