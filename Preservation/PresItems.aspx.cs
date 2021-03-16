using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PreservationItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PRESERVATION (";
            Master.HeadingMessage += WebTools.GetExpr("PRESERV_NO", "PRES_MAT", " PRESERV_ID='" + Request.QueryString["PRESERV_ID"].ToString() + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Preservation/PresDetail.aspx");
    }

   
    

    protected void btnImportFromMR_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Preservation/PresItemsAdd.aspx?PRESERV_ID=" + Request.QueryString["PRESERV_ID"]);
    }

    protected void gridPreservItems_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PRESERVATION_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PRESERVATION_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }

    protected void gridPreservItems_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PRESERVATION_DELETE"))
        {
            ItemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)ItemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)ItemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            ItemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PRESERVATION_DELETE"))
        {
            ItemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            ItemsGrid.AllowAutomaticUpdates = true;
        }
    }
}