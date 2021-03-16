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
using System.Threading;
using System.Globalization;
using System;

public partial class ResetPassword_code : System.Web.UI.Page
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
        
        try
        {
          
            adp = new OracleDataAdapter("SELECT USER_NAME,EMAIL,CODE FROM USERS WHERE CODE='"+ Request.QueryString["CODE"].ToString()
                 +"' AND(EMAIL='"+ Request.QueryString["EMAIL"].ToString()+"' OR USER_NAME='"+ Request.QueryString["USER_NAME"].ToString()
                 +"')", con);


            dt = new DataTable();
            adp.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                
                divExpire.Visible = true;
                divpwd1.Visible = false;
                divpwd2.Visible = false;
                btn_change_pwd.Visible = false;

                return;
            }
            else
            {
                
                divExpire.Visible = false;
                divpwd1.Visible = true;
                divpwd2.Visible = true;
                btn_change_pwd.Visible = true;

            }
        }
        catch(Exception ex)
        {
            lbl_msg.Text = ex.Message;
            lbl_msg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {

        }
    }
    protected void btn_change_pwd_Click(object sender, EventArgs e)
    {
        
        if (con.State == ConnectionState.Closed)
        { con.Open(); }
        try

        {
            cmd = new OracleCommand("UPDATE USERS SET CODE='',PASSKEY='" + WebTools.MD5Str(txt_pwd.Text)+"' WHERE (EMAIL='"+ Request.QueryString["EMAIL"].ToString()
                +"' OR USER_NAME='"+Request.QueryString["USER_NAME"].ToString()+"' )", con);
            

            cmd.ExecuteNonQuery();
            cmd.Dispose();
            con.Close();
            lbl_msg.Text = "Your Password has been Changed successfully";
            lbl_msg.ForeColor = System.Drawing.Color.Green;
            txt_pwd.Text = "";
            txt_retype_pwd.Text = "";
            btnLogin.Visible = true;

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

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/LoginPage.aspx");
    }
}
