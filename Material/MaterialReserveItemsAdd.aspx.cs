using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialCTableAdapters;

public partial class Material_MaterialReserveItemsAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Reserve Items (";
            heading += WebTools.GetExpr("MAT_RES_NO", "MAT_RESERVE", " MAT_RES_ID = '" + Request.QueryString["REQ_ID"] + "'");
            heading += ")";
            Master.HeadingMessage(heading);
        }
    }

    protected void txtMatcode_TextChanged(object sender, EventArgs e)
    {
        txtMatcode.Text = txtMatcode.Text.ToUpper().Trim();
        ddMatcode.Items.Clear();
        ddMatcode.Items.Add(new ListItem("(Select One)", "-1"));
    }

    protected void ddMatcode_DataBinding(object sender, EventArgs e)
    {
        ddMatcode.Items.Clear();
        ddMatcode.Items.Add(new ListItem("(Select One)", "-1"));
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (decimal.Parse(txtIssuedQty.Text) < decimal.Parse(txtReleaseQty.Text))
        {
            Master.show_error("Release qty cannot be greater than Reserve qty");
            return;
        }
        VIEW_ADAPTER_RES_MATTableAdapter resmat = new VIEW_ADAPTER_RES_MATTableAdapter();
        try
        {
            resmat.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"]), decimal.Parse(ddMatcode.SelectedValue.ToString()),
                decimal.Parse(txtIssuedQty.Text), decimal.Parse(txtReleaseQty.Text), txtRemarks.Text);
           

            Master.show_success("Material Reserve Item Registered Successfully!");
        }

        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            resmat.Dispose();
        }
    }
   
}