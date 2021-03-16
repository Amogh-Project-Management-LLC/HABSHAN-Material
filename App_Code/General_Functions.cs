using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OracleClient;
using dsWeldingATableAdapters;
using Ionic.Zip;
using System.IO;

/// <summary>
/// Summary description for General_Functions
/// </summary>
public class General_Functions
{
    public static string exec_non_qry(string statement)
    {
        Object result;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(statement, connection);
        command.CommandType = CommandType.Text;
        result = command.ExecuteNonQuery();
        connection.Close();
        return result.ToString();
    }
    public static void Update_Spool_Transmittal()
    {
        string sql1 = "declare outMSG VARCHAR2(200); Begin outMSG := FNC_SPL_TRANS(1); END;";

        //string sql2 = "UPDATE PIP_SPOOL SET RECVD_SITE=NULL WHERE RECVD_SITE IS NOT NULL " +
        //    "AND ISO_ID IN (SELECT ISO_ID FROM PIP_ISOMETRIC WHERE PROJ_ID=1) " +
        //    "AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE CAT_ID=3)";

        //string sql3 = "UPDATE PIP_SPOOL SET SENT_TO_SITE=NULL WHERE SENT_TO_SITE IS NOT NULL" + 
        //    " AND ISO_ID IN (SELECT ISO_ID FROM PIP_ISOMETRIC WHERE PROJ_ID=1)" + 
        //    " AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE CAT_ID=4)";

        //string sql4 = "UPDATE PIP_SPOOL SET RECVD_SITE=NULL WHERE SPL_ID IN " +
        //    "(SELECT SPL_ID FROM VIEW_RESEND_A)";

        exec_non_qry(sql1);
        //exec_non_qry(sql2);
        //exec_non_qry(sql3);
        //exec_non_qry(sql4);
    }
    public static string short_date(DateTime date)
    {
        string day, month_num, month_str, year;
        day = date.Day.ToString();
        month_num = date.Month.ToString();
        month_str = "xxx";
        year = date.Year.ToString();
        switch (month_num)
        {
            case "1": month_str = "JAN"; break;
            case "2": month_str = "FEB"; break;
            case "3": month_str = "MAR"; break;
            case "4": month_str = "APR"; break;
            case "5": month_str = "MAY"; break;
            case "6": month_str = "JUN"; break;
            case "7": month_str = "JUL"; break;
            case "8": month_str = "AUG"; break;
            case "9": month_str = "SEP"; break;
            case "10": month_str = "OCT"; break;
            case "11": month_str = "NOV"; break;
            case "12": month_str = "DEC"; break;
        }
        return String.Format("{0}-{1}-{2}", day, month_str, year);
    }

    public static string short_date(DateTime dateTime, string p, int p_3)
    {
        throw new Exception("The method or operation is not implemented.");
    }

    public static string get_prefix(string my_str)
    {
        return my_str.Substring(0, 2);
    }

