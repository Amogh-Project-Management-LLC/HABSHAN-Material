using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_TransfAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Items To - ";
            Master.HeadingMessage += WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID=" + Request.QueryString["TRANSF_ID"]);
            
        }
    }

    protected void HeaderCheck_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;

       
        foreach (GridDataItem item in itemsGrid.Items)
        {
            
            ((CheckBox)item.FindControl("checkPOItem")).Checked = cb.Checked;
        }
    }

   

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Import.");
            return;
        }
        string mat_id;
        string drum_no;
        string heat_no;
        string paint_sys;
        string transf_qty;
        string po_id;
        string mr_item_no;
        string BOX_NO;
        string org_bal_qty;
        decimal NO_OF_PIECE;

        dsMaterialETableAdapters.VIEW_ADAPTER_MAT_TRANSF_DTTableAdapter mat_transf = new dsMaterialETableAdapters.VIEW_ADAPTER_MAT_TRANSF_DTTableAdapter();
        string sql = string.Empty;
        string err_req_matcode = "";
        string err_stk_matcode = "";
        int success_cnt = 0;
        string bal_qty_left = "0";
        string req_qty = "0";
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                heat_no =  (item["HEAT_NO"].FindControl("ddlHeatNo") as RadDropDownList).SelectedValue;
                drum_no = (item["CABLE_DRUM_NO"].FindControl("ddlCableNo") as RadDropDownList).SelectedValue;
                paint_sys = ((item["PAINT_SYS"].FindControl("PAINT_SYSLabel")) as RadTextBox).Text;
                BOX_NO = ((item["BOX_NO"].FindControl("BOX_NOLabel")) as RadTextBox).Text;
                NO_OF_PIECE = decimal.Parse(((item["NO_OF_PIECE"].FindControl("NO_OF_PIECELabel")) as RadTextBox).Text);
                po_id = WebTools.GetExpr("PO_ID", "PIP_PO", " WHERE PO_NO='" + item["PO_NO"].Text + "'"); 
                mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text + "'");
                org_bal_qty = item["AVL_STOCK"].Text;

                string from_store = WebTools.GetExpr("A_STORE_ID", "PIP_MAT_TRANSF", " TRANSF_ID='" + Request.QueryString["TRANSF_ID"] + "'");
                string from_sc = WebTools.GetExpr("SC_ID", "STORES_DEF", " STORE_ID='" + from_store + "'");
                bal_qty_left = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " MAT_CODE1='" + item["MAT_CODE1"].Text + "' AND SUB_CON_ID='" + from_sc + "'");
                req_qty = WebTools.GetExpr("REQ_QTY", "VIEW_MAT_ISSUE_BALANCE_MAIN2", " MAT_REQ_ID='" + Request.QueryString["MAT_REQ_ID"] + "' AND MR_ITEM_NO ='"
                     + item["MR_ITEM_NO"].Text + "' AND BALANCE_STOCK >0"); 
                //string req_qty = item["REQ_QTY"].Text;
                if (bal_qty_left == "" || bal_qty_left == string.Empty)
                {
                    bal_qty_left = "0";
                }

                if(req_qty=="" || req_qty==string.Empty)
                {
                    req_qty = "0";
                }
                
                transf_qty = ((item["BALANCE_STOCK"].FindControl("BAL_QTYLabel")) as RadTextBox).Text;
                mr_item_no = item["MR_ITEM_NO"].Text;

                if ((decimal.Parse(bal_qty_left) >= (decimal.Parse(transf_qty))) && (decimal.Parse(req_qty) >= (decimal.Parse(transf_qty))))
                {
                    mat_transf.InsertQuery(decimal.Parse(Request.QueryString["TRANSF_ID"]), decimal.Parse(mat_id), heat_no, paint_sys, drum_no,
                    decimal.Parse(transf_qty), decimal.Parse(po_id), decimal.Parse(mr_item_no), BOX_NO , NO_OF_PIECE);
                    success_cnt++;
                    //Master.ShowSuccess("Selected Item(s) Imported");
                }
                else
                {
                    if((decimal.Parse(bal_qty_left) < (decimal.Parse(transf_qty))))
                    {
                        
                        err_stk_matcode += (item["MAT_CODE1"].Text)+";";
                    }
                    if((decimal.Parse(req_qty) < (decimal.Parse(transf_qty))))
                    {
                       
                        err_req_matcode += (item["MAT_CODE1"].Text)+";";
                    }
                  
                }
            }
            string sucess_msg = "";
            if (success_cnt > 0)
            {
                sucess_msg = "Selected Item(s) Imported, <br/> ";
                Master.ShowSuccess(sucess_msg);
            }
            string msg = "";
            if (err_req_matcode.Length > 0)
            {
                msg = "Transfer Qty greater than Request Qty for : " + err_req_matcode + "<br/>";
                Master.ShowWarn(msg);
            }
            if (err_stk_matcode.Length > 0)
            {
                msg += " Transfer Qty greater than Stock Qty for : " + err_stk_matcode;
                Master.ShowWarn(msg);
            }

            itemsGrid.Rebind();


        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/Mat_Transf_Items.aspx?TRANSF_ID=" + Request.QueryString["TRANSF_ID"]);
    }

    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            string mat_code1 = dataItem["MAT_CODE1"].Text;
            string MR_ITEM_NO = dataItem["MR_ITEM_NO"].Text;
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code1 + "'");
            string heatno_query = "SELECT DISTINCT NVL(HEAT_NO,'NA') AS HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID=" + mat_id;
            string drumno_query = " SELECT DISTINCT NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO   FROM (SELECT 1 AS SEQ, NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM  MATERIAL_REQUEST_DETAIL WHERE MAT_REQ_ID=" + Request.QueryString["mat_req_id"]+
                        "AND MR_ITEM_NO="+ MR_ITEM_NO+ " UNION SELECT DISTINCT 2 AS SEQ,  NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID=" + mat_id +
                        "ORDER BY seq ) ";



            HeatNoDataSource.SelectCommand = heatno_query;
            RadDropDownList ddlHn = ((dataItem["HEAT_NO"].FindControl("ddlHeatNo")) as RadDropDownList);
            ddlHn.DataSource = HeatNoDataSource;
            ddlHn.DataBind();
            DrumNoDataSource.SelectCommand = drumno_query;
            RadDropDownList ddlCN = ((dataItem["CABLE_DRUM_NO"].FindControl("ddlCableNo")) as RadDropDownList);
            ddlCN.DataSource = DrumNoDataSource;
            ddlCN.DataBind();
        }
    }


}