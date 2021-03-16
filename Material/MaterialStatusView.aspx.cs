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
using System.IO;
using Telerik.Web.UI;

public partial class Material_Catalog_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Status View";
        }
    }
    protected void DetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.NewMode == DetailsViewMode.Edit)
        {
            if (!WebTools.UserInRole("ADMIN"))
            {
                e.Cancel = true;
                Master.ShowWarn("Access denied!");
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialCatalogGrid.aspx");
    }
    protected void ddlMatCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string mat_id= ddlMatCode.SelectedValue;
        if (!string.IsNullOrEmpty(mat_id))
        {
             Response.Redirect("MaterialStatusView.aspx?MAT_ID=" + mat_id);
        }
    }
}

