using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Logistics_ShippingReleaseNoteDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Packing List Material<br/>";
            Master.HeadingMessage += WebTools.GetExpr("SRN_NO", "PRC_SRN_MASTER", " WHERE SRN_ID='" + Request.QueryString["SRN_ID"] + "'");
            Master.AddModalPopup("~/Logistics/PackingListItemAdd.aspx?SRN_ID="+Request.QueryString["SRN_ID"], btnAdd.ClientID, 500, 650);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ShippingReleaseNote.aspx");
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_PL_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_PL_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PO_PL_EDIT"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PO_PL_DELETE"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }
}