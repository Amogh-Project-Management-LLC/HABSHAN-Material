using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POPunchlistDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        //{
        //    Response.Redirect("~/ErrorPages/NoAccess.htm");
        //}

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Punch List (";
            Master.HeadingMessage += WebTools.GetExpr("PUNCH_NO", "PIP_PUNCH_MASTER", " WHERE PUNCH_ID='" + Request.QueryString["PUNCH_ID"].ToString() + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Procurement/POPunchlist.aspx");
    }

    //protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    //{
    //    if (e.CommandName == "Delete")
    //    {
    //        if (!WebTools.UserInRole("PO_RFI_DELETE"))
    //        {
    //            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
    //        }
    //    }
    //    if (e.CommandName == "Edit")
    //    {
    //        if (!WebTools.UserInRole("PO_RFI_EDIT"))
    //        {
    //            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
    //            e.Canceled = true;
    //        }
    //    }
    //}

    //protected void itemsGrid_DataBinding(object sender, EventArgs e)
    //{
    //    if (!WebTools.UserInRole("PO_RFI_DELETE"))
    //    {
    //        itemsGrid.AllowAutomaticDeletes = false;
    //        GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
    //    }
    //    else
    //    {
    //        string[] datafields = new string[1];
    //        datafields[0] = "MAT_CODE1";
    //        GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
    //        gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
    //        gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
    //        gridbutton.ConfirmTextFields = datafields;

    //        itemsGrid.AllowAutomaticDeletes = true;
    //    }
    //    if (!WebTools.UserInRole("PO_RFI_EDIT"))
    //    {
    //        itemsGrid.AllowAutomaticUpdates = false;
    //    }
    //    else
    //    {
    //        itemsGrid.AllowAutomaticUpdates = true;
    //    }
    //}
}