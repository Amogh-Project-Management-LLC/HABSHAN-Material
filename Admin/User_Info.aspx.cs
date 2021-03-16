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

public partial class Admin_User_Info : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "User Info";
            Master.AddModalPopup("~/Admin/ChangePassword.aspx", btnChangePass.ClientID, 300, 500);

            //Load Profile Picture
            Load_Profile_Picture();
        }
    }

    private string Right(string value, int length)
    {
        if (String.IsNullOrEmpty(value)) return string.Empty;

        return value.Length <= length ? value : value.Substring(value.Length - length);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string file_ext = Right(FileUpload1.FileName, 3);
            string FileName = WebTools.SessionDataPath() + "user_pic." + file_ext;

            if (File.Exists(FileName))
            {
                System.IO.File.Delete(FileName);
            }

            FileUpload1.SaveAs(FileName);

            FileInfo f = new FileInfo(FileName);
            if (f.Length > 200000)
            {
                Master.ShowWarn("File size can't be more than 200kb!");
                return;
            }

            byte[] byteArray = null;

            using (FileStream fs = new FileStream
                (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
            {

                byteArray = new byte[fs.Length];

                int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
            }

            string sql = "UPDATE USERS SET ACCOUNT_PIC=:ACCOUNT_PIC, ACCOUNT_PIC_EXT=:ACCOUNT_PIC_EXT WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND USER_NAME='" + Session["USER_NAME"].ToString() + "'";


            using (OracleConnection conn = WebTools.GetIpmsConnection())
            {
                using (OracleCommand cmd = new OracleCommand(sql, conn))
                {

                    cmd.Parameters.Add("ACCOUNT_PIC", OracleType.Blob);
                    cmd.Parameters[0].Value = byteArray;

                    cmd.Parameters.Add("ACCOUNT_PIC_EXT", OracleType.VarChar);
                    cmd.Parameters[1].Value = file_ext;

                    cmd.ExecuteNonQuery();
                }

            }

            Load_Profile_Picture();

            Master.ShowMessage("Picture Uploaded!");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
    protected void btnChangePic_Click(object sender, EventArgs e)
    {
        if (!ChangePicDiv.Visible)
        {
            ChangePicDiv.Visible = true;
        }
        else
        {
            ChangePicDiv.Visible = false;
        }
    }

    private void Load_Profile_Picture()
    {
        string sql = "SELECT * FROM USERS WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND USER_NAME='" + Session["USER_NAME"].ToString() + "'";

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

                                AccountImage.ImageUrl = baseUrl + "SessionData/" + Session.SessionID.ToString() + @"/" + file_name;
                                AccountImage.DataBind();
                            }
                        }
                    }
                }
            }
        }
    }
}