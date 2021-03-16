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

public partial class ImportBarCode : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Barcode";
            //lblUsers.Text = Application["userCount"].ToString();

            if (!WebTools.UserInRole("BAR_CODE_IMPORT"))
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
        if (RadioButtonList1.SelectedValue == "1")
        {
            ImportFitup();
        }
        else // 2
        {
            ImportWelding();
        }

        jointsGridView.DataBind();
    }

    private void ImportWelding()
    {
        // DATA_TYPE = 1 Welding

        int pass_id = 0;
        string welding_path = "";
        string weld_proc_bc = "";
        string weld_proc_name = "";
        string sLine = "";
        string sql = "INSERT INTO BARCODE_WELDING_IMPORT(" +
                        "PROJECT_ID, CSV_TEXT, JOINT_NO, DWG_NO, DATA_TYPE, WELDING_PATH, WELD_PROCESS, WELDER_ID, WELD_DATE, WPS_NO, PASS_ID, WELD_PROCESS_NAME)" +
                        "VALUES " +
                        "(:PROJECT_ID, :CSV_TEXT, :JOINT_NO, :DWG_NO, :DATA_TYPE, :WELDING_PATH, :WELD_PROCESS, :WELDER_ID, :WELD_DATE, :WPS_NO, :PASS_ID, :WELD_PROCESS_NAME)";

        string file_name = WebTools.SessionDataPath() + "Barcode-Welding.txt";
        if (File.Exists(file_name))
            File.Delete(file_name);

        FileUpload1.SaveAs(file_name);

        using (StreamReader sr = new StreamReader(file_name))
        {
            using (OracleConnection conn = WebTools.GetIpmsConnection())
            {
                // delete previous data
                using (OracleCommand cmd = new OracleCommand("DELETE BARCODE_WELDING_IMPORT", conn))
                {
                    cmd.ExecuteNonQuery();
                }

                // insert lines
                while ((sLine = sr.ReadLine()) != null)
                {
                    string[] values = sLine.Split(new char[] { ',' });
                    welding_path = values[5].Trim();

                    if (welding_path == "1" || welding_path == "3")
                        pass_id = 1;
                    else if (welding_path == "2")
                        pass_id = 4;
                    else
                        pass_id = 0;

                    // weld process
                    weld_proc_bc = values[4].Trim();

                    switch (weld_proc_bc)
                    {
                        case "1":
                            weld_proc_name = "TIG";
                            break;
                        case "2":
                            weld_proc_name = "ARC";
                            break;
                        case "3":
                            weld_proc_name = "FCAW";
                            break;
                        case "4":
                            weld_proc_name = "SAW";
                            break;
                    }

                    using (OracleCommand cmd = new OracleCommand(sql, conn))
                    {
                        cmd.Parameters.Add("PROJECT_ID", OracleType.Number);
                        cmd.Parameters["PROJECT_ID"].Value = Session["PROJECT_ID"].ToString();

                        cmd.Parameters.Add("CSV_TEXT", OracleType.VarChar);
                        cmd.Parameters["CSV_TEXT"].Value = sLine.Trim();

                        cmd.Parameters.Add("JOINT_NO", OracleType.VarChar);
                        cmd.Parameters["JOINT_NO"].Value = values[8].Trim();

                        cmd.Parameters.Add("DWG_NO", OracleType.VarChar);
                        cmd.Parameters["DWG_NO"].Value = values[7].Trim();

                        cmd.Parameters.Add("DATA_TYPE", OracleType.Number);
                        cmd.Parameters["DATA_TYPE"].Value = "1"; // welding = 1

                        cmd.Parameters.Add("WELDING_PATH", OracleType.Number);
                        cmd.Parameters["WELDING_PATH"].Value = welding_path == "3" ? "1" : welding_path;

                        cmd.Parameters.Add("WELD_PROCESS", OracleType.Number);
                        cmd.Parameters["WELD_PROCESS"].Value = weld_proc_bc;

                        cmd.Parameters.Add("WELDER_ID", OracleType.Number);
                        cmd.Parameters["WELDER_ID"].Value = values[3].Trim();

                        cmd.Parameters.Add("WELD_DATE", OracleType.DateTime);
                        cmd.Parameters["WELD_DATE"].Value = BarcodeDateToString(values[0].Trim());

                        cmd.Parameters.Add("WPS_NO", OracleType.VarChar);
                        cmd.Parameters["WPS_NO"].Value = values[6].Trim();

                        cmd.Parameters.Add("PASS_ID", OracleType.Number);
                        cmd.Parameters["PASS_ID"].Value = pass_id;

                        cmd.Parameters.Add("WELD_PROCESS_NAME", OracleType.VarChar);
                        cmd.Parameters["WELD_PROCESS_NAME"].Value = weld_proc_name;

                        cmd.ExecuteNonQuery();

                        // if welding path was = 3
                        if (welding_path == "3")
                        {
                            string new_csv_line = "";
                            for (int i = 0; i < values.Length; i++)
                            {
                                if (new_csv_line.Length > 0)
                                    new_csv_line += ",";

                                if (i == 5)
                                    new_csv_line += "2";
                                else
                                    new_csv_line += values[i];
                            }

                            // CSV_TEXT
                            cmd.Parameters[1].Value = new_csv_line;

                            // WELDING_PATH
                            cmd.Parameters[5].Value = "2";

                            // PASS_ID
                            cmd.Parameters[10].Value = "4";

                            cmd.ExecuteNonQuery();
                        }

                    }
                }

                // update weld_date, wps_no
                using (OracleCommand cmd =
                    new OracleCommand("SELECT DISTINCT JOINT_ID, WELD_DATE_NEW, WPS_NO_NEW, WELD_DATE_UPD, WPS_NO_UPD FROM VIEW_BARCODE_WELDING_IMPORT_B " +
                    "WHERE SUB_CON_ID IS NOT NULL AND CAT_ID IN (1, 3) AND (WELD_DATE_UPD='Y' OR WPS_NO_UPD='Y')", conn))
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
                                cmd2.CommandText += "WELD_DATE='" + DateTime.Parse(dr["WELD_DATE_NEW"].ToString()).ToString("dd-MMM-yyyy") + "'";
                            }

                            if (dr["WPS_NO_UPD"].ToString() == "Y")
                            {
                                if (have_col)
                                    cmd2.CommandText += ",";

                                have_col = true;
                                cmd2.CommandText += "WPS_NO='" + dr["WPS_NO_NEW"].ToString() + "'";
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
                using (OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_BARCODE_WELDING_WELDERS WHERE WELDER_ID IS NULL", conn))
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
                using (OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_BARCODE_WELDING_IMPORT_D", conn))
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
                            cmd2.Parameters["REWORK_CODE"].Value = "-";

                            cmd2.Parameters.Add("WELD_DATE", OracleType.DateTime);
                            cmd2.Parameters["WELD_DATE"].Value = DateTime.Parse(dr["WELD_DATE_NEW"].ToString()).ToString("dd-MMM-yyyy");

                            cmd2.Parameters.Add("WELDER_ID", OracleType.Number);
                            cmd2.Parameters["WELDER_ID"].Value = dr["WELDER_ID"].ToString();

                            cmd2.Parameters.Add("PASS_ID", OracleType.Number);
                            cmd2.Parameters["PASS_ID"].Value = dr["PASS_ID"].ToString();

                            cmd2.Parameters.Add("WELD_PROCESS", OracleType.VarChar);
                            cmd2.Parameters["WELD_PROCESS"].Value = dr["WELD_PROCESS_NAME"].ToString();

                            cmd2.ExecuteNonQuery(); // welding details

                        } // while
                    } // dr

                } // welder details added
            }
        }

        Master.ShowSuccess("Barcode Welding data imported!");
    }

    private void ImportFitup()
    {
        // DATA_TYPE = 2 Fitup

        string sLine = "";
        string sql = "INSERT INTO BARCODE_WELDING_IMPORT (PROJECT_ID, JOINT_NO, DWG_NO, INSPECTOR_ID, FITUP_DATE, CSV_TEXT, DATA_TYPE)" +
                "VALUES (:PROJECT_ID, :JOINT_NO, :DWG_NO, :INSPECTOR_ID, :FITUP_DATE, :CSV_TEXT, 2)";
        string file_name = WebTools.SessionDataPath() + "Barcode.txt";
        
            if (File.Exists(file_name))
                File.Delete(file_name);

            FileUpload1.SaveAs(file_name);

        using (StreamReader sr = new StreamReader(file_name))
        {
            using (OracleConnection conn = WebTools.GetIpmsConnection())
            {
                // delete previous data
                using (OracleCommand cmd = new OracleCommand("DELETE BARCODE_WELDING_IMPORT", conn))
                {
                    cmd.ExecuteNonQuery();
                }

                // insert lines
                while ((sLine = sr.ReadLine()) != null)
                {
                    string[] values = sLine.Split(new char[] { ',' });

                    using (OracleCommand cmd = new OracleCommand(sql, conn))
                    {
                        cmd.Parameters.Add("PROJECT_ID", OracleType.Number);
                        cmd.Parameters[0].Value = Session["PROJECT_ID"].ToString();

                        cmd.Parameters.Add("JOINT_NO", OracleType.VarChar);
                        cmd.Parameters[1].Value = values[5].Trim();

                        cmd.Parameters.Add("DWG_NO", OracleType.VarChar);
                        cmd.Parameters[2].Value = values[4].Trim();

                        cmd.Parameters.Add("INSPECTOR_ID", OracleType.VarChar);
                        cmd.Parameters[3].Value = values[3].Trim();

                        cmd.Parameters.Add("FITUP_DATE", OracleType.DateTime);
                        cmd.Parameters[4].Value = BarcodeDateToString(values[0].Trim());

                        cmd.Parameters.Add("CSV_TEXT", OracleType.VarChar);
                        cmd.Parameters[5].Value = sLine.Trim();

                        cmd.ExecuteNonQuery();
                    }
                }

                // update fitup_date
                using (OracleCommand cmd = new OracleCommand("SELECT * FROM VIEW_BARCODE_FITUP_IMP WHERE FITUP_DATE_UPD='Y' OR FITUP_INSP_UPD='Y'", conn))
                {
                    using (OracleDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            OracleCommand cmd2 = new OracleCommand();
                            cmd2.Connection = conn;
                            cmd2.CommandText = "UPDATE PIP_SPOOL_JOINTS SET ";

                            bool have_col = false;
                            if (dr["FITUP_DATE_UPD"].ToString() == "Y")
                            {
                                have_col = true;
                                cmd2.CommandText += "FITUP_DATE='" + DateTime.Parse(dr["FITUP_DATE_NEW"].ToString()).ToString("dd-MMM-yyyy") + "'";
                            }

                            if (dr["FITUP_INSP_UPD"].ToString() == "Y")
                            {
                                if (have_col)
                                    cmd2.CommandText += ",";

                                have_col = true;
                                cmd2.CommandText += "FITUP_INSP='" + dr["FITUP_INSP_NEW"].ToString() + "'";
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

            } // conn
        } // sr
        
        Master.ShowSuccess("Barcode fitup data imported!");
    }

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