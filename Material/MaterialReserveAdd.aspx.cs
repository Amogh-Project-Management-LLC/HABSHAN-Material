using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialCTableAdapters;

public partial class Material_MaterialReserveAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Add New Material Reserve Request");
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        VIEW_MAT_RESERVETableAdapter resv = new VIEW_MAT_RESERVETableAdapter();
        try
        {
            string reserve_date = txtResvDate.SelectedDate.ToString();
            resv.InsertQuery(txtReserveNo.Text, ddReserveType.SelectedValue.ToString(), decimal.Parse(ddSubcon.SelectedValue.ToString()),
                decimal.Parse(ddStores.SelectedValue.ToString()), DateTime.Parse(reserve_date), txtCreateby.Text, txtRemarks.Text);
           
            txtReserveNo.Text = string.Empty;
            ddSubcon.SelectedIndex = 0;
            Master.show_success(txtReserveNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            resv.Dispose();
        }
    }

    protected void ddSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            ddStores.Items.Clear();
            ddStores.Items.Add(new ListItem("(Store)", "-1"));
        }
        set_req_no1();
    }

    private void set_req_no1()
    {
        try
        {
            string sc_id = WebTools.GetExpr("SUB_CON_ID", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + ddSubcon.SelectedValue.ToString());
            string prefix = "MAT-RESERVE-";
            string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);

            txtReserveNo.Text = WebTools.NextSerialNo("MAT_RESERVE", "MAT_RES_NO", prefix + sc_name + "-", 4,
                " MAT_RES_SUBCON=" + ddSubcon.SelectedValue.ToString());

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddSubcon_DataBinding(object sender, EventArgs e)
    {
        ddSubcon.Items.Clear();
        ddSubcon.Items.Add(new ListItem("Select SUBCON", "-1"));
    }
    protected void ddStores_DataBinding(object sender, EventArgs e)
    {
        ddStores.Items.Clear();
        ddStores.Items.Add(new ListItem("Select Store", "-1"));
    }
}