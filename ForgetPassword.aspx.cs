using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.OracleClient;
using System.Text;

public partial class ForgetPassword_code : System.Web.UI.Page
{
    OracleCommand cmd;
    DataTable dt;
    OracleConnection con = new OracleConnection();
    OracleDataAdapter adp;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = WebTools.GetIpmsConnection();
        
        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }

    }
    protected void btn_send_Click(object sender, EventArgs e)
    {
        if (con.State == ConnectionState.Closed)
        { con.Open(); }
        try
        {
            adp = new OracleDataAdapter("SELECT USER_NAME,EMAIL FROM USERS WHERE EMAIL='"+ txt_email.Text+"' OR UPPER(USER_NAME)='"
                                       + txt_uname.Text.ToUpper()+"'", con);
            dt = new DataTable();
            adp.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                
                lbl_msg.Text = "Enter Valid Registered Email Address or User Name";
                lbl_msg.ForeColor = System.Drawing.Color.Red;
                txt_email.Text = "";
                txt_uname.Text = "";
                return;
            }
            else
            {
                string job_name = WebTools.GetExpr("JOB_NAME", "PROJECT_INFORMATION", "");
                string team_email = WebTools.GetExpr("TEAM_EMAIL", "PROJECT_INFORMATION", "");
                string code;
                code = Guid.NewGuid().ToString();
                cmd = new OracleCommand("UPDATE USERS SET CODE='"+ code+ "'WHERE EMAIL='" + txt_email.Text + "' OR UPPER(USER_NAME)='"
                                       + txt_uname.Text.ToUpper() + "'", con);
                StringBuilder sbody = new StringBuilder();
                sbody.Append("<span style=font-family:Calibri>Hello Mr." + dt.Rows[0]["USER_NAME"].ToString()+",");
                sbody.Append( "<br/>");
                sbody.Append("<br/>");
                sbody.Append( "Project:&nbsp;&nbsp;"+ job_name);
                sbody.Append( "<br/>");
                sbody.Append("Module Name:&nbsp;&nbsp;Material");
                sbody.Append( "<br/>");
                sbody.Append("<br/>");

                sbody.Append("<a href=https://amogh.cpecc.ae/Habshan5MM/ResetPassword.aspx?EMAIL=" + txt_email.Text);
                sbody.Append("&CODE=" + code + "&USER_NAME=" + dt.Rows[0]["USER_NAME"].ToString() + " style='color: #2463E6'>Click here to change your password</a></br></br>");
                sbody.Append("If you use this link and reset password onetime, it will expire.To get a new password reset link, visit");
                sbody.Append("<br/>");
                sbody.Append("http://amogh.cpecc.ae/Habshan5MM/LoginPage.aspx");
                System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage("apps@amoghllc.com", dt.Rows[0]["EMAIL"].ToString(), "Please reset your password of AMOGH", sbody.ToString());
                //mail.CC.Add("any other email address if u want for cc");
                System.Net.NetworkCredential mailAuthenticaion = new System.Net.NetworkCredential("apps@amoghllc.com", "Puw48379");
                System.Net.Mail.SmtpClient mailclient = new System.Net.Mail.SmtpClient("smtp-mail.outlook.com", 587);
                mailclient.EnableSsl = true;
                mailclient.Credentials = mailAuthenticaion;
                mail.IsBodyHtml = true;
                mailclient.Send(mail);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                con.Close();
                lbl_msg.Text = "Link has been sent to "+ dt.Rows[0]["EMAIL"].ToString()+" Email";
                lbl_msg.ForeColor = System.Drawing.Color.Green;
                txt_email.Text = "";
                txt_uname.Text = "";


            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = ex.Message;
            lbl_msg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            con.Close();
        }
    }



    protected void txt_uname_TextChanged(object sender, EventArgs e)
    {
        string Email = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='"
                                       + txt_uname.Text.ToUpper() + "'");
        ShowEmailLabel.Text = Email;
    }
}