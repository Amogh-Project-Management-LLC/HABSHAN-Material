using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialReserve : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Reserve";
            Master.AddModalPopup("~/Material/MaterialReserveAdd.aspx", btnAdd.ClientID, 450, 650);
            Master.RadGridList = gvMatReserve.ClientID;
        }
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (gvMatReserve.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select Reserve Request No to Proceed.");
            return;
        }
        Response.Redirect("MaterialReserveItems.aspx?REQ_ID=" + gvMatReserve.SelectedValue);
    }
}