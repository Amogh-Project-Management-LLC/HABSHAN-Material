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
using System.Data.OracleClient;
using System.Web.UI;
using Telerik.Web.UI;

public partial class Admin_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Change Password");
            txtUserName.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        try
        {

            if (txtPassword.Text.Length == 0)
            {
                Master.show_error("No Password provided!");
                return;
            }
            else if (txtPassword.Text.Length < 5)
            {
                Master.show_error("Minimum Password Length is 5!");
                return;
            }
            else if (txtPassword.Text != txtPasswordConfirm.Text)
            {
                Master.show_error("Password does not match!");
                return;
            }

            WebTools.ExeSql("UPDATE USERS SET PASSKEY='" + WebTools.MD5Str(txtPassword.Text) +
                "' WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND USER_NAME='" + Session["USER_NAME"].ToString() + "'");

            Master.show_success("Password Changed!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {

        }
    }
}