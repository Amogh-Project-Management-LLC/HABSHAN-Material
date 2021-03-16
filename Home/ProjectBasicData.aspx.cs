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

public partial class Home_ProjectBasicData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Project Basic Data";
    }
    protected void btnLineService_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineServices.aspx");
    }
    protected void btnPMS_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipingSpecs.aspx");
    }
    protected void btnMatType_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialType.aspx");
    }
    protected void btnAreas_Click(object sender, EventArgs e)
    {
        Response.Redirect("AreaList.aspx");
    }
    protected void btnStores_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStores.aspx");
    }
    protected void btnSubcons_Click(object sender, EventArgs e)
    {
        Response.Redirect("SubContractors.aspx");
    }
    protected void btnFabShops_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipingFabShops.aspx");
    }
}