using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using dsGeneralTableAdapters;
using System.Data.OracleClient;

/// <summary>
/// Summary description for Heat_Number
/// </summary>
public class heatno
{
    public static string pdf_name(string heat_no)
    {
        string temp = "";
        decimal tc_id = 0;
        tc_id = Decimal.Parse(WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS_DETAIL", 
            " WHERE HEAT_NO='" + heat_no + "'"));
        temp = WebTools.GetTC_Path(tc_id);
        return temp;
    }
    public static int CHK_HN_BOM(Decimal PROJ_ID,Decimal MAT_ID , String HEAT_NO ,Decimal NET_QTY)
    {
        //return 1 : material available
        //return 2 : material not enogh
        //return 3 : material not found
        string sql = "SELECT TOTAL_RCVD FROM VIEW_HN_RCVD WHERE PROJECT_ID=" + PROJ_ID.ToString() +
            " AND MAT_ID=" + MAT_ID.ToString() + " AND HEAT_NO='" + HEAT_NO + "'";
        Object total_rcvd,bom_qty;
        OracleConnection connection = conn_mngr.GetIpmsConnection();
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
                    return 1;
                }
                else
                {
                    connection.Close();
                    return  2;
                }
            }
        }
    }
}
