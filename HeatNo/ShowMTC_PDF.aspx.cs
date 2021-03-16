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
using System.Web.Hosting;
using System.IO;
using System.Data.OracleClient;


public partial class HeatNo_ShowMTC_PDF : System.Web.UI.Page
{
    string tc_id=string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("View PDF");
            tc_id = Request.QueryString["TC_ID"];
            //Load_Document();
            Load_PDF();
        }
    }

    private void Load_PDF()
    {
        string sql = "SELECT * FROM VIEW_TEST_CARDS WHERE TC_ID=" + tc_id;
        string sg_FileName = WebTools.SessionDataPath();
        string baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";
        string sg_pdf_html = "";
        string hc_pdf_html = "";
        string hc_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");
        string hc_url1 = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");


        string hc_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");
        string hc_asp_url1 = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");


        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        // HC_PDF_BLOB                        
                        {
                            string hc_FileName = dataReader["PDF_FILE_NAME"].ToString();
                            hc_url = hc_url1 + hc_FileName;
                            if (File.Exists(hc_url))
                            {
                                hc_asp_url = hc_asp_url1 + hc_FileName;
                                hc_pdf_html += "<br/>";

                                hc_pdf_html += string.Format("<a href='{0}' target='_blank'>{1}</a>",
                                    hc_asp_url,
                                    dataReader["PDF_TITLE"]);
                            }

                        }
                    } // dataReader.Read()

                    if (hc_pdf_html.Length > 0)
                    {
                        PDF_URL_Label.Text += "<b>MTC PDF</b><br/>" + hc_pdf_html + "<br/>";
                    }
                }
            }
        }
    }

    private void Load_Document()
    {
        if (string.IsNullOrEmpty(tc_id)) return;

        string sql = "SELECT * FROM PIP_TEST_CARDS WHERE TC_ID=" + tc_id;

        string FilePath = "";
        string FileName = "";

        string baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";

        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = dataReader["TC_ID"] + "_mtc.pdf";
                        FilePath = WebTools.SessionDataPath() + FileName;

                        if (File.Exists(FilePath))
                        {
                            File.Delete(FilePath);
                        }

                        if (dataReader["MTC_BLOB"] != DBNull.Value)
                        {
                            byte[] byteArray = (Byte[])dataReader["MTC_BLOB"];
                            using (FileStream fs = new FileStream(FilePath, FileMode.CreateNew, FileAccess.Write))
                            {
                                fs.Write(byteArray, 0, byteArray.Length);

                                if (PDF_URL_Label.Text.Length > 0)
                                {
                                    PDF_URL_Label.Text += "<br/>";
                                }

                                PDF_URL_Label.Text += string.Format("<a href='{0}' target='_blank'>{1}</a>",
                                    baseUrl + "SessionData/" + Session.SessionID.ToString() + @"\" + FileName,
                                    dataReader["TC_CODE"]);
                            }
                        }

                    }
                }
            }
        }

        if (PDF_URL_Label.Text == "") PDF_URL_Label.Text = "No PDF";
    }
}