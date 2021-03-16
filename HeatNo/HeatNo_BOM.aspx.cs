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

public partial class HeatNo_HeatNo_BOM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heat_no = Request.QueryString["HEAT_NO"];
            Master.HeadingMessage = "Heat Number (" + heat_no + ") - BOM";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HeatNoIndex.aspx");
    }
    protected void bomGridView_DataBound(object sender, EventArgs e)
    {

    }
}