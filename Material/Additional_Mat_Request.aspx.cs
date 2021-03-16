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
using Telerik.Web.UI;
using System.IO;

public partial class Erection_MatIssueLoose : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["ADD_MIV_FILTER"].ToString() != "")
            {
                txtSearch.Text = Session["ADD_MIV_FILTER"].ToString();
            }
            Master.HeadingMessage = "Materials Issue Request";
        }
    }

    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the issue number.");
            RadWindowManager1.RadAlert("Select the issue number.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("Additional_MatItems.aspx?ADD_ISSUE_REQ_ID=" + IssueGridView.SelectedValue.ToString());
    }

    protected void LooseIssueGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            //Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }

    protected void btnNewIssue_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("Additional_Mat_Request_Regist.aspx");
    }

    protected void IssueGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < IssueGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", IssueGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == IssueGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        IssueGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //IssueGridView.DeleteRow(IssueGridView.SelectedIndex);
            //Master.ShowMessage("Material deleted.");
            //IssueGridView.SelectedIndex = -1;
            dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter item = new dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter();
            item.DeleteQuery(decimal.Parse(IssueGridView.SelectedValue.ToString()));
            IssueGridView.Rebind();
            Master.ShowMessage("Item Deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the Issue number!");
            RadWindowManager1.RadAlert("Select the issue number.", 400, 150, "Warning", "");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        //Master.ShowWarn("Proceed delete the selected issue number?");
        RadWindowManager1.RadAlert("Proceed delete the selected issue number?", 400, 150, "Warning", "");
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Selected the MIV number!");
            RadWindowManager1.RadAlert("Selected the MIV number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() + "&Arg1=" + IssueGridView.SelectedValue.ToString());
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["ADD_MIV_FILTER"] = txtSearch.Text;
    }

    protected void btnPipeRemain_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            /// Master.ShowMessage("Select the issue number.");
             RadWindowManager1.RadAlert("Select the issue number.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("Additional_Mat_Remain.aspx?ADD_ISSUE_REQ_ID=" + IssueGridView.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the issue number.");
            return;
        }
        Response.Redirect("Additional_Mat_BOM.aspx?ADD_ISSUE_REQ_ID=" + IssueGridView.SelectedValue.ToString());
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string ADD_ISSUE_REQ_ID = IssueGridView.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(15, ADD_ISSUE_REQ_ID, "MAT_ISSUE", "MAT_ISSUE_SUPP", Response);
    }

    protected void IssueGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string issue_id = item.GetDataKeyValue("ADD_ISSUE_REQ_ID").ToString();
            string issue_no = WebTools.GetExpr("ISSUE_REQ_NO", "PIP_MAT_ISSUE_ADD_REQUEST", " ADD_ISSUE_REQ_ID = " + issue_id);
            string filename = issue_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_ISSUE'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_ISSUE'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");

            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='ISSUE PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

    protected void IssueGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }


    }

    protected void IssueGridView_DataBinding(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("MM_DELETE"))
        {
            IssueGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)IssueGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "ISSUE NO";
            GridButtonColumn gridbutton = (GridButtonColumn)IssueGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            IssueGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MM_EDIT"))
        {
            IssueGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            IssueGridView.AllowAutomaticUpdates = true;
        }

    }
}