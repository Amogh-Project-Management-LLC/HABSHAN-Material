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
using dsMaterialATableAdapters;

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
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
            Master.HeadingMessage = "Material Return - Register";
            txtRetNumber.Text = "- Select To Store -";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReturn.aspx");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_RETURNTableAdapter ret = new PIP_MAT_RETURNTableAdapter();
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");

            ret.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtRetNumber.Text,
                txtCreateDate.SelectedDate.Value,
                txtRetby.Text,
                ddlArea.SelectedValue,
                decimal.Parse(cboStore2.SelectedValue.ToString()),
                txtRemarks.Text,decimal.Parse(user_id),
                Decimal.Parse(RadDropDownList1.SelectedValue.ToString()));

            Master.ShowMessage(txtRetNumber.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
        }
        finally
        {
            ret.Dispose();
        }
    }

    private void set_ret_no()
    {
        if (cboStore2.SelectedValue.ToString() == "-1")
        {
            txtRetNumber.Text = "";
            return;
        }
        try
        {
          
            string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + cboStore2.SelectedValue.ToString());
            string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);
            string prefix = "MAT-RET-" + short_name + "-";
            txtRetNumber.Text = General_Functions.NextSerialNo("PIP_MAT_RETURN", "RETURN_NO", prefix, 3,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND STORE_ID2 IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void cboStore1_SelectedIndexChanged(object sender, EventArgs e)
    {
     
    }

    protected void ddlArea_DataBinding(object sender, EventArgs e)
    {
        ddlArea.Items.Clear();
        ddlArea.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void cboStore2_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_ret_no();
    }

    protected void cboStore2_DataBinding(object sender, EventArgs e)
    {
        cboStore2.Items.Clear();
        cboStore2.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void RadDropDownList1_DataBinding(object sender, EventArgs e)
    {
        RadDropDownList1.Items.Clear();
        RadDropDownList1.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", "-1"));
    }
}