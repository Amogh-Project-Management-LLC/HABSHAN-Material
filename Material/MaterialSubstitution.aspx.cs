using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialSubstitution : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Substitution";
            Master.AddModalPopup("~/Material/MaterialSubstitutionNew.aspx", btnAdd.ClientID, 400, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "DELETE")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                Master.ShowWarn("Access Denied!");
                return;
            }
        }

        if (e.CommandName.ToUpper() == "EDIT")
        {
            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                Master.ShowWarn("Access Denied!");
                e.Canceled = true;
                return;
            }
        }
    }

    protected void btnDetails_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Request Number to Proceed.");
            return;
        }
        Response.Redirect("MaterialSubstitutionItems.aspx?REQ_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Request Number to Proceed.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=23&Arg1=" + itemsGrid.SelectedValue);
    }
}