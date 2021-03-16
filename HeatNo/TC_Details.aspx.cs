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
using dsGeneralTableAdapters;

public partial class HeatNo_TC_HN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        Master.HeadingMessage = "Test Certificates detail";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TC_Index.aspx?Filter=" + Request.QueryString["Filter"].ToString() +
            "&PageIndex=" + Request.QueryString["PageIndex"] +
            "&SelIndex=" + Request.QueryString["SelIndex"]);
    }

 
    protected void tcDetailsGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < tcDetailsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", tcDetailsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == tcDetailsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        tcDetailsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtItemCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are more than materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        PIP_TEST_CARDS_DETAILTableAdapter tc_detail = new PIP_TEST_CARDS_DETAILTableAdapter();
        try
        {
            tc_detail.InsertQuery(Decimal.Parse(Request.QueryString["TC_ID"]), mat_id, txtHeatNo.Text,
                decimal.Parse(txtQty.Text),
                txtRemarks.Text,
                txtMrItem.Text, txtPoItem.Text);

            tcDetailsGridView.DataBind();

            Master.ShowMessage(txtItemCode.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            tc_detail.Dispose();
        }
        finally
        {
            tc_detail.Dispose();
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if(!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
  
}