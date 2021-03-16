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
using dsErectionATableAdapters;

public partial class Home_AreaListNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Area - Register";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AreaList.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_IPMS_AREATableAdapter area = new VIEW_IPMS_AREATableAdapter();
        try
        {
            area.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtAreaL1.Text,
                txtAreaL2.Text, txtAreaL3.Text, txtDescr.Text);
            Master.ShowMessage("Area added.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            area.Dispose();
        }
    }
}