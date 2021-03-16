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
using dsPO_ShipmentATableAdapters;

public partial class Material_MatReceiveNewItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
            string mrir = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID=" +
                Request.QueryString["MAT_RCV_ID"]);
            Master.HeadingMessage = "MRR Materials Register <br/> (" + mrir + ")";

            HiddenPOID.Value = WebTools.GetExpr("PO_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + Request.QueryString["MAT_RCV_ID"] + "'");
        }
        decimal mr_item_no = WebTools.DMax("MR_ITEM_NUM", "VIEW_ADAPTER_MAT_RCV_DETAIL", " WHERE MAT_RCV_ID='" + Request.QueryString["MAT_RCV_ID"] + "'");
        txtMrItem.Text = (mr_item_no + 1).ToString();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
            //if (WebTools.GetExpr("HEAT_NO", "PIP_HEAT_NO", " WHERE HEAT_NO='" + txtHeatNo.Text +
            //    "' AND PROJECT_ID=" + Session["PROJECT_ID"].ToString()) == "")
            //{
            //    Master.ShowWarn("Heat number not found!");
            //    return;
            //}
            //else
            //{
            //    //Find TC_CODE for selected heat number
            //}

            int irn_id = int.Parse(ddlIRN.SelectedValue);
            string po_item = txtPoItem.Text;
            decimal bal_to_rec=decimal.Parse(WebTools.GetExpr("BAL_TO_RECV", "VIEW_IRN_BAL_TO_RECV", " WHERE IRN_ID=" + irn_id + " AND PO_ITEM='" + po_item + "'"));
            if(decimal.Parse(txtQty.Text)>bal_to_rec)
            {
                RadWindowManager1.RadAlert("Receive Quantity cannot be more than IRN Qty:"+bal_to_rec, 300, 150, "Warning", "");
                return;
            }
            VIEW_ADAPTER_MAT_RCV_DETAILTableAdapter items = new VIEW_ADAPTER_MAT_RCV_DETAILTableAdapter();
            string pieces = txtPieces.Text;
            if (pieces == "N/A" || pieces=="")
            {
                pieces = "0";
            }
            
            items.InsertQuery(Decimal.Parse(Request.QueryString["MAT_RCV_ID"]),
            mat_id, Decimal.Parse(txtQty.Text),
            null, null,
            txtPoItem.Text, txtRemarks.Text,
            txtMrItem.Text, txtCableDrumNo.Text,decimal.Parse(ddlIRN.SelectedValue),decimal.Parse(pieces));
            Master.ShowMessage(txtMatCode.Text +  " added.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        
    }

    private void go_back()
    {
        Response.Redirect("MatReceiveItems.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }

    protected void txtMatCode_TextChanged(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        matIdField.Value = mat_id.ToString();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_back();
    }

    protected void txtPoItem_TextChanged(object sender, EventArgs e)
    {
        //string po_id = WebTools.GetExpr("PO_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + Request.QueryString["MAT_RCV_ID"] + "'");

        string mat_id = WebTools.GetExpr("MAT_ID", "PIP_PO_DETAIL", " WHERE PO_ID = '" + HiddenPOID.Value + "' AND PO_ITEM = '" + txtPoItem.Text + "'");

        txtMatCode.Text = WebTools.GetExpr("MAT_CODE1", "PIP_MAT_STOCK", " WHERE MAT_ID = '" + mat_id + "'");
        txtMatDescr.Text = WebTools.GetExpr("MAT_DESCR", "PIP_MAT_STOCK", " WHERE MAT_ID = '" + mat_id + "'");
    }

   

    protected void ddlMatList_DataBinding(object sender, EventArgs e)
    {
        //ddlMatList.Items.Clear();
        //ddlMatList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {

    }

    protected void btnExcelImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=10&RetUrl=~/Material/MatReceive.aspx");
    }

    protected void btnIRNImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceiveImport.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }

    protected void ddlMatList_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtPoItem.Text = WebTools.GetExpr("PO_ITEM", "VIEW_ADAPTER_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlMatList.SelectedValue + "'");
        txtMatCode.Text = WebTools.GetExpr("MAT_CODE1", "VIEW_ADAPTER_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlMatList.SelectedValue + "'");
        txtMatDescr.Text= WebTools.GetExpr("MAT_DESCR", "VIEW_ADAPTER_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlMatList.SelectedValue + "'");
        hiddenMatID.Value=WebTools.GetExpr("MAT_ID","PIP_PO_DETAIL", " WHERE PO_ITEM_ID='" + ddlMatList.SelectedValue + "'");

     
    }

    protected void ddlIRN_DataBinding(object sender, EventArgs e)
    {
        ddlIRN.Items.Clear();
        ddlIRN.Items.Add(new Telerik.Web.UI.DropDownListItem("Select IRN", ""));
    }

    protected void ddlIRN_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        int irn_id = int.Parse(ddlIRN.SelectedValue);
        string po_item = txtPoItem.Text;
        lblbalqty.Text="Bal IRN Qty to Receive: "+ WebTools.GetExpr("BAL_TO_RECV", "VIEW_IRN_BAL_TO_RECV", " WHERE IRN_ID=" + irn_id + " AND PO_ITEM='" + po_item + "'");
        txtPieces.Text= WebTools.GetExpr("BAL_TO_RECV_PIECES", "VIEW_IRN_BAL_TO_RECV", " WHERE IRN_ID=" + irn_id + " AND PO_ITEM='" + po_item + "'");
    }
}