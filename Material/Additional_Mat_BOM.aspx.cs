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

public partial class Material_Additional_Mat_BOM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Additional Mat - BOM <br/>" +
                WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", "ADD_ISSUE_ID=" + Request.QueryString["ADD_ISSUE_ID"]);

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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_MAT_ISSUE_ADD_BOMTableAdapter items = new VIEW_MAT_ISSUE_ADD_BOMTableAdapter();
        try
        {
            items.InsertQuery(
                decimal.Parse(Request.QueryString["ADD_ISSUE_ID"]),
                decimal.Parse(cboBOM.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text),
                txtPaintCode.Text,
                txtRemarks.Text);
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
    protected void cboBOM_DataBinding(object sender, EventArgs e)
    {
        cboBOM.Items.Clear();
        cboBOM.Items.Add(new ListItem("<BOM Item>", "-1"));
    }
    protected void cboBOM_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            txtPaintCode.Text = WebTools.GetExpr("PAINT_CODE", "PIP_BOM", "BOM_ID=" + cboBOM.SelectedValue.ToString());
            txtQty.Text = WebTools.GetExpr("NET_QTY", "PIP_BOM", "BOM_ID=" + cboBOM.SelectedValue.ToString());
        }
    }
}