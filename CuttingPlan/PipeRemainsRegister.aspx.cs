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

public partial class CuttingPlan_PipeRemainsRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Pipe Remains";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string proj_id = Session["PROJECT_ID"].ToString();
        string issue_id = cboIssue.SelectedValue.ToString();
        string mat_id = "";

        if (EntryTypeList.SelectedValue.ToString() == "2" && RadAutoCompleteBox1.Entries.Count <= 0)
        {
            Master.ShowError("No Item code entered!");
            return;
        }

        if (EntryTypeList.SelectedValue.ToString() == "2")
        {
            string mat_code = RadAutoCompleteBox1.Entries[0].Text;
            mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", "PROJ_ID=" + proj_id + " AND MAT_CODE1='" + mat_code + "'");
        }
        else
            mat_id = cboMatCode.SelectedValue.ToString();

        string sc_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_WO", "ISSUE_ID=" + issue_id);

        PIP_PIPE_REMAINTableAdapter remains = new PIP_PIPE_REMAINTableAdapter();
        try
        {
            remains.InsertQuery(decimal.Parse(mat_id),
                txtPaintCode.Text, txtHeatNo.Text,
                decimal.Parse(issue_id),
                decimal.Parse(txtLength.Text),
                decimal.Parse(proj_id),
                decimal.Parse(sc_id),
                null,
                null,
                txtRemarks.Text);

            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            remains.Dispose();
        }
    }

    protected void cboMatCode_DataBinding(object sender, EventArgs e)
    {
        cboMatCode.Items.Clear();
        cboMatCode.Items.Add(new ListItem("<Item Code>", "-1"));
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipeRemains.aspx");
    }

    protected void cboIssue_DataBinding(object sender, EventArgs e)
    {
        cboIssue.Items.Clear();
        cboIssue.Items.Add(new ListItem("", "-1"));
    }
    

    protected void EntryTypeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            if (EntryTypeList.SelectedValue.ToString() == "1")
            {
                cboMatCode.Visible = true;
                RadAutoCompleteBox1.Visible = false;
            }
            else
            {
                cboMatCode.Visible = false;
                RadAutoCompleteBox1.Visible = true;
            }
        }
    }

}