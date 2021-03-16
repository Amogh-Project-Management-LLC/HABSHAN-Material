using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspDetailAdd : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Items (";
            heading += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'") + ")";
            Master.HeadingMessage(heading);
        }
        decimal mir_item_no = WebTools.DMax("MIR_ITEM_NUM", "VIEW_ADAPTER_MIR_DT", " WHERE MIR_ID='" +  Session["popUp_MIR_ID"].ToString()  + "'");
        txtMIRItemNo.Text = (mir_item_no+1).ToString();
    }

    protected void ddlPOItems_DataBinding(object sender, EventArgs e)
    {
        ddlPOItems.Items.Clear();
        ddlPOItems.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlMTCList_DataBinding(object sender, EventArgs e)
    {
        ddlMTCList.Items.Clear();
        ddlMTCList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlSubStorList_DataBinding(object sender, EventArgs e)
    {
        ddlSubStorList.Items.Clear();
        ddlSubStorList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        ddlMTCList.Visible = true;
        txtMTCCode.Visible = false;
        btnNew.Visible = true;
        btnSelect.Visible = false;
       
    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        ddlMTCList.Visible = false;
        txtMTCCode.Visible = true;
        btnNew.Visible = false;
        btnSelect.Visible = true;
      
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string tc_id = "";
           
            if (!ddlMTCList.Visible)
            {
                tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + txtMTCCode.Text.ToUpper() + "'");
                if (tc_id.Trim().Length == 0)
                {
                 string po_id = WebTools.GetExpr("PO_ID", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
                 //Register New MTC Code.
                 string sql = "INSERT INTO PIP_TEST_CARDS (PROJECT_ID, TC_CODE, PO_ID) VALUES ('" + Session["PROJECT_ID"].ToString() + "', '" +txtMTCCode.Text.Trim() + "','" + po_id + "')";
                 WebTools.ExeSql(sql);
                 //Get TC_ID for New MTC Code
                 tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + txtMTCCode.Text.ToUpper() + "'");
                }
            }
            else
                tc_id = ddlMTCList.SelectedValue;
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + txtMatCode.Text + "'");
            string itemid = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_ID= " + mat_id);
            string heat_no = "";
            if (!ddlHeatNoList.Visible)
            {
                heat_no = txtHeatNo.Text;
            }
            else
            {
                heat_no = ddlHeatNoList.SelectedText;
            }

                //if (itemid != "33" && itemid != "242")
                //{
                //    if (txtAcptQty.Text.ToString().IndexOf('.') > 0 || txtRcvQty.Text.ToString().IndexOf('.') > 0)
                //    {
                //        Master.show_error("Selected Item cannot be in received in decimal Qty. <br/>Please Enter Integer Value.");
                //        return;
                //    }               
                //}

                if (decimal.Parse(txtAcptQty.Text.ToString()) > decimal.Parse(txtRcvQty.Text.ToString()))
            {
                Master.show_error("Accepted quantity cannot be more than received qty. <br/>Please re-check and enter valid value.");
                return;
            }

            string bal_mrir_qty = WebTools.GetExpr("BAL_MRIR_QTY", "VIEW_MRIR_BAL_FROM_RFI", 
                " WHERE RFI_ID  IN (SELECT RFI_ID FROM PRC_MAT_INSP WHERE MIR_ID = " + Session["popUp_MIR_ID"].ToString() + ") AND PO_ITEM='" + txtPOItemNO.Text +
                                 "' AND MAT_ID='" + mat_id + "'");
            string receive_qty = txtRcvQty.Text;
            string rec_pieces = txtPieces.Text;

            decimal? substore_id = null;
            if (ddlSubStorList.SelectedIndex > 0)
                substore_id = decimal.Parse(ddlSubStorList.SelectedValue);
            if (decimal.Parse(bal_mrir_qty) < (decimal.Parse(receive_qty) ))
            {

                Master.show_error("Received quantity cannot be more than Inspection qty.");
                return;
            }
            string sql1 = "";
            sql1 = "INSERT INTO PRC_MAT_INSP_DETAIL(MIR_ID, PO_ITEM, MIR_ITEM, MAT_ID, RCV_QTY, ACPT_QTY, HEAT_NO, PAINT_SYS, TC_ID, SUBSTORE_ID, REMARKS,CABLE_DRUM_NO, AS_PER_PL_QTY,SUB_WAREHOUSE,LINE_NO,RACK_NO,SHELF_NO,EXC_QTY,SH_QTY,DAMAG_QTY,PIECES) ";
            sql1 += "VALUES('" + Session["popUp_MIR_ID"].ToString() + "', '" + txtPOItemNO.Text + "','" + txtMIRItemNo.Text + "','" + mat_id + "','";
            sql1 += txtRcvQty.Text + "','" + txtAcptQty.Text + "','" + heat_no + "','" + txtPS.Text + "','" + tc_id + "','" + substore_id + "','";
            sql1 += txtRemarks.Text + "','" + ddlCableDrumNo.SelectedValue + "', '" + txtPLQty.Text + "','"+txtSubWareHouse.Text+"','"+txtLineNo.Text+"','"+txtRackNo.Text+"','"+txtShelf.Text+ "','" + txtExcessQty.Text + "','" + txtShortage.Text + "','" + txtDamage.Text + "','"+txtPieces.Text+"')";
            // Master.show_success(sql1);
            WebTools.ExeSql(sql1);            
            Master.show_success(txtMatCode.Text + " Added Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlPOItems_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtMatCode.Text = WebTools.GetExpr("MAT_CODE1", "VIEW_ADAPTER_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlPOItems.SelectedValue + "'");
        txtPOItemNO.Text = WebTools.GetExpr("PO_ITEM", "VIEW_ADAPTER_PO_DETAIL", " PO_ITEM_ID='" + ddlPOItems.SelectedValue + "'");
        string RFI_ID = WebTools.GetExpr("RFI_ID", "PRC_MAT_INSP", " WHERE MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
        txtRcvQty.Text = WebTools.DSum("BAL_MRIR_QTY", "VIEW_MRIR_BAL_FROM_RFI", " WHERE RFI_ID='" + RFI_ID + "' AND PO_ITEM = '" + txtPOItemNO.Text + "'").ToString();
        
        string pieces   = WebTools.GetExpr("BAL_PIECES", "VIEW_MRIR_BAL_FROM_RFI", " WHERE RFI_ID='" + RFI_ID + "' AND PO_ITEM = '" + txtPOItemNO.Text + "'").ToString();
        if (pieces == "N/A" || pieces == "")
        {
            pieces = "0";
        }

        txtPieces.Text = pieces;
        txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " MAT_CODE1='" + txtMatCode.Text + "'");

    }

    protected void ddlCableDrumNo_DataBinding(object sender, EventArgs e)
    {
        ddlCableDrumNo.Items.Clear();
        ddlCableDrumNo.Items.Insert(0, new Telerik.Web.UI.DropDownListItem(String.Empty, String.Empty));
        ddlCableDrumNo.SelectedIndex = 0;
    }

    protected void ddlHeatNoList_DataBinding(object sender, EventArgs e)
    {

    }

    protected void bthNewHeat_Click(object sender, EventArgs e)
    {
        ddlHeatNoList.Visible = false;
        txtHeatNo.Visible = true;
        btnNewHeat.Visible = false;
        btnSelectHeat.Visible = true;
    }

    protected void btnSelectHeat_Click(object sender, EventArgs e)
    {
        ddlHeatNoList.Visible = true;
        txtHeatNo.Visible = false;
        btnNewHeat.Visible = true;
        btnSelectHeat.Visible = false;

    }
}