using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Procurement_BTableAdapters;

public partial class Procurement_MRItemAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Items (";
            heading += WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " MR_ID='" + Request.QueryString["MR_ID"] + "'");
            heading += ")";
            Master.HeadingMessage(heading);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtTagNo.Entries.Count > 0)
            {
                VIEW_ADAPTER_MAT_REQ_DETAILSTableAdapter mr_detail = new VIEW_ADAPTER_MAT_REQ_DETAILSTableAdapter();
                mr_detail.InsertQuery(decimal.Parse(Request.QueryString["MR_ID"].ToString()), txtMRItem.Text, txtTagNo.Entries[0].Text,
                    txtMatDescr.Text, txtClientPartNo.Text, decimal.Parse(txtMRQty.Text), 0, "",
                    txtDelPoint.Text, txtConstArea.Text);
                Master.show_success("Item Added to MR.");
            }
            else
            {
                Master.show_error("Please enter valid material code");
            }
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void txtMatcodeNumber_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        //Master.ShowMessage(txtMRNumber.Entries[0].Text);
        if (txtTagNo.Entries.Count > 0)
        {
            txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + txtTagNo.Entries[0].Text + "'");
        }
    }
}