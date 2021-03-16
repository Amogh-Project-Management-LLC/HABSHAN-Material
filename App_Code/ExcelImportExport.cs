using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Globalization;
using System.IO;
using System.Linq;

public class ExcelImport
{
    public struct TableFieldInfo
    {
        public string FieldName;
        public string FieldDataType;
        public int FieldSize;
    }

    public static void Import_Excel_File(string FilePath, string Extension, string TableName, string TablePk, string ProjIdField, string ProjIdValue)
    {
        string conStr = "";
        switch (Extension)
        {
            case ".xls": //Excel 97-03
                conStr = ConnStrHelper.Excel03ConString();
                break;

            case ".xlsx": //Excel 07
                conStr = ConnStrHelper.Excel07ConString();
                break;

            default:
                return; // not supported
        }

        conStr = String.Format(conStr, FilePath, "Yes");
        OleDbConnection connExcel = new OleDbConnection(conStr);
        OleDbCommand cmdExcel = new OleDbCommand();
        OleDbDataAdapter oda = new OleDbDataAdapter();
        DataTable dt = new DataTable();
        cmdExcel.Connection = connExcel;

        //Get the name of First Sheet
        connExcel.Open();
        DataTable dtExcelSchema;
        dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
        connExcel.Close();

        //Read Data from First Sheet
        connExcel.Open();
        cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
        oda.SelectCommand = cmdExcel;
        oda.Fill(dt);
        connExcel.Close();

        bool has_pj_id = string.IsNullOrEmpty(ProjIdField) ? false : true;

        bool first_col = true;
        string sql = "INSERT " +
            (string.IsNullOrEmpty(TablePk) ? "" : string.Format(@"/*+ IGNORE_ROW_ON_DUPKEY_INDEX({0},{1}) */", TableName, TablePk)) +
            " INTO " + TableName + " (";

        // add proj_id field
        if (has_pj_id)
        {
            sql += ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += col.ColumnName;
        }

        sql += ") VALUES (";
        first_col = true;

        // add proj_id field
        if (has_pj_id)
        {
            sql += ":" + ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += ":" + col.ColumnName;
        }

        sql += ")";

        using (OracleConnection conn = WebTools.GetIpmsConnection()) // will open connection too
        {
            OracleCommand cmd = new OracleCommand(sql, conn);

            foreach (DataRow row in dt.Rows)
            {
                cmd.Parameters.Clear();

                // add proj_id value
                if (has_pj_id)
                {
                    OracleParameter proj_par = new OracleParameter(ProjIdField, ProjIdValue);
                    cmd.Parameters.Add(proj_par);
                }

                foreach (DataColumn col in dt.Columns)
                {
                    string col_val = row[col].ToString();
                                        
                    if (col.ColumnName.ToUpper().Contains("DATE") && !string.IsNullOrEmpty(col_val))
                    {
                        DateTime value;
                        if (DateTime.TryParse(col_val, out value))
                        {
                            col_val = value.ToString("dd-MMM-yyyy");
                        }
                        else
                            col_val = "";
                    }

                    OracleParameter parm = new OracleParameter(col.ColumnName, col_val);
                    cmd.Parameters.Add(parm);
                }
                cmd.ExecuteNonQuery();
            }

            cmd.Dispose();
        }

        //Bind Data to GridView
        //GridView1.Caption = Path.GetFileName(FilePath);
        //jointsGridView.DataSource = dt;
        //jointsGridView.DataBind();
    }

