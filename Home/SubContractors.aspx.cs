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
using dsGeneralATableAdapters;

public partial class Home_SubContractors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Sub-Contractors";
        }
    }
    //protected void PipingSpecGridView_DataBound(object sender, EventArgs e)
    //{
    //    PageList.Items.Clear();
    //    for (int i = 0; i < PipingSpecGridView.PageCount; i++)
    //    {
    //        ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", PipingSpecGridView.PageCount), i.ToString());
    //        PageList.Items.Add(pageListItem);
    //        if (i == PipingSpecGridView.CurrentPageIndex)
    //            pageListItem.Selected = true;
    //    }
    //}
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        PipingSpecGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
 
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN") || !WebTools.UserInRole("SUBCONTRACTOR_ADD"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        if (!EntryTable.Visible)
        {
            btnSave.Visible = true;
            EntryTable.Visible = true;
        }
        else
        {
            btnSave.Visible = false;
            EntryTable.Visible = false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_SUB_CONTRACTORTableAdapter items = new VIEW_SUB_CONTRACTORTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(txtSubconID.Text),
                txtSubconName.Text, txtShortCode.Text,
                ddFieldSC.SelectedValue.ToString(), ddShopSC.SelectedValue.ToString());
            PipingSpecGridView.DataBind();
            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }
}