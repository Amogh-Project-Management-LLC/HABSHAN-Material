using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POBatchCreateRev : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {          
            string uname = Session["USER_NAME"].ToString();           
            string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            string po_no = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID='" + po_id + "'");
            string batch_no = WebTools.GetExpr("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            txtBatchNo.Text = batch_no;
            txtRevNo.Text= WebTools.DMax("REV_NO", "PIP_PO_BATCH_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"])+1 +"";
            Master.HeadingMessage("New Batch Revision (PO No/Batch No : " + po_no + "/"+batch_no+")");
            txtCreateDate.SelectedDate = System.DateTime.Today;       
                set_rev_dates();
        }
    }

   protected void set_rev_dates()
    {
        try
        {
            string pim_intial = WebTools.GetExpr("PIM_INITIAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (pim_intial != "")
                txtPIMInitial.SelectedDate = DateTime.Parse(pim_intial);
            string manf_initial = WebTools.GetExpr("MANF_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (manf_initial != "")
                txtManuIntial.SelectedDate = DateTime.Parse(manf_initial);
            string fat_intial = WebTools.GetExpr("FAT_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (fat_intial != "")
                txtFATInitial.SelectedDate = DateTime.Parse(fat_intial);
            string rcvd_ex_intial = WebTools.GetExpr("RCVD_EXWORKS_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_ex_intial != "")
                txtReceivedExworksInitial.SelectedDate = DateTime.Parse(rcvd_ex_intial);
            string rcvd_port_intial = WebTools.GetExpr("RCVD_PORT_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_port_intial != "")
                txtReceivedPortInitial.SelectedDate = DateTime.Parse(rcvd_port_intial);
            string rcvd_site_initial = WebTools.GetExpr("RCVD_SITE_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_site_initial != "")
                txtReceivedSiteInitial.SelectedDate = DateTime.Parse(rcvd_site_initial);
            string delivery_initial = WebTools.GetExpr("DELIVERY_BASE_PLAN", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (delivery_initial != "")
                txtDeliveryBase.SelectedDate = DateTime.Parse(delivery_initial);
            ////////////////////////////////////////////
            string pim_forecast = WebTools.GetExpr("PIM_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (pim_forecast != "")
                txtPIMForecast.SelectedDate = DateTime.Parse(pim_forecast);
            string manf_forecast = WebTools.GetExpr("MANF_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (manf_forecast != "")
                txtManuForecast.SelectedDate = DateTime.Parse(manf_forecast);
            string fat_forecast = WebTools.GetExpr("FAT_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (fat_forecast != "")
                txtFATForecast.SelectedDate = DateTime.Parse(fat_forecast);
            string rcvd_ex_forecast = WebTools.GetExpr("RCVD_EXWORKS_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_ex_forecast != "")
                txtReceivedExworksForecast.SelectedDate = DateTime.Parse(rcvd_ex_forecast);
            string rcvd_port_forecast = WebTools.GetExpr("RCVD_PORT_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_port_forecast != "")
                txtReceivedPortForecast.SelectedDate = DateTime.Parse(rcvd_port_forecast);
            string rcvd_site_forecast = WebTools.GetExpr("RCVD_SITE_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_site_forecast != "")
                txtReceivedSiteForecast.SelectedDate = DateTime.Parse(rcvd_site_forecast);
            string del_forecast = WebTools.GetExpr("DELIVERY_FORECAST", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (del_forecast != "")
                txtDeliveryForecast.SelectedDate = DateTime.Parse(del_forecast);
            //////////////////
            string pim_actual = WebTools.GetExpr("PIM_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (pim_actual != "")
                txtPIMActual.SelectedDate = DateTime.Parse(pim_actual);
            string manf_actual = WebTools.GetExpr("MANF_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (manf_actual != "")
                txtManuActual.SelectedDate = DateTime.Parse(manf_actual);
            string fat_actual = WebTools.GetExpr("FAT_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (fat_actual != "")
                txtFATActual.SelectedDate = DateTime.Parse(fat_actual);
            string rcvd_ex_actual = WebTools.GetExpr("RCVD_EXWORKS_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_ex_actual != "")
                txtReceivedExworksActual.SelectedDate = DateTime.Parse(rcvd_ex_actual);
            string rcvd_port_actual = WebTools.GetExpr("RCVD_PORT_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_port_actual != "")
                txtReceivedPortActual.SelectedDate = DateTime.Parse(rcvd_port_actual);
            string rcvd_site_actual = WebTools.GetExpr("RCVD_SITE_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (rcvd_site_actual != "")
                txtReceivedSiteActual.SelectedDate = DateTime.Parse(rcvd_site_actual);
            string del_actual = WebTools.GetExpr("DELIVERY_ACTUAL", "VIEW_LATEST_BATCH_PLAN_REV", " WHERE BATCH_ID=" + Request.QueryString["BATCH_ID"]);
            if (del_actual != "")
                txtDeliveryActual.SelectedDate = DateTime.Parse(del_actual);
        }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_LATEST_BATCH_PLAN_REVTableAdapter batch_rev = new Procurement_CTableAdapters.VIEW_LATEST_BATCH_PLAN_REVTableAdapter();
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");

            batch_rev.InsertQuery(decimal.Parse(Request.QueryString["BATCH_ID"]), decimal.Parse(txtRevNo.Text), txtCreateDate.SelectedDate, decimal.Parse(user_id), 
                txtPIMInitial.SelectedDate, txtPIMForecast.SelectedDate, txtPIMActual.SelectedDate, 
                txtManuIntial.SelectedDate, txtManuForecast.SelectedDate, txtManuActual.SelectedDate, 
                txtFATInitial.SelectedDate, txtFATForecast.SelectedDate, txtFATActual.SelectedDate, 
                txtDeliveryBase.SelectedDate, txtDeliveryForecast.SelectedDate, txtDeliveryActual.SelectedDate, 
                txtReceivedExworksInitial.SelectedDate, txtReceivedExworksForecast.SelectedDate, txtReceivedExworksActual.SelectedDate, 
                txtReceivedPortInitial.SelectedDate, txtReceivedPortForecast.SelectedDate, txtReceivedPortActual.SelectedDate, 
                txtReceivedSiteInitial.SelectedDate, txtReceivedSiteForecast.SelectedDate, txtReceivedSiteActual.SelectedDate, txtRevRemarks.Text, ddlRevStatus.SelectedText);

            Master.show_success("Batch No " + txtBatchNo.Text + "Revision Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            batch_rev.Dispose();
            GC.Collect();
        }
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //decimal batch_no = WebTools.DMax("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
       // txtBatchNo.Text = (batch_no + 1).ToString();
    }
}