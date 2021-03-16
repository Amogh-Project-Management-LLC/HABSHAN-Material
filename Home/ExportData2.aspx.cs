
using System;
using System.Data;
using System.Data.OracleClient;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.IO;
using System.IO.Compression;
using Ionic.Zip;
using System.Configuration;
using ClosedXML.Excel;
using ClosedXML.Attributes;
using ClosedXML.Utils;
using System.Drawing;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
using System.Reflection;
using BuildClass;
using System.Dynamic;
using System.Linq.Expressions;
using OfficeOpenXml.Drawing.Chart;
using OfficeOpenXml.Drawing;
using Telerik.Web.UI;
using System.Text.RegularExpressions;


public partial class Home_ExportData : System.Web.UI.Page
{
    int user_id = 0;
    // numeric formats
    private const string positiveFormat = "#,##0.00_)";
    private const string negativeFormat = "(#,##0.00)";
    private const string zeroFormat = "-_)";
    private const string positiveIntFormat = "#,##0_)";
    private const string negativeIntFormat = "(#,##0)";
    private const string percentageFormat = "0.00%";

    private static readonly string numberFormat = string.Format("{0};{1}", positiveFormat, negativeFormat);
    private static readonly string fullNumberFormat = string.Format("{0};{1};{2}", positiveFormat, negativeFormat, zeroFormat);
    private static readonly string numberIntFormat = string.Format("{0};{1}", positiveIntFormat, negativeIntFormat);
    private static readonly string fullNumberIntFormat = string.Format("{0};{1};{2}", positiveIntFormat, negativeIntFormat, zeroFormat);


