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

public partial class Home_AreaList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Construction Areas";
        }
    }
    protected void areaGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("AreaListNew.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the area?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            areaGridView.DeleteRow(areaGridView.SelectedIndex);
        }
        catch (Exception ex)
        {
            Master.ShowWarn("Unable to delete the area! " + ex.Message);
        }
    }
    protected void areaGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < areaGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", areaGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == areaGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        areaGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
}