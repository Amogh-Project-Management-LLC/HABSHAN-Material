using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialStock_ISO_MTO : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HiddenField1.Value = WebTools.GetExpr("MAT_CODE1", "PIP_MAT_STOCK", " MAT_ID = '" + Request.QueryString["MAT_ID"] + "'");
            Master.HeadingMessage = "ISOMETRIC MTO<br/>";
            Master.HeadingMessage += HiddenField1.Value;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        string url = Request.QueryString["RetUrl"];
        if (string.IsNullOrEmpty(url) || string.IsNullOrWhiteSpace(url))
        {
            Response.Redirect("MaterialStock.aspx");
        }
        else
        {
            Response.Redirect(url);
        }
    }
}