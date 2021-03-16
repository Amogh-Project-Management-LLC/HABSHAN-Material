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
using System.IO;
using System.Web.Hosting;
using System.Linq;
using System.Data.OracleClient;
using System.Globalization;
using System.Data.OleDb;

public partial class ImportFieldWelding : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Field Welding";

            if (!WebTools.UserInRole("ADMIN"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            FileUpload1.SaveAs(FilePath);

            // delete old data
            WebTools.ExecNonQuery("DELETE FROM FIELD_WELDING_IMPORT WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());

            //Import_Excel_File(FilePath, Extension, "Yes");
            ExcelImport.Import_Excel_File(FilePath, Extension, "FIELD_WELDING_IMPORT", "PK_FIELD_WELDING_IMPORT",
                "PROJECT_ID", Session["PROJECT_ID"].ToString());

            // update proj_id
            WebTools.ExecNonQuery("UPDATE FIELD_WELDING_IMPORT SET PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " WHERE PROJECT_ID IS NULL");

            Save_Welding();
        }

    }

    private void Save_Welding()
    {
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            // update weld_date, wps_no
            using (OracleCommand cmd =
                new OracleCommand("SELECT DISTINCT JOINT_ID, WELDED_DATE, WPS_NO, WELD_DATE_UPD, WPS_NO_UPD FROM VIEW_FIELD_WELDING_IMP_A " +
                "WHERE JOINT_ID IS NOT NULL AND CAT_ID IN (2, 4) AND (WELD_DATE_UPD='Y' OR WPS_NO_UPD='Y')", conn))
            {
                using (OracleDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        OracleCommand cmd2 = new OracleCommand();
                        cmd2.Connection = conn;
                        cmd2.CommandText = "UPDATE PIP_SPOOL_JOINTS SET ";

                        bool have_col = false;
                        if (dr["WELD_DATE_UPD"].ToString() == "Y")
                        {
                            have_col = true;
                            cmd2.CommandText += "WELD_DATE='" + DateTime.Parse(dr["WELDED_DATE"].ToString()).ToString("dd-MMM-yyyy") + "'";
                        }

                        if (dr["WPS_NO_UPD"].ToString() == "Y")
                        {
                            if (have_col)
                                cmd2.CommandText += ",";

                            have_col = true;
                            cmd2.CommandText += "WPS_NO='" + dr["WPS_NO"].ToString() + "'";
                        }

                        if (have_col)
                        {
                            cmd2.CommandText += " WHERE JOINT_ID=" + dr["JOINT_ID"].ToString();
                            cmd2.ExecuteNonQuery();
                        }

                        cmd2.Dispose();

                    } // while
                } // dr
            } // cmd

            // add new welders
            using (OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_FIELD_WLD_WELDERS WHERE WELDER_ID IS NULL", conn))
            {
                using (OracleDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        OracleCommand cmd2 = new OracleCommand();
                        cmd2.Connection = conn;
                        cmd2.CommandText = "INSERT INTO PIP_WELDERS(WELDER_NO, W_NAME, SC_ID, EMP_DATE, PROJECT_ID) " +
                            "VALUES (:WELDER_NO, :W_NAME, :SC_ID, :EMP_DATE, :PROJECT_ID)";

                        cmd2.Parameters.Add("WELDER_NO", OracleType.VarChar);
                        cmd2.Parameters["WELDER_NO"].Value = dr["WELDER_NO"].ToString();

                        cmd2.Parameters.Add("W_NAME", OracleType.VarChar);
                        cmd2.Parameters["W_NAME"].Value = dr["WELDER_NO"].ToString();

                        cmd2.Parameters.Add("SC_ID", OracleType.Number);
                        cmd2.Parameters["SC_ID"].Value = dr["SUB_CON_ID"].ToString();

                        cmd2.Parameters.Add("EMP_DATE", OracleType.DateTime);
                        cmd2.Parameters["EMP_DATE"].Value = DateTime.Now.ToString("dd-MMM-yyyy");

                        cmd2.Parameters.Add("PROJECT_ID", OracleType.Number);
                        cmd2.Parameters["PROJECT_ID"].Value = Session["PROJECT_ID"].ToString();

                        cmd2.ExecuteNonQuery();

                    } // while
                } // dr

            } // new welders added

            // add weling details
            using (OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_FIELD_WLD_DETAIL", conn))
            {
                using (OracleDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        OracleCommand cmd2 = new OracleCommand();
                        cmd2.Connection = conn;
                        cmd2.CommandText = "INSERT INTO PIP_SPOOL_WELDING(JOINT_ID, REWORK_CODE, WELD_DATE, WELDER_ID, PASS_ID, WELD_PROCESS) " +
                            "VALUES (:JOINT_ID, :REWORK_CODE, :WELD_DATE, :WELDER_ID, :PASS_ID, :WELD_PROCESS)";

                        cmd2.Parameters.Add("JOINT_ID", OracleType.Number);
                        cmd2.Parameters["JOINT_ID"].Value = dr["JOINT_ID"].ToString();

                        cmd2.Parameters.Add("REWORK_CODE", OracleType.VarChar);
                        cmd2.Parameters["REWORK_CODE"].Value = dr["REWORK_CODE"].ToString();

                        cmd2.Parameters.Add("WELD_DATE", OracleType.DateTime);
                        cmd2.Parameters["WELD_DATE"].Value = DateTime.Parse(dr["WELDED_DATE"].ToString()).ToString("dd-MMM-yyyy");

                        cmd2.Parameters.Add("WELDER_ID", OracleType.Number);
                        cmd2.Parameters["WELDER_ID"].Value = dr["WELDER_ID"].ToString();

                        string work_on = dr["WORK_ON"].ToString();
                        string pass_id = "1";

                        if (work_on == "R" || work_on == "RF")
                            pass_id = "1";
                        else
                            pass_id = "4"; // F

                        cmd2.Parameters.Add("PASS_ID", OracleType.Number);
                        cmd2.Parameters["PASS_ID"].Value = pass_id;

                        cmd2.Parameters.Add("WELD_PROCESS", OracleType.VarChar);
                        cmd2.Parameters["WELD_PROCESS"].Value = dr["WELD_PROCESS"].ToString();

                        cmd2.ExecuteNonQuery(); // welding details

                        // RF Case 
                        if (work_on == "RF")
                        {
                            cmd2.Parameters["PASS_ID"].Value = 4;
                            cmd2.ExecuteNonQuery();
                        }

                    } // while
                } // dr

            } // welder details added
            
        }

        Master.ShowSuccess("Field Welding data imported!");
    }

    //private void Import_Excel_File(string FilePath, string Extension, string isHDR)
    //{
    //    string conStr = "";
    //    switch (Extension)
    //    {
    //        case ".xls": //Excel 97-03
    //            conStr = ConnStrHelper.Excel03ConString();
    //            break;
    //        case ".xlsx": //Excel 07
    //            conStr = ConnStrHelper.Excel07ConString();
    //            break;
    //        default:
    //            return; // not supported
    //    }

    //    conStr = String.Format(conStr, FilePath, isHDR);
    //    OleDbConnection connExcel = new OleDbConnection(conStr);
    //    OleDbCommand cmdExcel = new OleDbCommand();
    //    OleDbDataAdapter oda = new OleDbDataAdapter();
    //    DataTable dt = new DataTable();
    //    cmdExcel.Connection = connExcel;

    //    //Get the name of First Sheet
    //    connExcel.Open();
    //    DataTable dtExcelSchema;
    //    dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
    //    string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
    //    connExcel.Close();

    //    //Read Data from First Sheet
    //    connExcel.Open();
    //    cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
    //    oda.SelectCommand = cmdExcel;
    //    oda.Fill(dt);
    //    connExcel.Close();

    //    bool first_col = true;
    //    string sql = "INSERT INTO FIELD_WELDING_IMPORT (";

    //    foreach (DataColumn col in dt.Columns)
    //    {
    //        if (!first_col)
    //            sql += ",";
    //        else
    //            first_col = false;

    //        sql += col.ColumnName;
    //    }

    //    sql += ") VALUES (";
    //    first_col = true;
    //    foreach (DataColumn col in dt.Columns)
    //    {
    //        if (!first_col)
    //            sql += ",";
    //        else
    //            first_col = false;

    //        sql += ":" + col.ColumnName;
    //    }

    //    sql += ")";

    //    OracleConnection conn = WebTools.GetIpmsConnection(); // will open connection too
    //    OracleCommand cmd = new OracleCommand(sql, conn);

    //    foreach (DataRow row in dt.Rows)
    //    {
    //        cmd.Parameters.Clear();
    //        foreach (DataColumn col in dt.Columns)
    //        {
    //            string col_val = row[col].ToString();
    //            if (col.ColumnName.Contains("DATE") && !string.IsNullOrEmpty(col_val))
    //            {
    //                DateTime value;
    //                if (DateTime.TryParse(col_val, out value))
    //                {
    //                    col_val = value.ToString("dd-MMM-yyyy");
    //                    //DateTime.ParseExact(row[col].ToString(), "d", CultureInfo.InvariantCulture).ToString("dd-MMM-yyyy");
    //                }
    //                else
    //                    col_val = "";
    //            }
                

    //            OracleParameter parm = new OracleParameter(col.ColumnName, col_val);
    //            cmd.Parameters.Add(parm);
    //        }
    //        cmd.ExecuteNonQuery();
    //    }

    //    cmd.Dispose();
    //    conn.Close();
    //    conn.Dispose();

    //    //Bind Data to GridView
    //    //GridView1.Caption = Path.GetFileName(FilePath);
    //    //jointsGridView.DataSource = dt;
    //    //jointsGridView.DataBind();
    //}

    private string BarcodeDateToString(string bc_date)
    {
        var newDate = DateTime.ParseExact(bc_date, "yyyyMMdd", CultureInfo.InvariantCulture);
        return newDate.ToString("dd-MMM-yyyy");
    }

    protected void btnExptErrExcel_Click(object sender, EventArgs e)
    {
        string query = JointsDataSource.SelectCommand.Replace("\r\n", " ").Replace("\t", " ");
        db_export.ExportToCSV(query, "Joints");
    }

}