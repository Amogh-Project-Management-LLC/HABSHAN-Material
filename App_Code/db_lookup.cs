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

public class db_lookup
{
    public static decimal DSum(string expression, string domain, string criteria)
    {
        string where_con = "";
        if (criteria.Length > 0)
        {
            if (criteria.IndexOf("WHERE") > 0)
            {
                where_con = " " + criteria.Trim();
            }
            else
            {
                where_con = " WHERE " + criteria.Trim();
            }
        }
        string sql = "SELECT NVL(SUM(" + expression + "),0) AS RESULT FROM " + domain + where_con;
        Object expr;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        return decimal.Parse(expr.ToString());
    }

    public static decimal DMax(string expression, string domain, string criteria)
    {
        string where_con = "";
        if (criteria.Length > 0)
        {
            if (criteria.IndexOf("WHERE") > 0)
            {
                where_con = " " + criteria.Trim();
            }
            else
            {
                where_con = " WHERE " + criteria.Trim();
            }
        }
        string sql = "SELECT NVL(MAX(" + expression + "),0) AS RESULT FROM " + domain + where_con;
        Object expr;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        return decimal.Parse(expr.ToString());
    }

    public static decimal MAT_ID(string ITEM_CODE, Decimal PROJ_ID)
    {
        string sql_a = "SELECT MAT_ID FROM PIP_MAT_STOCK WHERE PROJ_ID=" + PROJ_ID.ToString() + " AND MAT_CODE1='" + ITEM_CODE.ToString() + "'";

        Object mat_id;

        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql_a, connection);
        command.CommandType = CommandType.Text;
        mat_id = command.ExecuteScalar();
        command.Dispose();

        connection.Close();
        if (mat_id == null)
        {
            return 0;
        }
        else
        {
            return Convert.ToDecimal(mat_id);
        }
    }
}