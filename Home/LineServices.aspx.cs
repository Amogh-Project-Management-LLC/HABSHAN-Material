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

public partial class WeldingInspec_LineServices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Line Service";
        }
    }
    protected void serviceGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            e.Cancel = true;
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }
    }
    protected void serviceGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < serviceGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", serviceGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == serviceGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        serviceGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (serviceGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            serviceGridView.DeleteRow(serviceGridView.SelectedIndex);
            Master.ShowMessage("Selected row deleted successfully!");
            serviceGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineServicesRegister.aspx");
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
}