using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POBatchCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New Batch");
            string uname = Session["USER_NAME"].ToString();
            txtCreateBy.Text = uname;
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            txtCreateDate.SelectedDate = System.DateTime.Today;
            txtRevCreateDate.SelectedDate = System.DateTime.Today;
        }
    }

    protected void ddlPOList_DataBinding(object sender, EventArgs e)
    {
        ddlPOList.Items.Clear();
        ddlPOList.Items.Add(new Telerik.Web.UI.RadComboBoxItem("SELECT PO", ""));
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter batch = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter();
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");

            batch.InsertQuery(txtBatchNo.Text,decimal.Parse(user_id), System.DateTime.Now, decimal.Parse(ddlPOList.SelectedValue),txtRemarks.Text,ddlStatus.SelectedValue);
            Master.show_success("Batch No " + txtBatchNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            batch.Dispose();
            GC.Collect();
        }
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        decimal batch_no = WebTools.DMaxchar("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
        txtBatchNo.Text = (batch_no + 1).ToString();
        txtRevBatchNo.Text = (batch_no + 1).ToString();
        txtRevNo.Text = "1";
    }

    protected void btnNewRevision_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_LATEST_BATCH_PLAN_REVTableAdapter batch_rev = new Procurement_CTableAdapters.VIEW_LATEST_BATCH_PLAN_REVTableAdapter();
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            string batch_id = WebTools.GetExpr("BATCH_ID", "PIP_PO_BATCH_PLAN", " WHERE PO_ID='" + ddlPOList.SelectedValue + "' AND BATCH_NO='"+txtRevBatchNo.Text+"'");
            if(batch_id=="" || batch_id==string.Empty)
            {
                RadWindowManager1.RadAlert("Please Create Batch First", 400, 150, "Warning", "");
                return;
            }
            batch_rev.InsertQuery(decimal.Parse(batch_id), decimal.Parse(txtRevNo.Text), txtRevCreateDate.SelectedDate, decimal.Parse(user_id),
                txtPIMInitial.SelectedDate, txtPIMForecast.SelectedDate, txtPIMActual.SelectedDate,
                txtManuIntial.SelectedDate, txtManuForecast.SelectedDate, txtManuActual.SelectedDate,
                txtFATInitial.SelectedDate, txtFATForecast.SelectedDate, txtFATActual.SelectedDate,
                txtDeliveryBase.SelectedDate, txtDeliveryForecast.SelectedDate, txtDeliveryActual.SelectedDate,
                txtReceivedExworksInitial.SelectedDate, txtReceivedExworksForecast.SelectedDate, txtReceivedExworksActual.SelectedDate,
                txtReceivedPortInitial.SelectedDate, txtReceivedPortForecast.SelectedDate, txtReceivedPortActual.SelectedDate,
                txtReceivedSiteInitial.SelectedDate, txtReceivedSiteForecast.SelectedDate, txtReceivedSiteActual.SelectedDate, txtRevRemarks.Text,ddlRevStatus.SelectedText);

            Master.show_success("Batch No " + txtBatchNo.Text + "Revision Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            batch_rev.Dispose();
            GC.Collect();
        }
    }
}