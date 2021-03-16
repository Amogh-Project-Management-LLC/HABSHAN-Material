using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MatRFIDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_VIEW") || WebTools.UserInRole("ADMIN")))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }

        if (!IsPostBack)
        {
            Master.HeadingMessage = "RFI Material List (";
            Master.HeadingMessage += WebTools.GetExpr("RFI_NO", "PIP_MAT_INSP_REQUEST", " WHERE RFI_ID='" + Request.QueryString["REQ_ID"].ToString() + "'");
            Master.HeadingMessage += ")";
        }
        if (WebTools.UserInRole("MM_DELETE_ALL"))
        {
            btnDeleteAll.Visible = true;
            return;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MatRFI.aspx");
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("RFI_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("RFI_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("RFI_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("RFI_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }

    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("RFI_ADD"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        Response.Redirect("MatRFIDetailAdd.aspx?RFI_ID=" + Request.QueryString["REQ_ID"]);
    }

    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =10 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =10";
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
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE_ALL"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string REQ_ITEM_ID = "";
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {

                REQ_ITEM_ID = item["REQ_ITEM_ID"].Text;
                sql = WebTools.ExeSql("DELETE FROM PIP_MAT_INSP_REQUEST_DT WHERE  REQ_ITEM_ID=" + REQ_ITEM_ID);

            }
            Master.ShowSuccess("Successfully Deleted Selected Items");
            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

    }
}