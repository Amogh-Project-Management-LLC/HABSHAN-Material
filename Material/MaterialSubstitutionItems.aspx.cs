using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialSubstitutionItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Substitution Request<br/>";
            Master.HeadingMessage += WebTools.GetExpr("REQ_NO", "PIP_MAT_SUBSTITUTE", " REQ_ID='" + Request.QueryString["REQ_ID"].ToString() + "'");
            Master.AddModalPopup("~/Material/MaterialSubstitutionItemNew.aspx?REQ_ID=" + Request.QueryString["REQ_ID"], btnAdd.ClientID, 450, 650);
            Master.RadGridList = itemsGridDetail.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialSubstitution.aspx");
    }

    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.Web.UI.GridDataItem dataitem = (Telerik.Web.UI.GridDataItem)e.Item;

            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                ((ImageButton)dataitem["EditCommandColumn"].Controls[0]).Visible = false;
            }

            if (!WebTools.UserInRole("MM_DELETE"))
            {
                ((ImageButton)dataitem["DeleteColumn"].Controls[0]).Visible = false;
            }
        }
    }
    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
    }
}