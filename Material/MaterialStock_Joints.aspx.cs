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
        if (!WebTools.UserInRole("PIP_WIC_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        Master.HeadingMessage = "Materials - Joint Dependences";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStock.aspx");
    }
    protected void jointsGridView_DataBound(object sender, EventArgs e)
    {
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
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        db_export.ExportDataSetToExcel(JointsDataSource, "Joints.xls");
    }
}
