using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.IO;
using System.Data.OracleClient;

public class db_export
{
    public static void ExportToCSV(string query, string fileName)
    {
        //Add Response header
        HttpResponse Response = HttpContext.Current.Response;
        Response.Clear();
        Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.csv", fileName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        //GET Data From Database

        OracleConnection cn = WebTools.GetIpmsConnection();
        OracleCommand cmd = new OracleCommand(query, cn);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            //cn.Open();
            OracleDataReader dr = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();

            //CSV Header
            for (int count = 0; count < dr.FieldCount; count++)
            {
                if (dr.GetName(count) != null)
                    sb.Append(dr.GetName(count));
                if (count < dr.FieldCount - 1)
                {
                    sb.Append(",");
                }
            }
            Response.Write(sb.ToString() + "\n");
            Response.Flush();

            //CSV Body
            while (dr.Read())
            {
                sb = new StringBuilder();

                for (int col = 0; col < dr.FieldCount - 1; col++)
                {
                    if (!dr.IsDBNull(col))
                    {
                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(col).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " "));
                        }
                    }
                    sb.Append(",");
                }

                if (!dr.IsDBNull(dr.FieldCount - 1))
                {
                    if (!dr.IsDBNull(dr.FieldCount - 1))
                    {
                        if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(dr.FieldCount - 1).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " "));
                        }
                    }
                }

                Response.Write(sb.ToString() + "\n");
                Response.Flush();
            }
            dr.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
        }
        Response.End();
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

}
