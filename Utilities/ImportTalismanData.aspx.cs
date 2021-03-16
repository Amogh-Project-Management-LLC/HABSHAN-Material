using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_ImportTalismanData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Talisman Data";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmoghUpdates.aspx");
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        bool flag;

        flag = fileUploadDefects.HasFile;
        flag = fileUploadIsoMTO.HasFile;
        flag = fileUploadSpoolStatus.HasFile;
        flag = fileUploadTestPack.HasFile;
        flag = fileUploadWeldMTO.HasFile;

        if (!flag)
        {
            Master.ShowError("One or more file is missing to upload. Please check again and upload.");
            return;
        }

        string working_file = string.Empty;
        try
        {
            //Isometric MTO
            working_file = fileUploadIsoMTO.FileName;
            UploadFile(fileUploadIsoMTO, "TALISMAN_ISO_MTO_IMPORT");
            //Spool Status
            working_file = fileUploadSpoolStatus.FileName;
            UploadFile(fileUploadSpoolStatus, "TALISMAN_SPOOL_STATUS");
            //Welding MTO
            working_file = fileUploadWeldMTO.FileName;
            UploadFile(fileUploadSpoolStatus, "TALISMAN_WELD_MTO");
            //Defects
            working_file = fileUploadDefects.FileName;
            UploadFile(fileUploadSpoolStatus, "TALISMAN_DEFECTS_IMPORT");
            //Testpack Information
            working_file = fileUploadTestPack.FileName;
            UploadFile(fileUploadSpoolStatus, "TALISMAN_TESTPACK_IMPORT");

            Master.ShowSuccess("All Files Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowError("Error in " + working_file + "<br/>" + ex.Message);
        }
    }

    protected void UploadFile(FileUpload f, string DestinationTable)
    {
        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(f.PostedFile.FileName);
        string Extension = Path.GetExtension(f.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        f.SaveAs(FilePath);

        // delete old data
        WebTools.ExecNonQuery("DELETE FROM "+ DestinationTable + " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

        FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

        DataTable dt = new DataTable();
        dt = ExcelImport.xlsxToDT2(stream);

        dt.Columns.Add("IMPORT_BY");

        foreach (DataRow r in dt.Rows)
        {
            r["IMPORT_BY"] = Session["USER_NAME"].ToString();
        }
            

        ExcelImport.ImportDataTable(dt, DestinationTable, "", "PROJECT_ID", proj_id);       
    }
}