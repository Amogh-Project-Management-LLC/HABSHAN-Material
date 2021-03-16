using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Add New MRIR");

            txtInspDate.SelectedDate = System.DateTime.Now;
            txtRecvdDate.SelectedDate = System.DateTime.Now;
            txtRcvBy.Text = Session["USER_NAME"].ToString();

            if (Session["MRIR_SUBCON_ID"] != null)
            {
                ddlSubcon.SelectedValue = Session["MRIR_SUBCON_ID"].ToString();
                setSerial(Session["MRIR_SUBCON_ID"].ToString());
                sqlSrcStore.DataBind();
            }

        }
    }

    protected void ddlSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        Session["MRIR_SUBCON_ID"] = ddlSubcon.SelectedValue;
        setSerial(ddlSubcon.SelectedValue);
    }
    protected void setSerial(string sc_id)
    {
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID ='" + Session["PROJECT_ID"].ToString() + "'");
        string prefix = job_code + "-MRIR-" + WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + sc_id + "'");
        prefix = prefix + "-";
        txtMIRNo.Text = WebTools.NextSerialNo("PRC_MAT_INSP", "MIR_NO", prefix, 4, " WHERE MRIR_SC_ID='" + sc_id + "'");
    }
    protected void ddlSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlSubcon.Items.Clear();
        ddlSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select Subcon)", "-1"));
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            decimal? po_no = null;
            decimal? mrv = null;
            if (ddlPOList.SelectedIndex > 0)
                po_no = decimal.Parse(ddlPOList.SelectedValue);

            if (ddlMRVList.SelectedIndex > 0)
                mrv = decimal.Parse(ddlMRVList.SelectedValue);

            string rfi_id = WebTools.GetExpr("RFI_ID", "PIP_MAT_INSP_REQUEST", " WHERE RFI_NO = '" + txtAutoRFINo.Text.Trim() + "'");
            if (rfi_id == null)
            {                
                Master.show_error("Invalid RFI Number");
                return;
            }
            dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter mir = new dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter();
            mir.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtMIRNo.Text, txtInspDate.SelectedDate, txtRecvdDate.SelectedDate,
                txtRcvBy.Text, po_no, mrv, decimal.Parse(ddlStoreList.SelectedValue), "N", txtRemarks.Text,
                txtSRNNumber.Text, txtShipNumber.Text, txtShipMode.Text, txtInvoiceNo.Text, txtPackingList.Text, null,
                decimal.Parse(ddlSubcon.SelectedValue), txtClientMIRNo.Text);
            string sql = "UPDATE PRC_MAT_INSP SET RFI_ID = '" + rfi_id + "' WHERE MIR_NO = '" + txtMIRNo.Text + "'";
            WebTools.ExeSql(sql);            
            Master.show_success("New MIR Number " + txtMIRNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlPOList_DataBinding(object sender, EventArgs e)
    {
        ddlPOList.Items.Clear();
        ddlPOList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlMRVList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        refreshData();
        //ddlDisciplineList.SelectedValue = WebTools.GetExpr("DISCIPLINE_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRRNumber.SelectedValue + "'");
        //txtShipNo.Text = WebTools.GetExpr("ship_no", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRRNumber.SelectedValue + "'");
    }

    protected void ddlMRVList_DataBinding(object sender, EventArgs e)
    {
        ddlMRVList.Items.Clear();
        ddlMRVList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void txtAutoRFINo_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        HiddenMRVID.Value = WebTools.GetExpr("MRR_ID", "PIP_MAT_INSP_REQUEST", " WHERE RFI_NO = '" + txtAutoRFINo.Text.Trim() + "'");

        ddlMRVList.DataBind();
        if (HiddenMRVID.Value != null)
        {
            ddlMRVList.SelectedValue = HiddenMRVID.Value;
            refreshData();
        }

        ddlMRVList.Enabled = false;
    }

    protected void refreshData()
    {
        string po_id = WebTools.GetExpr("PO_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
        ddlPOList.SelectedValue = po_id;
        txtSupplier.Text = WebTools.GetExpr("PO_VEND_NAME", "VIEW_ADAPTER_PO", " WHERE PO_ID='" + po_id + "'");
        txtSRNNumber.Text = WebTools.GetExpr("IRN_NO", "VIEW_ADAPTER_MAT_RCV", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
        txtShipNumber.Text = WebTools.GetExpr("SHIP_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
        txtShipMode.Text = WebTools.GetExpr("SHIP_MODE", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
    }

    protected void ddlStoreList_DataBinding(object sender, EventArgs e)
    {
        ddlStoreList.Items.Clear();
        ddlStoreList.Items.Add(new Telerik.Web.UI.DropDownListItem("Select", "-1"));
    }
}