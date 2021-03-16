using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;
using System.Web.UI;
using System.Net.Mail;
using System.Net;
using System.Data.OracleClient;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.ComponentModel;
using System.Threading;


public partial class Expeditors_Emails : System.Web.UI.Page
{
    
    
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Expeditors Emails";

        }
        try
        {
            WebTools.ExecuteProcedure("PRC_BATCH_STATUS");
            Master.ShowSuccess("BATCH STATUS HAS BEEN REFRESHED");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        try
        {
            string query = "";

            DataView dv_new;
            DataTable dt_new;
            string ToMail = "";
            string MailCC = "";
            string user_id = "";
            string job_name = WebTools.GetExpr("JOB_NAME", "PROJECT_INFORMATION", "");
            //MailMessage start_message = new MailMessage();
            //start_message.From = new MailAddress("apps@amoghllc.com");
            //start_message.To.Add("manikanta.kuchi@amoghllc.com,vinod.kuchi@maakuthariglobal.com,asif.amogh@cpecc.ae");
            //start_message.Subject = "Email process has been started";
            //SmtpClient start_smtp = new SmtpClient();
            //start_smtp.Host = "smtp-mail.outlook.com";
            //start_smtp.Port = 587;
            //start_smtp.EnableSsl = true;
            //start_smtp.UseDefaultCredentials = false;
            //start_smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            //start_smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
            //start_smtp.Send(start_message);


            DataSourceSelectArguments args_new = new DataSourceSelectArguments();
            dv_new = MailDataSource.Select(args_new) as DataView;
            dt_new = dv_new.ToTable() as DataTable;

            query = "UPDATE EXPEDITORS_EMAILS SET STATUS ='N' WHERE IS_EXPEDITOR ='Y'";
            WebTools.ExeSql(query);
            foreach (DataRow myRow in dt_new.Rows)
            {

                ToMail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + myRow["USER_NAME"].ToString().ToUpper() + "'");
                MailCC = WebTools.GetExpr("EMAIL", "VIEW_BATCH_CC", "");
                user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + myRow["USER_NAME"].ToString().ToUpper() + "'");
                query = "UPDATE EXPEDITORS_EMAILS SET START_DATE ='" + DateTime.Now + "' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
             
                string cnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
                OracleConnection sqlConnection = new OracleConnection(cnString);

                string CommandText = "SELECT * FROM VIEW_BATCH_EMAIL WHERE EMAIL='" + ToMail + "'";
                OracleCommand sqlCommand = new OracleCommand(CommandText, sqlConnection);

                OracleDataAdapter sqlDataAdapter = new OracleDataAdapter();
                sqlDataAdapter.SelectCommand = sqlCommand;

                DataSet dataSet = new DataSet();


                sqlDataAdapter.Fill(dataSet, "header");
                sqlConnection.Close();

                string mimeType = string.Empty;
                string encoding = string.Empty;
                string extension = string.Empty;

                //Send Mail

                MailMessage message = new MailMessage();
                message.From = new MailAddress("apps@amoghllc.com");
                string[] CCId = MailCC.Split(',');

                foreach (string CCEmail in CCId)
                {
                    message.CC.Add(new MailAddress(CCEmail));
                }
                message.To.Add(ToMail);

                message.Subject = "Amogh Notification - Expire Batches .";
                message.Body = "<span style=font-family:Courier New,font-size:11>Dear Amogh User,";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "Project:&nbsp;&nbsp;"+ job_name;
                message.Body += "<br/>";
                message.Body += "Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + System.DateTime.Today.ToString("dd/MMM/yyyy");
                message.Body += "<br/>";
                message.Body += "Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<font>The following batches have expired or are going to expire: </font><br><br>";
                string htmlTableStart = "<table style=\"border-collapse:collapse; text-align:center;\" >";
                string htmlTableEnd = "</table>";
                string htmlHeaderRowStart = "<tr style =\"background-color:#6FA1D2; color:#ffffff;\">";
                string htmlHeaderRowEnd = "</tr>";
                string htmlTrStart = "<tr style =\"color:#555555;\">";
                string htmlTrEnd = "</tr>";
                string htmlTdStart = "<td style=\" border-color:#5c87b2; border-style:solid; border-width:thin; padding: 5px;\">";
                string htmlTdEnd = "</td>";

                message.Body += htmlTableStart;
                message.Body += htmlHeaderRowStart;
                message.Body += htmlTdStart + "PO NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "PO ITEM NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "BATCH NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "DELIVERY FORECAST DATE" + htmlTdEnd;
                message.Body += htmlTdStart + "BATCH QTY " + htmlTdEnd;
                message.Body += htmlTdStart + "BALANCE TO RECEIVE QTY " + htmlTdEnd;

                message.Body += htmlHeaderRowEnd;

                foreach (DataRow Row in dataSet.Tables[0].Rows)
                {
                    message.Body = message.Body + htmlTrStart;
                    message.Body = message.Body + htmlTdStart + Row["PO_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["PO_ITEM_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["DELIVERY_FORECAST"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_QTY"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_QTY_BAL"] + htmlTdEnd;
                    message.Body = message.Body + htmlTrEnd;
                }
                message.Body = message.Body + htmlTableEnd;

                message.Body += "</span>";
                message.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp-mail.outlook.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
                smtp.Timeout = 2147483;
                smtp.Send(message);
                query = "UPDATE EXPEDITORS_EMAILS SET COMPLETE_DATE ='" + DateTime.Now + "' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
                query = "UPDATE EXPEDITORS_EMAILS SET STATUS ='Y' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
                

            }
            Master.ShowSuccess("Email has been Sent ");
            
            //MailMessage admin_message = new MailMessage();
            //SmtpClient admin_smtp = new SmtpClient();
            //admin_smtp.Host = "smtp-mail.outlook.com";
            //admin_smtp.Port = 587;
            //admin_smtp.EnableSsl = true;
            //admin_smtp.UseDefaultCredentials = false;
            //admin_smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            //admin_smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
            //admin_message.From = new MailAddress("apps@amoghllc.com");
            //admin_message.To.Add("manikanta.kuchi@amoghllc.com,vinod.kuchi@maakuthariglobal.com,asif.amogh@cpecc.ae");
            //admin_message.Subject = "Email has been Sent";
            //admin_smtp.Send(admin_message);
            
        }
        catch (Exception ex)
        {
          
            MailMessage admin_message = new MailMessage();
            SmtpClient admin_smtp = new SmtpClient();
            admin_smtp.Host = "smtp-mail.outlook.com";
            admin_smtp.Port = 587;
            admin_smtp.EnableSsl = true;
            admin_smtp.UseDefaultCredentials = false;
            admin_smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            admin_smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
            admin_message.From = new MailAddress("apps@amoghllc.com");
            admin_message.To.Add("manikanta.kuchi@amoghllc.com");
            admin_message.Subject = "Email Error..";
            admin_smtp.Send(admin_message);
            Master.ShowError(ex.Message);
        }
    }

    protected void ImageButtonProcedure_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {

        try
        {
            WebTools.ExecuteProcedure("PRC_BATCH_STATUS");
            Master.ShowSuccess("BATCH STATUS HAS BEEN REFRESHED");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }

    }

    protected void btnSendMail_Click(object sender, EventArgs e)

    {

        //string run_date = WebTools.GetExpr("TO_CHAR(RUN_TIME,'DD-MON-YY')", "PROJECT_JOB_LIST", " PROCESS_NAME ='BATCH_EMAILS'");
        //if (run_date != System.DateTime.Today.ToString("dd/MMM/yyyy"))
        //{
        try
        {
            string query = "";

            DataView dv_new;
            DataTable dt_new;
            string ToMail = "";
            string MailCC = "";
            string user_id = "";
            DataSourceSelectArguments args_new = new DataSourceSelectArguments();
            dv_new = MailDataSource.Select(args_new) as DataView;
            dt_new = dv_new.ToTable() as DataTable;


            foreach (DataRow myRow in dt_new.Rows)
            {

                ToMail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + myRow["USER_NAME"].ToString().ToUpper() + "'");
                MailCC = WebTools.GetExpr("EMAIL", "VIEW_BATCH_CC", "");
                user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + myRow["USER_NAME"].ToString().ToUpper() + "'");
                query = "UPDATE EXPEDITORS_EMAILS SET START_DATE ='" + DateTime.Now + "' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
                query = "UPDATE EXPEDITORS_EMAILS SET STATUS ='N' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
                string cnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
                OracleConnection sqlConnection = new OracleConnection(cnString);

                string CommandText = "SELECT * FROM VIEW_BATCH_EMAIL WHERE EMAIL='" + ToMail + "'";
                OracleCommand sqlCommand = new OracleCommand(CommandText, sqlConnection);

                OracleDataAdapter sqlDataAdapter = new OracleDataAdapter();
                sqlDataAdapter.SelectCommand = sqlCommand;

                DataSet dataSet = new DataSet();


                sqlDataAdapter.Fill(dataSet, "header");
                sqlConnection.Close();

                string mimeType = string.Empty;
                string encoding = string.Empty;
                string extension = string.Empty;

                //Send Mail

                MailMessage message = new MailMessage();
                message.From = new MailAddress("apps@amoghllc.com");
                string[] CCId = MailCC.Split(',');

                foreach (string CCEmail in CCId)
                {
                    message.CC.Add(new MailAddress(CCEmail));
                }
                message.To.Add(ToMail);

                message.Subject = "Amogh Notification - Expire Batches .";
                message.Body = "<span style=font-family:Courier New>Dear Amogh User,";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "Project:&nbsp;&nbsp;BAB Integrated Facilities Project (BIFP)";
                message.Body += "<br/>";
                message.Body += "Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + System.DateTime.Today.ToString("dd/MMM/yyyy");
                message.Body += "<br/>";
                message.Body += "Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<br/>";
                message.Body += "<font>The following batches have expired or are going to expire: </font><br><br>";
                string htmlTableStart = "<table style=\"border-collapse:collapse; text-align:center;\" >";
                string htmlTableEnd = "</table>";
                string htmlHeaderRowStart = "<tr style =\"background-color:#6FA1D2; color:#ffffff;\">";
                string htmlHeaderRowEnd = "</tr>";
                string htmlTrStart = "<tr style =\"color:#555555;\">";
                string htmlTrEnd = "</tr>";
                string htmlTdStart = "<td style=\" border-color:#5c87b2; border-style:solid; border-width:thin; padding: 5px;\">";
                string htmlTdEnd = "</td>";

                message.Body += htmlTableStart;
                message.Body += htmlHeaderRowStart;
                message.Body += htmlTdStart + "PO NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "PO ITEM NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "BATCH NUMBER " + htmlTdEnd;
                message.Body += htmlTdStart + "DELIVERY FORECAST DATE" + htmlTdEnd;
                message.Body += htmlTdStart + "BATCH QTY " + htmlTdEnd;
                message.Body += htmlTdStart + "BALANCE TO RECEIVE QTY " + htmlTdEnd;

                message.Body += htmlHeaderRowEnd;

                foreach (DataRow Row in dataSet.Tables[0].Rows)
                {
                    message.Body = message.Body + htmlTrStart;
                    message.Body = message.Body + htmlTdStart + Row["PO_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["PO_ITEM_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_NO"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["DELIVERY_FORECAST"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_QTY"] + htmlTdEnd;
                    message.Body = message.Body + htmlTdStart + Row["BATCH_QTY_BAL"] + htmlTdEnd;
                    message.Body = message.Body + htmlTrEnd;
                }
                message.Body = message.Body + htmlTableEnd;

                message.Body += "</span>";
                SmtpClient smtp = new SmtpClient();
                smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
                smtp.Port = 587;
                smtp.Host = "smtp-mail.outlook.com";
                //smtp.EnableSsl = true;
                smtp.Timeout = 2147483647;
                message.IsBodyHtml = true;
                smtp.Send(message);
                query = "UPDATE EXPEDITORS_EMAILS SET COMPLETE_DATE ='" + DateTime.Now + "' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);
                query = "UPDATE EXPEDITORS_EMAILS SET STATUS ='Y' WHERE USER_ID =" + user_id;
                WebTools.ExeSql(query);

            }
            Master.ShowSuccess("Email has been Sent ");


        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);

        }
    }

}