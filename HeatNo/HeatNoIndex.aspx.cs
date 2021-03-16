using System;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class HeatNo_HeatNoIndex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Heat Numbers";

            string heat_no = Session["HN_FILTER"].ToString();

            if (heat_no != "")
            {
                txtFilter.Text = heat_no;
            }
        }
    }
    protected void HeatNoGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < HeatNoGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", HeatNoGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == HeatNoGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
        save_filter();
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        HeatNoGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    private bool selected()
    {
        if (HeatNoGridView.SelectedIndexes.Count < 0)
        {
            // Master.ShowMessage("Select the heat number.");
            RadWindowManager1.RadAlert("Select the heat number.", 400, 150, "Warning", "");
            return false;
        }
        else
        {
            return true;
        }
    }

    protected void HeatNoGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }

    protected void btnRecvd_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_Received.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnESD_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_ESD.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_Joints.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_BOM.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_MTC.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    private void save_filter()
    {
        Session["HN_FILTER"] = txtFilter.Text;
    }

    protected void HeatNoGridView_PageIndexChanged(object sender, EventArgs e)
    {
        Session["HN_INDEX"] = HeatNoGridView.SelectedIndexes.Count.ToString();
    }

    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
    }

    protected void HeatNoGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("HN_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("HN_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void HeatNoGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("HN_DELETE"))
        {
            HeatNoGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)HeatNoGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "HEAT_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)HeatNoGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            HeatNoGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("HN_EDIT"))
        {
            HeatNoGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            HeatNoGridView.AllowAutomaticUpdates = true;
        }
    }
}