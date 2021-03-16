using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInsp_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string heading = "MRIR (";
        heading += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
        heading += ")";
        Master.HeadingMessage(heading);
    }
}