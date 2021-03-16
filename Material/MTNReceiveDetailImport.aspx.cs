using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MTNReceiveDetailImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Material Receive Detail<br/>";
            heading += WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
            Master.HeadingMessage = heading;
        }
    }
}