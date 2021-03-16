using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Preservation_PreserveCodesGuide : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage("Preservation Code Guide");
    }

    protected void RadMenu1_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        HiddenCatID.Value = e.Item.Value;
    }
}