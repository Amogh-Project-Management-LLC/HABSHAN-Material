using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MTNReceiveNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Material Receive (MTN) - Register");
            txtReceiveBy.Text = Session["USER_NAME"].ToString();
            txtReceiveDate.SelectedDate = System.DateTime.Now;

            if (Session["MTN_RCV_STORE"] != null)
            {
                ddlReceiveStore.SelectedValue = Session["MTN_RCV_STORE"].ToString();
                setSerial(Session["MTN_RCV_STORE"].ToString());
                sqlTransSource.DataBind();
            }
        }
    }

    protected void ddlReceiveStore_DataBinding(object sender, EventArgs e)
    {
        ddlReceiveStore.Items.Clear();
        ddlReceiveStore.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlReceiveStore_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        Session["MTN_RCV_STORE"] = ddlReceiveStore.SelectedValue;
        setSerial(ddlReceiveStore.SelectedValue);
    }
    protected void setSerial(string rcv_store_id)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = '" + rcv_store_id+ "')");
        prefix += "-MTN-RCV-";
        txtReceiveNo.Text = WebTools.NextSerialNo("PIP_MAT_TRANSFER_RCV", "RCV_NUMBER", prefix, 4, "STORE_ID =" + rcv_store_id);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string trans_id = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_NO = '" + cboTransNo.Text + "'");

            if (string.IsNullOrEmpty(trans_id))
            {
                Master.show_error("Invalid Transfer No");
                return;
            }
            dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCVTableAdapter rcv = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCVTableAdapter();
            rcv.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtReceiveNo.Text, txtReceiveDate.SelectedDate, txtReceiveBy.Text, decimal.Parse(trans_id),
                txtRemarks.Text, decimal.Parse(ddlReceiveStore.SelectedValue), txtContainer.Text, txtPackingNo.Text);
            Master.show_success(txtReceiveNo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}