using System;
using System.IO;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class HeatNo_TC_Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Certificates";

            string _filter = Session["TC_FILTER"].ToString();

            if (_filter != "")
            {
                txtFilter.Text = _filter;
            }

            Master.RadGridList = "";

           // Master.AddModalPopup("~/HeatNo/ShowMTC_PDF.aspx", btnShowPDF.ClientID, 20, 500);

            WebTools.Check_Session_Variable("popup_TC_ID");
        }
    }

  

   
    protected void btnAddTC_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            // Master.ShowWarn("Access Denied!");

            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("TC_New.aspx");
    }

    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
    }

    protected void tcGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            //Master.ShowWarn("Access Denied!");

            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }

    protected void tcGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < tcGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", tcGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == tcGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
        Session["TC_PG_INDEX"] = tcGridView.CurrentPageIndex;
        Session["TC_FILTER"] = txtFilter.Text;
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        tcGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void tcGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_TC_ID"] = tcGridView.SelectedValue.ToString();
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count < 0)
        {
            // Master.ShowWarn("Select the test certificate number!");

            RadWindowManager1.RadAlert("Select the test certificate number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("TC_Upload.aspx?TC_ID=" + tcGridView.SelectedValue.ToString() +
            "&Filter=" + txtFilter.Text + "&grdIndex=" + tcGridView.SelectedIndexes.ToString());
    }

    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count < 0)
        {
            // Master.ShowWarn("Select the test certificate number!");

            RadWindowManager1.RadAlert("Select the test certificate number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("TC_Details.aspx?Filter=" + txtFilter.Text +
            "&TC_ID=" + tcGridView.SelectedValue.ToString() +
            "&PageIndex=" + tcGridView.CurrentPageIndex.ToString() +
            "&SelIndex=" + tcGridView.SelectedIndexes.ToString());
    }

    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.Trim().ToUpper();
    }

    protected void tcGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("TC_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("TC_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void tcGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TC_DELETE"))
        {
            tcGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)tcGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "TC_CODE";
            GridButtonColumn gridbutton = (GridButtonColumn)tcGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            tcGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("TC_EDIT"))
        {
            tcGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            tcGridView.AllowAutomaticUpdates = true;
        }

    }

    protected void tcGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {    
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string tc_id = item.GetDataKeyValue("TC_ID").ToString();
                string mtc_code = WebTools.GetExpr("TC_CODE", "PIP_TEST_CARDS", " TC_ID ='" + tc_id + "'");
                string filename = mtc_code + ".pdf";

                string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");
                string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");

                string full_pdf_path = pdf_url + filename;
                string full_asp_path = pdf_asp_url + filename;
                Label pdf_label = (Label)item.FindControl("pdf");


                if (File.Exists(full_pdf_path))
                {
                    string url = "<a title='MTC PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                    Label pdficon = (Label)item.FindControl("pdf");
                    if (pdficon != null)
                        pdficon.Text = url;
                }
            }
    }

    protected void btnMTCHeatnos_Click(object sender, EventArgs e)
    {

    }
}