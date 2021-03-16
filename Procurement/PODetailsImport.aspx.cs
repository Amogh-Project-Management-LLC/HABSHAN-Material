using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_PODetailsImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Add Items - ";
            Master.HeadingMessage += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID='" + Request.QueryString["PO_ID"] + "'");

            HiddenMRID.Value = WebTools.GetExpr("MR_ID", "PIP_PO", " WHERE PO_ID='" + Request.QueryString["PO_ID"] + "'");

        }
        
    }

    protected void itemHeaderCheck_CheckedChanged(object sender, EventArgs e)
    {
        var rcb = (RadCheckBox)sender;

        foreach (GridDataItem row in itemsGrid.Items)
        {
            ((RadCheckBox)row["cbColumn"].FindControl("itemCheck")).Checked = rcb.Checked;
        }
        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        var mr_item = string.Empty; 
        var mat_code1 = string.Empty; 
        var bal_to_ord = string.Empty;
        var mat_id = string.Empty;
        string mr_id = "";
        decimal po_item = 0;
        Procurement_ATableAdapters.VIEW_ADAPTER_PO_DETAILTableAdapter po_detail = new Procurement_ATableAdapters.VIEW_ADAPTER_PO_DETAILTableAdapter();
        try
        {            
            foreach (GridDataItem row in itemsGrid.Items)
            {
                var rcb = (RadCheckBox)row["cbColumn"].FindControl("itemCheck");
                if (Convert.ToBoolean(rcb.Checked))
                {
                    mr_id = WebTools.GetExpr("MR_ID", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
                    mr_item = row["MR_ITEM_NO"].Text;
                    mat_code1 = row["MAT_CODE1"].Text;
                    bal_to_ord = WebTools.GetExpr("BAL_TO_ORD", "VIEW_MR_PO_BAL", " WHERE MR_ID = '" + mr_id + "' AND MR_ITEM_NO='" + mr_item  + "'");
                    //bal_to_ord = ((TextBox)row["BAL_TO_ORD"].FindControl("BAL_TO_ORDLabel")).Text;
                    mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code1 + "'");

                    if (string.IsNullOrEmpty(mat_id))
                    {
                        Master.ShowError("Invalid Item Code. Please Contact Administrator.");
                        return;
                    }
                    po_item = WebTools.DMax("PO_ITEM", "VIEW_PO_ITEM_MAX", " WHERE PO_ID='" + Request.QueryString["PO_ID"] + "'");
                    po_detail.InsertQuery(decimal.Parse(Request.QueryString["PO_ID"].ToString()), (po_item + 1).ToString(),
                        decimal.Parse(mat_id), decimal.Parse(bal_to_ord), null, mr_item);
                }
            }

            Master.ShowSuccess("Selected Items Added to PO");
            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally
        {
            po_detail.Dispose();
        }        
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PODetails.aspx?PO_ID=" + Request.QueryString["PO_ID"]);
    }
}