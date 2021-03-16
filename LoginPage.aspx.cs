using System;
using System.Web;
using System.Web.Hosting;
using System.IO;
using System.Data.OracleClient;
using System.Threading;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class LoginPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        //if (ProjectList.SelectedValue.ToUpper() == "DEMO")
        //{
        //    ErrMsg.Text = "Invalid Login ID or Password for selected Project";
        //    return;
        //}
        string proj_id, project, job_code, connect_as, connect, pj_code, proj_title;

        string host_ip = Request.UserHostAddress;
        var users = Application.Get("Users") as UsersCollection;
        //if(!users.CanLogin(txtUsername.Text, Session.SessionID, host_ip))
        //{
        //    ErrMsg.Text = "User has already logged in with this credentials. Can't login!";
        //    return;
        //}

        // can login
        Application.Set("Users", users);

        if (ProjectList.SelectedValue.ToString() != "-1")
        {
            proj_id = ProjectList.SelectedValue.ToString();
            project = ProjectList.SelectedItem.ToString();
            job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID=" +
                ProjectList.SelectedValue.ToString());
            pj_code = WebTools.GetExpr("SHORT_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID=" +
                ProjectList.SelectedValue.ToString());
            connect_as = "99";
            connect = "Admin";
            proj_title = WebTools.GetExpr("PROJ_DESC", "PROJECT_INFORMATION", " WHERE PROJECT_ID=" + ProjectList.SelectedValue.ToString());
            string disable = WebTools.GetExpr("DISABLED", "USERS", "UPPER(USER_NAME)=UPPER('" + txtUsername.Text + "')");
            Session["PROJECT_ID"] = proj_id;
            Session["USER_NAME"] = txtUsername.Text;

            if (disable == "Y")
            {
                ErrMsg.Text = "Your username has been blocked";
                return;
            }

            if (!WebTools.IsValidAuth(decimal.Parse(proj_id), txtUsername.Text, txtPassword.Text))
            {
                ErrMsg.Text = "Your login attempt was not successfull. Please try again.";
                //reset_session();
                return;
            }

            Session["PROJECT"] = project;
            Session["PROJECT_TITLE"] = proj_title;
            Session["JOB_CODE"] = job_code;
            Session["PJ_CODE"] = pj_code;
            Session["CONNECT_AS"] = connect_as;
            Session["CONNECT"] = connect;
            Session["STOCK_TYPE"] = WebTools.GetExpr("NVL(STOCK_TYPE, 'A')", "PROJECT_INFORMATION", "PROJECT_ID=" + proj_id);
            Session["HV_SCOPE"] = "XXX";

            //NEW
            if (!Directory.Exists(WebTools.SessionDataPath()))
            {
                Directory.CreateDirectory(WebTools.SessionDataPath());
            }

            //NEW
            Load_Profile_Picture(proj_id, txtUsername.Text);

            string back_url = Request.QueryString["RetUrl"];
            if (back_url != null)
            {
                Response.Redirect(back_url);
            }
            else
            {
             //   Response.Redirect("~/Home/dashboard.aspx");
                Response.Redirect("~/Procurement/MatRequisition.aspx");
                
            }
            
        }
    }

    protected void ProjectList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string proj_id = ProjectList.SelectedValue.ToString();
        Session["PROJECT_ID"] = proj_id;

        if(ProjectList.SelectedValue.ToUpper()=="DEMO")
        {
            Response.Redirect("../Demo/LoginPage.aspx");
            
        }
        else if (ProjectList.SelectedValue.ToUpper() == "JOB-5324")
        {
            Response.Redirect("../Habshan5MM/LoginPage.aspx");
        }
        else
        {
            Response.Redirect("../Material/LoginPage.aspx");
          
        }
    }

    protected void ProjectList_DataBound(object sender, EventArgs e)
    {
        if (ProjectList.Items.Count > 0)
        {
            ProjectList.SelectedIndex = 0;
        }
        ListItem item = new ListItem();
        bool demoFound = false;
        bool MaterialFound = false;
        bool HabshanMaterialFound = false;
        foreach(ListItem i in ProjectList.Items)
        {
            if(i.Text.ToUpper().Contains("DEMO"))
            {
                demoFound = true;
                break;
            }
            if (i.Text.ToUpper() == "P11570 - BIFP")
            {
                MaterialFound = true;
                break;
            }
            if (i.Text.ToUpper().Contains("HABSHAN-5"))
            {
                HabshanMaterialFound = true;
                break;
            }
        }
        if(!demoFound)
        {
            item.Text = "DEMO - DEMO PROJECT";
            item.Value = "DEMO";
            if (!ProjectList.Items.Contains(item))
                ProjectList.Items.Add(new ListItem(item.Text, item.Value));
        }
        if (!MaterialFound)
        {
            item.Text = "P11570 - BIFP";
            item.Value = "P11570";
            if (!ProjectList.Items.Contains(item))
                ProjectList.Items.Add(new ListItem(item.Text, item.Value));
        }
        if (!HabshanMaterialFound)
        {
            item.Text = "JOB-5324 - HABSHAN-5 PROJECT";
            item.Value = "JOB-5324";
            if (!ProjectList.Items.Contains(item))
                ProjectList.Items.Add(new ListItem(item.Text, item.Value));
        }
    }

    private void Load_Profile_Picture(string proj_id, string user_name)
    {
        string sql = "SELECT * FROM USERS WHERE PROJECT_ID=" + proj_id + " AND USER_NAME='" + user_name + "'";

        string FilePath = "";

        string baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";

        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        if (dataReader["ACCOUNT_PIC"] != DBNull.Value)
                        {
                            Random rnd = new Random();

                            string file_name = rnd.Next(1000, 9999).ToString() + "." + dataReader["ACCOUNT_PIC_EXT"];

                            FilePath = WebTools.SessionDataPath() + file_name;

                            if (File.Exists(FilePath))
                            {
                                File.Delete(FilePath);
                            }

                            byte[] byteArray = (Byte[])dataReader["ACCOUNT_PIC"];
                            using (FileStream fs = new FileStream(FilePath, FileMode.CreateNew, FileAccess.Write))
                            {
                                fs.Write(byteArray, 0, byteArray.Length);

                                Session["ACCOUNT_PIC_URL"] = baseUrl + "SessionData/" + Session.SessionID.ToString() + @"/" + file_name;
                            }
                        }
                    }
                }
            }
        }
    }

    protected void ProjectList_DataBinding(object sender, EventArgs e)
    {
        
    }
    protected void btnForgetPwd_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ForgetPassword.aspx");
    }
}