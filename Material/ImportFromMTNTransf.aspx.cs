using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class MTNReceiveDetailImportFromMTNTransf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Items To - ";
            Master.HeadingMessage += WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID=" + Request.QueryString["RCV_ID"]);
            //HiddenTransfID.Value = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID='" + Request.QueryString["id"]);
        }
    }

    protected void HeaderCheck_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;

        //string po_no;
        //string mat_code1;
      
        //string rcv_qty;
        //string insp_qty;
        //string bal_to_insp;
        //CheckBox itemCheck;
        foreach (GridDataItem item in itemsGrid.Items)
        {
            //po_no = item["PO_NO"].Text;
            //mat_code1 = item["MAT_CODE1"].Text;
            //rcv_qty = item["RCV_QTY"].Text;
            //insp_qty = item["INSP_QTY"].Text;
            //bal_to_insp = ((item["BAL_TO_INSP"].FindControl("BAL_TO_INSPLabel")) as RadTextBox).Text;

            ((CheckBox)item.FindControl("checkPOItem")).Checked = cb.Checked;
        }
    }

    //protected void checkPOItem_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox cb = (CheckBox)sender;
        
    //}

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
        string bal_rcv_qty;
        string excess_qty;
        string short_qty;
        string damage_qty;
        string po_id;
        string mr_item_no;
        string no_of_piece;
        string transf_qty;
        string recv_qty;

        dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter receive_transf = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter();
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                heat_no = (item["HEAT_NO"].FindControl("ddlHeatNo") as RadDropDownList).SelectedValue;
                drum_no = (item["CABLE_DRUM_NO"].FindControl("ddlCableNo") as RadDropDownList).SelectedValue;
                paint_sys = item["PAINT_SYS"].Text;
                po_id = item["PO_ID"].Text;
                mat_id = WebTools.GetExpr ("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text+"'");
                bal_rcv_qty = ((item["BAL_QTY"].FindControl("BAL_QTYLabel")) as RadTextBox).Text;
                excess_qty = ((item["EXCESS_QTY"].FindControl("EXCESS_QTYLabel")) as RadTextBox).Text;
                short_qty = ((item["SHORT_QTY"].FindControl("SHORT_QTYLabel")) as RadTextBox).Text;
                damage_qty = ((item["DAMAGE_QTY"].FindControl("DAMAGE_QTYLabel")) as RadTextBox).Text;
                mr_item_no = item["MR_ITEM_NO"].Text;
                transf_qty = WebTools.GetExpr("TRANSF_QTY", "view_mat_transfer_rcv_bal", " WHERE TRANSF_ID = '" + Request.QueryString["TRANSF_ID"] + "' AND MR_ITEM_NO='" + mr_item_no +"'");
                recv_qty = WebTools.GetExpr("rcv_qty", "view_mat_transfer_rcv_bal", " WHERE TRANSF_ID = '" + Request.QueryString["TRANSF_ID"] + "' AND MR_ITEM_NO='" + mr_item_no + "'");
                no_of_piece = ((item["NO_OF_PIECE"].FindControl("NO_OF_PIECELabel")) as RadTextBox).Text;
                if (decimal.Parse(transf_qty) - decimal.Parse(recv_qty) >= decimal.Parse(bal_rcv_qty))
                {
                    receive_transf.InsertQuery(decimal.Parse(Request.QueryString["rcv_id"]), decimal.Parse(mat_id), decimal.Parse(bal_rcv_qty), heat_no, drum_no,
                  paint_sys, "", decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(short_qty), decimal.Parse(damage_qty), decimal.Parse(excess_qty), decimal.Parse(po_id),
                  decimal.Parse(mr_item_no), decimal.Parse(no_of_piece));
                   
                }
                else
                {
                    Master.ShowError("Receive Quantity cannot be more than Transfer qty. ");
                    return;
                }
               
                 
               

                //if (decimal.Parse(rcv_qty) >= ((insp_qty.Trim() == "" ? 0 : decimal.Parse(insp_qty)) + decimal.Parse(bal_to_insp)))
                //{
                //    receive_transf.InsertQuery(decimal.Parse(Request.QueryString["rcv_id"]), mat_id, decimal.Parse(rcv_qty), heat_no,
                //paint_sys, "", decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(EXCESS_QTYTextBox.Text));
                //}
                //else
                //{
                //    Master.ShowError("Inspection quantity cannot be more than received qty.");
                //}
            }
            itemsGrid.Rebind();
            Master.ShowSuccess("Selected Item(s) Imported");
           // Response.Redirect("ImportFromMTNTransf.aspx?TRANSF_ID=" + Request.QueryString["TRANSF_ID"] + "&RCV_ID=" + Request.QueryString["RCV_ID"]);
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MTNReceiveDetail.aspx?id=" + Request.QueryString["RCV_ID"]);
    }
    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
          
            string mat_code1 = dataItem["MAT_CODE1"].Text;
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code1 + "'");
            
            string heatno_query = "SELECT DISTINCT NVL(HEAT_NO,'NA') AS HEAT_NO FROM PIP_MAT_TRANSF_DETAIL WHERE TRANSF_ID= (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID ="
                + Request.QueryString["RCV_ID"] + ") AND MAT_ID=" + mat_id + " AND MR_ITEM_NO=" + dataItem["MR_ITEM_NO"].Text;
            string drumno_query = "SELECT DISTINCT NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM PIP_MAT_TRANSF_DETAIL WHERE TRANSF_ID= (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID ="
                + Request.QueryString["RCV_ID"] + ") AND MAT_ID=" + mat_id + " AND MR_ITEM_NO=" + dataItem["MR_ITEM_NO"].Text;
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