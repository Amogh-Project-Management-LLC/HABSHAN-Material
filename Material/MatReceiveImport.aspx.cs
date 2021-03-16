using dsPO_ShipmentATableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MatReceiveImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MRR - Import From IRN<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + Request.QueryString["MAT_RCV_ID"] + "'");
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_MAT_RCV_DETAILTableAdapter mrr = new VIEW_ADAPTER_MAT_RCV_DETAILTableAdapter();
        decimal mat_id;
        string mat_code1;
        string bal_to_recv, mr_item;
        string rel_qty;
        string irn_id = "";
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                mat_code1 = item["MAT_CODE1"].Text;
                //mat_id = WebTools.GetMatId(mat_code1, decimal.Parse(Session["PROJECT_ID"].ToString()));
                mat_id = decimal.Parse(WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code1 + "'"));
                //irn_id = WebTools.GetExpr("IRN_ID", "PIP_MAT_RECEIVE_IRN", " WHERE MAT_RCV_ID = '" + Request.QueryString["MAT_RCV_ID"].ToString()+ "'");
                irn_id = WebTools.GetExpr("IRN_ID", "PIP_PO_IRN", " WHERE IRN_NO = '" + item["IRN_NO"].Text + "'");
                bal_to_recv = WebTools.GetExpr("BAL_TO_RECV", "VIEW_IRN_BAL_TO_RECV", " WHERE IRN_ID = '" + irn_id + "' AND PO_ITEM='" + item["PO_ITEM"].Text +
                    "' AND MAT_ID='" + mat_id + "'");
                //bal_to_recv = (item["BAL_TO_RECV"].FindControl("BAL_TO_RECVLabel") as TextBox).Text;
                mr_item = WebTools.CountExpr("(1)", "PIP_MAT_RECEIVE_DETAIL", " WHERE MAT_RCV_ID='" + Request.QueryString["MAT_RCV_ID"].ToString() + "'");
                string RECV_QTY = (item["BAL_TO_RECV"].FindControl("BAL_TO_RECVLabel") as TextBox).Text;


                if ((decimal.Parse(item["RELEASE_QTY"].Text) - decimal.Parse(item["RECV_QTY"].Text)) < decimal.Parse(bal_to_recv))
                {
                    Master.ShowError("Receive Quantity cannot be more than release qty. ");
                    return;
                }
                string pieces = (item["BAL_TO_RECV_PIECES"].FindControl("BAL_TO_RECV_PIECESLabel") as TextBox).Text;
                
                if (pieces == "N/A" || pieces == "")
                {
                    pieces = "0";
                }
                mrr.InsertQuery(decimal.Parse(Request.QueryString["MAT_RCV_ID"]), mat_id, decimal.Parse(RECV_QTY), null, null,
                    item["PO_ITEM"].Text, null, (Decimal.Parse(mr_item) + 1).ToString(), null,(decimal.Parse(item["IRN_ID"].Text)),decimal.Parse(pieces));
            }
            Master.ShowMessage("Selected Items Added to MRR.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally {
            itemsGrid.Rebind();
        }
       
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceiveItems.aspx?MAT_RCV_ID="+Request.QueryString["MAT_RCV_ID"]);
    }
}