    // english-united states culture
    private static readonly CultureInfo enUS = CultureInfo.CreateSpecificCulture("en-US");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["USER_NAME"].ToString().Length > 0)
        {
            user_id = int.Parse(WebTools.GetExpr("USER_ID", "USERS", "USER_NAME='" + Session["USER_NAME"] + "'"));

        }
        else
        {
            return;
        }
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Export Data";

        }
    }

        protected void btnPreview_Click(object sender, EventArgs e)
    {
        //string prc_name = WebTools.GetExpr("PROCEDURE_NAME", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

        //if (prc_name.Length > 0)
        //{
        //    WebTools.ExecuteProcedure(prc_name);
        //}
        //if (SetSqlDataSource() == true)
        //{

        //    ExportToCSV(OutPutDataSource, FileName_HiddenField.Value.ToString());
        //}
        if (ExportsListBox1.SelectedItems.Count <= 0)
        {
            Master.ShowMessage("Select an item to export!");

        }
        else
        {
            //if (SetSqlDataSource() == true)
            //{
            //    ExportToCSV(OutPutDataSource, FileName_HiddenField.Value.ToString());
            //}

            string SHEET_TABLE_NAME = WebTools.GetExpr("TABLE_NAME", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            string SHEET_REPORT_NAME = WebTools.GetExpr("EXPT_TITLE", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            string REPORT_ID = WebTools.GetExpr("REPORT_ID", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            if (SHEET_TABLE_NAME.Length > 0)
            {
                if (REPORT_ID == "1")
                {
                    NewSheetWiseExcelFile(ExportsListBox1.SelectedValue.ToString(), SHEET_REPORT_NAME);

                }
                
                ExportExcelSheets(ExportsListBox1.SelectedValue.ToString(), SHEET_REPORT_NAME);
            }
            else
            {
                SetSqlDataSource();
                ExportToCSV(OutPutDataSource, FileName_HiddenField.Value.ToString());
            }
        }
    }

    private bool SetSqlDataSource()
    {
        try
        {
            if (ExportsListBox1.SelectedItems.Count <= 0)
            {
                Master.ShowMessage("Select an item to export!");
                return false;
            }

            FileName_HiddenField.Value = ExportsListBox1.SelectedItem.Text.Replace(" ", "_");

            //string PROJ_FIELD_NAME = WebTools.GetExpr("PROJ_FIELD_NAME", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

            string EXPT_SQL = WebTools.GetExpr("EXPT_SQL", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

            // where
            //if (EXPT_SQL.IndexOf("WHERE") > 0)
            //{
            //    EXPT_SQL += " AND " + PROJ_FIELD_NAME + "=" + Session["PROJECT_ID"].ToString();
            //}
            //else
            //{
            //    EXPT_SQL += " WHERE " + PROJ_FIELD_NAME + "=" + Session["PROJECT_ID"].ToString();
            //}

            // order by
            string ORDER_BY = WebTools.GetExpr("ORDER_BY", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            if (!string.IsNullOrEmpty(ORDER_BY))
            {
                EXPT_SQL += " ORDER BY " + ORDER_BY;
            }

            if (ExportsListBox1.SelectedValue.ToString() == "125")
            {
                string source = WebTools.GetExpr("SOURCE", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
                DataTable dt = new DataTable();
                String ConnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
                OracleConnection con = new OracleConnection(ConnString);
                OracleCommand cmd = new OracleCommand(EXPT_SQL, con);
                cmd.CommandType = CommandType.Text;
                OracleDataAdapter da = new OracleDataAdapter(cmd);
                da.Fill(dt);
                string new_query = "";
                foreach (DataColumn column in dt.Columns)
                {
                     new_query = new_query+column.ColumnName+ ", ";

                }
                new_query = new_query.Replace("BATCH_PO_NO,", "").ToString().Replace("BATCH_PO_ITEM,", "");
                new_query = new_query.Substring(0, new_query.Length - 2);
                string query = "SELECT " + new_query + " FROM " + source;
                OutPutDataSource.SelectCommand = query;
              
                return true;
            }
            else
            {
                OutPutDataSource.SelectCommand = EXPT_SQL;
                return true;
            }


          
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
            return false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["BackUrl"] != null)
        {
            Response.Redirect(Request.QueryString["BackUrl"]);
        }
        else
        {
            Response.Redirect("~/Home/Default.aspx");
        }
    }

    public void ExportToCSV(SqlDataSource dataSrc, string fileName)
    {
        //Add Response header

        Response.Clear();
        Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.csv", fileName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        //GET Data From Database

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ").Replace(Environment.NewLine, "").Replace("\r","").Replace("\n", ""); 

        OracleCommand cmd = new OracleCommand(query, cn);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
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
                    sb.Replace("_", " ");
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
                        //else if (dr.GetDataTypeName(col).ToUpper().Contains("VARCHAR"))
                        //{
                        //    sb.Append("=\"" + dr.GetValue(col).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ").Replace("\"", "\"\"") + "\"");
                        //}

                        else
                        {
                            sb.Append( dr.GetValue(col).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ").Replace("\r", "").Replace("\n", ""));
                        }
                    }
                    else
                    {

                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append("*");
                        }

                        if (dr.GetDataTypeName(col).ToUpper() == "NUMBER")
                        {
                            sb.Append(0);
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
                        //else if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper().Contains("VARCHAR"))
                        //{
                        //    sb.Append("=\"" + dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ") + "\"");
                        //}
                        else
                        {
                            sb.Append( dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r", "").Replace("\n", ""));
                        }
                    }
                }
                else
                {

                    if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                    {
                        sb.Append("*");
                    }

                    if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "NUMBER")
                    {
                        sb.Append(0);
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

    protected void exportsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        //string prc_name = WebTools.GetExpr("PROCEDURE_NAME", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
        //if (prc_name.Length > 0)
        //{
        //    WebTools.ExecuteProcedure(prc_name);
        //}
        //if (SetSqlDataSource() == true)
        //{


        //    ExportToCSV_Zip(OutPutDataSource, FileName_HiddenField.Value.ToString());
        //}
        if (ExportsListBox1.SelectedItems.Count <= 0)
        {
            Master.ShowMessage("Select an item to export!");

        }
        else
        {
            string SHEET_TABLE_NAME = WebTools.GetExpr("TABLE_NAME", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            string SHEET_REPORT_NAME = WebTools.GetExpr("EXPT_TITLE", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
            string REPORT_ID = WebTools.GetExpr("REPORT_ID", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());

            if (SHEET_TABLE_NAME.Length > 0)
            {
                if (REPORT_ID == "1")
                {
                    NewSheetWiseExcelFile_zip(ExportsListBox1.SelectedValue.ToString(), SHEET_REPORT_NAME);

                }
                else
                {
                    ExportExcelSheets(ExportsListBox1.SelectedValue.ToString(), SHEET_REPORT_NAME);
                }

            }
            else
            {
                SetSqlDataSource();
                ExportToCSV_Zip(OutPutDataSource, FileName_HiddenField.Value.ToString());
            }
        }

    }

    public void ExportToCSV_Zip(SqlDataSource dataSrc, string fileName)
    {
        string path = WebTools.SessionDataPath();
        string excel_file = path + fileName + ".csv";
        string zip_file = path + fileName + ".zip";

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ").Replace(Environment.NewLine, "").Replace("\r", "").Replace("\n", ""); 

        OracleCommand cmd = new OracleCommand(query, cn);
        StreamWriter sr = new StreamWriter(excel_file);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
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
                    sb.Replace("_", " ");
                }
            }
            sr.WriteLine(sb.ToString());

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
                        //else if (dr.GetDataTypeName(col).ToUpper().Contains("VARCHAR"))
                        //{
                        //    sb.Append("=\"" + dr.GetValue(col).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ").Replace("\"", "\"\"") + "\"");
                        //}

                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ").Replace("\r", "").Replace("\n", ""));
                        }
                    }
                    else
                    {

                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append("*");
                        }

                        if (dr.GetDataTypeName(col).ToUpper() == "NUMBER")
                        {
                            sb.Append(0);
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
                        //else if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper().Contains("VARCHAR"))
                        //{
                        //    sb.Append("=\"" + dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ") + "\"");
                        //}
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " ").Replace(Environment.NewLine, "").Replace("\r\n", " ").Replace("\r", "").Replace("\n", ""));
                        }
                    }
                }
                else
                {

                    if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                    {
                        sb.Append("*");
                    }

                    if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "NUMBER")
                    {
                        sb.Append(0);
                    }
                }

                sr.WriteLine(sb.ToString());
            }

            dr.Dispose();
            sr.Close();

            //ZipFile
            using (ZipFile zip = new ZipFile())
            {
                zip.AddFile(excel_file, "CSV");
                zip.Save(zip_file);

                Response.AppendHeader("content-disposition", "attachment; filename=" + fileName + ".zip");
                Response.ContentType = "application/zip";
                Response.WriteFile(zip_file);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
            sr.Dispose();
        }
    }
    public void ExportExcelSheets(string EXPT_ID, string FILE_NAME)

    {

        string constr = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        string table_query = "SELECT * FROM SHEET_WISE_DOWNLOAD WHERE EXPT_ID=" + EXPT_ID + " ORDER BY EXPT_ID,SEQ ";


        string query = "";




        using (XLWorkbook wb = new XLWorkbook())
        {
            DataTable table_dt = General_Functions.GetDataTable(table_query);
            DataSet ds = new DataSet();
            foreach (DataRow row in table_dt.Rows)
            {
                query = "SELECT * FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                string hide_query = WebTools.GetExpr("HIDE_COLUMN", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string total_query = WebTools.GetExpr("IS_TOTAL_REP", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string format_query = WebTools.GetExpr("IS_COLOR_FORMAT", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string prc_date = WebTools.GetExpr("PRC_END_DATE", "IPMS_SYS_EXPORT", "EXPT_ID=" + EXPT_ID);
                string APP_LOGO1 = WebTools.GetExpr("APP_LOGO1", "PROJECT_INFORMATION", "");
                string APP_LOGO2 = WebTools.GetExpr("APP_LOGO2", "PROJECT_INFORMATION", "");
                string CLIENT_NAME = WebTools.GetExpr("CLIENT_NAME", "PROJECT_INFORMATION", "");
                string PROJ_DESC = WebTools.GetExpr("PROJ_DESC", "PROJECT_INFORMATION", "");
                string merge_count = WebTools.CountExpr("expt_id", "SHEET_WISE_MERGE", "EXPT_ID=" + EXPT_ID);


                if (hide_query.Length > 0)
                {
                    DataTable dt = new DataTable();

                    OracleConnection hide_con = new OracleConnection(constr);
                    try
                    {

                        OracleCommand hide_cmd = new OracleCommand(query, hide_con);
                        hide_cmd.CommandType = CommandType.Text;
                        OracleDataAdapter hide_da = new OracleDataAdapter(hide_cmd);
                        hide_da.Fill(dt);
                    }
                    finally
                    {
                        hide_con.Close();
                    }
                    string new_query = "";
                    foreach (DataColumn column in dt.Columns)
                    {
                        new_query = new_query + column.ColumnName + ", ";

                    }

                    string[] hide_clumns = hide_query.Split(',');

                    foreach (string column in hide_clumns)
                    {
                        new_query = new_query.Replace(column + ", ", "");
                        string col = column;
                    }
                    new_query = new_query.Substring(0, new_query.Length - 2);
                    query = "SELECT " + new_query + " FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                }

                OracleConnection con = new OracleConnection(constr);
                try
                {
                    OracleCommand cmd = new OracleCommand(query, con);
                    OracleDataAdapter adapter = new OracleDataAdapter(cmd);

                    adapter.Fill(ds);
                }
                finally
                {
                    con.Close();
                }
                int i = Convert.ToInt32(row["SEQ"]) - 1;
                ds.Tables[i].TableName = row["REPORT_NAME"].ToString();
                string sheet_name = row["REPORT_NAME"].ToString();
                string notes = row["NOTES"].ToString();

                var ws = wb.Worksheets.Add(sheet_name);


                var imagePath1 = @APP_LOGO1;
                var image1 = ws.AddPicture(imagePath1).MoveTo(ws.Cell("A1"));
                image1.Width = 50;
                image1.Height = 50;

                var wsReportNameHeaderRange = ws.Range(string.Format("B{0}:{1}{0}", 1, GetExcelColumnName(ds.Tables[i].Columns.Count - 1)));

                wsReportNameHeaderRange.Style.Font.Bold = true;
                wsReportNameHeaderRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                wsReportNameHeaderRange.Merge();
                wsReportNameHeaderRange.Value = FILE_NAME + " [ " + sheet_name + " ] ";
                wsReportNameHeaderRange.Style.Font.FontColor = XLColor.TealBlue;
                wsReportNameHeaderRange.Style.Font.FontName = "Arial";
                wsReportNameHeaderRange.Style.Font.FontSize = 20;

                var wsReportProjectHeaderRange = ws.Range(string.Format("B{0}:{1}{0}", 2, GetExcelColumnName(ds.Tables[i].Columns.Count - 1)));
                wsReportProjectHeaderRange.Style.Font.Bold = true;
                wsReportProjectHeaderRange.Merge();
                wsReportProjectHeaderRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                wsReportProjectHeaderRange.Value = string.Format("Project: " + PROJ_DESC);

                var wsReportClientHeaderRange = ws.Range(string.Format("B{0}:{1}{0}", 3, GetExcelColumnName(ds.Tables[i].Columns.Count - 1)));
                wsReportClientHeaderRange.Style.Font.Bold = true;
                wsReportClientHeaderRange.Merge();
                wsReportClientHeaderRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                wsReportClientHeaderRange.Value = string.Format("Client : " + CLIENT_NAME);

                var wsReportDateHeaderRange = ws.Range(string.Format("B{0}:{1}{0}", 4, GetExcelColumnName(ds.Tables[i].Columns.Count - 1)));
                wsReportDateHeaderRange.Merge();
                wsReportDateHeaderRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                wsReportDateHeaderRange.Value = string.Format("Report Generated Date :{0}", DateTime.Now.ToString("dddd, dd MMMM yyyy h:mm tt"));
                wsReportDateHeaderRange.Style.Font.FontColor = XLColor.Red;


                if (prc_date.Length > 0)
                {

                    var wsRefreshDateHeaderRange = ws.Range(string.Format("B{0}:{1}{0}", 5, GetExcelColumnName(ds.Tables[i].Columns.Count - 1)));
                    wsRefreshDateHeaderRange.Merge();
                    wsRefreshDateHeaderRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                    wsRefreshDateHeaderRange.Value = string.Format("Report Refreshed Date :{0}", prc_date);
                    wsRefreshDateHeaderRange.Style.Font.FontColor = XLColor.Red;
                }


                var imagePath2 = @APP_LOGO2;
                var image2 = ws.AddPicture(imagePath2).MoveTo(ws.Cell(string.Format("{0}1", GetExcelColumnName(ds.Tables[i].Columns.Count))));
                image2.Width = 50;
                image2.Height = 50;

                var wsReportNotesRange = ws.Range(string.Format("{0}7:{1}13", GetExcelColumnName(ds.Tables[i].Columns.Count + 3), GetExcelColumnName(ds.Tables[i].Columns.Count + 7)));
                wsReportNotesRange.Merge();
                wsReportNotesRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                wsReportNotesRange.Value = string.Format("NOTES : " + notes);



                ws.Row(5).InsertRowsBelow(1);
                ws.Row(6).Style.Border.OutsideBorder = XLBorderStyleValues.None;
                ws.Row(6).Style.Border.RightBorder = XLBorderStyleValues.None;
                ws.Row(6).Style.Border.LeftBorder = XLBorderStyleValues.None;
                int rowIndex = 7;
                int columnIndex = 1;
                if (int.Parse(merge_count) > 0)
                {
                    string merge_query = "SELECT * FROM SHEET_WISE_MERGE WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ ";

                    DataTable merge_dt = General_Functions.GetDataTable(merge_query);
                    foreach (DataRow merge_row in merge_dt.Rows)
                    {
                        var mergeRange = ws.Range(string.Format("{0}", merge_row["MERGE_RANGE"]));
                        mergeRange.Merge();
                        mergeRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        mergeRange.Value = string.Format("{0}", merge_row["MERGE_VALUE"]);

                        mergeRange.Style.Fill.BackgroundColor = XLColor.FromTheme(XLThemeColor.Accent1, 0.5);
                        mergeRange.Style.Font.FontColor = XLColor.Black;
                        mergeRange.Style.Font.FontSize = 13;
                        mergeRange.Style.Font.Bold = true;
                        mergeRange.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    }
                }

                foreach (DataColumn column in ds.Tables[i].Columns)
                {
                    string column_letter = GetExcelColumnName(columnIndex);
                    ws.Cell(string.Format("{0}{1}", column_letter, rowIndex)).Value = column.ColumnName.Replace("_", " ");
                    ws.Cell(string.Format("{0}{1}", column_letter, rowIndex)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                    ws.Cell(string.Format("{0}{1}", column_letter, rowIndex)).Style.Fill.BackgroundColor = XLColor.Orange;
                    ws.Cell(string.Format("{0}{1}", column_letter, rowIndex)).Style.Font.FontSize = 13;
                    ws.Cell(string.Format("{0}{1}", column_letter, rowIndex)).Style.Font.Bold = true;
                    ws.Column(columnIndex).AdjustToContents();

                    if (column.DataType == typeof(System.DateTime))
                    {
                        ws.Column(columnIndex).Style.DateFormat.Format = "dd-MMM-yyyy";
                    }

                    columnIndex++;
                }
                rowIndex++;


                if (format_query == "Y" || total_query == "Y")
                {
                    foreach (DataRow Row in ds.Tables[i].Rows)
                    {
                        int valueCount = 1;
                        foreach (object rowValue in Row.ItemArray)
                        {
                            string row_letter = GetExcelColumnName(valueCount);
                            ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = rowValue;
                            ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                            if (format_query == "Y")
                            {
                                string format_main_query = "SELECT * FROM SHEET_WISE_COLOR_FORMAT WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ ";

                                DataTable format_dt = General_Functions.GetDataTable(format_main_query);
                                foreach (DataRow format_row in format_dt.Rows)
                                {
                                    if (row_letter == format_row["COLUMN_LETTER"].ToString())
                                    {
                                        switch (format_row["SIGNAL_ID"].ToString())
                                        {

                                            case "1":

                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().IconSet(XLIconSetStyle.ThreeTrafficLights2)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 0, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 1, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number);
                                                break;

                                            case "2":

                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().IconSet(XLIconSetStyle.ThreeTrafficLights1)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 0, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 1, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number);
                                                break;

                                            case "3":
                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().DataBar(XLColor.Orange)
                                            .LowestValue()
                                            .HighestValue();
                                                break;

                                            case "4":

                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().ColorScale()
                                            .LowestValue(XLColor.Red)
                                            .Midpoint(XLCFContentType.Percent, 50, XLColor.Yellow)
                                            .HighestValue(XLColor.Green);
                                                break;

                                            case "5":

                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().IconSet(XLIconSetStyle.ThreeArrows)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 0, XLCFContentType.Number)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 1, XLCFContentType.Number)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number);
                                                break;

                                            case "6":
                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().IconSet(XLIconSetStyle.ThreeFlags)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 0, XLCFContentType.Number)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 1, XLCFContentType.Number)
                                                                   .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number);
                                                break;

                                            case "7":
                                                string data = ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value.ToString().ToUpper();
                                                switch(data)
                                                {
                                                    case "A":                                                     
                                                        ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = "0";
                                                        break;
                                                    case "B":
                                                        ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = "1";
                                                        break;
                                                    case "C":
                                                        ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = "100";
                                                        break;
                                                    case "D":
                                                        ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = "150";
                                                        break;
                                                }
                                                ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).AddConditionalFormat().IconSet(XLIconSetStyle.ThreeTrafficLights2)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 0, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 1, XLCFContentType.Number)
                                                                     .AddValue(XLCFIconSetOperator.EqualOrGreaterThan, 100, XLCFContentType.Number);                                             
                                                break;

                                        }


                                    }


                                }
                            }

                            if (rowValue.ToString().ToUpper().Contains("TOTAL"))
                            {
                                ws.Range(string.Format("{0}{2}:{1}{2}", GetExcelColumnName(valueCount),
                                                               GetExcelColumnName(ds.Tables[i].Columns.Count), rowIndex)).Style.Fill.BackgroundColor = XLColor.FromTheme(XLThemeColor.Accent1, 0.5);
                                ws.Range(string.Format("{0}{2}:{1}{2}", GetExcelColumnName(valueCount),
                                    GetExcelColumnName(ds.Tables[i].Columns.Count), rowIndex)).Style.Font.Bold = true;
                                ws.Range(string.Format("{0}{2}:{1}{2}", GetExcelColumnName(valueCount),
                                    GetExcelColumnName(ds.Tables[i].Columns.Count), rowIndex)).Style.Font.FontSize = 13;
                            }





                            valueCount++;
                        }

                        rowIndex++;
                    }
                }


                else
                {
                    foreach (DataRow Row in ds.Tables[i].Rows)
                    {
                        int valueCount = 1;
                        foreach (object rowValue in Row.ItemArray)
                        {
                            string row_letter = GetExcelColumnName(valueCount);
                            ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Value = rowValue;
                            ws.Cell(string.Format("{0}{1}", row_letter, rowIndex)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                            valueCount++;
                        }

                        rowIndex++;
                    }
                }



            }

            //Export the Excel file.
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=" + FILE_NAME + ".xlsx");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                wb.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }

        }
    }
    public static string GetExcelColumnName(int columnNumber)
    {
        int dividend = columnNumber;
        string columnName = String.Empty;
        int modulo;

        while (dividend > 0)
        {
            modulo = (dividend - 1) % 26;
            columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
            dividend = (int)((dividend - modulo) / 26);
        }

        return columnName;
    }
    protected void ImageButtonProcedure_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            if (ExportsListBox1.SelectedItems.Count <= 0)
            {
                Master.ShowMessage("Select an item to Refresh!");

            }
            else
            {
                string prc_name = WebTools.GetExpr("PROCEDURE_NAME", "IPMS_SYS_EXPORT", "EXPT_ID=" + ExportsListBox1.SelectedValue.ToString());
                if (prc_name.Length > 0)
                {
                    WebTools.ExecuteProcedure(prc_name);
                }
                Master.ShowSuccess("Refresh has been completed");
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    //protected void txtSearch_TextChanged(object sender, EventArgs e)
    //{
    //    txtSearch.Text = txtSearch.Text.ToUpper().Trim();
    //}
    protected void txtSearch_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        try
        {

            txtSearch.Text = txtSearch.Text.ToUpper().Trim();

            string expt_id = e.Value;

            string cat_id = WebTools.GetExpr("CAT_ID", "IPMS_SYS_EXPORT", "EXPT_ID=" + expt_id);
            string sub_cat_id = WebTools.GetExpr("SUB_CAT_ID", "IPMS_SYS_EXPORT", "EXPT_ID=" + expt_id);

            ExportCatList.SelectedValue = cat_id;
            ExportSubCatList.SelectedValue = sub_cat_id;
        }
        catch (Exception ex)
        {
            Master.ShowError("Please Select Report");
        }
    }
    protected void ExportsListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        HyperLinkPreview.NavigateUrl = "~/Home/FilterRdlc.aspx?ReportID=" + ExportsListBox1.SelectedValue.ToString();
    }

    public void NewSheetWiseExcelFile(string EXPT_ID, string FILE_NAME)
    {
        string constr = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        string table_query = "SELECT * FROM SHEET_WISE_DOWNLOAD WHERE EXPT_ID=" + EXPT_ID + " ORDER BY EXPT_ID,SEQ ";
        string query = "";
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
        List<BuildArgs> buildArgs = new List<BuildArgs>();
        using (ExcelPackage xp = new ExcelPackage())
        {
            DataTable table_dt = General_Functions.GetDataTable(table_query);
            DataSet ds = new DataSet();
            ds.Locale = CultureInfo.InvariantCulture;
            foreach (DataRow row in table_dt.Rows)
            {
                string sheet_user = WebTools.GetExpr("USER_ID", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                string user_where_query = WebTools.GetExpr("WHERE_QUERY", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                string fixed_query = WebTools.GetExpr("FIXED_QUERY", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                if (sheet_user.Length > 0)
                {
                    if (fixed_query.Length > 0)
                    {
                        if (user_where_query.IndexOf("WHERE") > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " " + user_where_query + " AND " + fixed_query;
                        }
                        else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + user_where_query + " AND " + fixed_query;

                        }
                        else
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + fixed_query;
                        }
                    }
                    else
                    {
                        if (user_where_query.IndexOf("WHERE") > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " " + user_where_query;
                        }
                        else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + user_where_query;

                        }
                        else
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"];
                        }
                    }


                }
                else
                {
                    query = "SELECT * FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                }

                string hide_query = WebTools.GetExpr("HIDE_COLUMN", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string total_query = WebTools.GetExpr("IS_TOTAL_REP", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string format_query = WebTools.GetExpr("IS_COLOR_FORMAT", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string prc_date = WebTools.GetExpr("PRC_END_DATE", "IPMS_SYS_EXPORT", "EXPT_ID=" + EXPT_ID);
                string APP_LOGO1 = WebTools.GetExpr("APP_LOGO1", "PROJECT_INFORMATION", "");
                string APP_LOGO2 = WebTools.GetExpr("APP_LOGO2", "PROJECT_INFORMATION", "");
                string CLIENT_NAME = WebTools.GetExpr("CLIENT_NAME", "PROJECT_INFORMATION", "");
                string PROJ_DESC = WebTools.GetExpr("PROJ_DESC", "PROJECT_INFORMATION", "");
                string merge_count = WebTools.CountExpr("expt_id", "SHEET_WISE_MERGE", "EXPT_ID=" + EXPT_ID);
                int month_from = int.Parse(WebTools.GetExpr("nvl(MONTH_FROM,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int month_to = int.Parse(WebTools.GetExpr("nvl(MONTH_TO,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int col_from = int.Parse(WebTools.GetExpr("nvl(COL_FROM,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int col_to = int.Parse(WebTools.GetExpr("nvl(COL_TO,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int GPyear = int.Parse(WebTools.GetExpr("nvl(GPYEAR,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int GPtotal = int.Parse(WebTools.GetExpr("nvl(GPTOTAL,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                string chart_id = WebTools.GetExpr("CHART_ID", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string col_position = WebTools.CountExpr("expt_id", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID);
                string main_grp_col = WebTools.GetExpr("COLUMN_NAME", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_MAIN_GROUP_COL)='Y' ");
                string sub_grp_col = WebTools.GetExpr("COLUMN_NAME", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ");
                string cell_merge_col = WebTools.GetExpr("CELL_MERGE_COL", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string cell_merge_range = WebTools.GetExpr("CELL_MERGE_RANGE", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                int sheet_model = int.Parse(WebTools.GetExpr("nvl(SHEET_MODEL,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int selection_report = int.Parse(WebTools.CountExpr("UNIQ", "SHEET_WISE_SELECTION", " EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"]));
                string is_group_merge = WebTools.GetExpr("IS_GROUP_MERGE", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string need_borders = WebTools.GetExpr("NEED_BORDERS", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);


                if (hide_query.Length > 0)
                {
                    DataTable dt = new DataTable();

                    OracleConnection hide_con = new OracleConnection(constr);
                    try
                    {

                        OracleCommand hide_cmd = new OracleCommand(query, hide_con);
                        hide_cmd.CommandType = CommandType.Text;
                        OracleDataAdapter hide_da = new OracleDataAdapter(hide_cmd);
                        hide_da.Fill(dt);
                    }
                    finally
                    {
                        hide_con.Close();
                    }
                    string new_query = "";
                    foreach (DataColumn column in dt.Columns)
                    {
                        new_query = new_query + column.ColumnName + ", ";

                    }

                    string[] hide_clumns = hide_query.Split(',');

                    foreach (string column in hide_clumns)
                    {
                        new_query = new_query.Replace(column + ", ", "");
                        string col = column;
                    }
                    new_query = new_query.Substring(0, new_query.Length - 2);
                    query = "SELECT " + new_query + " FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                }

                OracleConnection con = new OracleConnection(constr);
                try
                {
                    OracleCommand cmd = new OracleCommand(query, con);
                    OracleDataAdapter adapter = new OracleDataAdapter(cmd);

                    adapter.Fill(ds);
                }
                finally
                {
                    con.Close();
                }
                int i = Convert.ToInt32(row["SEQ"]) - 1;
                ds.Tables[i].TableName = row["REPORT_NAME"].ToString();
                string sheet_name = row["REPORT_NAME"].ToString();
                string notes = row["NOTES"].ToString();



                ExcelWorksheet ws = xp.Workbook.Worksheets.Add(sheet_name);
                System.Drawing.Image image = System.Drawing.Image.FromFile(@APP_LOGO1);
                var image1 = ws.Drawings.AddPicture("img", image);
                image1.SetPosition(0, 0, 0, 0);
                image1.SetSize(75);
                int colCnt = 0;

                int YearIndex = GPyear;
                int MonthFromIndex = month_from;
                int MonthToIndex = month_to;
                int colFromIndex = col_from;
                int colToIndex = col_to;
                int start_subtotal_col = 0;
                int end_subtotal_col = 0;

                int totalIndex = GPtotal;
                DataTable month_year_sort_dt = new DataTable();
                string month_year_sort = "";
                if (sheet_model >= 1)
                {
                    string where_text = "";
                    if (user_where_query.IndexOf("WHERE") > 0)
                    {
                        where_text = user_where_query;
                    }
                    else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                    {
                        where_text = " WHERE " + user_where_query;
                    }
                    else
                    {
                        where_text = row["TABLE_NAME"].ToString();
                    }
                    switch (sheet_model)
                    {
                        case 1:
                            month_year_sort = "SELECT DISTINCT MONTH_YEAR AS  MONTH_YEAR FROM " + row["TABLE_NAME"] + " " + where_text +
                                  " ORDER BY CASE WHEN Upper(month_year) LIKE '%DELIVERED%'" +
                                  "THEN To_Date('01-JAN-2015','DD-MON-YYYY') " +
                                  "WHEN Upper(month_year) LIKE '%MISSING%'  OR Upper(month_year) LIKE '%AWAITING%' " +
                                  "THEN  To_Date('01-JAN-2025','DD-MON-YYYY') ELSE To_Date(month_year,'mm/YY') END ";
                            break;
                        case 2:
                            month_year_sort = "SELECT DISTINCT ROWS_COLUMN AS  ROWS_COLUMN FROM " + row["TABLE_NAME"] + " " + where_text +
                                   " ORDER BY ROWS_COLUMN ";
                            break;

                    }

                    month_year_sort_dt = General_Functions.GetDataTable(month_year_sort);
                    MonthToIndex = MonthFromIndex + month_year_sort_dt.Rows.Count - 1;

                    totalIndex = MonthFromIndex + month_year_sort_dt.Rows.Count;
                }


                if (ds.Tables[i].Columns.Count <= 3)
                {
                    colCnt = 4;

                }
                else
                {

                    colCnt = ds.Tables[i].Columns.Count;
                }
                if (month_from > 0 || month_to > 0)
                {
                    colCnt = totalIndex;
                }
                var wsReportProjectHeaderRange = ws.Cells[1, 2, 1, colCnt];
                wsReportProjectHeaderRange.Style.Font.Bold = true;
                wsReportProjectHeaderRange.Merge = true;
                wsReportProjectHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Value = string.Format("Project: " + PROJ_DESC);

                var wsReportClientHeaderRange = ws.Cells[2, 2, 2, colCnt];
                wsReportClientHeaderRange.Style.Font.Bold = true;
                wsReportClientHeaderRange.Merge = true;
                wsReportClientHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Value = string.Format("Client : " + CLIENT_NAME);

                var wsReportDateHeaderRange = ws.Cells[3, 2, 3, colCnt];
                wsReportDateHeaderRange.Merge = true;
                wsReportDateHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Value = string.Format("Report Generated Date :{0}", DateTime.Now.ToString("dddd, dd MMMM yyyy h:mm tt"));
                wsReportDateHeaderRange.Style.Font.Color.SetColor(Color.Red);

                var rgex = new Regex("WHERE");
                var selec_str = "";
                if (sheet_user.Length > 0)
                {
                    selec_str = rgex.Replace(user_where_query.ToString(), "", 1);

                }
                else
                {
                    selec_str = rgex.Replace(row["WHERE_CONDITION"].ToString(), "", 1);
                }
                if (selection_report > 0)
                {
                    var wsRefreshDateHeaderRange = ws.Cells[4, 2, 4, colCnt];
                    wsRefreshDateHeaderRange.Merge = true;
                    wsRefreshDateHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Value = string.Format("Selection criteria :{0}", string.IsNullOrEmpty(selec_str) ? "Over All" : selec_str);
                    wsRefreshDateHeaderRange.Style.Font.Color.SetColor(Color.Red);
                }


                System.Drawing.Image image2 = System.Drawing.Image.FromFile(@APP_LOGO2);
                var image3 = ws.Drawings.AddPicture("img2", image2);
                image3.SetPosition(0, 0, colCnt, 0);
                image3.SetSize(25);


                if (int.Parse(merge_count) > 0)
                {
                    string merge_query = "SELECT * FROM SHEET_WISE_MERGE WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ ";

                    DataTable merge_dt = General_Functions.GetDataTable(merge_query);
                    foreach (DataRow merge_row in merge_dt.Rows)
                    {
                        var mergeRange = ws.Cells[string.Format("{0}", merge_row["MERGE_RANGE"])];
                        mergeRange.Merge = true;
                        mergeRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        mergeRange.Value = string.Format("{0}", merge_row["MERGE_VALUE"]);
                        mergeRange.Style.Font.Size = 11;
                        mergeRange.Style.Font.Bold = true;
                        mergeRange.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        mergeRange.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        mergeRange.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                    }
                }

                int rowstart = 5;
                int colstart = 1;
                int rowend = rowstart;
                int colend = colstart + colCnt - 1;

                ws.Cells[rowstart, colstart, rowend, colend].Merge = true;
                ws.Cells[rowstart, colstart, rowend, colend].Value = FILE_NAME + "( " + sheet_name + " )";
                ws.Cells[rowstart, colstart, rowend, colend].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Font.Bold = true;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);

                rowstart += 3;
                rowend = rowstart + ds.Tables[i].Rows.Count;
                if (row["IS_NOT_SUPP_OVERALL"].ToString() == "Y" && string.IsNullOrEmpty(selec_str))
                {
                    ws.Cells[8, 2, 10, colCnt].Merge = true;
                    ws.Cells[8, 2, 10, colCnt].Style.WrapText = true;
                    ws.Cells[8, 2, 10, colCnt].Value = "Sheet doesn't Support for over all Report.Please Select Any one Selection";
                    ws.Cells[8, 2, 10, colCnt].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    ws.Cells[8, 2, 10, colCnt].Style.Font.Bold = true;
                    ws.Cells[8, 2, 10, colCnt].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                    ws.Cells[8, 2, 10, colCnt].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);
                    ws.Cells[8, 2, 10, colCnt].Style.Font.Color.SetColor(Color.Red);

                }
                else
                {
                    var dynamicDt = new List<dynamic>();
                    List<string> columns1 = new List<string>();
                    List<string> sub_columns = new List<string>();

                    BuildClass.EqualityComparer<IDictionary<string, object>> equalityComparer = new BuildClass.EqualityComparer<IDictionary<string, object>>();


                    if (month_from > 0 || month_to > 0 || sub_grp_col.Length > 0)
                    {


                        string subTotalText = "S. Total";
                        var wb = xp.Workbook;
                        int rowIndex = rowstart;


                        foreach (DataRow Mrow in ds.Tables[i].Rows)
                        {
                            dynamic dyn = new ExpandoObject();
                            foreach (DataColumn column in ds.Tables[i].Columns)
                            {

                                var dic = (IDictionary<string, object>)dyn;
                                dic[column.ColumnName] = Mrow[column];
                            }
                            dynamicDt.Add(dyn);
                        }


                        string cus_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";

                        DataTable cus_dt = General_Functions.GetDataTable(cus_query);
                        foreach (DataRow cus_row in cus_dt.Rows)
                        {

                            ws.Cells[rowIndex, int.Parse(cus_row["COLUMN_POSITION"].ToString())].Value = string.Format("{0}", cus_row["CUSTOM_NAME"]);

                        }
                        if (sub_grp_col.Length == 0 || col_from != 0)
                        {
                            int SORTMonth = 1;
                            if (sheet_model >= 1)
                            {
                                foreach (DataRow month_year_sort_row in month_year_sort_dt.Rows)
                                {

                                    ws.Cells[rowstart, SORTMonth - 1 + month_from].Value = month_year_sort_row[0];
                                    SORTMonth++;
                                }
                            }
                            else
                            {
                                for (int month = 1; month <= 12; month++)
                                    ws.Cells[rowstart, month - 1 + month_from].Value = new DateTime(1900, month, 1).ToString("MMM", enUS);
                            }

                        }
                        if (total_query == "Y")
                        {
                            ws.Cells[rowstart, totalIndex].Value = "Total";
                        }

                        using (var cells = ws.Cells[rowstart, colstart, rowstart, totalIndex])
                        {
                            cells.Style.Font.Bold = true;
                            cells.Style.Font.Size = 11;
                            cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                        }

                        rowIndex++;
                        if (ds.Tables[i].Rows.Count > 0)
                        {
                            // MainGroup


                            string[] columns2 = main_grp_col.Split(',');
                            OracleConnection grp_conn = new OracleConnection(constr);
                            try
                            {
                                grp_conn.Open();
                                OracleCommand grp_cmd = new OracleCommand("SELECT COLUMN_NAME FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID
                                    + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ", grp_conn);
                                grp_cmd.CommandType = CommandType.Text;
                                OracleDataReader reader = grp_cmd.ExecuteReader();

                                while (reader.Read())
                                {
                                    columns1.Add(reader.GetValue(0).ToString());
                                }
                                reader.Close();
                            }
                            finally
                            {
                                grp_conn.Close();
                            }
                            OracleConnection sub_conn = new OracleConnection(constr);
                            try
                            {
                                sub_conn.Open();
                                OracleCommand sub_cmd = new OracleCommand("SELECT COLUMN_NAME FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID
                                    + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ", sub_conn);
                                sub_cmd.CommandType = CommandType.Text;
                                OracleDataReader reader = sub_cmd.ExecuteReader();

                                while (reader.Read())
                                {
                                    sub_columns.Add(reader.GetValue(0).ToString());
                                }
                                reader.Close();
                            }
                            finally
                            {
                                sub_conn.Close();
                            }

                            var groupedList = dynamicDt.GroupBy(x =>
                            {
                                var groupByColumns = new System.Dynamic.ExpandoObject();
                                ((IDictionary<string, object>)groupByColumns).Clear();
                                foreach (string column in columns1)

                                    ((IDictionary<string, object>)groupByColumns).Add(column, GetPropertyValue(x, column));

                                return groupByColumns;
                            }, equalityComparer);



                            int fromRowIndex = rowIndex;
                            string group_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable group_dt = General_Functions.GetDataTable(group_query);
                            string Subgroup_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable Subgroup_dt = General_Functions.GetDataTable(Subgroup_query);

                            string sum_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUM_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable sum_dt = General_Functions.GetDataTable(sum_query);
                            string count_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_COUNT_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable count_dt = General_Functions.GetDataTable(count_query);
                            string Dcount_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_DISTINCT_CNT_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable Dcount_dt = General_Functions.GetDataTable(Dcount_query);
                            List<string> HeaderColumnNames = new List<string>();
                            for (int h = 1; h <= ws.Dimension.End.Column; h++)
                            {
                                HeaderColumnNames.Add(ws.Cells[8, h].Value.ToString());

                            }
                            foreach (var MainGroup in groupedList)
                            {
                                int MainGroupFromRowIndex = rowIndex;

                                if (sub_grp_col.Length > 0)
                                {
                                    var SubgroupedList = MainGroup.GroupBy(x =>
                                    {
                                        var groupByColumns = new System.Dynamic.ExpandoObject();
                                        ((IDictionary<string, object>)groupByColumns).Clear();
                                        foreach (string column in sub_columns)

                                            ((IDictionary<string, object>)groupByColumns).Add(column, GetPropertyValue(x, column));

                                        return groupByColumns;
                                    }, equalityComparer);

                                    foreach (var Subgrouped in SubgroupedList)
                                    {

                                        foreach (DataRow grp_row in group_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];

                                        }
                                        foreach (DataRow Subgrp_row in Subgroup_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(Subgrp_row["COLUMN_POSITION"].ToString())].Value = Subgrouped.Key[string.Format("{0}", Subgrp_row["COLUMN_NAME"])];

                                        }

                                        foreach (DataRow sum_row in sum_dt.Rows)
                                        {
                                            decimal total = Subgrouped.Sum(item => (decimal)((IDictionary<string, object>)item)[sum_row["COLUMN_NAME"].ToString()]);
                                            //decimal? total = MainGroup.Select(x => x.ORDER_QTY).Cast<decimal?>().Sum();

                                            ws.Cells[rowIndex, int.Parse(sum_row["COLUMN_POSITION"].ToString())].Value = total;
                                        }
                                        foreach (DataRow count_row in count_dt.Rows)
                                        {
                                            int CntTotal = Subgrouped.Select(item => ((IDictionary<string, object>)item)[count_row["COLUMN_NAME"].ToString()]).Count();
                                            ws.Cells[rowIndex, int.Parse(count_row["COLUMN_POSITION"].ToString())].Value = CntTotal;
                                        }
                                        foreach (DataRow Dcount_row in Dcount_dt.Rows)
                                        {
                                            int CntTotal = Subgrouped.Select(item => ((IDictionary<string, object>)item)[Dcount_row["COLUMN_NAME"].ToString()]).Distinct().Count();


                                            ws.Cells[rowIndex, int.Parse(Dcount_row["COLUMN_POSITION"].ToString())].Value = CntTotal;
                                        }
                                        if (col_from > 0)
                                        {



                                            switch (sheet_model)
                                            {
                                                case 1:
                                                    // Month
                                                    ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;
                                                    var MonthGroups = Subgrouped.GroupBy(g => g.MONTH_YEAR);

                                                    //  OrderByDescending(g => g.Key.Year).ThenByDescending(g => g.Key.Month);  
                                                    foreach (var MonthGroup in MonthGroups)
                                                    {

                                                        int index = HeaderColumnNames.FindIndex(x => x == MonthGroup.Key);
                                                        decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                                        ws.Cells[rowIndex, index + 1].Value = total;


                                                    }
                                                    break;
                                                case 2:
                                                    // Month
                                                    ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;
                                                    var MonthGroups2 = Subgrouped.GroupBy(g => g.ROWS_COLUMN).OrderBy(g => g.Key);
                                                    //  OrderByDescending(g => g.Key.Year).ThenByDescending(g => g.Key.Month);  
                                                    foreach (var MonthGroup in MonthGroups2)
                                                    {
                                                        int index2 = HeaderColumnNames.FindIndex(x => x == MonthGroup.Key);
                                                        decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                                        ws.Cells[rowIndex, index2 + 1].Value = total;
                                                    }
                                                    break;

                                            }
                                        }

                                        if (total_query == "Y")
                                        {  // Total column
                                            ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                        }


                                        rowIndex++;
                                    }


                                }
                                else
                                {

                                    var YearGroups = MainGroup.GroupBy(g => g.GROUPDATE.Year).OrderByDescending(g => g.Key);
                                    foreach (var YearGroup in YearGroups)
                                    {

                                        foreach (DataRow grp_row in group_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];
                                        }

                                        ws.Cells[rowIndex, YearIndex].Value = YearGroup.Key;
                                        // Month
                                        ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;

                                        var MonthGroups = YearGroup.GroupBy(g => g.GROUPDATE.Month);
                                        foreach (var MonthGroup in MonthGroups)
                                        {
                                            int orderMonth = MonthGroup.Key;
                                            decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                            ws.Cells[rowIndex, orderMonth - 1 + MonthFromIndex].Value = total;
                                        }
                                        if (total_query == "Y")
                                        {
                                            // Total column
                                            ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));

                                        }

                                        rowIndex++;
                                    }
                                }

                                int MainGroupToRowIndex = rowIndex - 1;

                                if (col_from > 0)
                                {

                                    if (MonthFromIndex > colFromIndex)
                                    {
                                        start_subtotal_col = colFromIndex;
                                    }
                                    else
                                    {
                                        start_subtotal_col = MonthFromIndex;
                                    }
                                    if (MonthToIndex < colToIndex)
                                    {
                                        end_subtotal_col = colToIndex;
                                    }
                                    else
                                    {
                                        end_subtotal_col = MonthToIndex;
                                    }
                                }
                                foreach (DataRow grp_row in group_dt.Rows)
                                {



                                    // Main Group font color
                                    ws.Cells[MainGroupFromRowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString()), MainGroupToRowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Style.Font.Color.SetColor(Color.FromArgb(51, 51, 153));

                                    // Sub Total
                                    ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];


                                    ws.Cells[rowIndex, YearIndex].Value = subTotalText;

                                    if (col_from > 0)
                                    {
                                        for (int columnIndex = start_subtotal_col; columnIndex <= end_subtotal_col; columnIndex++)
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(MainGroupFromRowIndex, columnIndex, MainGroupToRowIndex, columnIndex));
                                        // cells format
                                        ws.Cells[MainGroupFromRowIndex, start_subtotal_col, MainGroupToRowIndex, totalIndex].Style.Numberformat.Format = fullNumberFormat;

                                        // Sub Total format
                                        ws.Cells[rowIndex, start_subtotal_col, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;
                                    }
                                    else
                                    {
                                        for (int columnIndex = MonthFromIndex; columnIndex <= MonthToIndex; columnIndex++)
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(MainGroupFromRowIndex, columnIndex, MainGroupToRowIndex, columnIndex));
                                        // cells format
                                        ws.Cells[MainGroupFromRowIndex, MonthFromIndex, MainGroupToRowIndex, totalIndex].Style.Numberformat.Format = fullNumberFormat;

                                        // Sub Total format
                                        ws.Cells[rowIndex, MonthFromIndex, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;
                                    }
                                    if (total_query == "Y")
                                    {
                                        ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                    }



                                    // Sub Total style
                                    using (var cells = ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString()), rowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                                    }
                                    if (is_group_merge.ToUpper() == "Y")
                                    {
                                        // merge cells 
                                        buildArgs.Add(new BuildArgs()
                                        {
                                            Action = BuildAction.Merge,
                                            Worksheet = ws,
                                            FromRow = MainGroupFromRowIndex,
                                            FromColumn = int.Parse(grp_row["COLUMN_POSITION"].ToString()),
                                            ToRow = rowIndex,
                                            ToColumn = int.Parse(grp_row["COLUMN_POSITION"].ToString())
                                        });
                                    }



                                }

                                rowIndex++;
                            }


                            int toRowIndex = rowIndex - 1;
                            int GrandTotalRow = rowIndex - 1;
                            // chart 1
                            var chart1 = new BuildChart()
                            {
                                Title = sheet_name,
                                Series = new List<BuildChartSerie>()
                            };

                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.ColumnClustered,
                                Worksheet = ws,
                                Chart = chart1
                            });

                            var chart2 = new BuildChart()
                            {
                                Title = sheet_name,
                                Series = new List<BuildChartSerie>()
                            };
                            // Main Sub Totals

                            var MaingroupedList = dynamicDt.GroupBy(x =>
                            {
                                var MaingroupByColumns = new System.Dynamic.ExpandoObject();
                                ((IDictionary<string, object>)MaingroupByColumns).Clear();
                                foreach (string column in columns2)

                                    ((IDictionary<string, object>)MaingroupByColumns).Add(column, GetPropertyValue(x, column));

                                return MaingroupByColumns;
                            }, equalityComparer);

                            string maingrp_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_MAIN_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ ";

                            DataTable mGrp_dt = General_Functions.GetDataTable(maingrp_query);
                            foreach (DataRow mGrp_row in mGrp_dt.Rows)
                            {

                                int mainNameFromRowIndex = rowIndex;
                                foreach (var MainNameGroup in MaingroupedList)
                                {
                                    ws.Cells[rowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())].Value = MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])] + " Total";


                                    if (col_from > 0)
                                    {
                                        for (int columnIndex = start_subtotal_col; columnIndex <= end_subtotal_col; columnIndex++)
                                        {
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUMIFS({0},{1},\"{2}\",{3},\"<>{4}\")",
                                                ExcelCellBase.GetAddress(fromRowIndex, columnIndex, toRowIndex, columnIndex),
                                                ExcelCellBase.GetAddress(fromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), toRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())),
                                                MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString().Replace("\"", "\"\""),
                                                ExcelCellBase.GetAddress(fromRowIndex, YearIndex, toRowIndex, YearIndex),
                                                subTotalText.Replace("\"", "\"\"")
                                            );
                                        }

                                    }
                                    else
                                    {
                                        for (int columnIndex = MonthFromIndex; columnIndex <= MonthToIndex; columnIndex++)
                                        {
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUMIFS({0},{1},\"{2}\",{3},\"<>{4}\")",
                                                ExcelCellBase.GetAddress(fromRowIndex, columnIndex, toRowIndex, columnIndex),
                                                ExcelCellBase.GetAddress(fromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), toRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())),
                                                MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString().Replace("\"", "\"\""),
                                                ExcelCellBase.GetAddress(fromRowIndex, YearIndex, toRowIndex, YearIndex),
                                                subTotalText.Replace("\"", "\"\"")
                                            );
                                        }

                                    }
                                    if (total_query == "Y")
                                    {
                                        ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                    }
                                    if (sub_grp_col.Length == 0)

                                    {
                                        // chart 1 MONTH series
                                        chart1.Series.Add(new BuildChartSerie()
                                        {
                                            Header = MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString(),
                                            SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex)),
                                            XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(rowstart, MonthFromIndex, rowstart, MonthToIndex))
                                        });
                                    }


                                    rowIndex++;
                                }


                                int mainNameToRowIndex = rowIndex - 1;
                                string chart_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_CHART_COL)='Y'  ORDER BY EXPT_ID,SEQ,COLUMN_POSITION ";

                                DataTable chart_dt = General_Functions.GetDataTable(chart_query);
                                foreach (DataRow chart_row in chart_dt.Rows)
                                {
                                    if (sub_grp_col.Length > 0)
                                    {
                                        // chart 1 series
                                        chart1.Series.Add(new BuildChartSerie()
                                        {
                                            Header = string.Format("{0}", chart_row["CUSTOM_NAME"]).ToString(),
                                            SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(chart_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(chart_row["COLUMN_POSITION"].ToString()))),
                                            XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())))
                                        });

                                    }
                                }

                                buildArgs.Add(new BuildArgs()
                                {
                                    Action = BuildAction.PieExploded3D,
                                    Worksheet = ws,
                                    Chart = chart2
                                });

                                // chart 2 series
                                chart2.Series.Add(new BuildChartSerie()
                                {
                                    SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, totalIndex, mainNameToRowIndex, totalIndex)),
                                    XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())))
                                });

                                if (col_from > 0)
                                {
                                    // Main Grp Sub Total format
                                    ws.Cells[mainNameFromRowIndex, start_subtotal_col, mainNameToRowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                                    //  Main Grp Sub Totals style
                                    using (var cells = ws.Cells[mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(255, 242, 204));
                                    }

                                }
                                else
                                {
                                    // Main Grp Sub Total format
                                    ws.Cells[mainNameFromRowIndex, MonthFromIndex, mainNameToRowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                                    //  Main Grp Sub Totals style
                                    using (var cells = ws.Cells[mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(255, 242, 204));
                                    }


                                }



                                // tab color
                                //ws.TabColor = Color.FromArgb(0, (territoryGroupIndex * greenStep), (territoryGroupIndex * blueStep) + 154);

                                // columns width
                                //for (int columnIndex = 1; columnIndex < int.Parse(mGrp_row["COLUMN_POSITION"].ToString()); columnIndex++)
                                //    ws.Column(columnIndex).Width = 2.5;
                                //ws.Column(int.Parse(mGrp_row["COLUMN_POSITION"].ToString())).Width=25; 

                                //ws.Column(YearIndex).Width = 19;
                                //for (int columnIndex = MonthFromIndex; columnIndex <= totalIndex; columnIndex++)
                                //    ws.Column(columnIndex).Width = 13.5;


                            }
                            // Grand Total
                            ws.Cells[rowIndex, colstart].Value = "Grand Total";
                            for (int columnIndex = MonthFromIndex; columnIndex <= totalIndex; columnIndex++)
                                ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(fromRowIndex, columnIndex, GrandTotalRow, columnIndex));

                            // Total format
                            ws.Cells[rowIndex, MonthFromIndex, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                            if (total_query == "Y")
                            {
                                ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                            }
                            // Total style
                            using (var cells = ws.Cells[rowIndex, colstart, rowIndex, totalIndex])
                            {
                                cells.Style.Font.Italic = true;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(221, 235, 247));
                            }


                            toRowIndex = rowIndex;

                            // cells horizontal alignment
                            ws.Cells[fromRowIndex, colstart, toRowIndex, colstart].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                            ws.Cells[fromRowIndex, YearIndex, toRowIndex, YearIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            ws.Cells[fromRowIndex, MonthFromIndex, toRowIndex, totalIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;

                            // cells borders
                            ws.View.ShowGridLines = false;
                            foreach (var cell in ws.Cells[fromRowIndex - 1, colstart, toRowIndex, totalIndex])
                            {
                                cell.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Top.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Bottom.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Left.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Right.Color.SetColor(Color.LightGray);
                            }
                            // Total style
                            using (var cells = ws.Cells[rowIndex, colstart, rowIndex, totalIndex])
                            {
                                cells.Style.Font.Italic = true;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(221, 235, 247));
                            }
                            // auto filter
                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.AutoFilter,
                                Worksheet = ws,
                                FromRow = rowstart,
                                FromColumn = colstart,
                                ToRow = toRowIndex,
                                ToColumn = totalIndex
                            });
                            // freeze pane
                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.FreezePanes,
                                Worksheet = ws,
                                FromRow = rowstart + 1,
                                FromColumn = MonthFromIndex
                            });
                            if (chart_id == "1")
                            {
                                // chart 1 position
                                chart1.Row = toRowIndex + 3;
                                chart1.RowOffsetPixels = 0;
                                chart1.Column = MonthFromIndex - 1;
                                chart1.ColumnOffsetPixels = 20;
                            }
                            if (chart_id == "2")
                            {
                                // chart 2 position
                                chart2.Row = toRowIndex + 3;
                                chart2.RowOffsetPixels = 0;
                                chart2.Column = MonthFromIndex + 1;
                                chart2.ColumnOffsetPixels = 20;
                            }
                            if (chart_id == "3")
                            {
                                chart1.Row = toRowIndex + 3;
                                chart1.RowOffsetPixels = 0;
                                chart1.Column = MonthFromIndex - 1;
                                chart1.ColumnOffsetPixels = 20;

                                chart2.Row = toRowIndex + 30;
                                chart2.RowOffsetPixels = 0;
                                chart2.Column = MonthFromIndex + 1;
                                chart2.ColumnOffsetPixels = 30;
                            }

                            if (chart_id == "1" || chart_id == "3")
                            {

                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.ColumnClustered && ba.Worksheet == ws))
                                {
                                    ExcelBarChart chart = args.Worksheet.Drawings.AddChart(sheet_name + args.Chart.Title.Replace(" ", string.Empty), eChartType.ColumnClustered) as ExcelBarChart;
                                    chart.SetSize(1100, 500);

                                    chart.Title.Text = args.Chart.Title;
                                    chart.Title.Font.Size = 18;
                                    chart.Title.Font.Bold = true;

                                    chart.Legend.Position = eLegendPosition.Bottom;

                                    chart.YAxis.Border.Fill.Style = eFillStyle.NoFill;

                                    //chart.YAxis.DisplayUnit = 1; 
                                    //chart.YAxis.Format = string.Format("{0};{1}", "#,##0 K", "(#,##0 K)");

                                    chart.YAxis.Font.Size = 9;

                                    chart.XAxis.MajorTickMark = eAxisTickMark.None;
                                    chart.XAxis.MinorTickMark = eAxisTickMark.None;

                                    chart.YAxis.MajorTickMark = eAxisTickMark.None;
                                    chart.YAxis.MinorTickMark = eAxisTickMark.None;

                                    // series
                                    foreach (var serie in args.Chart.Series)
                                        chart.Series.Add(serie.SerieAddress, serie.XSerieAddress).Header = serie.Header;

                                    // position
                                    chart.SetPosition(args.Chart.Row, args.Chart.RowOffsetPixels, args.Chart.Column, args.Chart.ColumnOffsetPixels);

                                    // data table
                                    chart.EnableChartDataTable(showLegendKeys: true);



                                }
                            }
                            if (chart_id == "2" || chart_id == "3")
                            {
                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.PieExploded3D && ba.Worksheet == ws))
                                {
                                    ExcelPieChart chart = args.Worksheet.Drawings.AddChart("pie" + sheet_name + args.Chart.Title.Replace(" ", string.Empty), eChartType.PieExploded3D) as ExcelPieChart;
                                    chart.SetSize(700, 500);

                                    chart.Title.Text = args.Chart.Title;
                                    chart.Title.Font.Size = 18;
                                    chart.Title.Font.Bold = true;

                                    chart.Legend.Remove();

                                    // series
                                    foreach (var serie in args.Chart.Series)
                                    {
                                        ExcelPieChartSerie pieChartSerie = chart.Series.Add(serie.SerieAddress, serie.XSerieAddress) as ExcelPieChartSerie;
                                        pieChartSerie.DataLabel.ShowCategory = true;
                                        pieChartSerie.DataLabel.ShowPercent = true;
                                        pieChartSerie.DataLabel.ShowLeaderLines = true;
                                        pieChartSerie.DataLabel.Position = eLabelPosition.OutEnd;
                                        pieChartSerie.Explosion = 10; // percent
                                    }

                                    // position
                                    chart.SetPosition(args.Chart.Row, args.Chart.RowOffsetPixels, args.Chart.Column, args.Chart.ColumnOffsetPixels);

                                    // shadow
                                    chart.Enable3DChartShadow(
                                        serieIndex: 0,
                                        red: 127, green: 96, blue: 0,
                                        sizePer: 90,
                                        blurPt: 8,
                                        distancePt: 25,
                                        angleDgr: 90,
                                        transparencyPer: 70
                                    );

                                    // material, bevel
                                    chart.Enable3DChartFormat(
                                        serieIndex: 0,
                                        material: BuildClass.EPPlusChartExtensions.PresetMaterialTypeValues.Metal,
                                        topBevelWidthPt: 10,
                                        topBevelHeightPt: 10,
                                        bottomBevelWidthPt: 10,
                                        bottomBevelHeightPt: 10
                                    );
                                }
                            }
                            if (is_group_merge.ToUpper() == "Y")
                            {
                                // merge cells
                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.Merge && ba.Worksheet == ws))
                                {
                                    using (var cells = args.Worksheet.Cells[args.FromRow, args.FromColumn, args.ToRow, args.ToColumn])
                                    {
                                        cells.Merge = true;
                                        cells.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                    }
                                }
                            }

                            // auto filter
                            foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.AutoFilter && ba.Worksheet == ws))
                            {
                                using (var autoFilterCells = args.Worksheet.Cells[args.FromRow, args.FromColumn, args.ToRow, args.ToColumn])
                                {
                                    autoFilterCells.AutoFilter = true;
                                }
                            }

                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);
                            ws.Column(totalIndex).Width = 20;
                        }

                    }


                    else
                    {
                        if (cell_merge_col.Length > 0)
                        {
                            const int startRow = 9;
                            int mergestarttrow = rowstart + 1;
                            int rw = startRow;
                            string RefNo = "";
                            //int TTLCONS = 0;

                            string[] mergedColNamed = cell_merge_col.Split(',');
                            //Dictionary<string, string> mergeRange = new Dictionary<string, string>()
                            //{{ "GROUPID", "A" },{ "TERRITORYGROUP", "B" }, { "TERRITORYNAME", "C" }, { "SALESPERSON", "D" }};
                            Dictionary<string, string> mergeRange = cell_merge_range
                                    .Split(';')
                                    .Select(part => part.Split('='))
                                    .Where(part => part.Length == 2)
                                    .ToDictionary(sp => sp[0], sp => sp[1]);
                            DataRow newBlankRow = ds.Tables[i].NewRow();
                            ds.Tables[i].Rows.InsertAt(newBlankRow, rowend);

                            if (ds.Tables[i].Rows.Count != 0)
                            {
                                foreach (DataRow sort_row in ds.Tables[i].Rows)
                                {
                                    bool needMerge = false;
                                    bool checkMerge = false;

                                    string CurrentRefNo = sort_row["GROUPID"].ToString();

                                    if (RefNo.Length > 0)
                                    {
                                        if (RefNo == CurrentRefNo)
                                        {
                                            checkMerge = true;
                                            mergeRange = cell_merge_range
                                            .Split(';')
                                            .Select(part => part.Split('='))
                                            .Where(part => part.Length == 2)
                                            .ToDictionary(sp => sp[0], sp => sp[1]);

                                        }
                                        else
                                        {
                                            mergestarttrow = rw;
                                            needMerge = true;
                                        }

                                    }

                                    int col = 1;

                                    if (rw > startRow)
                                        ws.InsertRow(rw, 1);

                                    if (needMerge)
                                    {
                                        for (int s = 0; s < mergedColNamed.Length; s++)
                                        {
                                            string MergeRangeValue = mergeRange.FirstOrDefault(x => x.Key == mergedColNamed[s]).Value;

                                            using (ExcelRange Rng = ws.Cells[MergeRangeValue])
                                            {
                                                if (MergeRangeValue.Length > 3)
                                                {
                                                    Rng.Merge = true;
                                                    ws.Cells[MergeRangeValue].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                                    ws.Cells[MergeRangeValue].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                                    Rng.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                                                    //if (mergedColNamed[s] == "GROUPTOTAL")
                                                    //{
                                                    //    Rng.Value = TTLCONS;
                                                    //    TTLCONS = 0;
                                                    //    //Rng.Style.Numberformat.Format = "0";
                                                    //}
                                                }


                                            }
                                        }
                                        mergeRange = cell_merge_range
                                        .Split(';')
                                        .Select(part => part.Split('='))
                                        .Where(part => part.Length == 2)
                                        .ToDictionary(sp => sp[0], sp => sp[1]);

                                    }

                                    foreach (DataColumn dc in ds.Tables[i].Columns)
                                    {
                                        if (mergedColNamed.Contains(dc.ColumnName.ToUpper()))
                                        {
                                            //if (dc.ColumnName.ToUpper() == "GROUPTOTAL")
                                            //    TTLCONS = TTLCONS + System.Convert.ToInt32(string.IsNullOrEmpty(sort_row[dc].ToString()) ? "0" : sort_row[dc]);

                                            if (!checkMerge)//First Row
                                            {
                                                if (dc.ColumnName.ToUpper() == "GROUPID")
                                                    RefNo = sort_row[dc].ToString();


                                                ws.Cells[rw, col].Value = sort_row[dc].ToString();
                                                ws.Cells[rw, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                                ws.Cells[rw, col].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                                ws.Cells[rw, col].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                                                //if (dc.ColumnName.ToUpper() == "GROUPTOTAL")
                                                //{
                                                //    ws.Cells[rw, col].Style.Numberformat.Format = "0";
                                                //}


                                            }
                                            else
                                            {
                                                string MergeRangeKey = mergeRange.FirstOrDefault(x => x.Value == mergeRange[dc.ColumnName.ToUpper()]).Key;
                                                string MergeRangeValue = mergeRange[dc.ColumnName.ToUpper()];
                                                mergeRange[MergeRangeKey] = string.Format(mergeRange[dc.ColumnName.ToUpper()] + "{0}:" + mergeRange[dc.ColumnName.ToUpper()] + "{1}", mergestarttrow, rw);
                                            }

                                        }
                                        else
                                        {
                                            ws.Cells[rw, col].Value = sort_row[dc].ToString();
                                            ws.Cells[rw, col].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                                        }
                                        col++;
                                    }
                                    rw++;
                                }
                            }
                            using (var cells = ws.Cells[rowstart, colstart, rowstart, colend])
                            {
                                cells.Style.Font.Bold = true;
                                cells.Style.Font.Size = 11;
                                cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                            }
                            int mj = 1;
                            foreach (DataColumn dc in ds.Tables[i].Columns)
                            {
                                ws.Cells[rowstart, mj, rowstart, colend].Value = dc.ColumnName.Replace("_", " ") + " :";

                                //if (dc.DataType == typeof(decimal))
                                //    ws.Column(j).Style.Numberformat.Format = "#0.00";
                                if (dc.DataType == typeof(System.DateTime))
                                {
                                    ws.Column(mj).Style.Numberformat.Format = "dd-MMM-yyyy";
                                }

                                mj++;
                            }
                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);
                            //for (int col = 1; col <= ws.Dimension.End.Column; col++)
                            //{
                            //    ws.Column(col).Width = ws.Column(col).Width + 1;
                            //}

                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Top.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Bottom.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Left.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            ws.DeleteRow(rowend + 1, ws.Dimension.End.Row - 1);
                        }

                        // Normal Export
                        ws.Cells[rowstart, colstart].LoadFromDataTable(ds.Tables[i], true);

                        using (var cells = ws.Cells[rowstart, colstart, rowstart, colend])
                        {
                            cells.Style.Font.Bold = true;
                            cells.Style.Font.Size = 11;
                            cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                        }
                        int j = 1;
                        foreach (DataColumn dc in ds.Tables[i].Columns)
                        {
                            ws.Cells[rowstart, j, rowstart, colend].Value = dc.ColumnName.Replace("_", " ") + " :";

                            if (dc.DataType == typeof(System.DateTime))
                            {
                                ws.Column(j).Style.Numberformat.Format = "dd-MMM-yyyy";
                            }

                            j++;
                        }
                        if (need_borders.ToUpper() == "Y")
                        {
                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);


                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Top.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Bottom.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Left.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;

                        }


                    }

                }

            }

            Response.AddHeader("content-disposition", "attachment;filename=" + FILE_NAME + ".xlsx");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.BinaryWrite(xp.GetAsByteArray());
            Response.End();

        }
    }

    public static string GetPropertyValue(object obj, string propertyName)
    {
        if (obj is ExpandoObject)
        {
            return ((ExpandoObject)obj).Single(e => e.Key == propertyName).Value.ToString();
        }
        Type type = obj.GetType();
        PropertyInfo pr = type.GetProperty(propertyName);
        return pr.GetValue(obj, null).ToString();
    }
    static string GetCellValueFromPossiblyMergedCell(ExcelWorksheet wks, int row, int col)
    {
        var cell = wks.Cells[row, col];
        if (cell.Merge)
        {
            var mergedId = wks.MergedCells[row, col];
            return wks.Cells[mergedId].First().Value.ToString();
        }
        else
        {
            return cell.Value.ToString();
        }
    }
    public void NewSheetWiseExcelFile_zip(string EXPT_ID, string FILE_NAME)
    {
        string path = WebTools.SessionDataPath();
        string excel_file = path + FILE_NAME + ".xlsx";
        string zip_file = path + FILE_NAME + ".zip";


        string constr = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
        string table_query = "SELECT * FROM SHEET_WISE_DOWNLOAD WHERE EXPT_ID=" + EXPT_ID + " ORDER BY EXPT_ID,SEQ ";
        string query = "";
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
        List<BuildArgs> buildArgs = new List<BuildArgs>();
        using (ExcelPackage xp = new ExcelPackage())
        {
            DataTable table_dt = General_Functions.GetDataTable(table_query);
            DataSet ds = new DataSet();
            ds.Locale = CultureInfo.InvariantCulture;
            foreach (DataRow row in table_dt.Rows)
            {
                string sheet_user = WebTools.GetExpr("USER_ID", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                string user_where_query = WebTools.GetExpr("WHERE_QUERY", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                string fixed_query = WebTools.GetExpr("FIXED_QUERY", "SHEET_WISE_DOWNLOAD_USER", "EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"] + " AND USER_ID=" + user_id);
                if (sheet_user.Length > 0)
                {
                    if (fixed_query.Length > 0)
                    {
                        if (user_where_query.IndexOf("WHERE") > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " " + user_where_query + " AND " + fixed_query;
                        }
                        else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + user_where_query + " AND " + fixed_query;

                        }
                        else
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + fixed_query;
                        }
                    }
                    else
                    {
                        if (user_where_query.IndexOf("WHERE") > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " " + user_where_query;
                        }
                        else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"] + " WHERE " + user_where_query;

                        }
                        else
                        {
                            query = "SELECT * FROM " + row["TABLE_NAME"];
                        }
                    }


                }
                else
                {
                    query = "SELECT * FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                }

                string hide_query = WebTools.GetExpr("HIDE_COLUMN", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string total_query = WebTools.GetExpr("IS_TOTAL_REP", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string format_query = WebTools.GetExpr("IS_COLOR_FORMAT", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string prc_date = WebTools.GetExpr("PRC_END_DATE", "IPMS_SYS_EXPORT", "EXPT_ID=" + EXPT_ID);
                string APP_LOGO1 = WebTools.GetExpr("APP_LOGO1", "PROJECT_INFORMATION", "");
                string APP_LOGO2 = WebTools.GetExpr("APP_LOGO2", "PROJECT_INFORMATION", "");
                string CLIENT_NAME = WebTools.GetExpr("CLIENT_NAME", "PROJECT_INFORMATION", "");
                string PROJ_DESC = WebTools.GetExpr("PROJ_DESC", "PROJECT_INFORMATION", "");
                string merge_count = WebTools.CountExpr("expt_id", "SHEET_WISE_MERGE", "EXPT_ID=" + EXPT_ID);
                int month_from = int.Parse(WebTools.GetExpr("nvl(MONTH_FROM,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int month_to = int.Parse(WebTools.GetExpr("nvl(MONTH_TO,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int col_from = int.Parse(WebTools.GetExpr("nvl(COL_FROM,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int col_to = int.Parse(WebTools.GetExpr("nvl(COL_TO,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int GPyear = int.Parse(WebTools.GetExpr("nvl(GPYEAR,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int GPtotal = int.Parse(WebTools.GetExpr("nvl(GPTOTAL,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                string chart_id = WebTools.GetExpr("CHART_ID", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string col_position = WebTools.CountExpr("expt_id", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID);
                string main_grp_col = WebTools.GetExpr("COLUMN_NAME", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_MAIN_GROUP_COL)='Y' ");
                string sub_grp_col = WebTools.GetExpr("COLUMN_NAME", "SHEET_WISE_COL_DATA", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ");
                string cell_merge_col = WebTools.GetExpr("CELL_MERGE_COL", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string cell_merge_range = WebTools.GetExpr("CELL_MERGE_RANGE", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                int sheet_model = int.Parse(WebTools.GetExpr("nvl(SHEET_MODEL,0)", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]));
                int selection_report = int.Parse(WebTools.CountExpr("UNIQ", "SHEET_WISE_SELECTION", " EXPT_ID=" + EXPT_ID + " AND SHEET_SEQ=" + row["SEQ"]));
                string is_group_merge = WebTools.GetExpr("IS_GROUP_MERGE", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);
                string need_borders = WebTools.GetExpr("NEED_BORDERS", "SHEET_WISE_DOWNLOAD", "EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"]);


                if (hide_query.Length > 0)
                {
                    DataTable dt = new DataTable();

                    OracleConnection hide_con = new OracleConnection(constr);
                    try
                    {

                        OracleCommand hide_cmd = new OracleCommand(query, hide_con);
                        hide_cmd.CommandType = CommandType.Text;
                        OracleDataAdapter hide_da = new OracleDataAdapter(hide_cmd);
                        hide_da.Fill(dt);
                    }
                    finally
                    {
                        hide_con.Close();
                    }
                    string new_query = "";
                    foreach (DataColumn column in dt.Columns)
                    {
                        new_query = new_query + column.ColumnName + ", ";

                    }

                    string[] hide_clumns = hide_query.Split(',');

                    foreach (string column in hide_clumns)
                    {
                        new_query = new_query.Replace(column + ", ", "");
                        string col = column;
                    }
                    new_query = new_query.Substring(0, new_query.Length - 2);
                    query = "SELECT " + new_query + " FROM " + row["TABLE_NAME"] + " " + row["WHERE_CONDITION"];
                }

                OracleConnection con = new OracleConnection(constr);
                try
                {
                    OracleCommand cmd = new OracleCommand(query, con);
                    OracleDataAdapter adapter = new OracleDataAdapter(cmd);

                    adapter.Fill(ds);
                }
                finally
                {
                    con.Close();
                }
                int i = Convert.ToInt32(row["SEQ"]) - 1;
                ds.Tables[i].TableName = row["REPORT_NAME"].ToString();
                string sheet_name = row["REPORT_NAME"].ToString();
                string notes = row["NOTES"].ToString();



                ExcelWorksheet ws = xp.Workbook.Worksheets.Add(sheet_name);
                System.Drawing.Image image = System.Drawing.Image.FromFile(@APP_LOGO1);
                var image1 = ws.Drawings.AddPicture("img", image);
                image1.SetPosition(0, 0, 0, 0);
                image1.SetSize(75);
                int colCnt = 0;

                int YearIndex = GPyear;
                int MonthFromIndex = month_from;
                int MonthToIndex = month_to;
                int colFromIndex = col_from;
                int colToIndex = col_to;
                int start_subtotal_col = 0;
                int end_subtotal_col = 0;

                int totalIndex = GPtotal;
                DataTable month_year_sort_dt = new DataTable();
                string month_year_sort = "";
                if (sheet_model >= 1)
                {
                    string where_text = "";
                    if (user_where_query.IndexOf("WHERE") > 0)
                    {
                        where_text = user_where_query;
                    }
                    else if (user_where_query.IndexOf("WHERE") <= 0 && user_where_query.Length > 0)
                    {
                        where_text = " WHERE " + user_where_query;
                    }
                    else
                    {
                        where_text = row["TABLE_NAME"].ToString();
                    }
                    switch (sheet_model)
                    {
                        case 1:
                            month_year_sort = "SELECT DISTINCT MONTH_YEAR AS  MONTH_YEAR FROM " + row["TABLE_NAME"] + " " + where_text +
                                  " ORDER BY CASE WHEN Upper(month_year) LIKE '%DELIVERED%'" +
                                  "THEN To_Date('01-JAN-2015','DD-MON-YYYY') " +
                                  "WHEN Upper(month_year) LIKE '%MISSING%'  OR Upper(month_year) LIKE '%AWAITING%' " +
                                  "THEN  To_Date('01-JAN-2025','DD-MON-YYYY') ELSE To_Date(month_year,'mm/YY') END ";
                            break;
                        case 2:
                            month_year_sort = "SELECT DISTINCT ROWS_COLUMN AS  ROWS_COLUMN FROM " + row["TABLE_NAME"] + " " + where_text +
                                   " ORDER BY ROWS_COLUMN ";
                            break;

                    }

                    month_year_sort_dt = General_Functions.GetDataTable(month_year_sort);
                    MonthToIndex = MonthFromIndex + month_year_sort_dt.Rows.Count - 1;

                    totalIndex = MonthFromIndex + month_year_sort_dt.Rows.Count;
                }


                if (ds.Tables[i].Columns.Count <= 3)
                {
                    colCnt = 4;

                }
                else
                {

                    colCnt = ds.Tables[i].Columns.Count;
                }
                if (month_from > 0 || month_to > 0)
                {
                    colCnt = totalIndex;
                }
                var wsReportProjectHeaderRange = ws.Cells[1, 2, 1, colCnt];
                wsReportProjectHeaderRange.Style.Font.Bold = true;
                wsReportProjectHeaderRange.Merge = true;
                wsReportProjectHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportProjectHeaderRange.Value = string.Format("Project: " + PROJ_DESC);

                var wsReportClientHeaderRange = ws.Cells[2, 2, 2, colCnt];
                wsReportClientHeaderRange.Style.Font.Bold = true;
                wsReportClientHeaderRange.Merge = true;
                wsReportClientHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportClientHeaderRange.Value = string.Format("Client : " + CLIENT_NAME);

                var wsReportDateHeaderRange = ws.Cells[3, 2, 3, colCnt];
                wsReportDateHeaderRange.Merge = true;
                wsReportDateHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                wsReportDateHeaderRange.Value = string.Format("Report Generated Date :{0}", DateTime.Now.ToString("dddd, dd MMMM yyyy h:mm tt"));
                wsReportDateHeaderRange.Style.Font.Color.SetColor(Color.Red);

                var rgex = new Regex("WHERE");
                var selec_str = "";
                if (sheet_user.Length > 0)
                {
                    selec_str = rgex.Replace(user_where_query.ToString(), "", 1);

                }
                else
                {
                    selec_str = rgex.Replace(row["WHERE_CONDITION"].ToString(), "", 1);
                }
                if (selection_report > 0)
                {
                    var wsRefreshDateHeaderRange = ws.Cells[4, 2, 4, colCnt];
                    wsRefreshDateHeaderRange.Merge = true;
                    wsRefreshDateHeaderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    wsRefreshDateHeaderRange.Value = string.Format("Selection criteria :{0}", string.IsNullOrEmpty(selec_str) ? "Over All" : selec_str);
                    wsRefreshDateHeaderRange.Style.Font.Color.SetColor(Color.Red);
                }


                System.Drawing.Image image2 = System.Drawing.Image.FromFile(@APP_LOGO2);
                var image3 = ws.Drawings.AddPicture("img2", image2);
                image3.SetPosition(0, 0, colCnt, 0);
                image3.SetSize(25);


                if (int.Parse(merge_count) > 0)
                {
                    string merge_query = "SELECT * FROM SHEET_WISE_MERGE WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ ";

                    DataTable merge_dt = General_Functions.GetDataTable(merge_query);
                    foreach (DataRow merge_row in merge_dt.Rows)
                    {
                        var mergeRange = ws.Cells[string.Format("{0}", merge_row["MERGE_RANGE"])];
                        mergeRange.Merge = true;
                        mergeRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        mergeRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        mergeRange.Value = string.Format("{0}", merge_row["MERGE_VALUE"]);
                        mergeRange.Style.Font.Size = 11;
                        mergeRange.Style.Font.Bold = true;
                        mergeRange.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        mergeRange.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        mergeRange.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                    }
                }

                int rowstart = 5;
                int colstart = 1;
                int rowend = rowstart;
                int colend = colstart + colCnt - 1;

                ws.Cells[rowstart, colstart, rowend, colend].Merge = true;
                ws.Cells[rowstart, colstart, rowend, colend].Value = FILE_NAME + "( " + sheet_name + " )";
                ws.Cells[rowstart, colstart, rowend, colend].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Font.Bold = true;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);

                rowstart += 3;
                rowend = rowstart + ds.Tables[i].Rows.Count;
                if (row["IS_NOT_SUPP_OVERALL"].ToString() == "Y" && string.IsNullOrEmpty(selec_str))
                {
                    ws.Cells[8, 2, 10, colCnt].Merge = true;
                    ws.Cells[8, 2, 10, colCnt].Style.WrapText = true;
                    ws.Cells[8, 2, 10, colCnt].Value = "Sheet doesn't Support for over all Report.Please Select Any one Selection";
                    ws.Cells[8, 2, 10, colCnt].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    ws.Cells[8, 2, 10, colCnt].Style.Font.Bold = true;
                    ws.Cells[8, 2, 10, colCnt].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                    ws.Cells[8, 2, 10, colCnt].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);
                    ws.Cells[8, 2, 10, colCnt].Style.Font.Color.SetColor(Color.Red);

                }
                else
                {
                    var dynamicDt = new List<dynamic>();
                    List<string> columns1 = new List<string>();
                    List<string> sub_columns = new List<string>();

                    BuildClass.EqualityComparer<IDictionary<string, object>> equalityComparer = new BuildClass.EqualityComparer<IDictionary<string, object>>();


                    if (month_from > 0 || month_to > 0 || sub_grp_col.Length > 0)
                    {


                        string subTotalText = "S. Total";
                        var wb = xp.Workbook;
                        int rowIndex = rowstart;


                        foreach (DataRow Mrow in ds.Tables[i].Rows)
                        {
                            dynamic dyn = new ExpandoObject();
                            foreach (DataColumn column in ds.Tables[i].Columns)
                            {

                                var dic = (IDictionary<string, object>)dyn;
                                dic[column.ColumnName] = Mrow[column];
                            }
                            dynamicDt.Add(dyn);
                        }


                        string cus_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";

                        DataTable cus_dt = General_Functions.GetDataTable(cus_query);
                        foreach (DataRow cus_row in cus_dt.Rows)
                        {

                            ws.Cells[rowIndex, int.Parse(cus_row["COLUMN_POSITION"].ToString())].Value = string.Format("{0}", cus_row["CUSTOM_NAME"]);

                        }
                        if (sub_grp_col.Length == 0 || col_from != 0)
                        {
                            int SORTMonth = 1;
                            if (sheet_model >= 1)
                            {
                                foreach (DataRow month_year_sort_row in month_year_sort_dt.Rows)
                                {

                                    ws.Cells[rowstart, SORTMonth - 1 + month_from].Value = month_year_sort_row[0];
                                    SORTMonth++;
                                }
                            }
                            else
                            {
                                for (int month = 1; month <= 12; month++)
                                    ws.Cells[rowstart, month - 1 + month_from].Value = new DateTime(1900, month, 1).ToString("MMM", enUS);
                            }

                        }
                        if (total_query == "Y")
                        {
                            ws.Cells[rowstart, totalIndex].Value = "Total";
                        }

                        using (var cells = ws.Cells[rowstart, colstart, rowstart, totalIndex])
                        {
                            cells.Style.Font.Bold = true;
                            cells.Style.Font.Size = 11;
                            cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                        }

                        rowIndex++;
                        if (ds.Tables[i].Rows.Count > 0)
                        {
                            // MainGroup


                            string[] columns2 = main_grp_col.Split(',');
                            OracleConnection grp_conn = new OracleConnection(constr);
                            try
                            {
                                grp_conn.Open();
                                OracleCommand grp_cmd = new OracleCommand("SELECT COLUMN_NAME FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID
                                    + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ", grp_conn);
                                grp_cmd.CommandType = CommandType.Text;
                                OracleDataReader reader = grp_cmd.ExecuteReader();

                                while (reader.Read())
                                {
                                    columns1.Add(reader.GetValue(0).ToString());
                                }
                                reader.Close();
                            }
                            finally
                            {
                                grp_conn.Close();
                            }
                            OracleConnection sub_conn = new OracleConnection(constr);
                            try
                            {
                                sub_conn.Open();
                                OracleCommand sub_cmd = new OracleCommand("SELECT COLUMN_NAME FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID
                                    + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ", sub_conn);
                                sub_cmd.CommandType = CommandType.Text;
                                OracleDataReader reader = sub_cmd.ExecuteReader();

                                while (reader.Read())
                                {
                                    sub_columns.Add(reader.GetValue(0).ToString());
                                }
                                reader.Close();
                            }
                            finally
                            {
                                sub_conn.Close();
                            }

                            var groupedList = dynamicDt.GroupBy(x =>
                            {
                                var groupByColumns = new System.Dynamic.ExpandoObject();
                                ((IDictionary<string, object>)groupByColumns).Clear();
                                foreach (string column in columns1)

                                    ((IDictionary<string, object>)groupByColumns).Add(column, GetPropertyValue(x, column));

                                return groupByColumns;
                            }, equalityComparer);



                            int fromRowIndex = rowIndex;
                            string group_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable group_dt = General_Functions.GetDataTable(group_query);
                            string Subgroup_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUB_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable Subgroup_dt = General_Functions.GetDataTable(Subgroup_query);

                            string sum_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_SUM_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable sum_dt = General_Functions.GetDataTable(sum_query);
                            string count_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_COUNT_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable count_dt = General_Functions.GetDataTable(count_query);
                            string Dcount_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_DISTINCT_CNT_COL)='Y' ORDER BY EXPT_ID,SEQ,COLUMN_POSITION  ";
                            DataTable Dcount_dt = General_Functions.GetDataTable(Dcount_query);
                            List<string> HeaderColumnNames = new List<string>();
                            for (int h = 1; h <= ws.Dimension.End.Column; h++)
                            {
                                HeaderColumnNames.Add(ws.Cells[8, h].Value.ToString());

                            }
                            foreach (var MainGroup in groupedList)
                            {
                                int MainGroupFromRowIndex = rowIndex;

                                if (sub_grp_col.Length > 0)
                                {
                                    var SubgroupedList = MainGroup.GroupBy(x =>
                                    {
                                        var groupByColumns = new System.Dynamic.ExpandoObject();
                                        ((IDictionary<string, object>)groupByColumns).Clear();
                                        foreach (string column in sub_columns)

                                            ((IDictionary<string, object>)groupByColumns).Add(column, GetPropertyValue(x, column));

                                        return groupByColumns;
                                    }, equalityComparer);

                                    foreach (var Subgrouped in SubgroupedList)
                                    {

                                        foreach (DataRow grp_row in group_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];

                                        }
                                        foreach (DataRow Subgrp_row in Subgroup_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(Subgrp_row["COLUMN_POSITION"].ToString())].Value = Subgrouped.Key[string.Format("{0}", Subgrp_row["COLUMN_NAME"])];

                                        }

                                        foreach (DataRow sum_row in sum_dt.Rows)
                                        {
                                            decimal total = Subgrouped.Sum(item => (decimal)((IDictionary<string, object>)item)[sum_row["COLUMN_NAME"].ToString()]);
                                            //decimal? total = MainGroup.Select(x => x.ORDER_QTY).Cast<decimal?>().Sum();

                                            ws.Cells[rowIndex, int.Parse(sum_row["COLUMN_POSITION"].ToString())].Value = total;
                                        }
                                        foreach (DataRow count_row in count_dt.Rows)
                                        {
                                            int CntTotal = Subgrouped.Select(item => ((IDictionary<string, object>)item)[count_row["COLUMN_NAME"].ToString()]).Count();
                                            ws.Cells[rowIndex, int.Parse(count_row["COLUMN_POSITION"].ToString())].Value = CntTotal;
                                        }
                                        foreach (DataRow Dcount_row in Dcount_dt.Rows)
                                        {
                                            int CntTotal = Subgrouped.Select(item => ((IDictionary<string, object>)item)[Dcount_row["COLUMN_NAME"].ToString()]).Distinct().Count();


                                            ws.Cells[rowIndex, int.Parse(Dcount_row["COLUMN_POSITION"].ToString())].Value = CntTotal;
                                        }
                                        if (col_from > 0)
                                        {



                                            switch (sheet_model)
                                            {
                                                case 1:
                                                    // Month
                                                    ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;
                                                    var MonthGroups = Subgrouped.GroupBy(g => g.MONTH_YEAR);

                                                    //  OrderByDescending(g => g.Key.Year).ThenByDescending(g => g.Key.Month);  
                                                    foreach (var MonthGroup in MonthGroups)
                                                    {

                                                        int index = HeaderColumnNames.FindIndex(x => x == MonthGroup.Key);
                                                        decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                                        ws.Cells[rowIndex, index + 1].Value = total;


                                                    }
                                                    break;
                                                case 2:
                                                    // Month
                                                    ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;
                                                    var MonthGroups2 = Subgrouped.GroupBy(g => g.ROWS_COLUMN).OrderBy(g => g.Key);
                                                    //  OrderByDescending(g => g.Key.Year).ThenByDescending(g => g.Key.Month);  
                                                    foreach (var MonthGroup in MonthGroups2)
                                                    {
                                                        int index2 = HeaderColumnNames.FindIndex(x => x == MonthGroup.Key);
                                                        decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                                        ws.Cells[rowIndex, index2 + 1].Value = total;
                                                    }
                                                    break;

                                            }
                                        }

                                        if (total_query == "Y")
                                        {  // Total column
                                            ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                        }


                                        rowIndex++;
                                    }


                                }
                                else
                                {

                                    var YearGroups = MainGroup.GroupBy(g => g.GROUPDATE.Year).OrderByDescending(g => g.Key);
                                    foreach (var YearGroup in YearGroups)
                                    {

                                        foreach (DataRow grp_row in group_dt.Rows)
                                        {

                                            ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];
                                        }

                                        ws.Cells[rowIndex, YearIndex].Value = YearGroup.Key;
                                        // Month
                                        ws.Cells[rowIndex, MonthFromIndex, rowIndex, MonthToIndex].Value = 0;

                                        var MonthGroups = YearGroup.GroupBy(g => g.GROUPDATE.Month);
                                        foreach (var MonthGroup in MonthGroups)
                                        {
                                            int orderMonth = MonthGroup.Key;
                                            decimal? total = MonthGroup.Select(x => x.GROUPTOTAL).Cast<decimal?>().Sum();
                                            ws.Cells[rowIndex, orderMonth - 1 + MonthFromIndex].Value = total;
                                        }
                                        if (total_query == "Y")
                                        {
                                            // Total column
                                            ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));

                                        }

                                        rowIndex++;
                                    }
                                }

                                int MainGroupToRowIndex = rowIndex - 1;

                                if (col_from > 0)
                                {

                                    if (MonthFromIndex > colFromIndex)
                                    {
                                        start_subtotal_col = colFromIndex;
                                    }
                                    else
                                    {
                                        start_subtotal_col = MonthFromIndex;
                                    }
                                    if (MonthToIndex < colToIndex)
                                    {
                                        end_subtotal_col = colToIndex;
                                    }
                                    else
                                    {
                                        end_subtotal_col = MonthToIndex;
                                    }
                                }
                                foreach (DataRow grp_row in group_dt.Rows)
                                {



                                    // Main Group font color
                                    ws.Cells[MainGroupFromRowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString()), MainGroupToRowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Style.Font.Color.SetColor(Color.FromArgb(51, 51, 153));

                                    // Sub Total
                                    ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString())].Value = MainGroup.Key[string.Format("{0}", grp_row["COLUMN_NAME"])];


                                    ws.Cells[rowIndex, YearIndex].Value = subTotalText;

                                    if (col_from > 0)
                                    {
                                        for (int columnIndex = start_subtotal_col; columnIndex <= end_subtotal_col; columnIndex++)
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(MainGroupFromRowIndex, columnIndex, MainGroupToRowIndex, columnIndex));
                                        // cells format
                                        ws.Cells[MainGroupFromRowIndex, start_subtotal_col, MainGroupToRowIndex, totalIndex].Style.Numberformat.Format = fullNumberFormat;

                                        // Sub Total format
                                        ws.Cells[rowIndex, start_subtotal_col, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;
                                    }
                                    else
                                    {
                                        for (int columnIndex = MonthFromIndex; columnIndex <= MonthToIndex; columnIndex++)
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(MainGroupFromRowIndex, columnIndex, MainGroupToRowIndex, columnIndex));
                                        // cells format
                                        ws.Cells[MainGroupFromRowIndex, MonthFromIndex, MainGroupToRowIndex, totalIndex].Style.Numberformat.Format = fullNumberFormat;

                                        // Sub Total format
                                        ws.Cells[rowIndex, MonthFromIndex, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;
                                    }
                                    if (total_query == "Y")
                                    {
                                        ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                    }



                                    // Sub Total style
                                    using (var cells = ws.Cells[rowIndex, int.Parse(grp_row["COLUMN_POSITION"].ToString()), rowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                                    }
                                    if (is_group_merge.ToUpper() == "Y")
                                    {
                                        // merge cells 
                                        buildArgs.Add(new BuildArgs()
                                        {
                                            Action = BuildAction.Merge,
                                            Worksheet = ws,
                                            FromRow = MainGroupFromRowIndex,
                                            FromColumn = int.Parse(grp_row["COLUMN_POSITION"].ToString()),
                                            ToRow = rowIndex,
                                            ToColumn = int.Parse(grp_row["COLUMN_POSITION"].ToString())
                                        });
                                    }



                                }

                                rowIndex++;
                            }


                            int toRowIndex = rowIndex - 1;
                            int GrandTotalRow = rowIndex - 1;
                            // chart 1
                            var chart1 = new BuildChart()
                            {
                                Title = sheet_name,
                                Series = new List<BuildChartSerie>()
                            };

                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.ColumnClustered,
                                Worksheet = ws,
                                Chart = chart1
                            });

                            var chart2 = new BuildChart()
                            {
                                Title = sheet_name,
                                Series = new List<BuildChartSerie>()
                            };
                            // Main Sub Totals

                            var MaingroupedList = dynamicDt.GroupBy(x =>
                            {
                                var MaingroupByColumns = new System.Dynamic.ExpandoObject();
                                ((IDictionary<string, object>)MaingroupByColumns).Clear();
                                foreach (string column in columns2)

                                    ((IDictionary<string, object>)MaingroupByColumns).Add(column, GetPropertyValue(x, column));

                                return MaingroupByColumns;
                            }, equalityComparer);

                            string maingrp_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_MAIN_GROUP_COL)='Y' ORDER BY EXPT_ID,SEQ ";

                            DataTable mGrp_dt = General_Functions.GetDataTable(maingrp_query);
                            foreach (DataRow mGrp_row in mGrp_dt.Rows)
                            {

                                int mainNameFromRowIndex = rowIndex;
                                foreach (var MainNameGroup in MaingroupedList)
                                {
                                    ws.Cells[rowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())].Value = MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])] + " Total";


                                    if (col_from > 0)
                                    {
                                        for (int columnIndex = start_subtotal_col; columnIndex <= end_subtotal_col; columnIndex++)
                                        {
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUMIFS({0},{1},\"{2}\",{3},\"<>{4}\")",
                                                ExcelCellBase.GetAddress(fromRowIndex, columnIndex, toRowIndex, columnIndex),
                                                ExcelCellBase.GetAddress(fromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), toRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())),
                                                MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString().Replace("\"", "\"\""),
                                                ExcelCellBase.GetAddress(fromRowIndex, YearIndex, toRowIndex, YearIndex),
                                                subTotalText.Replace("\"", "\"\"")
                                            );
                                        }

                                    }
                                    else
                                    {
                                        for (int columnIndex = MonthFromIndex; columnIndex <= MonthToIndex; columnIndex++)
                                        {
                                            ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUMIFS({0},{1},\"{2}\",{3},\"<>{4}\")",
                                                ExcelCellBase.GetAddress(fromRowIndex, columnIndex, toRowIndex, columnIndex),
                                                ExcelCellBase.GetAddress(fromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), toRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())),
                                                MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString().Replace("\"", "\"\""),
                                                ExcelCellBase.GetAddress(fromRowIndex, YearIndex, toRowIndex, YearIndex),
                                                subTotalText.Replace("\"", "\"\"")
                                            );
                                        }

                                    }
                                    if (total_query == "Y")
                                    {
                                        ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                                    }
                                    if (sub_grp_col.Length == 0)

                                    {
                                        // chart 1 MONTH series
                                        chart1.Series.Add(new BuildChartSerie()
                                        {
                                            Header = MainNameGroup.Key[string.Format("{0}", mGrp_row["COLUMN_NAME"])].ToString(),
                                            SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex)),
                                            XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(rowstart, MonthFromIndex, rowstart, MonthToIndex))
                                        });
                                    }


                                    rowIndex++;
                                }


                                int mainNameToRowIndex = rowIndex - 1;
                                string chart_query = "SELECT * FROM SHEET_WISE_COL_DATA WHERE EXPT_ID=" + EXPT_ID + " AND SEQ=" + row["SEQ"] + " AND UPPER(IS_CHART_COL)='Y'  ORDER BY EXPT_ID,SEQ,COLUMN_POSITION ";

                                DataTable chart_dt = General_Functions.GetDataTable(chart_query);
                                foreach (DataRow chart_row in chart_dt.Rows)
                                {
                                    if (sub_grp_col.Length > 0)
                                    {
                                        // chart 1 series
                                        chart1.Series.Add(new BuildChartSerie()
                                        {
                                            Header = string.Format("{0}", chart_row["CUSTOM_NAME"]).ToString(),
                                            SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(chart_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(chart_row["COLUMN_POSITION"].ToString()))),
                                            XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())))
                                        });

                                    }
                                }

                                buildArgs.Add(new BuildArgs()
                                {
                                    Action = BuildAction.PieExploded3D,
                                    Worksheet = ws,
                                    Chart = chart2
                                });

                                // chart 2 series
                                chart2.Series.Add(new BuildChartSerie()
                                {
                                    SerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, totalIndex, mainNameToRowIndex, totalIndex)),
                                    XSerieAddress = ExcelCellBase.GetFullAddress(ws.Name, ExcelCellBase.GetAddress(mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString())))
                                });

                                if (col_from > 0)
                                {
                                    // Main Grp Sub Total format
                                    ws.Cells[mainNameFromRowIndex, start_subtotal_col, mainNameToRowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                                    //  Main Grp Sub Totals style
                                    using (var cells = ws.Cells[mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(255, 242, 204));
                                    }

                                }
                                else
                                {
                                    // Main Grp Sub Total format
                                    ws.Cells[mainNameFromRowIndex, MonthFromIndex, mainNameToRowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                                    //  Main Grp Sub Totals style
                                    using (var cells = ws.Cells[mainNameFromRowIndex, int.Parse(mGrp_row["COLUMN_POSITION"].ToString()), mainNameToRowIndex, totalIndex])
                                    {
                                        cells.Style.Font.Italic = true;
                                        cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                        cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(255, 242, 204));
                                    }


                                }



                                // tab color
                                //ws.TabColor = Color.FromArgb(0, (territoryGroupIndex * greenStep), (territoryGroupIndex * blueStep) + 154);

                                // columns width
                                //for (int columnIndex = 1; columnIndex < int.Parse(mGrp_row["COLUMN_POSITION"].ToString()); columnIndex++)
                                //    ws.Column(columnIndex).Width = 2.5;
                                //ws.Column(int.Parse(mGrp_row["COLUMN_POSITION"].ToString())).Width=25; 

                                //ws.Column(YearIndex).Width = 19;
                                //for (int columnIndex = MonthFromIndex; columnIndex <= totalIndex; columnIndex++)
                                //    ws.Column(columnIndex).Width = 13.5;


                            }
                            // Grand Total
                            ws.Cells[rowIndex, colstart].Value = "Grand Total";
                            for (int columnIndex = MonthFromIndex; columnIndex <= totalIndex; columnIndex++)
                                ws.Cells[rowIndex, columnIndex].Formula = string.Format("SUBTOTAL(9,{0})", ExcelCellBase.GetAddress(fromRowIndex, columnIndex, GrandTotalRow, columnIndex));

                            // Total format
                            ws.Cells[rowIndex, MonthFromIndex, rowIndex, totalIndex].Style.Numberformat.Format = numberFormat;

                            if (total_query == "Y")
                            {
                                ws.Cells[rowIndex, totalIndex].Formula = string.Format("SUM({0})", ExcelCellBase.GetAddress(rowIndex, MonthFromIndex, rowIndex, MonthToIndex));
                            }
                            // Total style
                            using (var cells = ws.Cells[rowIndex, colstart, rowIndex, totalIndex])
                            {
                                cells.Style.Font.Italic = true;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(221, 235, 247));
                            }


                            toRowIndex = rowIndex;

                            // cells horizontal alignment
                            ws.Cells[fromRowIndex, colstart, toRowIndex, colstart].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                            ws.Cells[fromRowIndex, YearIndex, toRowIndex, YearIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            ws.Cells[fromRowIndex, MonthFromIndex, toRowIndex, totalIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;

                            // cells borders
                            ws.View.ShowGridLines = false;
                            foreach (var cell in ws.Cells[fromRowIndex - 1, colstart, toRowIndex, totalIndex])
                            {
                                cell.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                cell.Style.Border.Top.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Bottom.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Left.Color.SetColor(Color.LightGray);
                                cell.Style.Border.Right.Color.SetColor(Color.LightGray);
                            }
                            // Total style
                            using (var cells = ws.Cells[rowIndex, colstart, rowIndex, totalIndex])
                            {
                                cells.Style.Font.Italic = true;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(221, 235, 247));
                            }
                            // auto filter
                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.AutoFilter,
                                Worksheet = ws,
                                FromRow = rowstart,
                                FromColumn = colstart,
                                ToRow = toRowIndex,
                                ToColumn = totalIndex
                            });
                            // freeze pane
                            buildArgs.Add(new BuildArgs()
                            {
                                Action = BuildAction.FreezePanes,
                                Worksheet = ws,
                                FromRow = rowstart + 1,
                                FromColumn = MonthFromIndex
                            });
                            if (chart_id == "1")
                            {
                                // chart 1 position
                                chart1.Row = toRowIndex + 3;
                                chart1.RowOffsetPixels = 0;
                                chart1.Column = MonthFromIndex - 1;
                                chart1.ColumnOffsetPixels = 20;
                            }
                            if (chart_id == "2")
                            {
                                // chart 2 position
                                chart2.Row = toRowIndex + 3;
                                chart2.RowOffsetPixels = 0;
                                chart2.Column = MonthFromIndex + 1;
                                chart2.ColumnOffsetPixels = 20;
                            }
                            if (chart_id == "3")
                            {
                                chart1.Row = toRowIndex + 3;
                                chart1.RowOffsetPixels = 0;
                                chart1.Column = MonthFromIndex - 1;
                                chart1.ColumnOffsetPixels = 20;

                                chart2.Row = toRowIndex + 30;
                                chart2.RowOffsetPixels = 0;
                                chart2.Column = MonthFromIndex + 1;
                                chart2.ColumnOffsetPixels = 30;
                            }

                            if (chart_id == "1" || chart_id == "3")
                            {

                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.ColumnClustered && ba.Worksheet == ws))
                                {
                                    ExcelBarChart chart = args.Worksheet.Drawings.AddChart(sheet_name + args.Chart.Title.Replace(" ", string.Empty), eChartType.ColumnClustered) as ExcelBarChart;
                                    chart.SetSize(1100, 500);

                                    chart.Title.Text = args.Chart.Title;
                                    chart.Title.Font.Size = 18;
                                    chart.Title.Font.Bold = true;

                                    chart.Legend.Position = eLegendPosition.Bottom;

                                    chart.YAxis.Border.Fill.Style = eFillStyle.NoFill;

                                    //chart.YAxis.DisplayUnit = 1; 
                                    //chart.YAxis.Format = string.Format("{0};{1}", "#,##0 K", "(#,##0 K)");

                                    chart.YAxis.Font.Size = 9;

                                    chart.XAxis.MajorTickMark = eAxisTickMark.None;
                                    chart.XAxis.MinorTickMark = eAxisTickMark.None;

                                    chart.YAxis.MajorTickMark = eAxisTickMark.None;
                                    chart.YAxis.MinorTickMark = eAxisTickMark.None;

                                    // series
                                    foreach (var serie in args.Chart.Series)
                                        chart.Series.Add(serie.SerieAddress, serie.XSerieAddress).Header = serie.Header;

                                    // position
                                    chart.SetPosition(args.Chart.Row, args.Chart.RowOffsetPixels, args.Chart.Column, args.Chart.ColumnOffsetPixels);

                                    // data table
                                    chart.EnableChartDataTable(showLegendKeys: true);



                                }
                            }
                            if (chart_id == "2" || chart_id == "3")
                            {
                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.PieExploded3D && ba.Worksheet == ws))
                                {
                                    ExcelPieChart chart = args.Worksheet.Drawings.AddChart("pie" + sheet_name + args.Chart.Title.Replace(" ", string.Empty), eChartType.PieExploded3D) as ExcelPieChart;
                                    chart.SetSize(700, 500);

                                    chart.Title.Text = args.Chart.Title;
                                    chart.Title.Font.Size = 18;
                                    chart.Title.Font.Bold = true;

                                    chart.Legend.Remove();

                                    // series
                                    foreach (var serie in args.Chart.Series)
                                    {
                                        ExcelPieChartSerie pieChartSerie = chart.Series.Add(serie.SerieAddress, serie.XSerieAddress) as ExcelPieChartSerie;
                                        pieChartSerie.DataLabel.ShowCategory = true;
                                        pieChartSerie.DataLabel.ShowPercent = true;
                                        pieChartSerie.DataLabel.ShowLeaderLines = true;
                                        pieChartSerie.DataLabel.Position = eLabelPosition.OutEnd;
                                        pieChartSerie.Explosion = 10; // percent
                                    }

                                    // position
                                    chart.SetPosition(args.Chart.Row, args.Chart.RowOffsetPixels, args.Chart.Column, args.Chart.ColumnOffsetPixels);

                                    // shadow
                                    chart.Enable3DChartShadow(
                                        serieIndex: 0,
                                        red: 127, green: 96, blue: 0,
                                        sizePer: 90,
                                        blurPt: 8,
                                        distancePt: 25,
                                        angleDgr: 90,
                                        transparencyPer: 70
                                    );

                                    // material, bevel
                                    chart.Enable3DChartFormat(
                                        serieIndex: 0,
                                        material: BuildClass.EPPlusChartExtensions.PresetMaterialTypeValues.Metal,
                                        topBevelWidthPt: 10,
                                        topBevelHeightPt: 10,
                                        bottomBevelWidthPt: 10,
                                        bottomBevelHeightPt: 10
                                    );
                                }
                            }
                            if (is_group_merge.ToUpper() == "Y")
                            {
                                // merge cells
                                foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.Merge && ba.Worksheet == ws))
                                {
                                    using (var cells = args.Worksheet.Cells[args.FromRow, args.FromColumn, args.ToRow, args.ToColumn])
                                    {
                                        cells.Merge = true;
                                        cells.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                    }
                                }
                            }

                            // auto filter
                            foreach (var args in buildArgs.Where(ba => ba.Action == BuildAction.AutoFilter && ba.Worksheet == ws))
                            {
                                using (var autoFilterCells = args.Worksheet.Cells[args.FromRow, args.FromColumn, args.ToRow, args.ToColumn])
                                {
                                    autoFilterCells.AutoFilter = true;
                                }
                            }

                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);
                            ws.Column(totalIndex).Width = 20;
                        }

                    }


                    else
                    {
                        if (cell_merge_col.Length > 0)
                        {
                            const int startRow = 9;
                            int mergestarttrow = rowstart + 1;
                            int rw = startRow;
                            string RefNo = "";
                            //int TTLCONS = 0;

                            string[] mergedColNamed = cell_merge_col.Split(',');
                            //Dictionary<string, string> mergeRange = new Dictionary<string, string>()
                            //{{ "GROUPID", "A" },{ "TERRITORYGROUP", "B" }, { "TERRITORYNAME", "C" }, { "SALESPERSON", "D" }};
                            Dictionary<string, string> mergeRange = cell_merge_range
                                    .Split(';')
                                    .Select(part => part.Split('='))
                                    .Where(part => part.Length == 2)
                                    .ToDictionary(sp => sp[0], sp => sp[1]);
                            DataRow newBlankRow = ds.Tables[i].NewRow();
                            ds.Tables[i].Rows.InsertAt(newBlankRow, rowend);

                            if (ds.Tables[i].Rows.Count != 0)
                            {
                                foreach (DataRow sort_row in ds.Tables[i].Rows)
                                {
                                    bool needMerge = false;
                                    bool checkMerge = false;

                                    string CurrentRefNo = sort_row["GROUPID"].ToString();

                                    if (RefNo.Length > 0)
                                    {
                                        if (RefNo == CurrentRefNo)
                                        {
                                            checkMerge = true;
                                            mergeRange = cell_merge_range
                                            .Split(';')
                                            .Select(part => part.Split('='))
                                            .Where(part => part.Length == 2)
                                            .ToDictionary(sp => sp[0], sp => sp[1]);

                                        }
                                        else
                                        {
                                            mergestarttrow = rw;
                                            needMerge = true;
                                        }

                                    }

                                    int col = 1;

                                    if (rw > startRow)
                                        ws.InsertRow(rw, 1);

                                    if (needMerge)
                                    {
                                        for (int s = 0; s < mergedColNamed.Length; s++)
                                        {
                                            string MergeRangeValue = mergeRange.FirstOrDefault(x => x.Key == mergedColNamed[s]).Value;

                                            using (ExcelRange Rng = ws.Cells[MergeRangeValue])
                                            {
                                                if (MergeRangeValue.Length > 3)
                                                {
                                                    Rng.Merge = true;
                                                    ws.Cells[MergeRangeValue].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                                    ws.Cells[MergeRangeValue].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                                    Rng.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                                    Rng.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                                                    //if (mergedColNamed[s] == "GROUPTOTAL")
                                                    //{
                                                    //    Rng.Value = TTLCONS;
                                                    //    TTLCONS = 0;
                                                    //    //Rng.Style.Numberformat.Format = "0";
                                                    //}
                                                }


                                            }
                                        }
                                        mergeRange = cell_merge_range
                                        .Split(';')
                                        .Select(part => part.Split('='))
                                        .Where(part => part.Length == 2)
                                        .ToDictionary(sp => sp[0], sp => sp[1]);

                                    }

                                    foreach (DataColumn dc in ds.Tables[i].Columns)
                                    {
                                        if (mergedColNamed.Contains(dc.ColumnName.ToUpper()))
                                        {
                                            //if (dc.ColumnName.ToUpper() == "GROUPTOTAL")
                                            //    TTLCONS = TTLCONS + System.Convert.ToInt32(string.IsNullOrEmpty(sort_row[dc].ToString()) ? "0" : sort_row[dc]);

                                            if (!checkMerge)//First Row
                                            {
                                                if (dc.ColumnName.ToUpper() == "GROUPID")
                                                    RefNo = sort_row[dc].ToString();


                                                ws.Cells[rw, col].Value = sort_row[dc].ToString();
                                                ws.Cells[rw, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                                ws.Cells[rw, col].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                                ws.Cells[rw, col].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                                ws.Cells[rw, col].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                                                //if (dc.ColumnName.ToUpper() == "GROUPTOTAL")
                                                //{
                                                //    ws.Cells[rw, col].Style.Numberformat.Format = "0";
                                                //}


                                            }
                                            else
                                            {
                                                string MergeRangeKey = mergeRange.FirstOrDefault(x => x.Value == mergeRange[dc.ColumnName.ToUpper()]).Key;
                                                string MergeRangeValue = mergeRange[dc.ColumnName.ToUpper()];
                                                mergeRange[MergeRangeKey] = string.Format(mergeRange[dc.ColumnName.ToUpper()] + "{0}:" + mergeRange[dc.ColumnName.ToUpper()] + "{1}", mergestarttrow, rw);
                                            }

                                        }
                                        else
                                        {
                                            ws.Cells[rw, col].Value = sort_row[dc].ToString();
                                            ws.Cells[rw, col].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                            ws.Cells[rw, col].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                                        }
                                        col++;
                                    }
                                    rw++;
                                }
                            }
                            using (var cells = ws.Cells[rowstart, colstart, rowstart, colend])
                            {
                                cells.Style.Font.Bold = true;
                                cells.Style.Font.Size = 11;
                                cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                                cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                            }
                            int mj = 1;
                            foreach (DataColumn dc in ds.Tables[i].Columns)
                            {
                                ws.Cells[rowstart, mj, rowstart, colend].Value = dc.ColumnName.Replace("_", " ") + " :";

                                //if (dc.DataType == typeof(decimal))
                                //    ws.Column(j).Style.Numberformat.Format = "#0.00";
                                if (dc.DataType == typeof(System.DateTime))
                                {
                                    ws.Column(mj).Style.Numberformat.Format = "dd-MMM-yyyy";
                                }

                                mj++;
                            }
                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);
                            //for (int col = 1; col <= ws.Dimension.End.Column; col++)
                            //{
                            //    ws.Column(col).Width = ws.Column(col).Width + 1;
                            //}

                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Top.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Bottom.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Left.Style =
                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            ws.DeleteRow(rowend + 1, ws.Dimension.End.Row - 1);
                        }

                        // Normal Export
                        ws.Cells[rowstart, colstart].LoadFromDataTable(ds.Tables[i], true);

                        using (var cells = ws.Cells[rowstart, colstart, rowstart, colend])
                        {
                            cells.Style.Font.Bold = true;
                            cells.Style.Font.Size = 11;
                            cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            cells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(226, 239, 218));
                        }
                        int j = 1;
                        foreach (DataColumn dc in ds.Tables[i].Columns)
                        {
                            ws.Cells[rowstart, j, rowstart, colend].Value = dc.ColumnName.Replace("_", " ") + " :";

                            if (dc.DataType == typeof(System.DateTime))
                            {
                                ws.Column(j).Style.Numberformat.Format = "dd-MMM-yyyy";
                            }

                            j++;
                        }
                        if (need_borders.ToUpper() == "Y")
                        {
                            ws.Cells[ws.Dimension.Address].AutoFitColumns(0, 50);


                            ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Top.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Bottom.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Left.Style =
                               ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;

                        }


                    }

                }

            }

            //ZipFile
            using (ZipFile zip = new ZipFile())
            {
                zip.AddEntry(FILE_NAME + ".xlsx", xp.GetAsByteArray());
                zip.Save(zip_file);

                Response.AppendHeader("content-disposition", "attachment; filename=" + FILE_NAME + ".zip");
                Response.ContentType = "application/zip";
                Response.WriteFile(zip_file);
                Response.End();
            }


        }
    }
}