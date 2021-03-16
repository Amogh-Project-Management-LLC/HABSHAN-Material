using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_TransRcvAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void checkPOItem_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select Material to Add.");
            return;
        }
        string mrr_no;
        string mat_code1;

        string rcv_qty;
        string insp_qty;
        string bal_to_insp;
        string rcv_item_id;
        
        dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_DTTableAdapter rfi_item = new dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_DTTableAdapter();
        string sql = string.Empty;
        try
        {
            foreach (GridDataItem item in itemsGrid.SelectedItems)
            {
                mrr_no = item["MAT_RCV_NO"].Text;
                rcv_item_id = item["RCV_ITEM_ID"].Text;
                mat_code1 = item["MAT_CODE1"].Text;
                rcv_qty = item["RCV_QTY"].Text;
                insp_qty = item["INSP_QTY"].Text.Trim();
                bal_to_insp = ((item["BAL_TO_INSP"].FindControl("BAL_TO_INSPLabel")) as RadTextBox).Text;

                if (decimal.Parse(rcv_qty) >= ((insp_qty.Trim() == "" ? 0 : decimal.Parse(insp_qty)) + decimal.Parse(bal_to_insp)))
                {
                  //  rfi_item.InsertQuery(decimal.Parse(Request.QueryString["RFI_ID"]), WebTools.GetMatId(mat_code1, decimal.Parse(Session["PROJECT_ID"].ToString())),
                 //       decimal.Parse(bal_to_insp), null, "XXX", null,decimal.Parse(rcv_item_id));
                }
                else
                {
                    Master.ShowError("Inspection quantity cannot be more than received qty.");                   
                }
            }
            Master.ShowSuccess("Selected Items added to RFI");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

        
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MatRFI.aspx");
    }
}