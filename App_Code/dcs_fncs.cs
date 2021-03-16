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

/// <summary>
/// Summary description for DCS_Functions
/// </summary>
public class dcs_fncs
{
    public static string GetTransPrefix(Decimal CAT_ID)
    {
        string sql = "SELECT SER_PREFIX FROM PIP_DWG_TRANS_CAT WHERE CAT_ID=" + CAT_ID.ToString();
        Object ser_prefix;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
        OracleCommand command = new OracleCommand(sql, connection);
        command.CommandType = CommandType.Text;
        ser_prefix = command.ExecuteScalar();
        connection.Close();
        return (string)ser_prefix;
    }
}
