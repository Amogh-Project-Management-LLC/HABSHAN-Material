using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Logistics_ShipmentMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "SHIPMENT MASTER";
            Master.AddModalPopup("~/Logistics/ShipmentNew.aspx", btnAdd.ClientID, 550, 650);
        }
    }

    protected void btnDetail_Click(object sender, EventArgs e)
    {
        if(itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select a record to continue.");
            return;
        }

        Response.Redirect("ShipmentDetail.aspx?Ship_ID=" + itemsGrid.SelectedValue);
    }

  
}