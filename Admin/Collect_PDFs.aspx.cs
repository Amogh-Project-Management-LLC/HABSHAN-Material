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
using System.Text.RegularExpressions;
using VB_Functions;
using System.Data.OracleClient;
using Telerik.Web.UI;

public partial class Admin_Collect_PDFs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("ADMIN"))
        //{
        //    Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
        if (!IsPostBack)
        {
            Log_RadListBox.Items.Clear();

            Master.HeadingMessage = "Collect PDFs";
            //lblUsers.Text = Application["userCount"].ToString();
        }
    }

    protected void btnCollectSpoolgenPDF_Click(object sender, EventArgs e)
    {
        if (txtSpoolgen_PDF_Path.Text == string.Empty)
        {
            Master.ShowMessage("Enter transmittal path!");
            return;
        }
        else
        {
            if (!Directory.Exists(txtSpoolgen_PDF_Path.Text))
            {
                Master.ShowMessage("Path not found on file system!");
                return;
            }
        }
        Log_RadListBox.Items.Clear();
        CopyFiles(txtSpoolgen_PDF_Path.Text);
    }

    private void Save_Log(string Log_Text)
    {
        RadListBoxItem listItem = new RadListBoxItem(Log_Text);
        listItem.ImageUrl = "~/images/icons/blue-bullet.png";
        Log_RadListBox.Items.Add(listItem);
    }

    private void CopyFiles(string mFolder)
    {
        string[] sSubFolders;
        string[] sFiles;
        string File_Name = string.Empty;
        string ISO_TITLE1 = string.Empty;
        string REV_FCR_SCR = string.Empty;
        string SPOOL = string.Empty;
        string REV_ID = string.Empty;
        string SPL_ID = string.Empty;
        string TempString = string.Empty;
        string pdf_type = string.Empty;
        int i;

        sSubFolders = Directory.GetDirectories(mFolder);
        sFiles = Directory.GetFiles(mFolder);

        if (sFiles.Length == 0) goto lblSubFolders;

        Save_Log(String.Format("Total {0} files found!", sFiles.Length));

        for (i = 0; i < sFiles.Length; i++)
        {
            if (sFiles[i].Substring(sFiles[i].Length - 4).ToUpper() == ".PDF")
            {
                File_Name = get_file_name(sFiles[i]);
                pdf_type = PDF_Type(get_file_name(sFiles[i]));

                if (pdf_type == "ISO")
                {
                    ISO_TITLE1 = File_Name.Substring(0, File_Name.LastIndexOf("_"));
                    REV_FCR_SCR = File_Name.Substring(File_Name.LastIndexOf("_") + 1).ToUpper().Replace(".PDF", "");

                    REV_ID = WebTools.GetExpr("REV_ID", "VIEW_ISO_REV", "PROJ_ID=" + Session["PROJECT_ID"].ToString() + " AND ISO_TITLE1='" + ISO_TITLE1 + "' AND REV_FCR_SCR='" + REV_FCR_SCR + "'");

                    Save_Log("Uploading " + ISO_TITLE1 + ", " + REV_FCR_SCR);

                    if (REV_ID.Length > 0)
                    {
                        string FileName = sFiles[i];

                        byte[] byteArray = null;

                        using (FileStream fs = new FileStream
                            (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
                        {

                            byteArray = new byte[fs.Length];

                            int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
                        }

                        string sql = "UPDATE PIP_REVISION SET SG_PDF_BLOB=:SG_PDF_BLOB WHERE REV_ID=:REV_ID";


                        using (OracleConnection conn = WebTools.GetIpmsConnection())
                        {
                            using (OracleCommand cmd = new OracleCommand(sql, conn))
                            {
                                cmd.Parameters.Add("SG_PDF_BLOB", OracleType.Blob);
                                cmd.Parameters[0].Value = byteArray;

                                cmd.Parameters.Add("REV_ID", OracleType.Number);
                                cmd.Parameters[1].Value = REV_ID;

                                cmd.ExecuteNonQuery();
                            }

                        }
                    }

                }

                else if (pdf_type == "SPOOL")
                {
                    //SPOOL
                    string File_Name2 = File_Name.ToUpper().Replace(".PDF", "");
                    string iso_spool = File_Name2.Substring(0, File_Name2.LastIndexOf("_"));

                    ISO_TITLE1 = iso_spool.Substring(0, iso_spool.LastIndexOf("_"));
                    SPOOL = iso_spool.Substring(iso_spool.LastIndexOf("_") + 1);
                    REV_FCR_SCR = File_Name2.Substring(File_Name2.LastIndexOf("_") + 1);

                    SPL_ID = WebTools.GetExpr("SPL_ID", "VIEW_SPOOL_PDF", "SG_PDF_BLOB IS NULL AND PROJ_ID=" + Session["PROJECT_ID"].ToString() +
                        " AND ISO_TITLE1='" + ISO_TITLE1 +
                        "' AND SPOOL_DEC=TO_NUMBER('" + SPOOL.Replace("SPL-", "") +
                        "') AND REV_SCR_FCR='" + REV_FCR_SCR + "'");

                    Save_Log("Uploading Spool " + ISO_TITLE1 + " * " + SPOOL);
                    //Save_Log(string.Format("REV_ID={0}, REV_SCR_FCR={1}", REV_ID, REV_SCR_FCR));

                    if (SPL_ID.Length > 0)
                    {
                        string FileName = sFiles[i];

                        byte[] byteArray = null;

                        using (FileStream fs = new FileStream
                            (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
                        {

                            byteArray = new byte[fs.Length];

                            int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
                        }

                        //REV_SCR_FCR
                        string[] Revision = REV_FCR_SCR.Split('-');

                        string sql = "INSERT INTO PIP_SPOOL_PDF(SPL_ID, REV_NO, SCR, FCR, SG_PDF_BLOB) VALUES(:SPL_ID, :REV_NO, :SCR, :FCR, :SG_PDF_BLOB)";


                        using (OracleConnection conn = WebTools.GetIpmsConnection())
                        {
                            using (OracleCommand cmd = new OracleCommand(sql, conn))
                            {
                                cmd.Parameters.Add("SPL_ID", OracleType.Number);
                                cmd.Parameters[0].Value = SPL_ID;

                                cmd.Parameters.Add("REV_NO", OracleType.VarChar);
                                cmd.Parameters[1].Value = Revision[0];

                                cmd.Parameters.Add("SCR", OracleType.VarChar);
                                cmd.Parameters[2].Value = Revision[1];

                                cmd.Parameters.Add("FCR", OracleType.VarChar);
                                cmd.Parameters[3].Value = Revision[2];

                                cmd.Parameters.Add("SG_PDF_BLOB", OracleType.Blob);
                                cmd.Parameters[4].Value = byteArray;

                                cmd.ExecuteNonQuery();
                            }

                        }
                    }

                }
                else
                {
                    Save_Log(File_Name + " * Error while processing file!");
                }
            }
        }

    lblSubFolders:
        if (sSubFolders.Length == 0) return;

        for (i = 0; i < sSubFolders.Length; i++)
        {
            CopyFiles(sSubFolders[i]);
        }
    }

    private void CopyHardCopy(string mFolder)
    {
        string[] sSubFolders;
        string[] sFiles;
        string File_Name = string.Empty;
        string ISO_TITLE1 = string.Empty;
        string REV_FCR_SCR = string.Empty;
        string REV_ID = string.Empty;
        string TempString = string.Empty;
        string pdf_type = string.Empty;
        int i;

        sSubFolders = Directory.GetDirectories(mFolder);
        sFiles = Directory.GetFiles(mFolder);

        if (sFiles.Length == 0) goto lblSubFolders;

        Save_Log(string.Format("Total {0} files found!", sFiles.Length));

        for (i = 0; i < sFiles.Length; i++)
        {
            if (sFiles[i].Substring(sFiles[i].Length - 4).ToUpper() == ".PDF")
            {
                File_Name = get_file_name(sFiles[i]);
                pdf_type = PDF_Type(get_file_name(sFiles[i]));

                if (pdf_type == "ISO")
                {
                    ISO_TITLE1 = File_Name.Substring(0, File_Name.LastIndexOf("_"));
                    REV_FCR_SCR = File_Name.Substring(File_Name.LastIndexOf("_") + 1).ToUpper().Replace(".PDF", "");

                    if (REV_FCR_SCR.Length == 1)
                    {
                        REV_FCR_SCR += "-0-0";
                    }

                    REV_ID = WebTools.GetExpr("REV_ID", "VIEW_ISO_REV",
                        "PROJ_ID=" + Session["PROJECT_ID"].ToString() + " AND ISO_TITLE1='" + ISO_TITLE1 + "' AND REV_FCR_SCR='" + REV_FCR_SCR + "'");

                    Save_Log("Uploading " + ISO_TITLE1);

                    if (REV_ID.Length > 0)
                    {
                        string FileName = sFiles[i];

                        byte[] byteArray = null;

                        using (FileStream fs = new FileStream
                            (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
                        {

                            byteArray = new byte[fs.Length];
                            int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
                        }

                        string sql = "UPDATE PIP_REVISION SET HC_PDF_BLOB=:HC_PDF_BLOB WHERE REV_ID=:REV_ID";


                        using (OracleConnection conn = WebTools.GetIpmsConnection())
                        {
                            using (OracleCommand cmd = new OracleCommand(sql, conn))
                            {
                                cmd.Parameters.Add("HC_PDF_BLOB", OracleType.Blob);
                                cmd.Parameters[0].Value = byteArray;

                                cmd.Parameters.Add("REV_ID", OracleType.Number);
                                cmd.Parameters[1].Value = REV_ID;

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                }
                else
                {
                    Save_Log(File_Name + " * Error while processing file!");
                }
            }
        }

    lblSubFolders:
        if (sSubFolders.Length == 0) return;

        for (i = 0; i < sSubFolders.Length; i++)
        {
            CopyHardCopy(sSubFolders[i]);
        }
    }

    private string PDF_Type(string sFileName)
    {
        VB_Func vb = new VB_Func();

        if (vb.VB_Like(sFileName.ToLower(), "*_*spl*_*.pdf"))
        {
            return "SPOOL";
        }
        else if (vb.VB_Like(sFileName.ToLower(), "*_*.pdf"))
        {
            return "ISO";
        }
        else
        {
            return "";
        }
    }

    private string get_file_name(string file_path)
    {
        FileInfo mFileInfo = new FileInfo(file_path);
        return mFileInfo.Name;
    }

    //private bool Like(string toSearch, string toFind)
    //{
    //    return new Regex(@"\A" + new Regex(@"\.|\$|\^|\{|\[|\(|\||\)|\*|\+|\?|\\").Replace(toFind, ch => @"\" + ch).Replace('_', '.').Replace("%", ".*") +
    //                    @"\z", RegexOptions.Singleline).IsMatch(toSearch);
    //}

    protected void btnCollectHardCopyPDF_Click(object sender, EventArgs e)
    {
        if (txtHardCopy_Path.Text == string.Empty)
        {
            Master.ShowMessage("Enter hard-copy files path!");
            return;
        }
        else
        {
            if (!Directory.Exists(txtHardCopy_Path.Text))
            {
                Master.ShowMessage("Hard-copy path not found!");
                return;
            }
        }
        Log_RadListBox.Items.Clear();
        CopyHardCopy(txtHardCopy_Path.Text);
    }

    protected void btnMTC_Pdf_Click(object sender, EventArgs e)
    {
        if (txtMTC_Pdf.Text == string.Empty)
        {
            Master.ShowMessage("Enter MTC PDF path!");
            return;
        }
        else
        {
            if (!Directory.Exists(txtMTC_Pdf.Text))
            {
                Master.ShowMessage("MTC Path not found on file system!");
                return;
            }
        }
        Log_RadListBox.Items.Clear();
        CopyMTC(txtMTC_Pdf.Text);
    }

    private void CopyMTC(string mFolder)
    {
        string[] sSubFolders;
        string[] sFiles;
        string File_Name = string.Empty;
        string MTC_Code = string.Empty;
        string TC_ID = string.Empty;
        string TempString = string.Empty;
        int i;

        sSubFolders = Directory.GetDirectories(mFolder);
        sFiles = Directory.GetFiles(mFolder);

        if (sFiles.Length == 0) goto lblSubFolders;

        Save_Log(String.Format("Total {0} files found!", sFiles.Length));

        for (i = 0; i < sFiles.Length; i++)
        {
            if (sFiles[i].Substring(sFiles[i].Length - 4).ToUpper() == ".PDF")
            {
                File_Name = get_file_name(sFiles[i]);

                MTC_Code = File_Name.ToUpper().Replace(".PDF", "");
                TC_ID = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND TC_CODE='" + MTC_Code + "'");

                Save_Log("Uploading " + MTC_Code);

                if (TC_ID.Length > 0)
                {
                    string FileName = sFiles[i];
                    byte[] byteArray = null;
                    using (FileStream fs = new FileStream
                        (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
                    {

                        byteArray = new byte[fs.Length];
                        int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
                    }

                    string sql = "UPDATE PIP_TEST_CARDS SET MTC_BLOB=:MTC_BLOB WHERE TC_ID=:TC_ID";


                    using (OracleConnection conn = WebTools.GetIpmsConnection())
                    {
                        using (OracleCommand cmd = new OracleCommand(sql, conn))
                        {
                            cmd.Parameters.Add("MTC_BLOB", OracleType.Blob);
                            cmd.Parameters[0].Value = byteArray;

                            cmd.Parameters.Add("TC_ID", OracleType.Number);
                            cmd.Parameters[1].Value = TC_ID;

                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

    lblSubFolders:
        if (sSubFolders.Length == 0) return;

        for (i = 0; i < sSubFolders.Length; i++)
        {
            CopyMTC(sSubFolders[i]);
        }
    }

    protected void Log_RadListBox_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}