using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_PO_Assembly : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string po = WebTools.GetExpr("PO_NO", "PIP_PO", " PO_ID = '" + Session["PO_ID"].ToString() + "'");
            Master.HeadingMessage("Assembly - " + po);           
        }
    }
}