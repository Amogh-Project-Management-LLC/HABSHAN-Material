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
using dsPO_ShipmentTableAdapters;

public partial class Material_PO_Items_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po_no = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID=" + Session["popup_PO_ID"].ToString());
            Master.HeadingMessage("PO * " + po_no);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.show_error("There are two materials with the same code! try to use the unique one.");
            return;
        }
        
        else if (mat_id == 0)
        {
            Master.show_error("Material Code not found!");
            return;
        }

        //PIP_PO_DETAILTableAdapter po_detail = new PIP_PO_DETAILTableAdapter();
        //try
        //{
        //    po_detail.InsertQuery(decimal.Parse(Request.QueryString["PO_ID"]),
        //        txtPOItem.Text,
        //        txtPA_Item.Text,
        //        mat_id, decimal.Parse(txtPOQty.Text),
        //        DateTime.Parse(txtDeliveryDate.Text),
        //        txtRemarks.Text);
        //    Master.ShowMessage("New item created successfully!");
        //}
        //catch (Exception ex)
        //{
        //    Master.ShowWarn(ex.Message);
        //}
    }
}