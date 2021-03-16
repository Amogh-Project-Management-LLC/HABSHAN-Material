using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialReserveItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Reserve<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MAT_RES_NO", "MAT_RESERVE", " MAT_RES_ID = '" + Request.QueryString["REQ_ID"] + "'");
            Master.AddModalPopup("~/Material/MaterialReserveItemsAdd.aspx?REQ_ID=" + Request.QueryString["REQ_ID"], btnAdd.ClientID, 450, 650);
            Master.RadGridList = gvHoldDetails.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialReserve.aspx");
    }
}