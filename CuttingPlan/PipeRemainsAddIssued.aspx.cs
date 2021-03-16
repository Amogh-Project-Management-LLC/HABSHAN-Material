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
using dsCuttingPlanTableAdapters;

public partial class CuttingPlan_PipeRemainsAddIssued : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string rem_ser = WebTools.GetExpr("REM_SERIAL", "VIEW_ADAPTER_PIPE_REM", "REM_ID=" + Request.QueryString["REM_ID"]);
            Master.HeadingMessage = "Additional Issued <br/>" + rem_ser;
        }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipeRemains.aspx");
    }
}