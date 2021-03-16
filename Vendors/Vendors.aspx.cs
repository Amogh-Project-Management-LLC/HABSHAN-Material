using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Vendors_Vendors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Vendor Master";
            Master.AddModalPopup("~/Vendors/VendorsNew.aspx", btnNew.ClientID, 550, 650);
        }
        string user = Session["USER_NAME"].ToString().ToLower();
        string access_by = WebTools.GetExpr("ACCESS_BY", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        string all_records = WebTools.GetExpr("ALL_RECORDS", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        ACCESS_BY.Value = access_by;
        ALL_RECORDS.Value = all_records;
    }

    protected void btnConctacts_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            // Master.ShowWarn("Please Select Vendor to proceed.");
            RadWindowManager1.RadAlert("Please Select Vendor to proceed.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("VendorContacts.aspx?Arg1=" + itemsGrid.SelectedValue);
    }

    protected void btnDocs_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            //Master.ShowWarn("Please Select Vendor to proceed.");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("VendorDocuments.aspx?Arg1=" + itemsGrid.SelectedValue);
    }

    protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
    {
        {
            GridDataItem item = (GridDataItem)e.Item;
            string vendor_id = item.GetDataKeyValue("VENDOR_ID").ToString();
            string c_id = WebTools.GetExpr("CONTACT_ID", "VENDOR_CONTACTS", " WHERE VENDOR_ID='" + vendor_id + "'");
            if(c_id.Length>0)
            {
                // Master.ShowError("Delete Contacts list for the vendor first, then Delete the vendor!");
                RadWindowManager1.RadAlert("Delete Contacts list for the vendor first, then Delete the vendor!", 300, 150, "Warning", "");
                e.Canceled = true;
            }

        }
    }

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("VENDOR_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("VENDOR_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("VENDOR_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "VENDOR_CODE";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("VENDOR_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }
}