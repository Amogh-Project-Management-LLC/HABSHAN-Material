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

public partial class Erection_Additional_Mat_Regist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Issue Request Register";
            txtIssueNo.Text = "-Select the subcon-";
            txtIssueby.Text = Session["USER_NAME"].ToString();
            txtCreateDate.SelectedDate = System.DateTime.Today;
        }
        
    }

    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i <= cboSubcon.Items.Count; i++)
            {
                if (cboSubcon.Items[i].Value.ToString() == conn_as)
                {
                    cboSubcon.SelectedIndex = i;
                    break;
                }
            }
            cboSubcon.Enabled = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_ISSUE_ADD_REQUESTTableAdapter issue = new PIP_MAT_ISSUE_ADD_REQUESTTableAdapter();
        try
        {
            issue.InsertQuery(txtIssueNo.Text,txtCreateDate.SelectedDate.Value,
                txtIssueby.Text, Decimal.Parse(cboSubcon.SelectedValue.ToString()),
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                Decimal.Parse(cboStore.SelectedValue.ToString()),
                txtRemarks.Text, Decimal.Parse(cboCategory.SelectedValue.ToString()),
                decimal.Parse(ddScope.SelectedValue.ToString()), txtRefNo.Text,decimal.Parse(ddlIssueType.SelectedValue)
                );
            Master.ShowMessage(txtIssueNo.Text + " Saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Additional_Mat.aspx");
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboSubcon.SelectedValue.ToString() == "-1")
        {
            txtIssueNo.Text = "";
            return;
        }
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
            cboSubcon.SelectedValue.ToString());
        txtIssueNo.Text = WebTools.NextSerialNo("PIP_MAT_ISSUE_ADD_REQUEST", "ISSUE_REQ_NO", "MIV-REQ-" + sc_name + "-", 4,
            "PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
            " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
    }

    protected void ddScope_DataBinding(object sender, EventArgs e)
    {
        ddScope.Items.Clear();
        ddScope.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void cboSubcon_DataBinding(object sender, EventArgs e)
    {
        cboSubcon.Items.Clear();
        cboSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void cboCategory_DataBinding(object sender, EventArgs e)
    {
        cboCategory.Items.Clear();
        cboCategory.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void cboStore_DataBinding(object sender, EventArgs e)
    {
        cboStore.Items.Clear();
        cboStore.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlIssueType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtRefNo.Text = ddlArea.SelectedText.ToString();
        if(ddlIssueType.SelectedText== "JC MIV")
        {
            ddlArea.Enabled = false;
            ddlJC.Enabled = true;
            ddlSiteJC.Enabled = false;
        }
        if (ddlIssueType.SelectedText == "SITE MIV")
        {
            ddlArea.Enabled = false;
            ddlJC.Enabled = false;
            ddlSiteJC.Enabled = true;
        }
        if (ddlIssueType.SelectedText == "AREA WISE")
        {
            ddlArea.Enabled = true;
            ddlJC.Enabled = false;
            ddlSiteJC.Enabled = false;
        }
    }

    protected void ddlArea_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

        txtRefNo.Text = ddlArea.SelectedText.ToString();
    }

    protected void ddlArea_DataBinding(object sender, EventArgs e)
    {
        ddlArea.Items.Clear();
        ddlArea.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlJC_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

        txtRefNo.Text = ddlJC.SelectedText.ToString();
    }

    protected void ddlSiteJC_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

        txtRefNo.Text = ddlSiteJC.SelectedText.ToString();
    }

    protected void ddlJC_DataBinding(object sender, EventArgs e)
    {

        ddlJC.Items.Clear();
        ddlJC.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlSiteJC_DataBinding(object sender, EventArgs e)
    {

        ddlSiteJC.Items.Clear();
        ddlSiteJC.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlIssueType_DataBinding(object sender, EventArgs e)
    {
        ddlIssueType.Items.Clear();
        ddlIssueType.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    
}