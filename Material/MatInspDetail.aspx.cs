using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MatInspDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MRIR (";
            Master.HeadingMessage += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Request.QueryString["MIR_ID"].ToString() + "'");
            Master.HeadingMessage += ")";

            Master.AddModalPopup("~/Material/MatInspDetailAdd.aspx", btnAdd.ClientID, 600, 700);
            Master.AddModalPopup("~/Material/MatInspDetailView.aspx", btnView.ClientID, 600, 700);
            Master.RadGridList = grdMRIRItems.ClientID;
        }
        if (WebTools.UserInRole("Admin"))
        {

            btnDeleteAll.Visible = true;
            this.grdMRIRItems.Columns[2].Visible = true;
            return;
        }
        else
        {
            this.grdMRIRItems.Columns[2].Visible = false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MatInsp.aspx");
    }

    protected void grdMRIRItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popUp_MIR_ITEM_ID"] = grdMRIRItems.SelectedValue;
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string doc_no = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + Request.QueryString["MIR_ID"] + "'");
        string doc_id = Request.QueryString["MIR_ID"];
        string ret_url = "MatInspDetail.aspx?MIR_ID=" + doc_id;
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + ret_url);
    }

    protected void grdMRIRItems_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MRIR_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MRIR_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }

    protected void grdMRIRItems_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MRIR_DELETE"))
        {
           grdMRIRItems.AllowAutomaticDeletes = false;
           GridButtonColumn gridbutton = (GridButtonColumn)grdMRIRItems.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)grdMRIRItems.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            grdMRIRItems.AllowAutomaticDeletes = true;
            
        }
        if (!WebTools.UserInRole("MRIR_DELETE"))
        {
            grdMRIRItems.AllowAutomaticUpdates = false;
        }
        else
        {
            grdMRIRItems.AllowAutomaticUpdates = true;
        }

    }

    protected void btnImportFromMR_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatInspDetailImport.aspx?MIR_ID=" + Request.QueryString["MIR_ID"]);
    }
    protected void btnImportExcel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=11&RetUrl=~/Material/MatInsp.aspx");
    }


    protected void grdMRIRItems_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =12 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =12";
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

        if (grdMRIRItems.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string MIR_ITEM_ID = "";
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in grdMRIRItems.SelectedItems)
            {
                
                MIR_ITEM_ID = item["MIR_ITEM_ID"].Text;
                sql = WebTools.ExeSql("DELETE FROM PRC_MAT_INSP_DETAIL WHERE  MIR_ITEM_ID=" + MIR_ITEM_ID);

                Master.ShowSuccess("Successfully Deleted all Items");
                grdMRIRItems.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }
}