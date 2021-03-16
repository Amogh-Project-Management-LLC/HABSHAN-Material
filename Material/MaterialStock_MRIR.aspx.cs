using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialStock_MRIR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Stock - MRIR<br/>";
            Master.HeadingMessage += WebTools.GetExpr("Mat_code1", "PIP_MAT_STOCK", " MAT_ID='" + Request.QueryString["MAT_ID"].ToString() + "'");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        string url = Request.QueryString["RetUrl"];
        if (string.IsNullOrEmpty(url) || string.IsNullOrWhiteSpace(url))
        {
            Response.Redirect("MaterialCatalogGrid.aspx");
        }
        else
        {
            Response.Redirect(url);
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string itemcode = WebTools.GetExpr("Mat_code1", "PIP_MAT_STOCK", " MAT_ID='" + Request.QueryString["MAT_ID"].ToString() + "'");
        WebTools.ExportDataSetToExcel(sqlDataSource, itemcode + "_MRIR.xls");
    }
}