    //Revision 0
    //lookup the next serial number within tables on entire conditions.
    public static string NextSerialNo(String TableName, String FieldName, String SerPrefix,
        Int32 IndexLen, String SqlCriteria)
    {
        string num_format = "";
        for (int i = 0; i < IndexLen; i++)
        {
            num_format += "0";
        }
        string sql = "SELECT TO_CHAR(NVL(MAX(IDX_),0)+1,'" + num_format + "') AS MAX_INDEX FROM (SELECT " +
            FieldName + ",TO_NUMBER(SUBSTR(" + FieldName + ",-" + IndexLen.ToString() + "," +
            IndexLen.ToString() + ")) AS IDX_ FROM " + TableName + SqlCriteria + ")";
        Object max_index;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        max_index = command.ExecuteScalar();
        connection.Close();
        return string.Format("{0}{1}", SerPrefix, max_index.ToString().Trim());
    }
    public static string ExeSql(String statement)
    {
        Object result;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(statement, connection);
        command.CommandType = CommandType.Text;
        result = command.ExecuteNonQuery();
        connection.Close();
        return result.ToString();
    }
    public static string cut_rep_joint(decimal joint_id, string jnt_rev_id)
    {
        PIP_JOINTSTableAdapter joints = new PIP_JOINTSTableAdapter();
        dsWeldingA.PIP_JOINTSDataTable joints_tbl = new dsWeldingA.PIP_JOINTSDataTable();
        joints_tbl = joints.GetData(joint_id);
        dsWeldingA.PIP_JOINTSRow old_row;
        dsWeldingA.PIP_JOINTSRow new_row = joints_tbl.NewPIP_JOINTSRow();
        try
        {
            old_row = joints_tbl[0];
            new_row.SetJOINT_IDNull();
            new_row.SPL_ID = old_row.SPL_ID;
            new_row.ISO_ID = old_row.ISO_ID;
            //new_row.JOINT_NO = old_row.JOINT_NO;
            new_row.JOINT_TYPE = old_row.JOINT_TYPE;
            new_row.JOINT_SIZE = old_row.JOINT_SIZE;
            new_row.CAT_ID = old_row.CAT_ID;
            if (!old_row.IsITEM_1Null()) new_row.ITEM_1 = old_row.ITEM_1;
            if (!old_row.IsITEM_2Null()) new_row.ITEM_2 = old_row.ITEM_2;
            if (!old_row.IsHEAT_NO1Null()) new_row.HEAT_NO1 = old_row.HEAT_NO1;
            if (!old_row.IsHEAT_NO2Null()) new_row.HEAT_NO2 = old_row.HEAT_NO2;
            if (!old_row.IsRTNull()) new_row.RT = old_row.RT;
            if (!old_row.IsPTNull()) new_row.PT = old_row.PT;
            if (!old_row.IsMTNull()) new_row.MT = old_row.MT;
            new_row.PWHT = old_row.PWHT;
            if (!old_row.IsPMINull()) new_row.PMI = old_row.PMI;
            if (!old_row.IsDIS_FLGNull()) new_row.DIS_FLG = old_row.DIS_FLG;
            if (!old_row.IsWPS_NONull()) new_row.WPS_NO = old_row.WPS_NO;

            string jnt_rev_code = WebTools.GetExpr("SYMBOL", "PIP_JOINT_REV", "JNT_REV_ID=" + jnt_rev_id);

            string joint_no = old_row.JOINT_NO + jnt_rev_code;
            new_row.JOINT_NO = joint_no;

            //string iso_id = old_row.ISO_ID.ToString();

            //string cr_index = General_Functions.NextSerialNo("PIP_SPOOL_JOINTS", "CR_INDEX", "", 1, " WHERE ISO_ID=" +
            //    iso_id + " AND JOINT_NO='" + joint_no + "' AND (CR_INDEX LIKE 'R%' OR CR_INDEX LIKE 'C%')");

            decimal max_joint_id = db_lookup.DMax("JOINT_ID", "PIP_SPOOL_JOINTS", "") + 2;
            

            //if (cr_index == "1") old_row.JNT_REV_ID = 3;
            //if (!old_row.IsFITUP_DATENull()) new_row.FITUP_DATE = old_row.FITUP_DATE;
            //if (!old_row.IsFITUP_REP_NONull()) new_row.FITUP_REP_NO = old_row.FITUP_REP_NO;
            //if (!old_row.IsFITUP_INSPNull()) new_row.FITUP_INSP = old_row.FITUP_INSP;
            new_row.JNT_REV_ID = decimal.Parse(jnt_rev_id);

            //new_row.JOINT_ID = max_joint_id;
            joints_tbl.AddPIP_JOINTSRow(new_row);
            joints.Update(joints_tbl);
            return "Joint revised successfully!";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
        finally
        {
            joints.Dispose();
            joints_tbl.Dispose();
        }
    }
    public void download_zip(int type_id,string ref_id,string downloadsuffix,string dir_obj,HttpResponse respone)
    {


        ZipFile zip_file = new ZipFile();
      
        // string irn_no = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + mir_id+ "'");
        string sql = "";
        string FileName = "";
        string folderPath = WebTools.GetExpr("path", "dir_objects", " DIR_OBJ='"+dir_obj+"'");
        string filePath = string.Empty;
        string path = WebTools.SessionDataPath();
        string zip_file_path = path + downloadsuffix + ".zip";
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            //Isometric
            sql = "SELECT * FROM VIEW_UPLOAD_FILES WHERE TYPE_ID="+type_id+" AND REF_ID='" + ref_id + "'";
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())

                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);

                        if (File.Exists(folderPath + dataReader["FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["FILE_NAME"], "files");
                        }

                    }
                }//OracleDataReader1
            }//OracleCommand1            
        }//OracleConnection
        zip_file.Save(zip_file_path);
        var updateFile = new FileInfo(zip_file_path);
        respone.ContentType = "application/octet-stream";
        respone.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        respone.AddHeader("content-length", updateFile.Length.ToString());
        respone.TransmitFile(updateFile.FullName);
        respone.Flush();
    }
    
    public static DataTable GetDataTable(string query)
    {
        //string connection = @"Data Source=DESKTOP-M5TQV9A;Initial Catalog=ALLTEST;Integrated Security=True";
        DataTable dt;
        OracleConnection con = conn_mngr.GetIpmsConnection();
        //con.Open();
        using (OracleCommand cmd = new OracleCommand(query, con))
        {
            cmd.CommandType = CommandType.Text;
            //cmd.Parameters.Add("@SearchName", SqlDbType.VarChar).Value = name;
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            con.Close();
            return dt;
        }
    }
    public static string UpdatePDFlag(string dirobj, string tablename, string searchcolumn, string updatecolumn)
    {
        try
        {
            string query = "SELECT " + searchcolumn + " from " + tablename;
            DataTable dt = GetDataTable(query);
            foreach (DataRow row in dt.Rows)
            {
                string record = row[searchcolumn].ToString();
                string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " DIR_OBJ = '" + dirobj + "'");
                string full_pdf_path = pdf_url + record + ".pdf";
                string flag = "N";
                if (File.Exists(full_pdf_path))
                {
                    flag = "Y";
                }
                string sqlflagUpdate = "UPDATE " + tablename + " SET " + updatecolumn + "='" + flag + "' WHERE " + searchcolumn + "='" + record + "'";
                exec_non_qry(sqlflagUpdate);
            }
        }
        catch (Exception ex)
        {
            return "Error:"+ex.Message;
        }
        return "success";
    }
}