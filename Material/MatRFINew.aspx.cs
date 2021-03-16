using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatRFINew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Create Inspection Request (RFI)");
            txtRFIDate.SelectedDate = System.DateTime.Now;

            if (Session["MM_RFI_STORE"] != null)
            {
                ddlStoreList.SelectedValue = Session["MM_RFI_STORE"].ToString();
                SerialNumber(Session["MM_RFI_STORE"].ToString());
            }
        }
     
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string discipline_id = WebTools.GetExpr("DISCIPLINE_ID", "PIP_PO", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
        ddlDisciplineList.SelectedValue = discipline_id;
    }

    protected void ddlPOList_DataBinding(object sender, EventArgs e)
    {
        ddlPOList.Items.Clear();
        ddlPOList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlDisciplineList_DataBinding(object sender, EventArgs e)
    {
        ddlDisciplineList.Items.Clear();
        ddlDisciplineList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlStoreList_DataBinding(object sender, EventArgs e)
    {
        ddlStoreList.Items.Clear();
        ddlStoreList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlStoreList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        Session["MM_RFI_STORE"] = ddlStoreList.SelectedValue;
        SerialNumber(ddlStoreList.SelectedValue);
    }

    protected void SerialNumber(string store_id)
    {
        string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + store_id);
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-RFI-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = '" + store_id + "')");
        prefix += "-";
        txtRFINo.Text = WebTools.NextSerialNo("PIP_MAT_INSP_REQUEST", "RFI_NO", prefix, 4, " WHERE STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            dsMaterialETableAdapters.VIEW_MAT_INSP_REQUESTTableAdapter rfi = new dsMaterialETableAdapters.VIEW_MAT_INSP_REQUESTTableAdapter();
            rfi.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtRFINo.Text, txtRFIDate.SelectedDate, decimal.Parse(ddlPOList.SelectedValue),
                txtShipNo.Text, txtRemarks.Text, decimal.Parse(ddlDisciplineList.SelectedValue), decimal.Parse(ddlStoreList.SelectedValue), 
                decimal.Parse(ddlMRRNumber.SelectedValue),txtClientRFI.Text,decimal.Parse(user_id),txtRefDocs.Text,ddlStatus.SelectedValue,
                ddlCritical.SelectedValue,ddlInspClass.SelectedValue,ddlMatCert.SelectedValue,txtCompany.Text,txtName.Text,txtPhone.Text,txtEmail.Text,txtLocation.Text);
            Master.show_success(txtRFINo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlMRRNumber_DataBinding(object sender, EventArgs e)
    {
        ddlMRRNumber.Items.Clear();
        ddlMRRNumber.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select)", ""));
    }

    protected void ddlMRRNumber_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string po_id = WebTools.GetExpr("PO_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRRNumber.SelectedValue + "'");
        ddlPOList.SelectedValue = po_id;
        ddlDisciplineList.SelectedValue = WebTools.GetExpr("DISCIPLINE_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRRNumber.SelectedValue + "'");
        txtShipNo.Text = WebTools.GetExpr("ship_no", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRRNumber.SelectedValue + "'");
    }
}