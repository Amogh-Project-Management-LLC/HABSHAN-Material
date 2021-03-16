using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Logistics_ShippingReleaseNote : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Packing List";
            Master.AddModalPopup("~/Logistics/CreateSRN.aspx", btnAdd.ClientID, 500, 650);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select a record to continue.");
            return;
        }
        Response.Redirect("ShippingReleaseNoteDetail.aspx?SRN_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select a record to continue.");
            return;
        }

        if (ddlReportList.SelectedValue == "")
        {
            Master.ShowError("Please select a report to continue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?Arg1=" + itemsGrid.SelectedValue + "&ReportID=" + ddlReportList.SelectedValue);
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
       
    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PO_PL_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[0];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "SRN_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[0];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
      
    }
}