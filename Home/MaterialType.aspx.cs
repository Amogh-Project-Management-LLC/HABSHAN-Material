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

public partial class WeldingInspec_MaterialType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Types";
        }
    }
    protected void PipingSpecGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < PipingSpecGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", PipingSpecGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == PipingSpecGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        PipingSpecGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.ToUpper();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
}