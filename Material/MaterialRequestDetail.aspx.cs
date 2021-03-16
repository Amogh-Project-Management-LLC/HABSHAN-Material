using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialRequestDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Material Request");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialRequestItems.aspx?MAT_REQ_ID=" + Request.QueryString["MAT_REQ_ID"]);
    }
    protected void itemsDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        string status_flg = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " MAT_REQ_ID = " + Request.QueryString["MAT_REQ_ID"]);
        if (e.NewMode == DetailsViewMode.Edit)
        {
            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                Master.show_error("Access Denied!");
                e.Cancel = true;
            }
           else  if (status_flg == "Y" && !WebTools.UserInRole("ADMIN"))
            {
                Master.show_error("Status Completed");
                e.Cancel = true;
            }

        }
    }
}