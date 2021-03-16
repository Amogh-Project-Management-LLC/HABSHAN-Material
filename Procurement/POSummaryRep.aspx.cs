using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PODetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Summary Report <br/> (";
            Master.HeadingMessage += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ") <br/> (" + WebTools.GetExpr("PO_SUBJECT", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POMaster.aspx");
    }

    protected void btnImportMR_Click(object sender, EventArgs e)
    {
        
            Response.Redirect("PODetailsImport.aspx?PO_ID=" + Request.QueryString["PO_ID"]);
        
    }

  

}