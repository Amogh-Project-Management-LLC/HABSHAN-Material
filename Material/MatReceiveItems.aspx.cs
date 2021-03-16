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

public partial class Material_MatReceiveItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string mrir = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID=" +
                Request.QueryString["MAT_RCV_ID"]);
            Master.HeadingMessage = "MRR Materials (" + mrir + ")";

        }
        if (WebTools.UserInRole("MM_DELETE_ALL"))
        {
            btnDeleteAll.Visible = true;
            return;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceive.aspx");
    }


    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void itemsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }

    protected void itemsGridView_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void itemsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        //   string mat_descr = WebTools.GetExpr("MAT_DESCR", "VIEW_ADAPTER_MAT_RCV_DETAIL"," WHERE RCV_ITEM_ID=" + itemsGridView.SelectedValue.ToString());
        //  Master.ShowMessage(mat_descr);
    }
    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }

        Response.Redirect("MatReceiveNewItem.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }

    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE_ALL"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string RCV_ITEM_ID = "";
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGridView.SelectedItems)
            {

                RCV_ITEM_ID = item["RCV_ITEM_ID"].Text;
                sql = WebTools.ExeSql("DELETE FROM PIP_MAT_RECEIVE_DETAIL WHERE  RCV_ITEM_ID=" + RCV_ITEM_ID);

            }
            Master.ShowSuccess("Successfully Deleted Selected Items");
            itemsGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

    }

    protected void itemsGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =8 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =8";
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