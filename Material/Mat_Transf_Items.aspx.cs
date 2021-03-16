using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using dsMaterialBTableAdapters;
using Telerik.Web.UI;
using System.Data.OracleClient;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Erection_Additional_MatItems : System.Web.UI.Page
{
    
    decimal req_qty = 0;
    decimal issued_qty = 0;
    string item_name = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            
            Master.HeadingMessage = "Material Transfer <br/>(" +
            WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID=" + Request.QueryString["TRANSF_ID"]) + ")";
            int mat_req_id = int.Parse(WebTools.GetExpr("MAT_REQ_ID", "PIP_MAT_TRANSF", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND TRANSF_ID=" + Request.QueryString["TRANSF_ID"]));
            string status_flg = WebTools.GetExpr("STATUS_FLG", "PIP_MAT_TRANSF", " TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);

            string CREATE_BY = WebTools.GetExpr("CREATE_BY", "PIP_MAT_TRANSF", " WHERE TRANSF_ID ='" + Request.QueryString["TRANSF_ID"] + "'");
            string USER_NAME = Session["USER_NAME"].ToString();

            if ((CREATE_BY.ToUpper() == USER_NAME.ToUpper() && status_flg != "Y") || WebTools.UserInRole("ADMIN"))
            {
                btnEntry.Visible = true;
                btnAddFromMTN.Visible = true;
                btnBarcodeImport.Visible = true;
            }
            else
            {
                btnEntry.Visible = false;
                btnAddFromMTN.Visible = false;
                btnBarcodeImport.Visible = false;
            }

            
        }
        if (WebTools.UserInRole("ADMIN"))
        {

            btnDeleteAll.Visible = true;
            this.itemsGridView.Columns[2].Visible = true;
            return;
        }
        else
        {
            this.itemsGridView.Columns[2].Visible = false;
        }
        

    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        //PageList.Items.Clear();
        //for (int i = 0; i < itemsGridView.PageCount; i++)
        //{
        //    ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
        //    PageList.Items.Add(pageListItem);
        //    if (i == itemsGridView.CurrentPageIndex)
        //        pageListItem.Selected = true;
        //}
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Mat_Transf.aspx");
    }


    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            decimal mat_id = db_lookup.MAT_ID(ddlMatCode.SelectedItem.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
            string mr_item = ddlMR.SelectedValue.ToString();
            if (mat_id == 0)
            {
                Master.ShowWarn("Material Code not found!");
                return;
            }
            if (mr_item == "-1")
            {
                Master.ShowWarn("Please select Mr Item No");
                return;
            }

            int mat_req_id = int.Parse(WebTools.GetExpr("MAT_REQ_ID", "PIP_MAT_TRANSF", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND TRANSF_ID=" + Request.QueryString["TRANSF_ID"]));

            req_qty = WebTools.DSum("REQ_QTY", "MATERIAL_REQUEST_DETAIL", " MAT_REQ_ID=" + mat_req_id + " AND MAT_ID=" + mat_id + " AND MR_ITEM_NO=" + mr_item);

            issued_qty = WebTools.DSum("TRANSF_QTY", "PIP_MAT_TRANSF_DETAIL", "TRANSF_ID=" + Request.QueryString["TRANSF_ID"] + " AND MAT_ID=" + mat_id + " AND MR_ITEM_NO=" + mr_item);
            string item_id = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");

            item_name = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " ITEM_ID=" + item_id);
            //bal qty to check before transfer
            string from_store = WebTools.GetExpr("A_STORE_ID", "PIP_MAT_TRANSF", " TRANSF_ID='" + Request.QueryString["TRANSF_ID"] + "'");
            string from_sc = WebTools.GetExpr("SC_ID", "STORES_DEF", " STORE_ID='" + from_store + "'");
            string bal_qty_left = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "' AND SUB_CON_ID='" + from_sc + "'");
            if (bal_qty_left == "" || bal_qty_left == string.Empty)
            {
                bal_qty_left = "0";
            }
            decimal bal_qty = decimal.Parse(bal_qty_left);
            string po_bal_qty_left = WebTools.GetExpr("WHC_PO_BAL_QTY", "VIEW_MAT_ISSUE_BALANCE_MAIN2", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "' AND SUB_CON_ID='" + from_sc + "' AND PO_ID = '" + ddlPO.SelectedValue + "'");
            if (po_bal_qty_left == "" || po_bal_qty_left == string.Empty)
            {
                po_bal_qty_left = "0";
            }
            decimal po_bal_qty = decimal.Parse(po_bal_qty_left);

            if (bal_qty - decimal.Parse(txtQty.Text) >= 0)
            {
                if (((req_qty - issued_qty) < decimal.Parse(txtQty.Text)) && (!item_name.ToUpper().Contains("PIP")))
                {
                    Master.ShowError("Other than Pipe cannot issue more than requested qty");
                    return;
                }
                else
                {
                    VIEW_ADAPTER_MAT_TRANSF_DTTableAdapter items = new VIEW_ADAPTER_MAT_TRANSF_DTTableAdapter();
                    items.InsertQuery(
                    Decimal.Parse(Request.QueryString["TRANSF_ID"]),
                    mat_id, ddlHeatNo.SelectedValue, ddlCabledrum.SelectedValue,
                    Decimal.Parse(txtQty.Text),
                    txtBoxNo.Text,
                    decimal.Parse(txtNO_OF_PIECE.Text),
                    decimal.Parse("0"),
                    txtRemarks.Text,
                    txtPaintCode.Text,
                    decimal.Parse(ddlPO.SelectedValue),
                    decimal.Parse(ddlMR.SelectedValue)
                    );

                    itemsGridView.DataBind();

                    Master.ShowMessage(ddlMatCode.SelectedItem.Text + " Saved!");
                }

            }
            else
            {
                Master.ShowWarn(ddlMatCode.SelectedItem.Text + " Stock Not Available");
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }

    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            btnSubmit.Enabled = true;

            lblbalqty.Text = "";
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");
            if (mat_id != "")
            {
                //bal qty to check before transfer
                string from_store = WebTools.GetExpr("A_STORE_ID", "PIP_MAT_TRANSF", " TRANSF_ID='" + Request.QueryString["TRANSF_ID"] + "'");
                string from_sc = WebTools.GetExpr("SC_ID", "STORES_DEF", " STORE_ID='" + from_store + "'");
                string bal_qty_left = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "' AND SUB_CON_ID='" + from_sc + "'");
                if (bal_qty_left == "" || bal_qty_left == string.Empty)
                {
                    bal_qty_left = "0";
                }
                decimal bal_qty = decimal.Parse(bal_qty_left);
                txtbalQty.Text = bal_qty.ToString();
                string po_bal_qty_left = WebTools.GetExpr("WHC_PO_BAL_QTY", "VIEW_MAT_ISSUE_BALANCE_MAIN2", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "' AND SUB_CON_ID='" + from_sc + "' AND PO_ID = '" + ddlPO.SelectedValue + "'");
                if (po_bal_qty_left == "" || po_bal_qty_left == string.Empty)
                {
                    po_bal_qty_left = "0";
                }
                decimal po_bal_qty = decimal.Parse(po_bal_qty_left);
                txtWHCPOBal.Text = po_bal_qty.ToString();
                if (bal_qty <= 0)
                {
                    btnSubmit.Enabled = false;

                    RadWindowManager1.RadAlert("No Stock found, Material cannot be issued.", 400, 150, "Warning", "");
                    return;
                }

                string mat_descr = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");
                txtItemDescr.Text = mat_descr;

            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

        ddlMR.Items.Clear();
        ddlMR.Items.Add(new DropDownListItem("Select", "-1"));
        ddlMR.DataBind();

        ddlMR.SelectedValue = "-1";
    }

    protected void btnBarcodeImport_Click(object sender, EventArgs e)
    {
        string doc_no = WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID='" + Request.QueryString["TRANSF_ID"] + "'");
        string doc_id = Request.QueryString["TRANSF_ID"];
        string ret_url = "Mat_Transf_Items.aspx?TRANSF_ID=" + doc_id;
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + ret_url);
    }

    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
            else
            {
               
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
            datafields[0] = "MAT_CODE1_NO";
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
    protected void txtHeatNo_DataBinding(object sender, EventArgs e)
    {
        ddlHeatNo.Items.Clear();
        ddlHeatNo.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlHeatNo.SelectedIndex = 0;
    }
    protected void btnAddFromMTN_Click(object sender, EventArgs e)
    {
        string mat_req_id = WebTools.GetExpr("MAT_REQ_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        Response.Redirect("Mat_Transf_ItemsAdd.aspx?mat_req_id=" + mat_req_id + "&TRANSF_ID=" + Request.QueryString["TRANSF_ID"]);
    }


    protected void ddlMR_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        string mr_item = ddlMR.SelectedValue;
        if (mr_item.Equals("-1"))
            return;
        int mat_id = int.Parse(WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'"));
        int mat_req_id = int.Parse(WebTools.GetExpr("MAT_REQ_ID", "PIP_MAT_TRANSF", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND TRANSF_ID=" + Request.QueryString["TRANSF_ID"]));

        req_qty = WebTools.DSum("REQ_QTY", "MATERIAL_REQUEST_DETAIL", " MAT_REQ_ID=" + mat_req_id + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);

        issued_qty = WebTools.DSum("TRANSF_QTY", "VIEW_MAT_ISSUE_BALANCE_MAIN2", " MAT_REQ_ID=" + mat_req_id + " AND MAT_ID=" + mat_id + " AND mr_item_no=" + mr_item);
        string item_id = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + ddlMatCode.SelectedItem.Text + "'");

        item_name = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " ITEM_ID=" + item_id);
        if (item_name.ToUpper().Contains("PIP"))
        {
            lblbalqty.Text = "Can Issue Approximately:  " + (req_qty - issued_qty);

        }
        else
        {
            lblbalqty.Text = "Can Issue Max Qty:  " + (req_qty - issued_qty);
        }
    }


    protected void itemsGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {
            string status_flg = WebTools.GetExpr("STATUS_FLG", "PIP_MAT_TRANSF", " TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);

            if (e.Item is GridDataItem)
            {
                string CREATE_BY = WebTools.GetExpr("CREATE_BY", "PIP_MAT_TRANSF", " WHERE TRANSF_ID ='" + Request.QueryString["TRANSF_ID"] + "'");
                string USER_NAME = Session["USER_NAME"].ToString();
                GridDataItem dataItem = (GridDataItem)e.Item;
                if (status_flg == "Y" && !WebTools.UserInRole("ADMIN"))
                {
                    ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                    btnEdit.Visible = false;

                    ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                    btnDelete.Visible = false;
                }
                if (CREATE_BY.ToUpper() != USER_NAME.ToUpper() && !WebTools.UserInRole("ADMIN"))
                {
                    ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                    btnEdit.Visible = false;

                    ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                    btnDelete.Visible = false;
                }

            }
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)

                //{
                //    GridEditableItem dataItem = e.Item as GridEditableItem;

                //    string mat_code1 = (dataItem["MAT_CODE1"].Controls[0] as TextBox).Text;
                //    string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code1 + "'");
                //    string heatno_query = "SELECT DISTINCT NVL(HEAT_NO,'NA') AS HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID=" + mat_id;
                //    string drumno_query = "SELECT DISTINCT NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID=" + mat_id;
                //    string TRANSF_ITEM_ID = dataItem.GetDataKeyValue("TRANSF_ITEM_ID").ToString();
                //    HeatNoDataSource.SelectCommand = heatno_query;
                //    RadDropDownList ddlHn = (RadDropDownList)dataItem.FindControl("ddlHeatNo");
                //    ddlHn.DataSource = HeatNoDataSource;
                //    string heat_no = ddlHn.SelectedValue;
                //    ddlHn.DataBind();
                //    DrumNoDataSource.SelectCommand = drumno_query;
                //    RadDropDownList ddlCN = (RadDropDownList)dataItem.FindControl("ddlCableNo");
                //    ddlCN.DataSource = DrumNoDataSource;
                //    string drum_no = ddlCN.SelectedValue;
                //    ddlCN.DataBind();
                //    string drumUpdate = "UPDATE PIP_MAT_TRANSF_DETAIL SET CABLE_DRUM_NO ='"+ drum_no + "', HEAT_NO ='" + heat_no+ "' WHERE TRANSF_ITEM_ID="+ TRANSF_ITEM_ID;

                //}

                if (e.Item.IsInEditMode && e.Item is GridEditableItem)
                {

                    if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "ParentGrid")
                    {
                        GridEditableItem dataItem = e.Item as GridEditableItem;
                        string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =18 ";
                        DataTable dt = WebTools.getDataTable(query);

                        foreach (DataRow row in dt.Rows)
                        {
                            string hide_col = row["HIDE_COL_NAME"].ToString();
                            dataItem[hide_col].Enabled = false;
                            dataItem[hide_col].Controls[0].Visible = false;
                        }
                        string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                            " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =18";
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
                    else if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "ChildGrid")
                    {
                        string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =19 ";
                        DataTable dt = WebTools.getDataTable(query);
                        GridEditableItem dataItem = e.Item as GridEditableItem;

                        foreach (DataRow row in dt.Rows)
                        {
                            string hide_col = row["HIDE_COL_NAME"].ToString();
                            dataItem[hide_col].Enabled = false;
                            dataItem[hide_col].Controls[0].Visible = false;
                        }
                        string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                            " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =19";
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
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }

    protected void itemsGridView_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            Master.ShowWarn(" cannot be deleted (check for MR Items In MTN Receive)  : " + e.Exception.Message);
        }
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {

        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Delete.");
            return;
        }

        string TRANSF_ITEM_ID = "";
        
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGridView.SelectedItems)
            {

                TRANSF_ITEM_ID = item["TRANSF_ITEM_ID"].Text;


                sql = WebTools.ExeSql("DELETE FROM PIP_MAT_TRANSF_DETAIL WHERE  TRANSF_ITEM_ID=" + TRANSF_ITEM_ID );


                Master.ShowSuccess("Successfully Deleted Selected Items");
                itemsGridView.Rebind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }


    }


    protected void itemsGridView_PreRender(object sender, EventArgs e)
    {
        string CREATE_BY = WebTools.GetExpr("CREATE_BY", "PIP_MAT_TRANSF", " WHERE TRANSF_ID ='" + Request.QueryString["TRANSF_ID"] + "'");
        string USER_NAME = Session["USER_NAME"].ToString();
        string status_flg = WebTools.GetExpr("STATUS_FLG", "PIP_MAT_TRANSF", " TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        if ((CREATE_BY.ToUpper() == USER_NAME.ToUpper() && status_flg != "Y") || WebTools.UserInRole("ADMIN"))
        {
            itemsGridView.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClick";
        }
        else
        {
            itemsGridView.ClientSettings.ClientEvents.OnRowDblClick = "RowDblClickCancel";
        }
    }
}

