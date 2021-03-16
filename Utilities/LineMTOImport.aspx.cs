using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Utilities_LineMTOImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Line MTO Bulk Import");
        }
    }



    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (!FileUpload1.HasFile) return;

            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            FileUpload1.SaveAs(FilePath);

            // delete old data
            WebTools.ExecNonQuery("DELETE FROM PIP_LINE_MTO WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);
           
            ExcelImport.ImportDataTable(dt, "PIP_LINE_MTO", "", "PROJECT_ID", proj_id);

            WebTools.ExecNonQuery("BEGIN " +
                                            "PKG_PAGE_VALIDATION.UPDATE_LINE_MTO('" + Session["PROJECT_ID"].ToString() + "'); " +
                                            " END;");

            Master.show_success("LINE MTO Data Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}