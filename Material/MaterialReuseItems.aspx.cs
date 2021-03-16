using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialReuseItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Reuse<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MRN_NO", "PIP_MAT_REUSE", " MRN_ID=" + Request.QueryString["REQ_ID"]);
            Master.AddModalPopup("~/Material/MaterialReuseItemsNew.aspx?REQ_ID=" + Request.QueryString["REQ_ID"], btnAdd.ClientID, 450, 650);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialReuse.aspx");
    }

    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        HiddenField1.Value = WebTools.GetExpr("ISO_ID", "VIEW_ADP_MAT_REUSE_DT", "MRN_ITEM_ID = " + RadGrid1.SelectedValue.ToString());
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
}