using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_MatRequisition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Requisition";

        
        }
     //  ClientScript.RegisterStartupScript(GetType(), "JavaScript", "javascript:Test(); ", true);
        //if (!WebTools.UserInRole("MatRequisition"))
        //{
        //    Master.ShowError("Dont have access to this page");
        //    //  Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
        //string user = Session["USER_NAME"].ToString().ToLower();
        //string access_by = WebTools.GetExpr("ACCESS_BY", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        //string all_records = WebTools.GetExpr("ALL_RECORDS", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        //ACCESS_BY.Value = access_by;
        //ALL_RECORDS.Value = all_records;
    }
    

}