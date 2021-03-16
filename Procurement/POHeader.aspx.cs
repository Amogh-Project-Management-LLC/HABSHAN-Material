using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POHeader : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Header (";
            Master.HeadingMessage += WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID = '" + Request.QueryString["PO_ID"] + "'");
            Master.HeadingMessage += ")";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POMaster.aspx");
    }

    protected void ddlVendorList_DataBinding(object sender, EventArgs e)
    {
        RadDropDownList ddl = new RadDropDownList();
        ddl = (RadDropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new DropDownListItem("(Select)", ""));
    }
}