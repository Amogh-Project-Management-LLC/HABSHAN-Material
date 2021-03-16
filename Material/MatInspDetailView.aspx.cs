using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspDetailView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
            heading += " : PO Item : ";
            heading += WebTools.GetExpr("PO_ITEM", "PRC_MAT_INSP_DETAIL", " MIR_ITEM_ID='" + Session["popUp_MIR_ITEM_ID"].ToString()+"'");
            Master.HeadingMessage(heading);
        }
    }

    protected void DropDownList1_DataBinding(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("(Select)", ""));
    }

    protected void DropDownList2_DataBinding(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("(Select)", ""));
    }
}