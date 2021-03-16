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
using dsMaterial_IssueATableAdapters;
using Telerik.Web.UI;

public partial class Erection_Additional_MatItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Issue Detail <br/>" +
                WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID=" + Request.QueryString["ADD_ISSUE_ID"]);            
        }
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Additional_Mat.aspx");
    }

  

  
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));

        if (mat_id == 0)
        {
            //Master.ShowWarn("Material Code not found!");
            RadWindowManager1.RadAlert("Material Code not found!", 400, 150, "Warning", "");
            return;
        }

        //if (ddlMatRequestNo.SelectedValue == "")
        //{
        //    //Master.ShowWarn("Select Material Request Number!");
        //    RadWindowManager1.RadAlert("Select Material Request Number!", 400, 150, "Warning", "");
        //    return;
        //}

        string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
        decimal bal_qty = db_lookup.DSum("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID=" + mat_id + " AND SUB_CON_ID=" + sub_con_id);
        if (bal_qty < decimal.Parse(txtQty.Text))
        {
            // Master.ShowWarn("Material not found in stock!, Please check the quantity carefully.");
            RadWindowManager1.RadAlert("Material not found in stock!, Please check the quantity carefully.", 00, 150, "Warning", "");
            return;
        }

        PIP_MAT_ISSUE_ADD_DETAILTableAdapter items = new PIP_MAT_ISSUE_ADD_DETAILTableAdapter();
        try
        {
            items.InsertQuery(
                Decimal.Parse(Request.QueryString["ADD_ISSUE_ID"]),
                mat_id,
                decimal.Parse(txtQty.Text),
                txtHeatNo.Text,
                txtPaintCode.Text,
                txtRemarks.Text, txtCableDrumNo.Text
               );
            Master.ShowMessage(txtMatCode.Text + " Saved.");
            itemsGridView.DataBind();
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

    protected void txtMatCode_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        if (txtMatCode.Text != "")
        {
            txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + txtMatCode.Text + "'");
            string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
            txtAvlQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_CODE1='" + txtMatCode.Text + "' and sub_con_id = '" + sub_con_id + "'");
        }
    }

    //protected void ddlMatRequestNo_DataBinding(object sender, EventArgs e)
    //{
    //    ddlMatRequestNo.Items.Clear();
    //    ddlMatRequestNo.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    //}

    protected void btnImportBarcode_Click(object sender, EventArgs e)
    {
        string doc_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID ='" + Request.QueryString["ADD_ISSUE_ID"] + "'");
        string doc_id = Request.QueryString["ADD_ISSUE_ID"];
        string ret_url = "Additional_MatItems.aspx?ADD_ISSUE_ID=" + doc_id;
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + ret_url);
    }

    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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

    protected void itemsGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            itemsGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_CODE1";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MM_EDIT"))
        {
            itemsGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGridView.AllowAutomaticUpdates = true;
        }
    }
}