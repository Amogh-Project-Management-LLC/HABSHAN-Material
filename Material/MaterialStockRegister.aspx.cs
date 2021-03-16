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
using dsMainTablesATableAdapters;

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string bolt_len;
        if (txtBoltLength.Text == "")
        {
            bolt_len = "0";
        }
        else
        {
            bolt_len = txtBoltLength.Text;
        }
        PIP_MAT_STOCKTableAdapter stock = new PIP_MAT_STOCKTableAdapter();
        try
        {
            stock.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtMatCode1.Text, txtMatCode2.Text,txtMatCode3.Text,txtMatCode4.Text,txtglcode.Text,
                txtSizeDesc.Text, txtSize1.Text, txtSize2.Text, txtSchDesc.Text,
                txtSch1.Text, txtSch2.Text, decimal.Parse(cboItem.SelectedValue.ToString()),
                decimal.Parse(cboUOM.SelectedValue.ToString()), decimal.Parse(bolt_len), txtDesc.Text);
            Master.show_success(txtMatCode1.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            stock.Dispose();
        }
    }
}