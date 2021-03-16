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
using dsCuttingPlanTableAdapters;

public partial class CuttingPlan_PipeRemainsHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string rem_ser = WebTools.GetExpr("REM_SERIAL", "VIEW_ADAPTER_PIPE_REM", "REM_ID=" + Request.QueryString["REM_ID"]);
            Master.HeadingMessage = "Pipe Remains History (" + rem_ser + ")";
            matIdField.Value = WebTools.GetExpr("MAT_ID", "PIP_PIPE_REMAIN", "REM_ID=" + Request.QueryString["REM_ID"]);
        }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipeRemains.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string rem_qty = WebTools.GetExpr("BAL_QTY", "VIEW_TOTAL_PIPE_REM", "REM_ID=" + Request.QueryString["REM_ID"]);


        PIP_PIPE_REMAIN_USETableAdapter rem_use = new PIP_PIPE_REMAIN_USETableAdapter();
        try
        {
            if (rem_qty != "" && rem_qty.Length > 0)
            {
                if (decimal.Parse(rem_qty) < decimal.Parse(txtQty.Text))
                {
                    Master.ShowWarn("Remain Quantity is not enough!");
                    return;
                }
            }

            rem_use.InsertQuery(decimal.Parse(Request.QueryString["REM_ID"]),
                decimal.Parse(cboBOM.SelectedValue.ToString()), decimal.Parse(txtQty.Text));
            historyGridView.DataBind();
            Master.ShowMessage("Insert completed successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            rem_use.Dispose();
        }

    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
        }
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (historyGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select a row!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected row?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            dsCuttingPlanTableAdapters.PIP_PIPE_REMAIN_USETableAdapter remain = new PIP_PIPE_REMAIN_USETableAdapter();
            remain.DeleteQuery(decimal.Parse(historyGridView.SelectedValue.ToString()));
            historyGridView.Rebind();
            Master.ShowMessage("Item Deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}