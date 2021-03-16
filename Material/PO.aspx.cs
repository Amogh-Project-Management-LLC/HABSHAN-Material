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

public partial class Material_PO : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Purchase Order";
            Master.RadGridList = "";
            Master.AddModalPopup("~/Material/PO_Register.aspx", btnNew.ClientID, 400, 600);
        }
    }

    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (PO_GridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the po number!");
            return;
        }
        Response.Redirect("PO_Items.aspx?PO_ID=" + PO_GridView.SelectedValue.ToString());
    }

    protected void PO_GridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < PO_GridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", PO_GridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == PO_GridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        PO_GridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access deined; Error 404.");
            return;
        }
        Response.Redirect("PO_Register.aspx");
    }
    protected void PO_GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("No Access!");
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (PO_GridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the po number!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected po?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            PO_GridView.DeleteRow(PO_GridView.SelectedIndex);
            Master.ShowMessage("PO deleted successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn("Unable to delete the PO!" + ex.Message);
        }
    }
    protected void ImageButtonPreview_Click(object sender, ImageClickEventArgs e)
    {
        if (PO_GridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the po number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=30&Arg1=" + PO_GridView.SelectedValue.ToString());
    }
}