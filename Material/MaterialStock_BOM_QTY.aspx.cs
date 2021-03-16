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

public partial class MaterialStock_BOM_QTY : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "BOM";
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        db_export.ExportDataSetToExcel(itemsDataSource, "BOM.xls");
    }
}
