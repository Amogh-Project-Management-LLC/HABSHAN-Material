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
            Master.HeadingMessage("Add PO Inspection Request (RFI)");
            txtRFIDate.SelectedDate = System.DateTime.Now;
        }
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string discipline_id = WebTools.GetExpr("DISCIPLINE_ID", "PIP_PO", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
        ddlDisciplineList.SelectedValue = discipline_id;
        SerialNumber();
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

    protected void ddlStoreList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        SerialNumber();
    }

    protected void SerialNumber()
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-PO-RFI-";
        //prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = '" + ddlStoreList.SelectedValue + "')");
        //prefix += "-";

        txtRFINo.Text = WebTools.NextSerialNo("PIP_PO_INSP_REQUEST", "RFI_NO", prefix, 4, " WHERE 1=1");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
            Procurement_CTableAdapters.VIEW_PO_INSP_REQUESTTableAdapter rfi = new Procurement_CTableAdapters.VIEW_PO_INSP_REQUESTTableAdapter();
            rfi.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtRFINo.Text, txtRFIDate.SelectedDate, decimal.Parse(ddlPOList.SelectedValue),
                txtRemarks.Text, decimal.Parse(ddlDisciplineList.SelectedValue), System.DateTime.Now,txtRFIReportNo.Text,txtRFIReportDate.SelectedDate,decimal.Parse(user_id));
            Master.show_success(txtRFINo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}