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

public partial class HeatNo_HeatNo_Joints : System.Web.UI.Page
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
            string heat_no = Request.QueryString["HEAT_NO"];
            Master.HeadingMessage = "Heat Number (" + heat_no + ") - Joints";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HeatNoIndex.aspx");
    }
    protected void jointsGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < jointsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", jointsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == jointsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        jointsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
}
