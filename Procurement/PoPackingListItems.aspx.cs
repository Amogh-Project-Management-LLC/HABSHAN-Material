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
using PO_PackingListTableAdapters;
public partial class PoPackingListItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Packing List <br/> " +
            WebTools.GetExpr("PKL_NO", "MAT_PK_LIST", "PKL_ID=" + Request.QueryString["PKL_ID"]);
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PoPackingList.aspx");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row to delete!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Delete the selected row?");
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            Master.ShowMessage("Row deleted.");
            itemsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access denied!");
            return;
        }

        if (!EntryTable.Visible)
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }

        //-------------------------------------------------------------------
        VIEW_MAT_PK_LIST_DETAILTableAdapter items = new VIEW_MAT_PK_LIST_DETAILTableAdapter();
        try
        {
            items.InsertQuery(
                decimal.Parse(Request.QueryString["PKL_ID"]),
                txtPoItemNo.Text,
                mat_id,
                decimal.Parse(txtQty.Text),
                decimal.Parse(txtPkgQty.Text),
                decimal.Parse(ddPackageStyle.SelectedValue.ToString()),
                decimal.Parse(txtUnitWeightNet.Text),
                decimal.Parse(txtUnitWeightGross.Text),
                txtRemarks.Text
                );

            itemsGridView.DataBind();

            Master.ShowMessage(txtMatCode.Text + " Saved!");
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
