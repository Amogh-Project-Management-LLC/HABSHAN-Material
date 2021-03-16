using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialCTableAdapters;

public partial class Material_MaterialReuseItemsNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Reuse Material (";
            heading += WebTools.GetExpr("MRN_NO", "PIP_MAT_REUSE", " MRN_ID=" + Request.QueryString["REQ_ID"]);
            heading += ")";

            Master.HeadingMessage(heading);
        }
    }

    protected void txtIsometric_TextChanged(object sender, EventArgs e)
    {
        txtQty.Text = string.Empty;
    }

    protected void ddBomItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        string MAT_ID = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + ddBomItem.SelectedValue.ToString());
        string bal_qty = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID=" + MAT_ID);
        string net_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", " WHERE  BOM_ID=" + ddBomItem.SelectedValue.ToString());
        txtQty.Text = net_qty;

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string MAT_ID = WebTools.GetExpr("MAT_ID", "VIEW_BOM_EREC_ITEM", " WHERE BOM_ID=" + ddBomItem.SelectedValue.ToString());
        string itemid = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_ID= " + MAT_ID);

        if (itemid != "19")
        {
            if (txtQty.Text.ToString().IndexOf('.') > 0)
            {
                Master.show_error("Please enter integer value");
                return;
            }
        }

        PIP_MAT_REUSE_DETAILTableAdapter reuse = new PIP_MAT_REUSE_DETAILTableAdapter();
        try
        {
            reuse.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"]),
                decimal.Parse(ddBomItem.SelectedValue.ToString()), decimal.Parse(txtQty.Text));
            Master.show_success("New BOM Item added!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            reuse.Dispose();
        }


    }


    protected void bomDataSourceB_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void ddBomItem_DataBinding(object sender, EventArgs e)
    {
        ddBomItem.Items.Clear();
        ddBomItem.Items.Add(new ListItem("(BOM Item)", "-1"));
        
    }
}