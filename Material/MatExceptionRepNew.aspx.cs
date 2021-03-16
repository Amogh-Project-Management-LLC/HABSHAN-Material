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

public partial class Material_MatExceptionRepNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
            Master.HeadingMessage = "Material Exception";
            txtReportNo.Text = "-Select the store-";

            txtReportDate.SelectedDate = System.DateTime.Today;



        }
    }
    private void go_abck()
    {
        Response.Redirect("MatExceptionRep.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

      if(cboMR.SelectedValue== ""  && ddlTransRecive.SelectedValue == "")
        {
            RadWindowManager1.RadAlert("Please select MRIR or Receive Number", 400, 150, "Warning", "");
            return;
        }
        PIP_MAT_EXCEPTION_REPTableAdapter mat_excp = new PIP_MAT_EXCEPTION_REPTableAdapter();
        try
        {
            decimal mir_id, rcv_id;
            bool IsMR_Source = decimal.TryParse(cboMR.SelectedValue, out mir_id);
            bool IsTrans_Source = decimal.TryParse(ddlTransRecive.SelectedValue, out rcv_id);
            int ref_id = 0, type_id = 0;
            string store_id = string.Empty;
            switch (RadioButtonList1.SelectedValue)
            {
                case "MRIR":
                    type_id = 1;
                    ref_id =int.Parse(cboMR.SelectedValue);
                    store_id=WebTools.GetExpr("STORE_ID", "PRC_MAT_INSP", " WHERE MIR_ID=" + cboMR.SelectedValue);
                    break;
                case "TRANS":
                    type_id = 2;
                    ref_id = int.Parse(ddlTransRecive.SelectedValue);
                    store_id = WebTools.GetExpr("STORE_ID", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID=" + ddlTransRecive.SelectedValue);
                    break;
            }
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");

            mat_excp.InsertQuery(txtReportNo.Text, txtReportDate.SelectedDate,
                Decimal.Parse(Session["PROJECT_ID"].ToString()), ref_id,
                txtRemarks.Text, null, decimal.Parse(ddlSubconList.SelectedValue),type_id, int.Parse(store_id),decimal.Parse(user_id));
            
            Master.ShowMessage("Report created.");
            mat_excp.Dispose();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            mat_excp.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_abck();
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (RadioButtonList1.SelectedValue)
        {
            case "MRIR":
                cboMR.Enabled = true;
                ddlTransRecive.Enabled = false;
     
                break;
            case "TRANS":
                
                cboMR.Enabled = false;
                ddlTransRecive.Enabled = true;
        
                break;
        }
    }

  
    protected void ddlSubconList_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtReportNo.Text = "";
        //string sc_id = WebTools.GetExpr("MRIR_SC_ID", "PRC_MAT_INSP", " MIR_ID='" + cboMR.SelectedValue + "'");
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-ESD-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + ddlSubconList.SelectedValue + "'") +"-";
        txtReportNo.Text = WebTools.NextSerialNo("PIP_MAT_EXCEPTION_REP", "REP_NO", prefix, 4, " WHERE SC_ID='" + ddlSubconList.SelectedValue + "'");
    }

    protected void ddlSubconList_DataBinding(object sender, EventArgs e)
    {
        ddlSubconList.Items.Clear();
        ddlSubconList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }




}