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
using System.Threading.Tasks;

public partial class Expeditors_Emails : System.Web.UI.Page
{
    
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Expeditors Emails";

            if (!WebTools.UserInRole("EXPEDITORS_USER_REGISTER"))
            {
                ImageButtonAdd.Visible = false;
            }
            else
            {
                Master.AddModalPopup("~/Admin/UserNew.aspx", ImageButtonAdd.ClientID, 300, 500);
            }
            if (!WebTools.UserInRole("EXPEDITORS_EMAIL"))
            {
                btnSendMail.Visible = false;
            }
            if (WebTools.UserInRole("Admin"))
            {

                this.itemsGridView.Columns[0].Visible = true;
                return;
            }

            try
            {
                if (Session["EXPEDITORS_EMAILS_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    itemsGridView.Rebind();

                }
            }
            catch (Exception ex)
            {

            }

        }
       
    }
  

    protected void btnEntry_Click(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("EXPEDITORS_REGISTER"))
        {
            Master.ShowWarn("Access denied.");
            return;
        }
        if (!EntryTable.Visible)
        {
            btnSave.Visible = true;
            EntryTable.Visible = true;
        }
        else
        {
            btnSave.Visible = false;
            EntryTable.Visible = false;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string code_exist = WebTools.GetExpr("USER_ID", "EXPEDITORS_EMAILS", " WHERE USER_ID='" + ddlEXPEDITOR_NAME.SelectedValue + "'");
            string USER_NAME = WebTools.GetExpr("USER_NAME", "USERS", " WHERE USER_ID='" + ddlEXPEDITOR_NAME.SelectedValue + "'");
            if (code_exist != ddlEXPEDITOR_NAME.SelectedValue)
            {

                itemsDataSource.Insert();
                Master.ShowMessage(USER_NAME + " Saved succesfully!");
            }
            else
            {
                Master.ShowWarn(USER_NAME + " Exist in Module!");
            }

        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }

    }


    public class SessionStorageProvider : IStateStorageProvider
    {
        private System.Web.SessionState.HttpSessionState session = HttpContext.Current.Session;
        static string storageKey;

        public static string StorageProviderKey
        {
            set { storageKey = value; }
        }

        public void SaveStateToStorage(string key, string serializedState)
        {
            session[storageKey] = serializedState;
        }

        public string LoadStateFromStorage(string key)
        {

            return session[storageKey].ToString();
        }
    }

    protected void itemsGridView_PreRender(object sender, EventArgs e)
    {
        SessionStorageProvider.StorageProviderKey = "EXPEDITORS_EMAILS_SESSION";
        RadPersistenceManager1.SaveState();
    }
    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("EXPEDITORS_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("EXPEDITORS_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }

    }
    protected void itemsGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =1 ";
            DataTable dt = General_Functions.GetDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =1";
            DataTable lbl_dt = General_Functions.GetDataTable(lbl_query);
            Label[] descLabel = new Label[30];
            int i = 0;
            foreach (DataRow row in lbl_dt.Rows)
            {
                string lbl_col = row["LBL_COL_NAME"].ToString();

                string str = (dataItem[lbl_col].Controls[0] as TextBox).Text;
                descLabel[i] = new Label();
                descLabel[i].Text = str;
                dataItem[lbl_col].Controls.Add(descLabel[i]);
                i++;
            }

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
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select EXPEDITORS  to ");
            return;
        }
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

           foreach (GridDataItem item in itemsGridView.SelectedItems)
            {
                ToMail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + item["USER_NAME"].Text.ToString().ToUpper() + "'");
                MailCC = WebTools.GetExpr("EMAIL", "VIEW_BATCH_CC", "");
                user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + item["USER_NAME"].Text.ToString().ToUpper() + "'");
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
                message.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp-mail.outlook.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
                
                //smtp.EnableSsl = true;
                smtp.Timeout = 2147483647;
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
    //    else
    //    {
    //        Master.ShowError("Already Send Mails");
    //    }



    private void SendPDFEmail(DataTable dt, string ToMail)
    {
        // DataView dv_new;
        //DataTable dt_new;
        //string ToMail = "";
        //DataSourceSelectArguments args_new = new DataSourceSelectArguments();
        //dv_new = MailDataSource.Select(args_new) as DataView;
        //dt_new = dv_new.ToTable() as DataTable;


        //foreach (DataRow myRow in dt_new.Rows)
        //{
        //    ToMail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + myRow["USER_NAME"].ToString().ToUpper() + "'");

        //    string cnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        //    OracleConnection sqlConnection = new OracleConnection(cnString);

        //    string CommandText = "SELECT * FROM VIEW_BATCH_EMAIL WHERE EMAIL='" + ToMail + "'";
        //    OracleCommand sqlCommand = new OracleCommand(CommandText, sqlConnection);

        //    OracleDataAdapter sqlDataAdapter = new OracleDataAdapter();
        //    sqlDataAdapter.SelectCommand = sqlCommand;

        //    DataSet dataSet = new DataSet();


        //    sqlDataAdapter.Fill(dataSet, "header");
        //    sqlConnection.Close();

        //    DataTable dt = new DataTable();
        //    String ConnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        //    OracleConnection con = new OracleConnection(ConnString);
        //    OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_BATCH_EMAIL WHERE EMAIL='" + ToMail + "'", con);
        //    cmd.CommandType = CommandType.Text;
        //    OracleDataAdapter da = new OracleDataAdapter(cmd);

        //    System.Data.DataTable result = new System.Data.DataTable();
        //    da.Fill(result);

        //    SendPDFEmail(result, ToMail);
        //}
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                string companyName = "Amogh";
                StringBuilder sb = new StringBuilder();
                sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Batch Details</b></td></tr>");
                sb.Append("<tr><td colspan = '2'></td></tr>");
                //sb.Append("<tr><td><b>PO Number:</b>");
                //sb.Append(orderNo);
                sb.Append("</td><td><b>Date: </b>");
                sb.Append(DateTime.Now);
                sb.Append(" </td></tr>");
                sb.Append("<tr><td colspan = '2'><b>Company Name:</b> ");
                sb.Append(companyName);
                sb.Append("</td></tr>");
                sb.Append("</table>");
                sb.Append("<br />");
                sb.Append("<table border = '1'>");
                sb.Append("<tr>");
                foreach (DataColumn column in dt.Columns)
                {
                    sb.Append("<th style = 'background-color: #D20B0C;color:#ffffff'>");
                    sb.Append(column.ColumnName);
                    sb.Append("</th>");
                }
                sb.Append("</tr>");
                foreach (DataRow row in dt.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn column in dt.Columns)
                    {
                        sb.Append("<td>");
                        sb.Append(row[column]);
                        sb.Append("</td>");
                    }
                    sb.Append("</tr>");
                }
                sb.Append("</table>");
                StringReader sr = new StringReader(sb.ToString());

                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();
                    byte[] bytes = memoryStream.ToArray();
                    memoryStream.Close();

                    MailMessage mm = new MailMessage("apps@amoghllc.com", ToMail);
                    mm.Subject = "Expire Batches";
                    mm.Body = "The attached batches are going to expire";
                    mm.Attachments.Add(new Attachment(new MemoryStream(bytes), "batch.pdf"));
                    mm.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient();
                    smtp.Credentials = new NetworkCredential("apps@amoghllc.com", "Puw48379");
                    smtp.Port = 587;
                    smtp.Host = "smtp-mail.outlook.com";
                    smtp.EnableSsl = true;
                    smtp.Timeout = 2000000;
                    smtp.Send(mm);
                }
            }
        }
    }





}