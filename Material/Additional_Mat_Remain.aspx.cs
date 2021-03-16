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
using dsMaterial_IssueATableAdapters;

public partial class Additional_Mat_Remain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Additional Mat - Remain";
            scidField.Value = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", "ADD_ISSUE_ID=" + Request.QueryString["ADD_ISSUE_ID"]);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (returnGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row!?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            returnGridView.DeleteRow(returnGridView.SelectedIndex);
            Master.ShowMessage("Selected row deleted successfully.");
            returnGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Additional_Mat.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnregist_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnSave.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSave.Visible = false;
        }
    }
    protected void returnGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void txtMatCode_TextChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            decimal mat_id = WebTools.GetMatId(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
            ddRemains.Items.Clear();
            ddRemains.Items.Add(new ListItem("(Select Remain)", "-1"));
            if (mat_id == -1)
            {
                Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            }
            else if (mat_id == 0)
            {
                Master.ShowWarn("Material Code not found!");
            }
            matIdField.Value = mat_id.ToString();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        decimal mat_id = WebTools.GetMatId(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        string bal_qty = WebTools.GetExpr("BAL_QTY", "VIEW_TOTAL_PIPE_REM", "REM_ID=" + ddRemains.SelectedValue.ToString());
        if (bal_qty.Trim() != "" && bal_qty.Trim() != "0")
        {
            decimal bal_qty_dec = decimal.Parse(bal_qty);
            if (bal_qty_dec < decimal.Parse(txtQty.Text))
            {
                Master.ShowWarn("Remain Balance Qty is not enough!");
                return;
            }
        }
        else
        {
            Master.ShowWarn("Remain Balance Qty is not enough!");
            return;
        }
        VIEW_ADD_ISSUE_REMTableAdapter items = new VIEW_ADD_ISSUE_REMTableAdapter();
        try
        {
            items.InsertQuery(
                decimal.Parse(Request.QueryString["ADD_ISSUE_ID"]),
                decimal.Parse(ddRemains.SelectedValue),
                decimal.Parse(txtQty.Text), string.Empty);
            returnGridView.DataBind();
            Master.ShowMessage("New item created successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }
    protected void matIdField_ValueChanged(object sender, EventArgs e)
    {

    }
}