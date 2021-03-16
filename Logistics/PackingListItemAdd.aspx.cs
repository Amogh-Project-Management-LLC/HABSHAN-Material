using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistics_PackingListItemAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage("Add Split Detail");
            hiddenIRN_ID.Value =  WebTools.GetExpr("PO_ID", "PRC_SRN_MASTER", " WHERE SRN_ID='" + Request.QueryString["SRN_ID"] + "'");
            
            string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_IRN", " WHERE IRN_ID=" + hiddenIRN_ID.Value);
            txtPONo.Text = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID=" + po_id);
        }
    }

    protected void txtSearchItem_TextChanged(object sender, EventArgs e)
    {
        Master.show_success(hiddenIRN_ID.Value);
    }
}