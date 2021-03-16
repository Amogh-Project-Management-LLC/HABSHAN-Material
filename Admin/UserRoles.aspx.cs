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

public partial class Home_ContactsUserInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.IsAdminUser(Session["USER_NAME"].ToString()))
            {
                btnSubmit.Enabled = false;
                Master.show_error("Access Denied!");
                return;
            }

            Master.HeadingMessage("User Roles");

            txtUserName.Text = WebTools.GetExpr("USER_NAME", "USERS", "USER_ID=" + Request.QueryString["USER_ID"]);
        }
    }
    private void Update_List()
    {
        string queryString = "SELECT * FROM VIEW_USERS_ROLE WHERE USER_ID=" + Request.QueryString["USER_ID"] + " ORDER BY ROLE_NAME";

        using (OracleConnection connection = WebTools.GetIpmsConnection())
        {
            OracleCommand command = new OracleCommand(queryString, connection);
            //connection.Open();
            using (OracleDataReader reader = command.ExecuteReader())
            {

                while (reader.Read())
                {
                    Role_ListBoxDestination.Items.Add(new Telerik.Web.UI.RadListBoxItem(
                        reader["ROLE_NAME"].ToString(), reader["ROLE_NAME"].ToString()
                        ));

                    for (int i = 0; i < Role_ListBoxSource.Items.Count; i++)
                    {
                        if (Role_ListBoxSource.Items[i].Value.ToString() == reader["ROLE_NAME"].ToString())
                        {
                            Role_ListBoxSource.Items.Remove(Role_ListBoxSource.Items[i]);
                        }
                    }
                }
            }
        }
    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        txtPassword.Enabled = true;
        txtPassword2.Enabled = true;
    }
    protected void Role_ListBoxSource_DataBound(object sender, EventArgs e)
    {
        Update_List();
    }
    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        string USER_ID = Request.QueryString["USER_ID"];

        OracleConnection connection = WebTools.GetIpmsConnection();
        OracleCommand command = new OracleCommand();
        command.Connection = connection;
        command.CommandType = CommandType.Text;

        try
        {
            if (txtPassword.Enabled == true)
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

                WebTools.ExeSql("UPDATE USERS SET PASSKEY='" + WebTools.MD5Str(txtPassword.Text.ToLower()) + "' WHERE USER_ID=" + USER_ID);
            }

            //Save Roles
            //============================================================
            WebTools.ExeSql("DELETE USERS_ROLE WHERE USER_ID=" + USER_ID);

            foreach (Telerik.Web.UI.RadListBoxItem role in Role_ListBoxDestination.Items)
            {
                command.CommandText = "INSERT INTO USERS_ROLE(USER_ID, ROLE_NAME) VALUES(" + USER_ID + ",'" + role.Value.ToString() + "')";

                command.ExecuteNonQuery();
            }
            //============================================================

            if (txtPassword.Enabled == true)
            {
                Master.show_success("User Info Saved and Password Changed!");
            }
            else
            {
                Master.show_success(txtUserName.Text + " Saved!");
            }
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            command.Dispose();
            connection.Close();
            connection.Dispose();
        }
    }
    protected void btnReadOnly_Click(object sender, EventArgs e)
    {
        bool transfer;

        do
        {
            transfer = false;

            for (int i = 0; i < Role_ListBoxDestination.Items.Count; i++)
            {
                if (!is_read_only_role(Role_ListBoxDestination.Items[i].Value.ToString()))
                {
                    Role_ListBoxSource.Items.Add(Role_ListBoxDestination.Items[i]);
                    transfer = true;
                }

            }

        } while (transfer == true);

        Role_ListBoxDestination.Items.Sort();
        Role_ListBoxSource.Items.Sort();
    }

    private bool is_read_only_role(string role_name)
    {
        if (role_name.Contains("_DELETE") || 
            role_name.Contains("_UPDATE") || 
            role_name.Contains("_INSERT") || 
            role_name.Contains("_ENTRY") ||
            role_name.Contains("ADMIN")
            )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}