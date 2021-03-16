using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

/// <summary>
/// Summary description for AmoghMail
/// </summary>
public class AmoghMail
{
    public AmoghMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string SendEmail(string ToMail, string user_id,string password)
    {
        try
        {            
            string[] streamids;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            string EmpName = WebTools.GetExpr("USER_FULL_NAME", "USERS", " WHERE User_id='" + user_id + "'");
            string user_name = WebTools.GetExpr("USER_NAME", "USERS", " WHERE User_id='" + user_id + "'");
            string job_name= WebTools.GetExpr("JOB_NAME", "PROJECT_INFORMATION", "");
            string team_email = WebTools.GetExpr("TEAM_EMAIL", "PROJECT_INFORMATION", "");
            //Send Mail
            SmtpClient smtp = new SmtpClient();
            smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
            smtp.Port = 587;
            smtp.Host = "smtp-mail.outlook.com";
            smtp.EnableSsl = true;
            MailMessage message = new MailMessage();
            message.From = new MailAddress("apps@amoghllc.com");
            message.To.Add(ToMail);
            
            message.Subject = "Amogh Notification - User ID Created.";
            message.Body = "<span style=font-family:Courier New>Dear Amogh User,";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "Project:&nbsp;&nbsp;"+ job_name;
            message.Body += "<br/>";
            message.Body += "Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + System.DateTime.Today.ToString("dd/MMM/yyyy");
            message.Body += "<br/>";
            message.Body += "Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification";
            message.Body += "<br/>";
            message.Body += "Module:&nbsp;&nbsp;&nbsp;User Creation";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "Your user account has been created in Amogh System.";
            message.Body += "<br/>";
            message.Body += "Please find below URL & your login credentials.";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "URL: https://amogh.cpecc.ae/";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "Login ID: " + user_name;
            message.Body += "<br/>";
            message.Body += "Password: "+password;
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "<br/>";
            message.Body += "For clarifications, please contact Amogh team on "+ team_email;
            message.Body += "</span>";
            message.IsBodyHtml = true;
            smtp.Send(message);
            //           
            return "0";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }

    }


    public static string Mail(string MailTo, string Mailcc, string Subject, string MailText)
    {
        try
        {
            //Send Mail
            SmtpClient smtp = new SmtpClient();
            smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
            smtp.Port = 587;
            smtp.Host = "smtp-mail.outlook.com";
            smtp.EnableSsl = true;
            MailMessage message = new MailMessage();
            message.From = new MailAddress("apps@amoghllc.com");
            message.To.Add(MailTo);
            if (Mailcc.Length > 0)
                message.CC.Add(Mailcc);
            message.Subject = Subject;
            message.Body = MailText;
            message.IsBodyHtml = true;
            smtp.Send(message);
            return "0";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }

    }

}