using dsMaterialBTableAdapters;
using System;

public partial class Erection_Additional_Mat_Regist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Transfer - Register";
            txtCreateBy.Text= Session["USER_NAME"].ToString();
            txtCreateDate.SelectedDate = System.DateTime.Today;
          
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_TRANSFTableAdapter issue = new PIP_MAT_TRANSFTableAdapter();
        try
        {
            if(decimal.Parse(Session["PROJECT_ID"].ToString())==-1)
            {
                Response.Redirect(Request.RawUrl);
                return;
            }

            if(txtTransfNo.Text=="")
            {
                Master.ShowError("Select Valid Request Number");
                return;
            }
                  
            issue.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTransfNo.Text, txtCreateDate.SelectedDate,
                txtCreateBy.Text,
                Decimal.Parse(ddFrom.SelectedValue.ToString()),
                Decimal.Parse(ddTo.SelectedValue.ToString()),
                txtRemarks.Text,
              Decimal.Parse(ddlReqNo.SelectedValue.ToString()));

            Master.ShowMessage(txtTransfNo.Text+" : Material transfer created.");
         
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }

    private void set_req_no()
    {
       
       string req_to_store= WebTools.GetExpr("REQ_TO_STORE_ID", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + ddlReqNo.SelectedValue+ "'");    
        string prefix = "MAT-TRANSF-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = '" + req_to_store + "')") + "-";
        txtTransfNo.Text = WebTools.NextSerialNo("PIP_MAT_TRANSF", "TRANSF_NO", prefix, 4, " A_STORE_ID =" + req_to_store);                 
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Mat_Transf.aspx");
    }

  
    protected void ddlReqNo_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddFrom.SelectedValue = WebTools.GetExpr("REQ_TO_STORE_ID", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + ddlReqNo.SelectedValue + "'");
        ddTo.SelectedText = WebTools.GetExpr("REQ_FROM", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + ddlReqNo.SelectedValue + "'");
        set_req_no();
    }
}