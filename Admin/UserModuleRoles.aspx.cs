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
            string user_name = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID = " + Request.QueryString["USER_ID"]);
            Master.HeadingMessage("User Roles (" + user_name + ")");


        }
    }
    private void Update_List()
    {
        string user_name = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID = " + Request.QueryString["USER_ID"]);
        string queryString = "SELECT * FROM VIEW_USER_MODULE WHERE USER_ID=" + Request.QueryString["USER_ID"] + " AND MODULE_ID=" + ddlModule.SelectedValue + " ORDER BY SEQ";

        using (OracleConnection connection = WebTools.GetIpmsConnection())
        {
            OracleCommand command = new OracleCommand(queryString, connection);
            //connection.Open();
            using (OracleDataReader reader = command.ExecuteReader())
            {

                while (reader.Read())
                {
                    Role_ListBoxDestination.Items.Add(new Telerik.Web.UI.RadListBoxItem(
                        reader["HIDE_COL_NAME"].ToString(), reader["SEQ"].ToString()
                        ));


                    for (int i = 0; i < Role_ListBoxSource.Items.Count; i++)
                    {

                        if (Role_ListBoxSource.Items[i].Text.ToString() == reader["HIDE_COL_NAME"].ToString())
                        {
                            Role_ListBoxSource.Items.Remove(Role_ListBoxSource.Items[i]);
                        }
                    }
                }
            }
        }
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
            //Save Roles
            //============================================================
            WebTools.ExeSql("DELETE USER_MODULE_ROLES WHERE USER_ID=" + USER_ID + " AND MODULE_ID=" + ddlModule.SelectedValue);

            foreach (Telerik.Web.UI.RadListBoxItem role in Role_ListBoxDestination.Items)
            {
                command.CommandText = "INSERT INTO USER_MODULE_ROLES (USER_ID, SEQ,MODULE_ID) VALUES(" + USER_ID + ",'" + role.Value.ToString() + "'," + ddlModule.SelectedValue + " )";

                command.ExecuteNonQuery();
            }
            //============================================================


            Master.show_success(" Saved!");

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



    protected void ddlModule_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Role_ListBoxSource.Items.Clear();
        Role_ListBoxDestination.Items.Clear();
        Role_ListBoxSource.DataSourceID = "RolesSqlDataSource";
        Role_ListBoxSource.DataBind();
        Update_List();
    }

    protected void btnAllRoles_Click(object sender, EventArgs e)
    {
        string USER_ID = Request.QueryString["USER_ID"];
        WebTools.ExecuteProcedure("PRC_ADMIN_COLUMN_WISE(" + USER_ID + ")");
        Master.show_success("Saved");

    }
}