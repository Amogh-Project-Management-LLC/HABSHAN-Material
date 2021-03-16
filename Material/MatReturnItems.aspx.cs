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
using dsMaterialATableAdapters;
using Telerik.Web.UI;

public partial class Material_MatReturn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Return";
        }
    }
   
  
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReturn.aspx");
    }
    protected void btnregist_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MatReturnNewItem.aspx?MAT_RET_ID=" + Request.QueryString["MAT_RET_ID"]);
    }
    protected void returnGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //decimal mat_id = db_lookup.MAT_ID(ddlMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        //if (mat_id == 0)
        //{
        //    Master.ShowWarn("Material Code not found!");
        //    return;
        //}
        if (ddlReusable.SelectedValue.ToString() == "-1")
        {
            RadWindowManager1.RadAlert("Select Material Reusability", 300, 150, "Warning", "");
            return;
        }

            PIP_MAT_RETURN_LISTTableAdapter items = new PIP_MAT_RETURN_LISTTableAdapter();
        try
        {
            items.InsertQuery(
                Decimal.Parse(Request.QueryString["MAT_RET_ID"]),
            decimal.Parse(ddlMatCode.SelectedValue), decimal.Parse(ddlPo.SelectedValue), txtHeatNo.Text,txtDrumNo.Text,
            Decimal.Parse(txtQty.Text),
            txtPaintCode.Text,
            txtRemarks.Text);
            returnGridView.DataBind();
            RadWindowManager1.RadAlert("Material Added", 300, 150, "Success", "");

        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access denied!");
            return;
        }

        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }

    protected void ddlReusable_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if(ddlReusable.SelectedValue.ToString()=="N")
        {
            btnSubmit.Enabled = false;
            RadWindowManager1.RadAlert("Not Reusable Material to be entered in Material Quarantine", 300, 150, "Warning", "");
        }
        if (ddlReusable.SelectedValue.ToString() == "Y")
        {
            btnSubmit.Enabled = true;
        }

    }

    protected void btnImportExcel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=14&RetUrl=~/Material/MatReturnItems.aspx?MAT_RET_ID=" + Request.QueryString["MAT_RET_ID"]);
    }

    protected void returnGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =27 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =27";
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