    public static void ExportToExcelNopi(string FilePath, string SqlQuery)
    {
        DataTable dt = new DataTable();

        OracleConnection conn = WebTools.GetIpmsConnection();
        OracleCommand cmd = new OracleCommand(SqlQuery, conn);

        // create data adapter
        OracleDataAdapter da = new OracleDataAdapter(cmd);
        // this will query your database and return the result to your datatable
        da.Fill(dt);

        // close objects
        conn.Close();
        da.Dispose();
        cmd.Dispose();
        
        using (FileStream stream = new FileStream(FilePath, FileMode.Create, FileAccess.Write))
        {
            IWorkbook wb = new XSSFWorkbook();
            ISheet sheet = wb.CreateSheet("Sheet1");
            ICreationHelper cH = wb.GetCreationHelper();

            // create header
            IRow header_row = sheet.CreateRow(0); // first row = 0

            // style for heading
            IFont boldFont = wb.CreateFont();
            boldFont.Boldweight = (short)FontBoldWeight.Bold;
            ICellStyle header_style = wb.CreateCellStyle();
            header_style.SetFont(boldFont);

            //boldStyle.BorderBottom = BorderStyle.Medium;
            header_style.FillForegroundColor = NPOI.HSSF.Util.HSSFColor.Grey25Percent.Index;
            header_style.FillPattern = FillPattern.SolidForeground;
            header_style.Alignment = HorizontalAlignment.Center;
            header_style.VerticalAlignment = VerticalAlignment.Center;

            for (int j = 0; j < dt.Columns.Count; j++)
            {
                ICell cell = header_row.CreateCell(j);
                cell.SetCellValue(cH.CreateRichTextString(dt.Columns[j].ColumnName));
                cell.CellStyle = header_style;
            }


            for (int i = 0; i < dt.Rows.Count; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    DataRow drow = dt.Rows[i];
                    string str_value = drow.ItemArray[j].ToString();
                    ICell cell = row.CreateCell(j);
                    if (dt.Columns[j].DataType == typeof(DateTime) && drow.ItemArray[j] != DBNull.Value)
                    {
                        cell.SetCellValue(DateTime.Now);
                        IDataFormat dataFormatCustom = wb.CreateDataFormat();

                        DateTime? date_field = drow.Field<DateTime?>(j);
                        
                        //cell.CellStyle.DataFormat = dataFormatCustom.GetFormat("yyyyMMdd HH:mm:ss");
                        //DateTime.ParseExact(str_value, "dd/M/yyyy hh:mm:ss tt", CultureInfo.InvariantCulture)
                        cell.SetCellValue(date_field.Value);
                        ICellStyle date_style = wb.CreateCellStyle(); 
                        date_style.DataFormat = dataFormatCustom.GetFormat("dd-mmm-yyyy;@");
                        cell.CellStyle = date_style;
                    }
                    {
                        cell.SetCellValue(cH.CreateRichTextString(str_value.ToString()));
                    }
                }
            }
            wb.Write(stream);
        }
    }

    private static DataTable xlsxToDT(Stream stream)
    {
        IWorkbook hssfworkbook = WorkbookFactory.Create(stream);
        ISheet sheet = hssfworkbook.GetSheetAt(0);
        stream.Close();

        DataTable dt = new DataTable();
        IRow headerRow = sheet.GetRow(0);
        IEnumerator rows = sheet.GetRowEnumerator();

        int colCount = headerRow.LastCellNum;
        int rowCount = sheet.LastRowNum;

        for (int c = 0; c < colCount; c++)
            dt.Columns.Add(headerRow.GetCell(c).ToString());

        while (rows.MoveNext())
        {
            IRow row = (IRow)rows.Current;
            DataRow dr = dt.NewRow();

            for (int i = 0; i < colCount; i++)
            {
                ICell cell = row.GetCell(i);

                if (cell != null)
                    dr[i] = cell.ToString();
            }
            dt.Rows.Add(dr);
        }

        return dt;
    }

    public static DataTable xlsxToDT2(Stream stream)
    {
        IWorkbook hssfworkbook = WorkbookFactory.Create(stream);
        ISheet sheet = hssfworkbook.GetSheetAt(0);
        stream.Close();

        DataTable dt = new DataTable();
        IRow headerRow = sheet.GetRow(0);
        IEnumerator rows = sheet.GetRowEnumerator();

        int colCount = headerRow.LastCellNum;
        int rowCount = sheet.LastRowNum;

        for (int c = 0; c < colCount; c++)
            dt.Columns.Add(headerRow.GetCell(c).ToString());

        while (rows.MoveNext())
        {
            IRow row = (IRow)rows.Current;
            DataRow dr = dt.NewRow();

            for (int i = 0; i < colCount; i++)
            {
                ICell cell = row.GetCell(i);

                if (cell != null)
                    dr[i] = cell.ToString();
            }
            dt.Rows.Add(dr);
        }

        return dt;
    }

    public static void ImporNpoi(Stream stream, string TableName, string TablePk, string ProjIdField, string ProjIdValue)
    {
        DataTable dt = new DataTable();
        dt = xlsxToDT(stream);

        bool has_pj_id = string.IsNullOrEmpty(ProjIdField) ? false : true;

        bool first_col = true;
        string sql = "INSERT " +
            (string.IsNullOrEmpty(TablePk) ? "" : string.Format(@"/*+ IGNORE_ROW_ON_DUPKEY_INDEX({0},{1}) */", TableName, TablePk)) +
            " INTO " + TableName + " (";

        // add proj_id field
        if (has_pj_id)
        {
            sql += ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += col.ColumnName;
        }

        sql += ") VALUES (";
        first_col = true;

        // add proj_id field
        if (has_pj_id)
        {
            sql += ":" + ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += ":" + col.ColumnName;
        }

        sql += ")";

        using (OracleConnection conn = WebTools.GetIpmsConnection()) // will open connection too
        {
            List<TableFieldInfo> columns = GetColumns(conn, TableName);
            OracleCommand cmd = new OracleCommand(sql, conn);

            for (int rowindex = 1; rowindex < dt.Rows.Count; rowindex++) // row 0 is heading
            {
                DataRow row = dt.Rows[rowindex];
                cmd.Parameters.Clear();

                // add proj_id value
                if (has_pj_id)
                {
                    OracleParameter proj_par = new OracleParameter(ProjIdField, ProjIdValue);
                    cmd.Parameters.Add(proj_par);
                }

                foreach (DataColumn col in dt.Columns)
                {
                    string data_type = columns.Where(x => x.FieldName == col.ColumnName).First().FieldDataType;
                    int data_len = columns.Where(x => x.FieldName == col.ColumnName).First().FieldSize;

                    string col_val = row[col].ToString();

                    if (data_type.ToLower().Contains("date"))
                    {
                        DateTime value;
                        if (DateTime.TryParse(col_val, out value))
                        {
                            col_val = value.ToString("dd-MMM-yyyy");
                            //col_val = "";
                        }
                        else
                            col_val = "";
                    }
                    else if (data_type.ToLower().Contains("varchar"))
                    {
                        if (col_val.Length > data_len)
                            col_val = col_val.Substring(0, data_len);
                    }


                    OracleParameter parm = new OracleParameter(col.ColumnName, col_val);
                    cmd.Parameters.Add(parm);
                }

                cmd.ExecuteNonQuery();
            }

            cmd.Dispose();
        }

    } // method

    private static List<TableFieldInfo> GetColumns(OracleConnection conn, string table)
    {
        OracleCommand cmd =
            new OracleCommand(string.Format("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH FROM USER_TAB_COLUMNS WHERE TABLE_NAME = '{0}'", table),
            conn);

        var columns = new List<TableFieldInfo>();
        using (var reader = cmd.ExecuteReader())
        {
            while (reader.Read())
            {
                var info = new TableFieldInfo();
                info.FieldName = reader["COLUMN_NAME"].ToString();
                info.FieldDataType = reader["DATA_TYPE"].ToString();
                info.FieldSize = int.Parse(reader["DATA_LENGTH"].ToString());

                columns.Add(info);
            }
        }

        cmd.Dispose();
        return columns;

    }

    public static void ImportDataTable(DataTable data, string TableName, string TablePk, string ProjIdField, string ProjIdValue)
    {
        DataTable dt = new DataTable();
        dt = data;

        bool has_pj_id = string.IsNullOrEmpty(ProjIdField) ? false : true;

        bool first_col = true;
        string sql = "INSERT " +
            (string.IsNullOrEmpty(TablePk) ? "" : string.Format(@"/*+ IGNORE_ROW_ON_DUPKEY_INDEX({0},{1}) */", TableName, TablePk)) +
            " INTO " + TableName + " (";

        // add proj_id field
        if (has_pj_id)
        {
            sql += ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += col.ColumnName;
        }

        sql += ") VALUES (";
        first_col = true;

        // add proj_id field
        if (has_pj_id)
        {
            sql += ":" + ProjIdField;
            first_col = false;
        }

        foreach (DataColumn col in dt.Columns)
        {
            if (!first_col)
                sql += ",";
            else
                first_col = false;

            sql += ":" + col.ColumnName;
        }

        sql += ")";

        using (OracleConnection conn = WebTools.GetIpmsConnection()) // will open connection too
        {
            List<TableFieldInfo> columns = GetColumns(conn, TableName);
            OracleCommand cmd = new OracleCommand(sql, conn);

            for (int rowindex = 1; rowindex < dt.Rows.Count; rowindex++) // row 0 is heading
            {
                DataRow row = dt.Rows[rowindex];
                cmd.Parameters.Clear();

                // add proj_id value
                if (has_pj_id)
                {
                    OracleParameter proj_par = new OracleParameter(ProjIdField, ProjIdValue);
                    cmd.Parameters.Add(proj_par);
                }

                foreach (DataColumn col in dt.Columns)
                {
                    string data_type = columns.Where(x => x.FieldName == col.ColumnName).First().FieldDataType;
                    int data_len = columns.Where(x => x.FieldName == col.ColumnName).First().FieldSize;

                    string col_val = row[col].ToString();

                    if (data_type.ToLower().Contains("date"))
                    {
                        DateTime value;
                        if (DateTime.TryParse(col_val, out value))
                        {
                            col_val = value.ToString("dd-MMM-yyyy");
                            //col_val = "";
                        }
                        else
                            col_val = "";
                    }
                    else if (data_type.ToLower().Contains("varchar"))
                    {
                        if (col_val.Length > data_len)
                            col_val = col_val.Substring(0, data_len);
                    }


                    OracleParameter parm = new OracleParameter(col.ColumnName, col_val);
                    cmd.Parameters.Add(parm);
                }

                cmd.ExecuteNonQuery();
            }

            cmd.Dispose();
        }

    }

}