using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Preservation_PresDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Preservation Report Details";
            Master.AddModalPopup("~/Preservation/PresDetailAdd.aspx", btnAdd.ClientID, 550, 600);
            Master.RadGridList = griItems.ClientID;
        }
    }

    protected void RadMenu1_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {

    }

    protected void griItems_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PRES_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PRES_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void griItems_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PRES_DELETE"))
        {
            griItems.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)griItems.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "PRES_REP_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)griItems.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            griItems.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PRES_EDIT"))
        {
            griItems.AllowAutomaticUpdates = false;
        }
        else
        {
            griItems.AllowAutomaticUpdates = true;
        }

    }
}