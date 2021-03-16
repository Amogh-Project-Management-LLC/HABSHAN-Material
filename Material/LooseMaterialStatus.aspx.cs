using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_LooseMaterialStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Loose Material Status";
        }
    }

    protected void RadGrid1_PreRender(object sender, EventArgs e)
    {
       // FilterValue.Value = RadGrid1.MasterTableView.FilterExpression;
    }
}