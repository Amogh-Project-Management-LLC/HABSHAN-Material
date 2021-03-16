using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class Admin_Users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Users";

            if (!WebTools.UserInRole("USERS_ADMIN"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }

            if (Session["popup_USER_ID"] == null)
            {
                Session.Add("popup_USER_ID", "");
            }

            Master.RadGridList = RadGrid1.ClientID;

            Master.AddModalPopup("~/Admin/UserNew.aspx", ImageButtonAdd.ClientID, 300, 500);
            //Master.AddModalPopup("~/Admin/UserRoles.aspx", btnRoles.ClientID, 600, 750);

        }
    }
    protected void itemsDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {

    }
    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_USER_ID"] = RadGrid_USER_ID();
    }
    protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }
    private string RadGrid_USER_ID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("USER_ID").ToString();
            }
        }
        return string.Empty;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            string emailID;
            string userid;
            int i = 0;
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                userid = item.GetDataKeyValue("USER_ID").ToString();
                emailID = WebTools.GetExpr("EMAIL", "USERS", " WHERE USER_ID='" + userid + "'");
                if (emailID != "")
                {
                    string str = AmoghMail.SendEmail(emailID, userid,"$cpecc1234");
                    i++;
                }
            }
          
            Master.ShowSuccess("Email Sent to selected users:"+i);
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
        }
    }


}