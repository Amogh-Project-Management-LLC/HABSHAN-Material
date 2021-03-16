using dsWeldingATableAdapters;
using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
//using System.ServiceProcess;
using System.Text;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;

public class WebTools
{
    public static OracleConnection GetIpmsConnection()
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        OracleConnection connection = new OracleConnection(ConnectionString);
        connection.Open();
        return connection;
    }

    public static void Check_Session_Variable(string SessionVariable)
    {
        if (HttpContext.Current.Session[SessionVariable] == null)
        {
            HttpContext.Current.Session.Add(SessionVariable, string.Empty);
        }
    }

    public static string SessionDataPath()
    {
        return HostingEnvironment.ApplicationPhysicalPath + @"SessionData\" + HttpContext.Current.Session.SessionID + @"\";
    }

    public static SqlConnection GetASPNETConnection()
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["ASPNETDBConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(ConnectionString);
        connection.Open();
        return connection;
    }

    public static string get_scr_rep_id(string SPL_ID)
    {
        string sfr = WebTools.GetExpr("SFR", "PIP_SPOOL", "SPL_ID=" + SPL_ID);

        string single_mat = WebTools.GetExpr("SPL_ID", "VIEW_SINGLE_MAT_SPL", "SPL_ID=" + SPL_ID);
        if (single_mat == null) single_mat = "";

        if (sfr == "Y")
        {
            return "203";
        }
        else if (!string.IsNullOrEmpty(single_mat))
        {
            return "203.1";
        }
        else
        {
            return "200";
        }
    }

    public static bool IsValidAuth(decimal project_id, string username, string password)
    {
        string test;
        test = GetExpr("USER_ID", "USERS", "PROJECT_ID=" + project_id.ToString() +
                " AND UPPER(USER_NAME)='" + username.ToUpper() +
                "' AND PASSKEY='" + MD5Str(password) + "'");
        if (test.Length > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static bool IsAdminUser(string username)
    {
        string test;
        test = GetExpr("IS_ADMIN", "USERS", "UPPER(USER_NAME)='" + username.ToUpper() + "'");

        if (test.Length > 0)
        {
            if (test == "Y")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    public static bool UserInRole(string role)
    {
        string projid = HttpContext.Current.Session["PROJECT_ID"].ToString();
        string username = HttpContext.Current.Session["USER_NAME"].ToString();
        string userid = WebTools.GetExpr("USER_ID", "VIEW_USERS_ROLE", "PROJECT_ID=" + projid +
            " AND UPPER(USER_NAME)='" + username.ToUpper() + "' AND UPPER(ROLE_NAME)='" + role.ToUpper() + "'");
        if (userid.Length > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static bool check_hn_mrir(string mat_id, string heat_no)
    {
        string mrr_item = GetExpr("MIR_ITEM_ID", "PRC_MAT_INSP_DETAIL", "MAT_ID=" + mat_id + " AND HEAT_NO='" + heat_no + "'");
        if (mrr_item.Length > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static void ExecuteProcedure(string ProcName)
    {
        Object result;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(ProcName, connection);
        command.CommandType = CommandType.StoredProcedure;     
        result = command.ExecuteNonQuery();
        connection.Close();
       
    }

    public static string MD5Str(string raw)
    {
        MD5 md5serv = MD5CryptoServiceProvider.Create();
        byte[] hash;
        StringBuilder stringbuff = new StringBuilder();
        ASCIIEncoding asciienc = new ASCIIEncoding();
        //convert string into array of bytes
        byte[] buffer = asciienc.GetBytes(raw);
        //Comupte the hash for the string
        hash = md5serv.ComputeHash(buffer);
        foreach (byte b in hash)
        {
            stringbuff.Append(b.ToString("x2"));
        }
        return stringbuff.ToString();
    }

    public bool IsLoginValid(string InPassword, string MD5String)
    {
        if (MD5Str(InPassword) == MD5String)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static bool UrlExist(string url)
    {
        System.Net.HttpWebRequest wreq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
        wreq.Method = "GET";
        wreq.Timeout = 3000;
        System.Net.HttpWebResponse wr;
        try
        {
            wr = (System.Net.HttpWebResponse)wreq.GetResponse();
            if (wr.StatusCode == System.Net.HttpStatusCode.OK)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch
        {
            return false;
        }
    }

    public static string GetTransPrefix(Decimal CAT_ID)
    {
        string sql = "SELECT SER_PREFIX FROM PIP_DWG_TRANS_CAT WHERE CAT_ID=" + CAT_ID.ToString();
        Object ser_prefix;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        ser_prefix = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return (string)ser_prefix;
    }

    public static string ExecNonQuery(string statement)
    {
        Object result;
        using (OracleConnection conn = GetIpmsConnection())
        {
            using (OracleCommand command = new OracleCommand(statement, conn))
            {
                command.CommandType = CommandType.Text;
                result = command.ExecuteNonQuery();
            }
        }
        return result.ToString();
    }

    public static void update_spl_trans(int proj_id)
    {
        string sql1 = "declare outMSG VARCHAR2(200); Begin outMSG := FNC_SPL_TRANS(" + proj_id.ToString() + "); END;";
        string sql2 = "UPDATE PIP_SPOOL SET RECVD_SITE=NULL WHERE RECVD_SITE IS NOT NULL " +
            "AND ISO_ID IN (SELECT ISO_ID FROM PIP_ISOMETRIC WHERE PROJ_ID=" + proj_id.ToString() + ") " +
            "AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE CAT_ID=3)";
        string sql3 = "UPDATE PIP_SPOOL SET SENT_TO_SITE=NULL WHERE SENT_TO_SITE IS NOT NULL" +
            " AND ISO_ID IN (SELECT ISO_ID FROM PIP_ISOMETRIC WHERE PROJ_ID=" + proj_id.ToString() + ")" +
            " AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE CAT_ID=4)";
        string sql4 = "UPDATE PIP_SPOOL SET RECVD_SITE=NULL WHERE SPL_ID IN " +
            "(SELECT SPL_ID FROM VIEW_RESEND_A WHERE SPL_BAL_C = 0)";
        if (proj_id == 2)
        {
            return;
        }
        ExecNonQuery(sql1);
        ExecNonQuery(sql2);
        ExecNonQuery(sql3);
        ExecNonQuery(sql4);
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

    public static string get_prefix(string my_str)
    {
        return my_str.Substring(0, 2);
    }

    public static string NextSerialNo(String TableName, String FieldName, String SerPrefix,
        Int32 IndexLen, String SqlCriteria)
    {
        string num_format = "";
        for (int i = 0; i < IndexLen; i++)
        {
            num_format += "0";
        }
        if (SqlCriteria.IndexOf("WHERE") < 0) SqlCriteria = " WHERE " + SqlCriteria;
        string sql = "SELECT TO_CHAR(NVL(MAX(IDX_),0)+1,'" + num_format + "') AS MAX_INDEX FROM (SELECT " +
            FieldName + ",TO_NUMBER(REGEXP_REPLACE(SUBSTR(" + FieldName + ",-" + IndexLen.ToString() + "," +
            IndexLen.ToString() + "),'[a-zA-Z]', '')) AS IDX_ FROM " + TableName + SqlCriteria + ")";
        Object max_index;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        try
        {
            max_index = command.ExecuteScalar();
            return string.Format("{0}{1}", SerPrefix, max_index.ToString().Trim());
        }
        catch
        {
            return string.Format("{0}{1:0000}", SerPrefix, 1);
        }
        finally
        {
            connection.Close();
            connection.Dispose();
            command.Dispose();
        }

    }

    public static string ExeSql(String statement)
    {
        Object result;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(statement, connection);
        command.CommandType = CommandType.Text;
        result = command.ExecuteNonQuery();
        connection.Close();
        return result.ToString();
    }

    //public static string cut_rep_joint(string proj_id, decimal joint_id, string rev_code)
    //{
    //    PIP_JOINTSTableAdapter joints = new PIP_JOINTSTableAdapter();
    //    dsWeldingA.PIP_JOINTSDataTable joints_tbl = new dsWeldingA.PIP_JOINTSDataTable();
    //    joints_tbl = joints.GetData(joint_id);
    //    dsWeldingA.PIP_JOINTSRow old_row;
    //    dsWeldingA.PIP_JOINTSRow new_row = joints_tbl.NewPIP_JOINTSRow();
    //    try
    //    {
    //        old_row = joints_tbl[0];
    //        new_row.SPL_ID = old_row.SPL_ID;
    //        new_row.ISO_ID = old_row.ISO_ID;
    //        new_row.JOINT_NO = old_row.JOINT_NO;
    //        new_row.JOINT_TYPE = old_row.JOINT_TYPE;
    //        new_row.JOINT_SIZE = old_row.JOINT_SIZE;
    //        new_row.CAT_ID = old_row.CAT_ID;
    //        if (!old_row.IsITEM_1Null()) new_row.ITEM_1 = old_row.ITEM_1;
    //        if (!old_row.IsITEM_2Null()) new_row.ITEM_2 = old_row.ITEM_2;
    //        if (!old_row.IsHEAT_NO1Null()) new_row.HEAT_NO1 = old_row.HEAT_NO1;
    //        if (!old_row.IsHEAT_NO2Null()) new_row.HEAT_NO2 = old_row.HEAT_NO2;
    //        if (!old_row.IsRTNull()) new_row.RT = old_row.RT;
    //        if (!old_row.IsPTNull()) new_row.PT = old_row.PT;
    //        if (!old_row.IsMTNull()) new_row.MT = old_row.MT;
    //        if (!old_row.IsPWHTNull()) new_row.PWHT = old_row.PWHT;
    //        if (!old_row.IsPMINull()) new_row.PMI = old_row.PMI;
    //        if (!old_row.IsDIS_FLGNull()) new_row.DIS_FLG = old_row.DIS_FLG;
    //        if (!old_row.IsWPS_NONull()) new_row.WPS_NO = old_row.WPS_NO;

    //        string joint_no = old_row.JOINT_NO.ToString();
    //        string iso_id = old_row.ISO_ID.ToString();

    //        joints_tbl.AddPIP_JOINTSRow(new_row);
    //        joints.Update(joints_tbl);
    //        return "Joint created successfully!";
    //    }
    //    catch (Exception ex)
    //    {
    //        return ex.Message;
    //    }
    //    finally
    //    {
    //        joints.Dispose();
    //        joints_tbl.Dispose();
    //    }
    //}

    public static int CHK_HN_BOM(Decimal PROJ_ID, Decimal MAT_ID, String HEAT_NO, Decimal NET_QTY)
    {
        //return 1 : material available
        //return 2 : material not enogh
        //return 3 : material not found
        string sql = "SELECT TOTAL_RCVD FROM VIEW_HN_RCVD WHERE PROJECT_ID=" + PROJ_ID.ToString() +
            " AND MAT_ID=" + MAT_ID.ToString() + " AND HEAT_NO='" + HEAT_NO + "'";
        Object total_rcvd, bom_qty;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        total_rcvd = command.ExecuteScalar(); command.Dispose();
        if (total_rcvd == null)
        {
            connection.Close();
            return 3;
        }
        else
        {
            if ((decimal)total_rcvd == 0)
            {
                connection.Close();
                return 2;
            }
            else
            {
                sql = "SELECT BOM_QTY FROM VIEW_HN_BOM WHERE PROJ_ID=" + PROJ_ID.ToString() +
                    " AND MAT_ID=" + MAT_ID.ToString() + " AND HEAT_NO='" + HEAT_NO + "'";
                command = new OracleCommand(sql, connection);
                command.CommandType = CommandType.Text;
                bom_qty = command.ExecuteScalar(); command.Dispose();
                if (((decimal)total_rcvd - (decimal)bom_qty - NET_QTY) >= 0)
                {
                    connection.Close();
                    connection.Dispose();
                    command.Dispose();
                    return 1;
                }
                else
                {
                    connection.Close();
                    connection.Dispose();
                    command.Dispose();
                    return 2;
                }
            }
        }
    }

    public static void ExportDataSetToExcel(SqlDataSource ds, string filename)
    {
        HttpResponse response = HttpContext.Current.Response;
        response.Clear();
        response.Charset = "";
        response.ContentType = "application/vnd.ms-excel";
        response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                GridView dg = new GridView();
                dg.DataSource = ds;
                dg.CssClass = "DataWebControlStyle";
                dg.AlternatingRowStyle.CssClass = "AlternatingRowStyle";
                dg.HeaderStyle.CssClass = "HeaderStyle";
                dg.DataBind();
                dg.RenderControl(htw);
                response.Write(sw.ToString());
                response.End();
            }
        }
    }

    public static void ExportObjDataSetToExcel(ObjectDataSource ds, string filename)
    {
        HttpResponse response = HttpContext.Current.Response;
        response.Clear();
        response.Charset = "";
        response.ContentType = "application/vnd.ms-excel";
        response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                GridView dg = new GridView();
                dg.DataSource = ds;
                dg.CssClass = "DataWebControlStyle";
                dg.AlternatingRowStyle.CssClass = "AlternatingRowStyle";
                dg.HeaderStyle.CssClass = "HeaderStyle";
                dg.DataBind();
                dg.RenderControl(htw);
                response.Write(sw.ToString());
                response.End();
            }
        }
    }

    public static string GetIsoTitle1(decimal ISO_ID)
    {
        string sql = "SELECT ISO_TITLE1 FROM PIP_ISOMETRIC WHERE ISO_ID=" + ISO_ID.ToString();
        Object iso_title;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        iso_title = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return (string)iso_title;
    }

    public static string GetTC_Path(decimal tc_id)
    {
        string mtc_url = GetExpr("PDF_URL", "VIEW_TC_PDF", "TC_ID=" + tc_id.ToString());

        if (UrlExist(mtc_url))
        {
            return mtc_url;
        }
        else
        {
            return string.Empty;
        }
    }

    public static string GetExpr(string expression, string domain, string criteria)
    {
        string sql;
        if (criteria.IndexOf("WHERE") > 0)
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain + criteria;
        }
        else if (criteria.IndexOf("WHERE") <= 0 && criteria.Length > 0)
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain + " WHERE " + criteria;
        }
        else
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain;
        }
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return expr.ToString();
    }

    public static decimal DSum(string expression, string domain, string criteria)
    {
        string sql;
        if (criteria.IndexOf("WHERE") > 0)
        {
            sql = "SELECT NVL(SUM(" + expression + "),0) AS RESULT FROM " + domain + criteria;
        }
        else if (criteria.IndexOf("WHERE") <= 0 && criteria.Length > 0)
        {
            sql = "SELECT NVL(SUM(" + expression + "),0) AS RESULT FROM " + domain + " WHERE " + criteria;
        }
        else
        {
            sql = "SELECT NVL(SUM(" + expression + "),0) AS RESULT FROM " + domain;
        }
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return decimal.Parse(expr.ToString());
    }

    public static decimal DMax(string expression, string domain, string criteria)
    {
        string sql = "SELECT NVL(MAX(" + expression + "),0) AS RESULT FROM " + domain + criteria;
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return decimal.Parse(expr.ToString());
    }

    public static decimal DMaxchar(string expression, string domain, string criteria)
    {
        string sql = "SELECT NVL(MAX(TO_NUMBER(" + expression + ")),0) AS RESULT FROM " + domain + criteria;
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return decimal.Parse(expr.ToString());
    }

    public static string DMaxText(string expression, string domain, string criteria)
    {
        string sql;
        if (criteria.IndexOf("WHERE") > 0)
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain + criteria;
        }
        else if (criteria.IndexOf("WHERE") <= 0 && criteria.Length > 0)
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain + " WHERE " + criteria;
        }
        else
        {
            sql = "SELECT MAX(" + expression + ") AS RESULT FROM " + domain;
        }
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return expr.ToString();
    }

    public static string DMinText(string expression, string domain, string criteria)
    {
        string sql;
        if (criteria.IndexOf("WHERE") > 0)
        {
            sql = "SELECT MIN(" + expression + ") AS RESULT FROM " + domain + criteria;
        }
        else if (criteria.IndexOf("WHERE") <= 0 && criteria.Length > 0)
        {
            sql = "SELECT MIN(" + expression + ") AS RESULT FROM " + domain + " WHERE " + criteria;
        }
        else
        {
            sql = "SELECT MIN(" + expression + ") AS RESULT FROM " + domain;
        }
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return expr.ToString();
    }

    public static Decimal GetPO_ID(String PO_NO, Decimal PROJ_ID)
    {
        string sql = "SELECT PO_ID FROM PO_MASTER WHERE PO_NO='" + PO_NO.ToString() + "' AND PROJECT_ID=" + PROJ_ID.ToString();
        Object PO_ID;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        PO_ID = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        if (PO_ID == null)
        {
            return 0;
        }
        else
        {
            return (Decimal)PO_ID;
        }
    }

    public static string SubconName(Decimal SC_ID)
    {
        string sql = "SELECT SUB_CON_NAME FROM SUB_CONTRACTOR WHERE SUB_CON_ID=" + SC_ID.ToString();
        Object subcon_name;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        subcon_name = command.ExecuteScalar();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        return (string)subcon_name;
    }

    public static decimal GetMatId(string ItemCode, decimal ProjId)
    {
        string sql_a = "SELECT MAT_ID FROM PIP_MAT_STOCK WHERE PROJ_ID=" + ProjId.ToString() +
            " AND (MAT_CODE1='" + ItemCode.ToString() + "')";
        Object mat_id;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command;
        command = new OracleCommand(sql_a, connection);
        command.CommandType = CommandType.Text;
        mat_id = command.ExecuteScalar();
        command.Dispose();
        connection.Close();
        connection.Dispose();
        command.Dispose();
        if (mat_id == null)
        {
            return 0;
        }
        else
        {
            return Convert.ToDecimal(mat_id);
        }
    }

    public static string CountExpr(string expression, string domain, string criteria)
    {
        string sql;
        if (criteria.IndexOf("WHERE") > 0)
        {
            sql = "SELECT Count(" + expression + ") AS RESULT FROM " + domain + criteria;
        }
        else if (criteria.IndexOf("WHERE") <= 0 && criteria.Length > 0)
        {
            sql = "SELECT  Count(" + expression + ") AS RESULT FROM " + domain + " WHERE " + criteria;
        }
        else
        {
            sql = "SELECT Count(" + expression + ") AS RESULT FROM " + domain;
        }
        Object expr;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        command.Dispose();
        connection.Close();
        connection.Dispose();
        return (expr == null ? "0" : expr.ToString());
    }

    public static string exec_non_qry(string statement)
    {
        Object result;
        OracleConnection connection = GetIpmsConnection();
        OracleCommand command = new OracleCommand(statement, connection);
        command.CommandType = CommandType.Text;
        result = command.ExecuteNonQuery();
        command.Dispose();
        //Commit Now
        command = new OracleCommand("COMMIT", connection);
        command.ExecuteNonQuery();
        //Dispose all
        command.Dispose();
        connection.Close();
        connection.Dispose();
        return result.ToString();
    }


    public static DataTable getDataTable(string query)
    {
        OracleConnection conn = GetIpmsConnection(); 
        OracleDataAdapter adapter = new OracleDataAdapter();
        adapter.SelectCommand = new OracleCommand(query, conn);
        DataTable myDataTable = new DataTable();
        
        try
        {
            adapter.Fill(myDataTable);
        }
        finally
        {
            conn.Close();
        }

        return myDataTable;
    }
}