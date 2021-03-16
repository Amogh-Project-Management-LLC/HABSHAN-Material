using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Preservation_PreserveCodes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Preservation Codes";
            Master.AddModalPopup("~/Preservation/PreserveCodeAdd.aspx", btnAdd.ClientID, 450, 700);
            Master.AddModalPopup("~/Preservation/PreserveCodesGuide.aspx", btnCodeGuide.ClientID, 450, 700);
            Master.RadGridList = itemeGridView.ClientID;
        }
    }

    protected void itemeGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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

    protected void itemeGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PRES_DELETE"))
        {
            itemeGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemeGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "PRESERV_CODE";
            GridButtonColumn gridbutton = (GridButtonColumn)itemeGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemeGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PRES_EDIT"))
        {
            itemeGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            itemeGridView.AllowAutomaticUpdates = true;
        }
    }
}