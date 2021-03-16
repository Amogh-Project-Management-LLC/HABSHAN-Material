using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MTCCommon_FileImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import MTC Files");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            int filecount = RadAsyncUpload2.UploadedFiles.Count;
            if (RadAsyncUpload2.UploadedFiles.Count>0)
            {              
                for (int i=0;i<filecount;i++)
                {                
                    string f_name = Path.GetFileName(RadAsyncUpload2.UploadedFiles[i].GetNameWithoutExtension());
                    f_name = f_name.Replace("/", "-");
                    string Extension = Path.GetExtension(RadAsyncUpload2.UploadedFiles[i].GetExtension());
                    string FileName = f_name+Extension;                                 
                    string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_OBJ='MTC'");
                    string FilePath = FolderPath + FileName;       
                    RadAsyncUpload2.UploadedFiles[i].SaveAs(FilePath);                   
                }
                Master.show_success("Files Uploaded");
            }         
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

   
       
    
}