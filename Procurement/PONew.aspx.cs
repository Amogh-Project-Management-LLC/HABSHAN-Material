using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PONew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "New Purchase Order";

            txtPODate.SelectedDate = System.DateTime.Today;
            txtPORev.Text = "0";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POMaster.aspx");
    }

    protected void ddlDiscipline_DataBinding(object sender, EventArgs e)
    {
        ddlDiscipline.Items.Clear();
        ddlDiscipline.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlPOTerms_DataBinding(object sender, EventArgs e)
    {
        ddlPOTerms.Items.Clear();
        ddlPOTerms.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlDiscipline_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        //txtMRNumber.Entries.Clear();
        txtPOSubject.Text = "";
    }

    protected void txtMRNumber_EntryAdded(object sender, Telerik.Web.UI.AutoCompleteEntryEventArgs e)
    {

    }

    protected void txtMRNumber_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        //Master.ShowMessage(txtMRNumber.Entries[0].Text);
        if (txtMRNumber.Entries.Count > 0)
        {
            txtPOSubject.Text = WebTools.GetExpr("MR_TITLE", "PIP_MAT_REQUISITION", " WHERE MR_NO='" + txtMRNumber.Entries[0].Text + "'");
        }
    }

    protected void ddlPOTerms_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtPOTerms.Text += " " + ddlPOTerms.SelectedText;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnSaveImport_Click(object sender, EventArgs e)
    {
        SaveData();
        string po_id = WebTools.GetExpr("PO_ID", "PIP_PO", " WHERE PO_NO='" + txtPO.Text + "'");
        Response.Redirect("PO_MRImport.aspx?PO_ID=" + po_id);
    }

    protected void SaveData()
    {
        try
        {

            string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
            string mr_no = txtMRNumber.Entries[0].Text.Trim();
            string mr_id = WebTools.GetExpr("MR_ID", "PIP_MAT_REQUISITION", " WHERE MR_NO='" + mr_no + "'");
            Procurement_ATableAdapters.VIEW_ADAPTER_POTableAdapter po = new Procurement_ATableAdapters.VIEW_ADAPTER_POTableAdapter();
            po.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtPO.Text, txtPOSubject.Text, txtPODate.SelectedDate, txtPORev.Text,
                cboVendorList.SelectedItem.Value, txtPOSubject.Text, null, txtShipToName.Text, txtShipToAdd1.Text, txtShipToAdd2.Text,
                txtShipToAdd3.Text, txtShipRemarks.Text, txtPODelivery.Text, txtPOTerms.Text, decimal.Parse(ddlDiscipline.SelectedValue),
                decimal.Parse(mr_id), decimal.Parse(user_id), ddlWorkType.SelectedValue, txtBuyer.Text, ddlExpeditor.Text, txtCDDDate.SelectedDate);
            Master.ShowSuccess("PO Added Successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowError("Please Enter all fields," + ex.Message);

        }
    }
}