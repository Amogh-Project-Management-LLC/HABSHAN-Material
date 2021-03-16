using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Upload;

public partial class Utilities_CollectPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Collect PDF Files");
            //Do not display SelectedFilesCount progress indicator.
            RadProgressArea1.ProgressIndicators &= ~ProgressIndicators.SelectedFilesCount;
        }

        RadProgressArea1.Localization.Uploaded = "Total Progress";
        RadProgressArea1.Localization.UploadedFiles = "Progress";
        RadProgressArea1.Localization.CurrentFileName = "File Collection in action: ";
    }

    protected void btnSpoolgenPDF_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("ISO_SPOOLGEN");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void StartCollectingFiles(string FileType)
    {
        string source = WebTools.GetExpr("source", "dir_objects", " dir_obj='" + FileType + "'");
        string destination = WebTools.GetExpr("path", "dir_objects", " dir_obj='" + FileType + "'");

        int FileCount = Directory.GetFiles(source).Count();
        if (FileCount == 0)
        {
            Master.show_info("0 files found at source location.");
            return;
        }
        else
        {
            //UpdateProgressContext(FileCount);
            collect_pdfs(source, destination, FileType);
            Master.show_info(string.Format("{0} files collected from source location.", FileCount.ToString()));
        }
    }
    
    
    protected string collect_pdfs(string source_directory, string target_directory, string specific_file)
    {
        string message = null;

        int Total = Directory.GetFiles(source_directory).Count();

        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        int i = 1;
        //non replacement drawings
        try
        {
            foreach (string f in Directory.GetFiles(source_directory))
            {
                progress.PrimaryTotal = 1;
                progress.PrimaryValue = 1;
                progress.PrimaryPercent = 100;

                progress.SecondaryTotal = Total;
                progress.SecondaryValue = i;
                progress.SecondaryPercent = Math.Round((double)(i * 100/ Total), 0);

                progress.CurrentOperationText = "Step " + i.ToString();

                if (!Response.IsClientConnected)
                {
                    //Cancel button was clicked or the browser was closed, so stop processing
                    break;
                }

                progress.TimeEstimated = (Total - i) * 100;
                //Stall the current thread for 0.1 seconds
                System.Threading.Thread.Sleep(100);

                string file_name = f.Replace(source_directory, "").Replace("\\", "").ToUpper();

                //CHECK  if pdf name does not contain SPL then its ISO pdf also ignore PDFs with transmittal name
                if (specific_file.Equals("ISO_SPOOLGEN"))
                {
                    if (file_name.Contains(".PDF") && !file_name.Contains("_SPL-") &&
                        WebTools.CountExpr("SERIAL_NO", "PIP_DWG_TRANS", "SERIAL_NO='" + file_name.Replace(".PDF", "") + "'").Equals("0"))
                        if (!File.Exists(target_directory + file_name))
                            File.Copy(f, target_directory + file_name, true);

                }
                else if (specific_file.Equals("SPL_SPOOLGEN"))
                {
                    if (file_name.Contains(".PDF") && file_name.Contains("_SPL-"))
                        if (!File.Exists(target_directory + file_name))
                            File.Copy(f, target_directory + file_name, true);

                }

                else if (specific_file.Equals("ISO_HARDCOPY"))
                {
                    if (file_name.EndsWith(".PDF") &&
                        !WebTools.CountExpr("ISO_TITLE1", "PIP_ISOMETRIC", "'" + file_name.Replace(".PDF", "") + "' LIKE ISO_TITLE1||'%'").Equals("0"))
                        if (!File.Exists(target_directory + file_name))
                            File.Copy(f, target_directory + file_name, true);
                }


                else if (specific_file.Equals("MTC_PDF"))
                {
                    if (file_name.EndsWith(".PDF") &&
                        !WebTools.CountExpr("TC_CODE", "TEST_CERTIFICATE", "'" + file_name.Replace(".PDF", "") + "' LIKE TC_CODE||'%'").Equals("0"))
                        if (!File.Exists(target_directory + file_name))
                            File.Copy(f, target_directory + file_name, true);
                }
                i++;

            }

            //foreach (string subDir in Directory.GetDirectories(@source_directory))
            //{
            //    collect_pdfs(subDir, target_directory, specific_file);
            //}            
            Master.show_success("PDFs collected successfully ! Please proceed for flag update!");
        }
        catch (Exception ex)
        {
            message = "<font color='red'>" + ex.Message + "</font>";
        }
        return message;
    }

    protected void btnHardcopy_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("ISO_HARDCOPY");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnSplPDF_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("SPL_SPOOLGEN");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("MTC_PDF");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}