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

public partial class Material_MaterialStock_Recon_A : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Material Summary";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialCatalogGrid.aspx");
    }

    protected void txtAutoMatCode_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        string matcode = txtAutoMatCode.Text;
        if (!string.IsNullOrEmpty(matcode.Trim()))
        {
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1 = '" + matcode + "'");
            Response.Redirect("MaterialStock_Recon_A.aspx?MAT_ID=" + mat_id);
        }
    }

    protected void txtAutoMatCode_EntryAdded(object sender, Telerik.Web.UI.AutoCompleteEntryEventArgs e)
    {
        
    }
}