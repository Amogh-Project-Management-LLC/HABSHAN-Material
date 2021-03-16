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

public partial class HeatNo_HeatNo_ESD : System.Web.UI.Page
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
            Master.HeadingMessage = "Heat Number (" + heat_no + ") - Excess/ Shortage/ Damage";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HeatNoIndex.aspx");
    }
    protected void matsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < matsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", matsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == matsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        matsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
}
