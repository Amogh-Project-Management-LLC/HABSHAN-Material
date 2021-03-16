using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POPunchlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Punch List";
            Master.AddModalPopup("~/Procurement/POPunchlistAdd.aspx", btnNewPunch.ClientID, 350, 550);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    ////protected void btnMaterial_Click(object sender, EventArgs e)
    ////{
    ////    if (RadGrid1.SelectedIndexes.Count == 0)
    ////    {
    ////        // Master.ShowWarn("Select a row to conitnue.");
    ////        RadWindowManager1.RadAlert("Select a row to conitnue.", 400, 150, "Warning", "");
    ////        return;
    ////    }
    ////    Response.Redirect("MaterialQuarantineDetail.aspx?id=" + RadGrid1.SelectedValue);
    ////}

    //protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    //{

    //    if (e.CommandName == "Delete")
    //    {
    //        if (!WebTools.UserInRole("PUNCH_DELETE"))
    //        {
    //            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
    //        }
    //    }
    //    if (e.CommandName == "Edit")
    //    {
    //        if (!WebTools.UserInRole("PUNCH_UPDATE"))
    //        {
    //            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
    //            e.Canceled = true;
    //        }
    //    }
    //}

    //protected void RadGrid1_DataBinding(object sender, EventArgs e)
    //{

    //    if (!WebTools.UserInRole("PUNCH_DELETE"))
    //    {
    //        RadGrid1.AllowAutomaticDeletes = false;
    //        GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
    //    }
    //    else
    //    {
    //        string[] datafields = new string[1];
    //        datafields[0] = "PUNCH_NO";
    //        GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
    //        gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
    //        gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
    //        gridbutton.ConfirmTextFields = datafields;

    //        RadGrid1.AllowAutomaticDeletes = true;
    //    }
    //    if (!WebTools.UserInRole("PUNCH_UPDATE"))
    //    {
    //        RadGrid1.AllowAutomaticUpdates = false;
    //    }
    //    else
    //    {
    //        RadGrid1.AllowAutomaticUpdates = true;
    //    }
    //}

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Punch Number to continue.");
            return;
        }
        Response.Redirect("POPunchlistDetail.aspx?PUNCH_ID=" + RadGrid1.SelectedValue);
    }
    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Punch Number to continue.");
            return;
        }
        //string punch_no=WebTools.GetExpr("PUNCH_NO", "PIP_PUNCH_MASTER", " PUNCH_ID=" + RadGrid1.SelectedValue);
        Response.Redirect("POPunchlistDetailAdd.aspx?PUNCH_ID=" + RadGrid1.SelectedValue);
    }
}