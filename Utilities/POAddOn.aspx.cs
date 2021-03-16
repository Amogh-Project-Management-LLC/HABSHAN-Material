using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_POAddOn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Add-on Material to PPCS Data";
            Master.AddModalPopup("~/Utilities/POAddOnImport.aspx", btnUpload.ClientID, 600, 750);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmoghUpdates.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsGeneralATableAdapters.PIP_PPCS_ADD_MATTableAdapter item = new dsGeneralATableAdapters.PIP_PPCS_ADD_MATTableAdapter();
            item.InsertQuery(ddlItemCodes.SelectedItem.Text, decimal.Parse(txtQty.Text), txtPO.Text, txtPOItem.Text,
                 txtETADate.SelectedDate, decimal.Parse(txtOrdQty.Text), txtSplitID.Text);
            itemsGrid.Rebind();
            Master.ShowSuccess(ddlItemCodes.SelectedItem.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = false;
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }
}