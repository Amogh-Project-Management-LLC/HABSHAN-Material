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

public partial class WeldingInspec_WPS_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "WPS Details";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WeldingInspec/WPS_Numbers.aspx");
    }
    protected void wpsDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {

    }
    protected void wpsDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.NewMode == DetailsViewMode.Edit)
        {
            if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
            {
                Master.ShowMessage("Access denied!");
                e.Cancel = true;
            }
        }
    }
}