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

public partial class Material_PurchaseOrderItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po_no = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID=" + Request.QueryString["PO_ID"]);
            Master.HeadingMessage = "PO (" + po_no + ")";
        }
    }
    protected void btnPOList_Click(object sender, EventArgs e)
    {
        Response.Redirect("PO.aspx");
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
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowWarn("Select the po item!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected po item?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            Master.ShowMessage("PO Item deleted successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn("Unable to delete the PO Item!" + ex.Message);
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

    }
}