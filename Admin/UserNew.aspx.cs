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
using dsUsersTableAdapters;

public partial class Admin_UserNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New User");
        }
    }
    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        VIEW_USERSTableAdapter users = new VIEW_USERSTableAdapter();
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
            else if (txtPassword.Text != txtPassword2.Text)
            {
                Master.show_error("Password does not match!");
                return;
            }

            users.InsertQuery(txtUserName.Text, string.Empty, txtEmail.Text, "N",
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                WebTools.MD5Str(txtPassword.Text),txtDesignation.Text,txtCompany.Text
                );

           string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE EMAIL='" + txtEmail.Text + "'");
            AmoghMail.SendEmail(txtEmail.Text, user_id, txtPassword.Text);

            Master.show_success(txtUserName.Text + " User Created & Notification Email sent to the user!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            users.Dispose();
        }
    }
}