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

public partial class Material_MatReturn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Return";
        }
    }
    protected void returnGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < returnGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", returnGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == returnGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }


     
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        returnGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnRegist_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MatReturnRegister.aspx");
    }
   
    
    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (returnGridView.SelectedIndexes.Count <= 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        Response.Redirect("MatReturnItems.aspx?MAT_RET_ID=" + returnGridView.SelectedValue.ToString());
    }

    protected void returnGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnPreview_Click1(object sender, EventArgs e)
    {
        if (returnGridView.SelectedIndexes.Count <= 0)
        {
            Master.ShowMessage("Select the entire Retutn Number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=1&Arg1=" + returnGridView.SelectedValue.ToString());
    }

    protected void returnGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (returnGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string ret_id = returnGridView.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(28, ret_id, "MAT_RETURN", "MAT_RETURN", Response);
    }

    protected void returnGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mat_ret_id = item.GetDataKeyValue("MAT_RET_ID").ToString();
            string return_no = WebTools.GetExpr("RETURN_NO", "PIP_MAT_RETURN", " MAT_RET_ID = " + mat_ret_id);
            return_no = return_no.Replace("/", "-");
            string filename = return_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_RETURN'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_RETURN'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='PO PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =26 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =26";
            DataTable lbl_dt = WebTools.getDataTable(lbl_query);
            Label[] descLabel = new Label[30];
            int i = 0;
            foreach (DataRow row in lbl_dt.Rows)
            {
                string lbl_col = row["LBL_COL_NAME"].ToString();

                string str = (dataItem[lbl_col].Controls[0] as TextBox).Text;
                descLabel[i] = new Label();
                descLabel[i].Text = str;
                dataItem[lbl_col].Controls.Add(descLabel[i]);
                i++;
            }
        }
    }
}