using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialCTableAdapters;

public partial class Material_MaterialReuseNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Create Material Reuse Number");
            txtRetDate.SelectedDate = DateTime.Today;
            txtRetby.Text = Session["USER_NAME"].ToString();

            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnSubmit.Enabled = false;
            }
        }
    }

    protected void cboStore_SelectedIndexChanged(object sender, EventArgs e)
    {

        set_ret_no();
    }

    private void set_ret_no()
    {
        if (cboStore.SelectedValue.ToString() == "-1")
        {
            txtRetNumber.Text = "";
            return;
        }
        try
        {
            string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + cboStore.SelectedValue.ToString());
            string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);
            string prefix = "SPL-MRN-" + short_name + "-";
            txtRetNumber.Text = WebTools.NextSerialNo("PIP_MAT_REUSE", "MRN_NO", prefix, 3,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADP_MAT_REUSETableAdapter reuse = new VIEW_ADP_MAT_REUSETableAdapter();
        try
        {

            reuse.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtRetNumber.Text, DateTime.Parse(txtRetDate.SelectedDate.ToString()),
                txtRetby.Text, decimal.Parse(cboStore.SelectedValue.ToString()), txtRemarks.Text);

             Master.show_success("Material Reuse (" + txtRetNumber.Text + ") created successfully!");
        }
        catch (Exception ex)
        {
              Master.show_error(ex.Message);
        }
        finally
        {
            reuse.Dispose();
        }


    }
}