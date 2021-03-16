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
using System.IO;

public partial class WeldingInspec_WPS_Numbers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "WPS Numbers";
            string wps_filter = Session["WPS_FILTER"].ToString();
            if (wps_filter != "")
            {
                txtSearch.Text = wps_filter;
            }
            else
            {
                txtSearch.Text = "%";
            }
        }
    }
    protected void btnWPS_Details_Click(object sender, EventArgs e)
    {
        if (wpsGridView.SelectedIndex < 0) return;
        Response.Redirect("~/WeldingInspec/WPS_Details.aspx?WPS_ID=" + wpsGridView.SelectedValue.ToString());
    }
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        if (wpsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the wps number!");
            return;
        }
        Response.Redirect(ConfigurationManager.AppSettings["WPS_Location"].ToString() +
            wpsGridView.SelectedValue.ToString() + ".pdf");
    }
    protected void wpsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < wpsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", wpsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == wpsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        wpsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["WPS_FILTER"] = txtSearch.Text;
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("WPS_Register.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (wpsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire WPS Number!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected WPS?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            wpsGridView.DeleteRow(wpsGridView.SelectedIndex);
            Master.ShowMessage("WPS deleted successfully!");
            wpsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
}