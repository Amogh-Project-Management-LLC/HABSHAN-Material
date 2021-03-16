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
using dsPO_ShipmentTableAdapters;

public partial class PO_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New PO");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_POTableAdapter po = new PIP_POTableAdapter();
        try
        {
            po.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtPO.Text, txtCreateDate.SelectedDate.Value,
                txtManufacture.Text,
                txtOrigin.Text,
                txtPO_Terms.Text,
                txtPO_Place.Text);

            Master.show_success(txtPO.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}