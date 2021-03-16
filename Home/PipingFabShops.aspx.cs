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
using dsGeneralBTableAdapters;

public partial class Home_PipingFabShops : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Fabrication Shops";
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
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
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
        Master.ShowWarn("Proceed delete selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            PipingSpecGridView.DeleteRow(PipingSpecGridView.SelectedIndex);
            Master.ShowMessage("Row deleted!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
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
        VIEW_PIP_FAB_SHOPTableAdapter items = new VIEW_PIP_FAB_SHOPTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(txtSubconID.Text),
                txtShopNo.Text, txtSubconName.Text, decimal.Parse(ddSubcon.SelectedValue.ToString()));
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