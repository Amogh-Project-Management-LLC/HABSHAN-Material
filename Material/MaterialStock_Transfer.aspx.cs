using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialStock_Transfer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Stock - Transfer/Return<br/>";
            Master.HeadingMessage += WebTools.GetExpr("Mat_code1", "PIP_MAT_STOCK", " MAT_ID='" + Request.QueryString["MAT_ID"].ToString() + "'");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialCatalogGrid.aspx");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string item = WebTools.GetExpr("Mat_code1", "PIP_MAT_STOCK", " MAT_ID='" + Request.QueryString["MAT_ID"].ToString() + "'");
        WebTools.ExportDataSetToExcel(SqlDataSource1, item + "_Transfer.xls");
    }
}