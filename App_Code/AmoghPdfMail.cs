using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

/// <summary>
/// Summary description for AmoghMail
/// </summary>
public class AmoghPdfMail
{
    public AmoghPdfMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string SendEmail(string ToMail, string id ,string userName, string userEmail , string type_id)
    {
        try
        {            
            string[] streamids;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            //Send Mail
            SmtpClient smtp = new SmtpClient();
            smtp.Credentials = new NetworkCredential("amogh@cpecc.ae", "Amogh#5678");
            smtp.Port = 587;
            smtp.Host = "smtp.cpecc.ae";
            //smtp.EnableSsl = true;
            MailMessage message = new MailMessage();
            message.From = new MailAddress("amogh@cpecc.ae");
            message.To.Add(ToMail);
            switch (type_id)
            {
                case "1":
                    message.Subject = "Amogh Notification - MR Completed ." + id;
                    message.Body = "<span style=font-family:Courier New>Dear Amogh User,";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "Project:&nbsp;&nbsp;BAB Integrated Facilities Project (BIFP)";
                    message.Body += "<br/>";
                    message.Body += "Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + System.DateTime.Today.ToString("dd/MMM/yyyy");
                    message.Body += "<br/>";
                    message.Body += "Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification";
                    message.Body += "<br/>";
                    message.Body += "Module:&nbsp;&nbsp;&nbsp;MR NUMBER (" + id + ") Status Completed By User :" + userName;
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "For clarifications, please contact User on Email :" + userEmail;
                    message.Body += "</span>";
                    message.IsBodyHtml = true;
                    smtp.Send(message);
                    break;
                case "2":
                    message.Subject = "Amogh Notification - MTN Completed ." + id;
                    message.Body = "<span style=font-family:Courier New>Dear Amogh User,";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "Project:&nbsp;&nbsp;BAB Integrated Facilities Project (BIFP)";
                    message.Body += "<br/>";
                    message.Body += "Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + System.DateTime.Today.ToString("dd/MMM/yyyy");
                    message.Body += "<br/>";
                    message.Body += "Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification";
                    message.Body += "<br/>";
                    message.Body += "Module:&nbsp;&nbsp;&nbsp;MTN NUMBER (" + id + ") Status Completed By User :" + userName;
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "<br/>";
                    message.Body += "For clarifications, please contact User on Email :" + userEmail;
                    message.Body += "</span>";
                    message.IsBodyHtml = true;
                    smtp.Send(message);
                    break;
            }
            
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
            smtp.Credentials = new NetworkCredential("amogh@cpecc.ae", "Amogh#5678");
            smtp.Port = 587;
            smtp.Host = "smtp.cpecc.ae";
            smtp.EnableSsl = true;
            MailMessage message = new MailMessage();
            message.From = new MailAddress("amogh@cpecc.ae");
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