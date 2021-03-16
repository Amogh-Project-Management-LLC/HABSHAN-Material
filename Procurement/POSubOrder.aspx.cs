using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POSubOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po_no = WebTools.GetExpr("PO_NO", "PIP_PO", " PO_ID='" + Session["PO_ID"].ToString() + "'");
            Master.HeadingMessage("PO Sub-Order & Material Receipt - " + po_no);
        }
    }

    protected void checkSubOrdNotRequired_CheckedChanged(object sender, EventArgs e)
    {
        if (checkSubOrdNotRequired.Checked)
        {
            txtMatReceived.Enabled = false;
            txtSubOrderDate.Enabled = false;
            txtMatReceived.SelectedDate = null;
            txtSubOrderDate.SelectedDate = null;
            CheckMatReceivedNotRequired.Checked = true;
        }
        else
        {
            txtMatReceived.Enabled = true;
            txtSubOrderDate.Enabled = true;
            CheckMatReceivedNotRequired.Checked = false;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_ACTIVITY", " PO_ID='" + Session["PO_ID"].ToString() + "'");
        string sub_ord = checkSubOrdNotRequired.Checked ? "N" : "Y";
        string mat_rcv = CheckMatReceivedNotRequired.Checked ? "N" : "Y";

        if (sub_ord == "Y" && txtMatReceived.SelectedDate != null && txtSubOrderDate.SelectedDate != null)
        {
            if (txtMatReceived.SelectedDate < txtSubOrderDate.SelectedDate)
            {
                Master.show_error("Material Receive Date cannot be earlier than Sub Order Date.");
                return;
            }
        }
        
        Procurement_ATableAdapters.VIEW_PO_ACTIVITYTableAdapter activity = new Procurement_ATableAdapters.VIEW_PO_ACTIVITYTableAdapter();
        try
        {
            if (string.IsNullOrEmpty(po_id))
            {
                activity.InsertSubOrder(decimal.Parse(Session["PO_ID"].ToString()), txtSubOrderDate.SelectedDate, txtMatReceived.SelectedDate,
                    sub_ord, mat_rcv, txtRemarks.Text);
            }
            else
            {
                activity.UpdateSubOrderQuery(txtSubOrderDate.SelectedDate, txtMatReceived.SelectedDate, sub_ord, mat_rcv, txtRemarks.Text,
                    decimal.Parse(Session["PO_ID"].ToString()));
            }
            Master.show_success("Data Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            activity.Dispose();
        }

    }
}