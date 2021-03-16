using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Preservation_PreserveCodeAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage("Add Preservation Code");
    }

    protected void ddlStorageClass_DataBinding(object sender, EventArgs e)
    {
        ddlStorageClass.Items.Clear();
        ddlStorageClass.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void ddlWBS_DataBinding(object sender, EventArgs e)
    {
        ddlWBS.Items.Clear();
        ddlWBS.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void ddlCompanyVendor_DataBinding(object sender, EventArgs e)
    {
        ddlCompanyVendor.Items.Clear();
        ddlCompanyVendor.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void ddlPreservFreq_DataBinding(object sender, EventArgs e)
    {
        ddlPreservFreq.Items.Clear();
        ddlPreservFreq.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void ddlStorageClass_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string val = ddlStorageClass.SelectedValue;
        string str = txtCodes.Text.Substring(1, 6);
        txtCodes.Text = val + str;
    }
    protected void ddlWBS_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string[] str = txtCodes.Text.Split('-');
        txtCodes.Text = str[0] + "-" + ddlWBS.SelectedValue + "-" + str[2];
    }
    protected void ddlCompanyVendor_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string[] str = txtCodes.Text.Split('-');
        string freq = str[2].Substring(1, 2);
        txtCodes.Text = str[0] + "-" + str[1] + "-" + ddlCompanyVendor.SelectedValue + freq;
    }
    protected void ddlPreservFreq_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string[] str = txtCodes.Text.Split('-');
        string company = str[2].Substring(0, 1);
        txtCodes.Text = str[0] + "-" + str[1] + "-" + company + ddlPreservFreq.SelectedValue;

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            bool storage = (ddlStorageClass.SelectedIndex == 0);
            bool wbs = ddlWBS.SelectedIndex == 0;
            bool CompanyVendor = ddlCompanyVendor.SelectedIndex == 0;
            bool Preserv_Freq = ddlPreservFreq.SelectedIndex == 0;

            if (storage || wbs || CompanyVendor || Preserv_Freq)
            {
                Master.show_error("Invalid Code. Please select all fields!");
                return;
            }
            dsPreservationTableAdapters.VIEW_PRESERV_CODE_MASTERTableAdapter preserv = new dsPreservationTableAdapters.VIEW_PRESERV_CODE_MASTERTableAdapter();
            //preserv.InsertQuery(txtCodes.Text, txtDescription.Text, ddlStorageClass.SelectedValue, ddlWBS.SelectedValue, ddlCompanyVendor.SelectedValue,
            //     ddlPreservFreq.SelectedValue);
            preserv.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtCodes.Text, ddlStorageClass.SelectedValue,
                ddlWBS.SelectedValue, ddlCompanyVendor.SelectedValue, ddlPreservFreq.SelectedValue, txtDescription.Text);
            Master.show_success(txtCodes.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }  
}