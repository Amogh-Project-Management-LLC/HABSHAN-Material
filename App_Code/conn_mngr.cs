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
using System.Data.SqlClient;

public class conn_mngr
{
    public static OracleConnection GetIpmsConnection()
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        OracleConnection connection = new OracleConnection(ConnectionString);
        connection.Open();
        return connection;
    }
    public static SqlConnection GetASPNETConnection()
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["ASPNETDBConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(ConnectionString);
        connection.Open();
        return connection;
    }
}
