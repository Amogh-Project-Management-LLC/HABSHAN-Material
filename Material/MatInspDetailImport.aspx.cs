using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MatInspImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Items To - ";
            Master.HeadingMessage += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID=" + Request.QueryString["MIR_ID"]);
            
        }
        

    }
    

  

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //////////////////////////////////
            
            CheckBox cb;
            decimal mir_item = WebTools.DMax("MIR_ITEM_NUM", "VIEW_ADAPTER_MIR_DT", " WHERE MIR_ID=" + Request.QueryString["MIR_ID"]);
            foreach (GridDataItem item in itemsGrid.Items)
                {
                    cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));
                    if (cb.Checked)
                    {
                        /////////////////////////////////////////////////


                        string tc_id = "";
                        /////////////////////////////////get values////////////////////////////////////
                        string po_item = item["PO_ITEM"].Text;
                        string mat_code1 = item["MAT_CODE1"].Text;
                        string rfi_id = WebTools.GetExpr("RFI_ID", "PRC_MAT_INSP", " MIR_ID= '" + Request.QueryString["MIR_ID"] + "'");
                        decimal mat_id = WebTools.GetMatId(mat_code1, decimal.Parse(Session["PROJECT_ID"].ToString()));
                        string tc_no = (item["MTC_NO"].FindControl("txtMTCNo") as TextBox).Text;
                        string bal_mrir_qty = WebTools.GetExpr("BAL_MRIR_QTY", "VIEW_MRIR_BAL_FROM_RFI", " WHERE RFI_ID = '" + rfi_id + "' AND PO_ITEM='" + po_item +
                                     "' AND MAT_ID='" + mat_id + "'");
                    //string bal_mrir_qty = (item["BAL_MRIR_QTY"].FindControl("BAL_MRIR_QTYTextBox") as TextBox).Text;
                    string receive_qty = item["INSP_QTY"].Text;
                        string mrir_qty = item["MRIR_QTY"].Text;
                        string cable_drum_no = (item["CABLE_DRUM_NO"].FindControl("ddlCableNo") as RadDropDownList).SelectedValue;
                        string heat_no = (item["HEAT_NO"].FindControl("txtHeatNo") as TextBox).Text;
                        string excess = (item["EXCESS"].FindControl("txtExcess") as TextBox).Text;
                        string shortage = (item["SHORTAGE"].FindControl("txtShortage") as TextBox).Text;
                        string damage = (item["DAMAGE"].FindControl("txtDamage") as TextBox).Text;

                        string substore = (item["SUBSTORE"].FindControl("ddlsubstore") as RadDropDownList).SelectedValue;
                        string paint_sys = (item["PAINT_SYS"].FindControl("txtPaintSys") as TextBox).Text;
                        string pl_qty = (item["PL_QTY"].FindControl("txtPLQty") as TextBox).Text;
                        string unit_wt = (item["UNIT_WT"].FindControl("txtUnitWt") as TextBox).Text;
                        string remarks = (item["REMARKS"].FindControl("txtRemarks") as TextBox).Text;
                        string sub_warehouse = (item["SUB_WAREHOUSE"].FindControl("txtSubWarehouse") as TextBox).Text;
                        string line_no = (item["LINE_NO"].FindControl("txtLineNo") as TextBox).Text;
                        string rack_no = (item["RACK_NO"].FindControl("txtRackNo") as TextBox).Text;
                        string shelf_no = (item["SHELF_NO"].FindControl("txtShelfNo") as TextBox).Text;
                        string pieces = (item["BAL_PIECES"].FindControl("BAL_PIECESTextBox") as TextBox).Text;
                        if (pieces == "N/A" || pieces == "")
                        {
                            pieces = "0";
                        }

                    ////////////////////////////////get values///////////////////////////////////////
                    tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + tc_no.ToUpper() + "'");

                        if (tc_id.Trim().Length == 0)
                        {
                            string po_id = WebTools.GetExpr("PO_ID", "PRC_MAT_INSP", " MIR_ID='" + Request.QueryString["MIR_ID"] + "'");
                            //Register New MTC Code.
                            string sql = "INSERT INTO PIP_TEST_CARDS (PROJECT_ID, TC_CODE, PO_ID) VALUES ('" + Session["PROJECT_ID"].ToString() + "', '" +
                                tc_no.Trim().ToUpper() + "','" + po_id + "')";
                            WebTools.ExeSql(sql);

                            //Get TC_ID for New MTC Code
                            tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + tc_no.ToUpper() + "'");
                        }

                        //string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + mat_code1 + "'");
                        string itemid = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_ID= " + mat_id);

                        if (decimal.Parse(bal_mrir_qty) > (decimal.Parse(receive_qty) - decimal.Parse(mrir_qty)))
                        {

                            RadWindowManager1.RadAlert("Accepted quantity cannot be more than Inspection qty. <br/>Please re-check and enter valid value.", 300, 150, "Warning", "");
                            return;
                        }

                        //decimal? substore_id = null;
                         //string sub_store_id=   WebTools.GetExpr("SUBSTORE_ID", "STORES_SUB", " STORE_L1= '" + substore+"'");
                         //   if (sub_store_id.Trim().Length == 0)
                         //   {
                         //       RadWindowManager1.RadAlert("Enter Valid Sub Store", 300, 150, "Warning", "");
                         //       return;
                         //   }
                  
                        string sql1 = "";
                        sql1 = "INSERT INTO PRC_MAT_INSP_DETAIL(MIR_ID, PO_ITEM, MIR_ITEM, MAT_ID, RCV_QTY, ACPT_QTY, HEAT_NO, PAINT_SYS, TC_ID, SUBSTORE_ID, REMARKS,CABLE_DRUM_NO, AS_PER_PL_QTY,SUB_WAREHOUSE,LINE_NO,RACK_NO,SHELF_NO,EXC_QTY,SH_QTY,DAMAG_QTY,PIECES) ";
                        sql1 += "VALUES('" + Request.QueryString["MIR_ID"].ToString() + "', '" + po_item + "','" + (++mir_item) + "','" + mat_id + "','";
                        sql1 += bal_mrir_qty + "','" + bal_mrir_qty + "','" + heat_no + "','" + paint_sys + "','" + tc_id + "','" + substore + "','";
                        sql1 += remarks + "','" + cable_drum_no + "', '" + pl_qty + "','" + sub_warehouse + "','" + line_no + "','" + rack_no + "','" + shelf_no + "','" + excess + "','" + shortage + "','" + damage + "','"+pieces+"')";
                        // Master.show_success(sql1);
                        WebTools.ExeSql(sql1);
                    }
                
            }
            Master.ShowMessage("Selected Items Added.");
            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError("Please enter MTC No:"+ex.Message);
        }
    }
    protected void checkHeaderItems_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;

        foreach (GridDataItem item in itemsGrid.Items)
        {
            ((CheckBox)item["checkCol"].FindControl("checkItems")).Checked = cb.Checked;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MatInspDetail.aspx?MIR_ID="+Request.QueryString["MIR_ID"]);
    }

    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            string PO_ITEM = dataItem["PO_ITEM"].Text;
            //string heatno_query = "SELECT DISTINCT NVL(PIP_MAT_RECEIVE_DETAIL.HEAT_NO,'NA') AS HEAT_NO FROM PIP_MAT_RECEIVE_DETAIL,PIP_MAT_INSP_REQUEST_DT " +
            //    "WHERE PIP_MAT_RECEIVE_DETAIL.RCV_ITEM_ID = PIP_MAT_INSP_REQUEST_DT.RCV_ITEM_ID " +
            //    "AND REQ_ID IN(SELECT RFI_ID FROM PRC_MAT_INSP WHERE MIR_ID ="+ Request.QueryString["MIR_ID"] + ") AND PO_ITEM ='" + PO_ITEM + "' ORDER BY NVL(PIP_MAT_RECEIVE_DETAIL.HEAT_NO,'NA')";
            string drumno_query = "SELECT DISTINCT NVL(PIP_MAT_RECEIVE_DETAIL.CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM PIP_MAT_RECEIVE_DETAIL,PIP_MAT_INSP_REQUEST_DT " +
             "WHERE PIP_MAT_RECEIVE_DETAIL.RCV_ITEM_ID = PIP_MAT_INSP_REQUEST_DT.RCV_ITEM_ID " +
             "AND REQ_ID IN(SELECT RFI_ID FROM PRC_MAT_INSP WHERE MIR_ID =" + Request.QueryString["MIR_ID"] + ") AND PO_ITEM ='" + PO_ITEM + "' ORDER BY NVL(PIP_MAT_RECEIVE_DETAIL.CABLE_DRUM_NO,'NA')";
            //HeatNoDataSource.SelectCommand = heatno_query;
            //RadDropDownList ddlHn = ((dataItem["HEAT_NO"].FindControl("ddlHeatNo")) as RadDropDownList);
            //ddlHn.DataSource = HeatNoDataSource;
            //ddlHn.DataBind();
            DrumNoDataSource.SelectCommand = drumno_query;
            RadDropDownList ddlCN = ((dataItem["CABLE_DRUM_NO"].FindControl("ddlCableNo")) as RadDropDownList);
            ddlCN.DataSource = DrumNoDataSource;
            ddlCN.DataBind();
        }
    }
}