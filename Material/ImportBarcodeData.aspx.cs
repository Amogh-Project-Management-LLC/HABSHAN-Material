using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_ImportBarcodeData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Barcode Data<br/>";
            Master.HeadingMessage += Request.QueryString["DOC_NO"].ToString();
            SetupGrid();
        }
    }

    protected void SetupGrid()
    {
        string doc_type = WebTools.GetExpr("doc_type", "VIEW_MATERIAL_DOC_MASTER", " WHERE doc_no = '" + Request.QueryString["doc_no"] + "'");
        int count = 0;
        GridColumn gridAccept_Qty;
        GridColumn gridExcessQty;
        GridColumn gridShortQty;
        GridColumn gridDamageQty;
        GridColumn gridQty;

        switch (doc_type)
        {
            case "MRIR":
                count = itemsGrid.MasterTableView.Columns.Count;
                gridQty = itemsGrid.MasterTableView.Columns[count - 1];
                gridQty.Visible = false;
                break;
            case "TRANSFER":
                count = itemsGrid.MasterTableView.Columns.Count;
                gridAccept_Qty = itemsGrid.MasterTableView.Columns[count - 5];
                gridExcessQty = itemsGrid.MasterTableView.Columns[count - 4];
                gridShortQty = itemsGrid.MasterTableView.Columns[count - 3];
                gridDamageQty = itemsGrid.MasterTableView.Columns[count - 2];
                gridAccept_Qty.Visible = false;
                gridExcessQty.Visible = false;
                gridShortQty.Visible = false;
                gridDamageQty.Visible = false;
                break;
            case "RECEIVE":
                count = itemsGrid.MasterTableView.Columns.Count;
                gridQty = itemsGrid.MasterTableView.Columns[count - 1];
                gridQty.Visible = false;
                break;
            case "MIV":
                count = itemsGrid.MasterTableView.Columns.Count;
                gridAccept_Qty = itemsGrid.MasterTableView.Columns[count - 5];
                gridExcessQty = itemsGrid.MasterTableView.Columns[count - 4];
                gridShortQty = itemsGrid.MasterTableView.Columns[count - 3];
                gridDamageQty = itemsGrid.MasterTableView.Columns[count - 2];
                gridAccept_Qty.Visible = false;
                gridExcessQty.Visible = false;
                gridShortQty.Visible = false;
                gridDamageQty.Visible = false;
                break;
        }
    }

    protected void btnDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("ImportBarcodeDataDetail.aspx?doc_no=" + Request.QueryString["doc_no"] + "&RetUrl=" + Request.QueryString["RetUrl"]);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.QueryString["RetUrl"]);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string doc_type = WebTools.GetExpr("doc_type", "VIEW_MATERIAL_DOC_MASTER", " WHERE doc_no = '" + Request.QueryString["doc_no"] + "'");
            string sql = string.Empty;
            string response = string.Empty;
            switch (doc_type)
            {
                case "MRIR":
                    response = AddMRIR();
                    if (response == "1")
                        Master.ShowMessage("Items Added to MRIR.");                        
                    else
                        Master.ShowError(response);                    
                    break;
                case "TRANSFER":
                    response = AddTransfer();
                    if (response == "1")
                        Master.ShowMessage("Items Added to Transfer List.");
                    else
                        Master.ShowError(response);
                    break;
                case "RECEIVE":
                    response = AddReceive();
                    if (response == "1")
                        Master.ShowMessage("Items Added to Receive List.");
                    else
                        Master.ShowError(response);
                    break;
                case "MIV":
                    response = AddMIV();
                    if (response == "1")
                        Master.ShowMessage("Items Added to MIV.");
                    else
                        Master.ShowError(response);
                    break;
            }
            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected string AddMRIR()
    {
        try
        {
            string mir_id = WebTools.GetExpr("MIR_ID", "PRC_MAT_INSP", " WHERE MIR_NO='" + Request.QueryString["doc_no"] + "'");
            string store_id = WebTools.GetExpr("STORE_ID", "VIEW_MATERIAL_DOC_MASTER", " WHERE DOC_NO = '" + Request.QueryString["DOC_NO"] + "'"); ;
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                string mrr_id = WebTools.GetExpr("MRV_ID", "PRC_MAT_INSP", " WHERE MIR_ID = '" + mir_id + "'");
                double accept_qty = double.Parse(item["ACCEPT_QTY"].Text);
                string po_item = WebTools.GetExpr("PO_ITEM", "VIEW_MRR_BAL_FOR_MIR", " WHERE MAT_RCV_ID = '" + mrr_id + "' AND (BAL_QTY = " + accept_qty + " or BAL_QTY > " + accept_qty + ")");
                int poitem = Int32.Parse(po_item);
                double RecieveQty = double.Parse(WebTools.GetExpr("recv_qty", "VIEW_MRR_BAL_FOR_MIR", " WHERE MAT_RCV_ID='" + mrr_id + "' and po_item = '" + po_item + "'"));
                string mir_item = WebTools.GetExpr("MIR_ITEM", "PRC_MAT_INSP_DETAIL", " WHERE MIR_ID='" + mir_id + "'");
                if (string.IsNullOrEmpty(mir_item))
                    mir_item = "1";
                else
                    mir_item = (Int32.Parse(mir_item) + 1).ToString();

                string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text + "'");
                string substore = WebTools.GetExpr("SUBSTORE_ID", "STORES_SUB", " WHERE STORE_ID = '" + store_id + "' and STORE_L1 = '" + item["SUBSTORE"].Text + "'");
                string sql = "INSERT INTO PRC_MAT_INSP_DETAIL (MIR_ID, RCV_QTY, ACPT_QTY, EXCESS_QTY, SHORTAGE_QTY, DAMAGE_QTY, HEAT_NO, MAT_ID, PO_ITEM, MIR_ITEM, SUBSTORE_ID,  CABLE_DRUM_NO, ROW_NO, RACK_NO, BOX_NO) VALUES ('";
                sql += mir_id + "','" + RecieveQty + "', '" + accept_qty + "','" + item["EXCESS_QTY"].Text + "', '";
                sql += item["SHORT_QTY"].Text + "','" + item["DAMAGE_QTY"].Text + "','" + item["HEATNO"].Text + "','" + mat_id + "','";
                sql += po_item + "','" + mir_item + "','" + substore + "','" + item["CABLEDRUMNO"].Text + "','" + item["ROWNO"].Text + "','";
                sql += item["RACKNO"].Text + "','" + item["BOXNO"].Text + "')";

                WebTools.ExeSql(sql);

                sql = "DELETE FROM TBL_BARCODE_IMPORT_DATA WHERE DOCUMENTNO='" + Request.QueryString["doc_no"] + "' and materialid = '" + mat_id + "' and heatno='" + item["HEATNO"].Text + "'";
                sql += " and substoreid='" + substore + "' and cabledrumno = '" + item["CABLEDRUMNO"].Text + "' AND BOXNO='" + item["BOXNO"].Text + "'";
                sql += " and rackno = '" + item["RACKNO"].Text + "' and rowno = '" + item["ROWNO"].Text + "'";

                WebTools.ExeSql(sql);
            }
            return "1";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    protected string AddTransfer()
    {
        try
        {
            string trans_id = WebTools.GetExpr("MIR_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_NO='" + Request.QueryString["doc_no"] + "'");
            string store_id = WebTools.GetExpr("STORE_ID", "VIEW_MATERIAL_DOC_MASTER", " WHERE DOC_NO = '" + Request.QueryString["DOC_NO"] + "'"); ;
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                
                string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text + "'");
                string substore = WebTools.GetExpr("SUBSTORE_ID", "STORES_SUB", " WHERE STORE_ID = '" + store_id + "' and STORE_L1 = '" + item["SUBSTORE"].Text + "'");
                string sql = "INSERT INTO PIP_MAT_TRANSF_DETAIL (TRANSF_ID, MAT_ID, HEAT_NO, TRANSF_QTY, SUBSTORE_ID,  CABLE_DRUM_NO, ROW_NO, RACK_NO, BOX_NO) VALUES ('";
                sql += trans_id + "','" + mat_id + "', '" + item["HEATNO"].Text + "','";
                sql += item["OTHER_QTY"].Text + "','" + substore + "','" + item["CABLEDRUMNO"].Text + "','" + item["ROWNO"].Text + "','";
                sql += item["RACKNO"].Text + "','" + item["BOXNO"].Text + "')";

                WebTools.ExeSql(sql);

                sql = "DELETE FROM TBL_BARCODE_IMPORT_DATA WHERE DOCUMENTNO='" + Request.QueryString["doc_no"] + "' and materialid = '" + mat_id + "' and heatno='" + item["HEATNO"].Text + "'";
                sql += " and substoreid='" + substore + "' and cabledrumno = '" + item["CABLEDRUMNO"].Text + "' AND BOXNO='" + item["BOXNO"].Text + "'";
                sql += " and rackno = '" + item["RACKNO"].Text + "' and rowno = '" + item["ROWNO"].Text + "'";

                WebTools.ExeSql(sql);
            }
            return "1";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    protected string AddReceive()
    {
        try
        {
            string rcv_id = WebTools.GetExpr("RCV_ID", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_NUMBER='" + Request.QueryString["doc_no"] + "'");
            string store_id = WebTools.GetExpr("STORE_ID", "VIEW_MATERIAL_DOC_MASTER", " WHERE DOC_NO = '" + Request.QueryString["DOC_NO"] + "'"); ;
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                
                string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text + "'");
                string substore = WebTools.GetExpr("SUBSTORE_ID", "STORES_SUB", " WHERE STORE_ID = '" + store_id + "' and STORE_L1 = '" + item["SUBSTORE"].Text + "'");
                string sql = "INSERT INTO PIP_MAT_TRANSF_DETAIL (PROJECT_ID, RCV_ID, MAT_ID, RCV_QTY, HEAT_NO, EXCESS_QTY, SHORT_QTY, DAMAGE_QTY, SUBSTORE_ID,  CABLE_DRUM_NO, ROW_NO, RACK_NO, BOX_NO) VALUES ('"+Session["PROJECT_ID"].ToString()+"','";
                sql += rcv_id + "','" + mat_id + "', '" + item["ACCEPT_QTY"].Text + "','" + item["HEATNO"] + "','" + item["EXCESS_QTY"].Text + "', '";
                sql += item["SHORT_QTY"].Text + "','" + item["DAMAGE_QTY"].Text + "','" + substore + "','";
                sql += item["CABLEDRUMNO"].Text + "','" + item["ROWNO"].Text + "','";
                sql += item["RACKNO"].Text + "','" + item["BOXNO"].Text + "')";

                WebTools.ExeSql(sql);

                sql = "DELETE FROM TBL_BARCODE_IMPORT_DATA WHERE DOCUMENTNO='" + Request.QueryString["doc_no"] + "' and materialid = '" + mat_id + "' and heatno='" + item["HEATNO"].Text + "'";
                sql += " and substoreid='" + substore + "' and cabledrumno = '" + item["CABLEDRUMNO"].Text + "' AND BOXNO='" + item["BOXNO"].Text + "'";
                sql += " and rackno = '" + item["RACKNO"].Text + "' and rowno = '" + item["ROWNO"].Text + "'";

                WebTools.ExeSql(sql);
            }
            return "1";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    protected string AddMIV()
    {
        try
        {
            string issue_id = WebTools.GetExpr("ADD_ISSUE_ID", "PIP_MAT_ISSUE_ADD", " WHERE issue_no='" + Request.QueryString["doc_no"] + "'");
            string store_id = WebTools.GetExpr("STORE_ID", "VIEW_MATERIAL_DOC_MASTER", " WHERE DOC_NO = '" + Request.QueryString["DOC_NO"] + "'"); ;
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {

                string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + item["MAT_CODE1"].Text + "'");
                string substore = WebTools.GetExpr("SUBSTORE_ID", "STORES_SUB", " WHERE STORE_ID = '" + store_id + "' and STORE_L1 = '" + item["SUBSTORE"].Text + "'");
                string sql = "INSERT INTO PIP_MAT_ISSUE_ADD_DETAIL (ADD_ISSUE_ID, MAT_ID, HEAT_NO, ISSUE_QTY, SUBSTORE_ID,  CABLE_DRUM_NO, ROW_NO, RACK_NO, BOX_NO) VALUES ('";
                sql += issue_id + "','" + mat_id + "', '" + item["HEATNO"].Text + "','";
                sql += item["OTHER_QTY"].Text + "','" + substore + "','" + item["CABLEDRUMNO"].Text + "','" + item["ROWNO"].Text + "','";
                sql += item["RACKNO"].Text + "','" + item["BOXNO"].Text + "')";

                WebTools.ExeSql(sql);

                sql = "DELETE FROM TBL_BARCODE_IMPORT_DATA WHERE DOCUMENTNO='" + Request.QueryString["doc_no"] + "' and materialid = '" + mat_id + "' and heatno='" + item["HEATNO"].Text + "'";
                sql += " and substoreid='" + substore + "' and cabledrumno = '" + item["CABLEDRUMNO"].Text + "' AND BOXNO='" + item["BOXNO"].Text + "'";
                sql += " and rackno = '" + item["RACKNO"].Text + "' and rowno = '" + item["ROWNO"].Text + "'";

                WebTools.ExeSql(sql);
            }
            return "1";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
}