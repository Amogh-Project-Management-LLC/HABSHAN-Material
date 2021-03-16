using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.SqlClient;

public class security_con
{
    public static string GetExpr(string expression , string domain , string criteria)
    {
        string sql = "SELECT " + expression + " AS RESULT FROM " + domain + criteria;
        Object expr;
        SqlConnection connection = conn_mngr.GetASPNETConnection();
        SqlCommand command = new SqlCommand(sql, connection);
        command.CommandType = CommandType.Text;
        expr = command.ExecuteScalar();
        connection.Close();
        if (expr == null) expr = "";
        return expr.ToString();
    }
}
