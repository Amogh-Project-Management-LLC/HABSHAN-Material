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

public partial class Material_MaterialStock_Alloc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Inventory Allocation <br/>" +
            WebTools.GetExpr("MAT_CODE1", "PIP_MAT_STOCK", "MAT_ID=" + Request.QueryString["MAT_ID"]);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStock.aspx");
    }
}
