using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PO_IRN_ADD : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Items (";
            heading += WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " IRN_ID='" + Request.QueryString["IRN_ID"].ToString() + "'") + ")";
            Master.HeadingMessage(heading);
            string rfi_id=WebTools.GetExpr("RFI_ID", "PIP_PO_IRN", " IRN_ID=" + Request.QueryString["IRN_ID"].ToString());
        }

    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtMatCode.Text=ddlMatCode.SelectedText;
        fnc_set_bal();
    }

    protected void Save_Click(object sender, EventArgs e)
    {
        try
        {
            if(decimal.Parse(txtReleaseQty.Text)>decimal.Parse(txtBalRel.Text))
            {
                Master.show_error("Cannot release more than RFI Qty");
                return;
            }
            string irn_id = Request.QueryString["IRN_ID"].ToString();
            string qer = "INSERT INTO PIP_PO_IRN_DETAIL(IRN_ID, PO_ID, PO_ITEM, MAT_ID, RELEASE_QTY,HEAT_NO, TC_NO, INSP_QTY) VALUES(" +
                decimal.Parse(irn_id) + "," + decimal.Parse(ddlPO.SelectedValue) + ",'" + ddlPOItem.SelectedValue+ "'," + decimal.Parse(ddlMatCode.SelectedValue) +","+
                decimal.Parse(txtReleaseQty.Text) + ",'" + txtHeatNo.Text + "','" + txtTCNo.Text + "'," + txtInspQty.Text + ")";
            WebTools.ExeSql(qer);
            Master.show_success("Added");
            txtBalRel.Text = "";
            fnc_set_bal();
    }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
    protected void fnc_set_bal()
    {
        try
        {
            int mat_id = int.Parse(ddlMatCode.SelectedValue);
            string rfi_qty = WebTools.GetExpr("INSP_QTY", "VIEW_PO_RFI_QTY", " MAT_ID=" + ddlMatCode.SelectedValue + " AND  RFI_ID=" + Request.QueryString["RFI_ID"].ToString());
            string irn_qty = WebTools.GetExpr("REL_QTY", "VIEW_PO_IRN_QTY", " MAT_ID=" + ddlMatCode.SelectedValue + " AND  IRN_ID=" + Request.QueryString["IRN_ID"].ToString());
            if (rfi_qty == "")
            {
                rfi_qty = "0";
            }
            if (irn_qty == "")
            {
                irn_qty = "0";
            }
            txtBalRel.Text = (decimal.Parse(rfi_qty) - decimal.Parse(irn_qty)) + "";
        }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }



    protected void ddlMatCode_DataBinding(object sender, EventArgs e)
    {
        ddlMatCode.Items.Add(new Telerik.Web.UI.DropDownListItem("Select", "-1"));
    }
}