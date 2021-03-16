using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POInspAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Add PO Punch list");
            //txtRFIDate.SelectedDate = System.DateTime.Now;
        }
    }
    protected void ddlPOPunchlist_DataBinding(object sender, EventArgs e)
    {
        ddlPOPunchlist.Items.Clear();
        //ddlPOPunchlist.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", "-1"));
    }
    protected void ddlPOPunchlist_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

    }

    protected void ddlPOPunchlist_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtPunchNumber.Text = "";
        set_Punchlist_Seq();
    }

    protected void set_Punchlist_Seq()
    {
        string prefix = "PUNCH-";
        prefix += WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
      //  prefix += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID='" + ddlPOPunchlist.SelectedValue + "'");
        prefix += "-" + ddlPOPunchlist.SelectedItem.Text+ "-";
        txtPunchNumber.Text = WebTools.NextSerialNo("PIP_PUNCH_MASTER", "PUNCH_NO", prefix, 3, " WHERE PO_ID=" + ddlPOPunchlist.SelectedValue.ToString());
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
            Procurement_CTableAdapters.VIEW_PUNCH_MASTERTableAdapter punchlist = new Procurement_CTableAdapters.VIEW_PUNCH_MASTERTableAdapter();
            punchlist.InsertQuery(txtPunchNumber.Text, decimal.Parse(ddlPOPunchlist.SelectedValue), decimal.Parse(Session["PROJECT_ID"].ToString()), txtCreateDate.SelectedDate,decimal.Parse(user_id), txtRemarks.Text, txtRaisedBy.Text);
            Master.show_success(txtPunchNumber.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}