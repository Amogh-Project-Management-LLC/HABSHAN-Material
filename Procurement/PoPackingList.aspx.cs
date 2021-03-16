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

public partial class PoPackingList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Packing List";
        }
    }
    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("PoPackingListItems.aspx?PKL_ID=" + IssueGridView.SelectedValue.ToString());
    }
    protected void LooseIssueGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    
    protected void btnNewIssue_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("PoPackingListNew.aspx");
    }
    protected void IssueGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < IssueGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", IssueGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == IssueGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        IssueGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            IssueGridView.DeleteRow(IssueGridView.SelectedIndex);
            Master.ShowMessage("Material deleted.");
            IssueGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the transfer number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=22&Arg1=" + IssueGridView.SelectedValue.ToString());
    }

    protected void btnPackages_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("PoPackingListPakg.aspx?PKL_ID=" + IssueGridView.SelectedValue.ToString());
    }
}