using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using dsPO_ShipmentATableAdapters;

public partial class Home_WeeklyReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Weekly Report";
        }
    }

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string sql = "INSERT INTO PIP_MAT_RECEIVE (PROJECT_ID,MAT_RCV_NO,RECV_DATE,RECV_BY,SHIP_NO,DELIVERY_POINT,STORE_ID, PO_ID, SHIP_MODE, SUPPLIER, REMARKS, DISCIPLINE_ID)" +
    //        " VALUES(" + Session["PROJECT_ID"].ToString() + ",'" +
    //        txtReportNo.Text + "','" + txtCreateDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "','" +
    //        txtRecvby.Text + "','" + txtShipNo.Text + "','" + txtDeliveryPoint.Text + "'," + cboStore.SelectedValue.ToString() + 
    //        ",'" + ddlPOList.SelectedValue+ "', '" + radShipMode.SelectedItem.Text + "', '" + txtSupplierVendor.Text + "', '" + txtRemarks.Text + "', '" + ddlDiscipline.SelectedValue + "')";

    //        General_Functions.ExeSql(sql);


    //        var collection = cboIRNList.CheckedItems;
    //        string mrr_id = WebTools.GetExpr("MAT_RCV_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_NO='" + txtReportNo.Text + "'");

    //        foreach (var item in collection)
    //        {
    //            int irn_id = int.Parse(item.Value);
    //            string mrr_irn_sql = "INSERT INTO PIP_MAT_RECEIVE_IRN(MAT_RCV_ID,IRN_ID) VALUES(" + int.Parse(mrr_id) + "," + irn_id + ")";
    //            General_Functions.ExeSql(mrr_irn_sql);
    //        }

    //        Master.ShowMessage("MRR " + txtReportNo.Text + " created successfully.");
    //    }
    //    catch (Exception ex)
    //    {
    //        Master.ShowWarn(ex.Message);
    //    }
    //}

    //protected void txtShipNo_TextChanged(object sender, EventArgs e)
    //{

    //}
    //protected void cboReport_SELECTedIndexChanged(object sender, EventArgs e)
    //{
    //    if (cboStore.SelectedValue.ToString() == "-1")
    //    {
    //        txtReportNo.Text = "";
    //        return;
    //    }
    //    try
    //    {
    //        Session["MRV_STORE"] = cboStore.SelectedValue;
    //        setSerial();
    //    }
    //    catch (Exception ex)
    //    {
    //        Master.ShowWarn(ex.Message);
    //    }
    //}
    //protected void setSerial()
    //{
    //    string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" +
    //           cboStore.SelectedValue.ToString());
    //    string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);
    //    string prefix = "MRR-" + short_name + "-";
    //    txtReportNo.Text = General_Functions.NextSerialNo("PIP_MAT_RECEIVE", "MAT_RCV_NO",
    //        prefix, 3, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
    //        " AND STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
    //}
    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("MatReceive.aspx");
    //}

    //protected void ddlDiscipline_DataBinding(object sender, EventArgs e)
    //{
    //    ddlDiscipline.Items.Clear();
    //    ddlDiscipline.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    //}

    //protected void ddlPOList_DataBinding(object sender, EventArgs e)
    //{
    //    ddlPOList.Items.Clear();
    //    ddlPOList.Items.Add(new ListItem("(Select)", ""));
    //}

    //protected void ddlPOList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string disc_id = WebTools.GetExpr("DISCIPLINE_ID", "PIP_PO", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");

    //    if (!string.IsNullOrEmpty(disc_id))
    //    {
    //        ddlDiscipline.SelectedValue = disc_id;
    //        txtSupplierVendor.Text = WebTools.GetExpr("PO_VEND_NAME", "VIEW_ADAPTER_PO", " WHERE PO_ID='" + ddlPOList.SelectedItem.Value + "'");
    //        txtDeliveryPoint.Text= WebTools.GetExpr("PO_DELIVERY_POINT", "VIEW_ADAPTER_PO", " WHERE PO_ID='" + ddlPOList.SelectedItem.Value + "'");
    //        radShipMode.SelectedValue= WebTools.GetExpr("PO_SHIPMENT_MODE", "PIP_PO", " WHERE PO_ID='" + ddlPOList.SelectedItem.Value + "'");
    //    }
    //    else
    //    {
    //        ddlDiscipline.SelectedValue = "";
    //        txtSupplierVendor.Text = "";
    //    }
    //}

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/Default.aspx");
    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        if (cboReport.SelectedValue == "-1")
        {
            RadWindowManager1.RadAlert("Please Select Any Report.", 300, 150, "Warning", "");
            return;
        }
        try
        {
            string asp_url = WebTools.GetExpr("ASPX_PATH", "IPMS_SYS_EXPORT", "EXPT_ID='" + cboReport.SelectedValue + "'");
            Response.Redirect(asp_url + "&Arg1=" + txtFromDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "&Arg2=" + txtToDate.SelectedDate.Value.ToString("dd-MMM-yyyy"));
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
}