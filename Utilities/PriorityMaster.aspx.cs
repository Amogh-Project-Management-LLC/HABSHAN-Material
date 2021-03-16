using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_PriorityMaster : System.Web.UI.Page
{
    protected static string uploadedFileName = "", selected_priority = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("SET PROJECT PRIORITY");
        }
    }

    protected void RadListBoxSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("PRIORITY_IMPORT"))
        //{
        //    btnImport.Visible = false;
        //    return;
        //}


        if (RadListBoxSource.SelectedItem != null)
        {
            selected_priority = RadListBoxSource.SelectedItem.Value.ToString();
            lblSampleExcel.Text = "<a href='../Import_Format/Priority_" + selected_priority + ".xlsx'>Sample "
                + selected_priority + " Priority File</a>";
            uploadOptions.Visible = true;
        }

        else
            Master.show_info("Please select an item !!!");
           
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (RadListBoxSource.SelectedItem != null)
        {
            string export_option = RadListBoxSource.SelectedItem.Value.ToString();

            switch (export_option)
            {
                case "SPOOL":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_SPOOL";
                    break;
                case "MAIN_MAT":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_MAIN_MAT";
                    break;
                case "AREA":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_AREA";
                    break;
                case "SERVICE":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_SERVICE";
                    break;
                case "LINE":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_LINE";
                    break;
                case "ISOMETRIC":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_ISOMETRIC";
                    break;
                case "SPLIT_WBS":
                    dsExport.SelectCommand = "SELECT *  FROM  PROJECT_PRIORITY_SPLIT_WBS";
                    break;
            }
            dsExport.DataBind();
            WebTools.ExportDataSetToExcel(dsExport, "Priority_" + export_option + ".xls");
        }
        else
            lblMessage.Text = "<font color='red'>Please select an item !!!</font>";
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (!uploadPriorityExcel.HasFile) return;
        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(uploadPriorityExcel.PostedFile.FileName);
        string Extension = Path.GetExtension(uploadPriorityExcel.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        uploadPriorityExcel.SaveAs(FilePath);

        string table_name = "";
        string query = "", message="";
        string uploadOption = rdoUploadOption.SelectedValue;
        DataTable dt;
        FileStream stream;
        try
        {
            switch (selected_priority)
            {
                case "SPOOL":
                    table_name = "PROJECT_PRIORITY_SPOOL";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE ISO_TITLE1='" + dr[0].ToString().ToUpper().Trim()
                            + "' AND SPOOL='" + dr[1].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);

                        string iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                        string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL", "ISO_ID='" + iso_id + "' AND SPOOL='" + dr[1].ToString() + "'");

                        if (!string.IsNullOrEmpty(spl_id))
                        {
                            query = "INSERT INTO " + table_name + " (ISO_TITLE1, SPOOL, PRIORITY,SPL_ID) "
                                + " VALUES('" + dr[0].ToString() + "','" + dr[1].ToString() + "','" + dr[2].ToString() + "','" + spl_id + "')";
                            message = WebTools.ExeSql(query);
                        }
                    }
                    break;

                case "MAIN_MAT":
                    table_name = "PROJECT_PRIORITY_MAIN_MAT";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE MAIN_MAT='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "INSERT INTO " + table_name + " (MAIN_MAT, PRIORITY) VALUES ('" + dr[0].ToString() + "', '" + dr[1].ToString() + "')";                        
                        message = WebTools.ExeSql(query);
                    }

                    break;
                case "AREA":
                    table_name = "PROJECT_PRIORITY_AREA";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE AREA='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {                       
                        query = "INSERT INTO " + table_name + " (AREA, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "SERVICE":
                    table_name = "PROJECT_PRIORITY_SERVICE";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE SERVICE='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {                       
                        query = "INSERT INTO " + table_name + " (SERVICE, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";                        
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "LINE":
                    table_name = "PROJECT_PRIORITY_LINE";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE LINE_NO='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {                      
                        query = "INSERT INTO " + table_name + " (LINE_NO, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "ISOMETRIC":
                    table_name = "PROJECT_PRIORITY_ISOMETRIC";

                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);
                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE ISO_TITLE1='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {                     
                        query = "INSERT INTO " + table_name + " (ISO_TITLE1, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "SPLIT_WBS":
                    table_name = "PROJECT_PRIORITY_SPLIT_WBS";
                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE  WBS_NO='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }
                    foreach (DataRow dr in dt.Rows)
                    {                     
                        query = "INSERT INTO " + table_name + " (WBS_NO, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
            }

            Master.show_success("Data Imported Sucessfully!!!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }       
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            for (var i = 0; i < RadListBoxSource.Items.Count(); i++)
            {
                WebTools.ExeSql("UPDATE project_priority_options SET field_order='" + (i +1) + "' WHERE priority_field='" + RadListBoxSource.Items[i].Value + "'");
            }
            Master.show_success("Priority order saved !!!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}