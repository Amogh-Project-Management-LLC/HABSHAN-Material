using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Data.OracleClient;
using Telerik.Web.UI;
using System.Collections;
using Telerik.Web.UI.PersistenceFramework;

public partial class Material_MatInsp : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Receive & Inspection (MRIR)";
            Master.AddModalPopup("~/Material/MatInspAdd.aspx", btnAdd.ClientID, 550, 850);
            Master.AddModalPopup("~/Material/MatInsp_View.aspx", btnView.ClientID, 600, 600);


            //   Master.AddModalPopup("~/Common/FileImport.aspx?TYPE_ID=11", btnPDFImport.ClientID, 600, 600);

            Master.RadGridList = grdMRIR.ClientID;
            try
            {
                if (Session["MatInsp_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    grdMRIR.Rebind();

                }
            }
            catch (Exception ex)
            {

            }
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnAdd.Visible = false;
            }
        }
    }

    protected void grdMRIR_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popUp_MIR_ID"] = grdMRIR.SelectedValue;
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {      
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select MRIR to proceed.");
            RadWindowManager1.RadAlert("Select MRIR to proceed.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("~/Material/MatInspDetail.aspx?MIR_ID=" + grdMRIR.SelectedValue);
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select MRIR to proceed.");
            RadWindowManager1.RadAlert("Select MRIR to proceed.", 400, 150, "Warning", "");
            return;
        }
      
        string filename = WebTools.GetExpr("MIR_No", "PRC_MAT_INSP", " MIR_ID='" + grdMRIR.SelectedValue + "'");
        WebTools.ExportDataSetToExcel(sqlExportMIR, "MRIR_" + filename + ".xls");
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select MRIR to proceed.");
            RadWindowManager1.RadAlert("Select MRIR to proceed.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("~/Material/ReportViewer.aspx?ReportID=10&Arg1=" + grdMRIR.SelectedValue);
    }

    protected void btnExportAll_Click(object sender, EventArgs e)
    {
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        WebTools.ExportDataSetToExcel(sqlExportMIRAll, "MRIR-" + job_code + ".xls");
    }

   

    protected void btnPDFImport_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            //Master.ShowError("Select MRIR to proceed.");
            RadWindowManager1.RadAlert("Select MRIR to proceed.", 400, 150, "Warning", "");
        }
    }



    ////////////////////////////////////////////////////////////////////////
    protected void btnGenerateBarcode_Click(object sender, EventArgs e)
    {
        try
        {

            DataTable dt = new DataTable();

            dt = ((DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty)).Table;

            string[] Files = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles");
            foreach (string file in Files)
            {
                System.IO.File.Delete(file);
            }

            if (dt.Rows.Count >= 1000)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["ID"].ToString().Length == 1)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "000" + dr["ID"].ToString());
                    }

                    if (dr["ID"].ToString().Length == 2)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "00" + dr["ID"].ToString());
                    }

                    if (dr["ID"].ToString().Length == 3)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "0" + dr["ID"].ToString());
                    }

                    if (dr["ID"].ToString().Length == 4)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), dr["ID"].ToString());
                    }
                }
            }

            if ((dt.Rows.Count) >= 100 && (dt.Rows.Count) < 1000)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["ID"].ToString().Length == 1)
                    {

                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "00" + dr["ID"].ToString());
                    }

                    if (dr["ID"].ToString().Length == 2)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "0" + dr["ID"].ToString());
                    }

                    if (dr["ID"].ToString().Length == 3)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), dr["ID"].ToString());
                    }
                }
            }

            if ((dt.Rows.Count) < 100)
            {
                foreach (DataRow dr in dt.Rows)
                {

                    if (dr["ID"].ToString().Length == 1)
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), "0" + dr["ID"].ToString());
                    }

                    else
                    {
                        createTable("BarcodeFiles", int.Parse(dr["MAT_ID"].ToString()), dr["ID"].ToString());
                    }
                }
            }

            string path = HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles";
            // string path = "D://PDF_DIR//2014_RABIGH" + "//" + "BarcodeFiles";
            string[] filenames = Directory.GetFiles(path);
            MergeFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1" + "/" + "MultipleBarcode" + ".pdf", filenames);
            string[] Filenames = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1");
            using (ZipFile zip = new ZipFile())
            {
                zip.AddFiles(Filenames, "files");
                zip.Save(Server.MapPath("~/Zip_Folder/barcode1.zip"));
            }

            Response.Redirect("~/Zip_Folder/barcode1.zip");
        }
        catch (Exception ex)
        {
            // Master.ShowMessage(ex.Message);
            RadWindowManager1.RadAlert("Select MRIR to proceed.", 400, 150, "Warning", "");
        }
    }

    public void createTable(string FileName, int mat_id, string id_1)
    {

        //72 point =1 inch
        //  
        // var r = new iTextSharp.text.Rectangle(220, 144)
        var r = new iTextSharp.text.Rectangle(144, 72)
        {
            //BackgroundColor=new BaseColor(179,227,238), remove this in original code
            Border = 0
        };
        Document dc = new Document(r, 0, 0, 0, 0);
        // PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + spl_id + ".pdf", FileMode.Create));

        PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + id_1 + ".pdf", FileMode.Create));
        dc.Open();
        // BaseFont customfont = BaseFont.CreateFont("d:\\ss.ttf", BaseFont.CP1252, BaseFont.EMBEDDED);
        BaseFont customfont = BaseFont.CreateFont();
        int a = mat_id;
        //string connectionString = "Data Source=ALRAR;Persist Security Info=True;User ID=AMOGH;Password=ALRAR2020;Unicode=True";
        OracleConnection conn = WebTools.GetIpmsConnection();
        // string query = "SELECT iso_title1,spl_rev,spool,round(spl_size,2) as spl_size ,area_l1,round(weight,2),mat_type,line_no,unit FROM view_total_spool_list WHERE spl_id=" + spl_id;
        string query = "SELECT mat_code1,mat_code2,size_desc,THK1, ITEM_NAM FROM view_stock WHERE mat_id=" + mat_id;
        OracleCommand cmd = new OracleCommand(query, conn);
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        OracleDataReader rdr = cmd.ExecuteReader();
        // Font bigFont = new Font(Font.FontFamily.TIMES_ROMAN, 6.5f, Font.NORMAL);
        Font bigFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 8, Font.BOLD, BaseColor.BLACK);
        Font smallFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 7, Font.BOLD, BaseColor.BLACK);
        Font headfont = new Font(Font.FontFamily.COURIER, 14f, Font.BOLD);
        iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;
        Barcode128 bc = new Barcode128();
        bc.ChecksumText = true;
        bc.Code = a.ToString().PadLeft(16, '0');
        bc.Size = 4;
        bc.BarHeight = 25;

        bc.Baseline = 4;



        PdfPTable table = new PdfPTable(2);
        // table.SetWidths(new float[]{158,68});
        table.SetWidthPercentage(new float[] { 100, 100 }, r);
        table.SetWidths(new float[] { 144, 72 });
        table.DefaultCell.Border = Rectangle.NO_BORDER;
        table.DefaultCell.NoWrap = true;

        // PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / Rabigh"));
        PdfPCell cell = new PdfPCell(new Paragraph());
        cell.Colspan = 2;
        cell.Rowspan = 4;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        cell.Border = 0;
        cell.Padding = 4;
        table.AddCell(cell);
        cell = new PdfPCell();
        //cell.Image = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        img.ScaleToFit(r);
        cell.Colspan = 2;
        cell.Border = 0;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        table.AddCell(cell);
        rdr.Read();
        table.AddCell(new Paragraph("Mat Code1:" + rdr[0].ToString(), smallFont));
        //    table.AddCell(new Paragraph("MESC Code:" + rdr[1].ToString(), bigFont));
        //    table.AddCell(new Paragraph("Size:" + rdr[2].ToString(), bigFont));
        //    table.AddCell(new Paragraph("Thk/Sch:" + rdr[3].ToString(), bigFont));
        //    table.AddCell(new Paragraph("Description:" + rdr[4].ToString(), bigFont));        
        table.AddCell("");
        //NEW  CONDITION
        rdr.Close();
        //END
        conn.Close();
        dc.Add(img);
        dc.Close();

        Response.Write(bc.BarcodeSize.ToString());
    }

    public void MergeFiles(string destinationFile, string[] sourceFiles)
    {
        try
        {
            int f = 0;
            // we create a reader for a certain document
            PdfReader reader = new PdfReader(sourceFiles[f]);
            // we retrieve the total number of pages
            int n = reader.NumberOfPages;
            Console.WriteLine("There are " + n + " pages in the original file.");
            // step 1: creation of a document-object
            Document document = new Document(reader.GetPageSizeWithRotation(1));
            // step 2: we create a writer that listens to the document
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(destinationFile, FileMode.Create));
            // step 3: we open the document
            document.Open();
            PdfContentByte cb = writer.DirectContent;
            PdfImportedPage page;
            int rotation;
            // step 4: we add content
            while (f < sourceFiles.Length)
            {
                int i = 0;
                while (i < n)
                {
                    i++;
                    document.SetPageSize(reader.GetPageSizeWithRotation(i));
                    document.NewPage();
                    page = writer.GetImportedPage(reader, i);
                    rotation = reader.GetPageRotation(i);
                    if (rotation == 90 || rotation == 270)
                    {
                        cb.AddTemplate(page, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(i).Height);
                    }
                    else
                    {
                        cb.AddTemplate(page, 1f, 0, 0, 1f, 0, 0);
                    }
                    Console.WriteLine("Processed page " + i);
                }
                f++;
                if (f < sourceFiles.Length)
                {
                    reader = new PdfReader(sourceFiles[f]);
                    // we retrieve the total number of pages
                    n = reader.NumberOfPages;
                    //Console.WriteLine("There are " + n + " pages in the original file.");
                }
            }
            // step 5: we close the document
            document.Close();
        }
        catch (Exception e)
        {
            Master.ShowError(e.Message);
        }
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string mir_id = grdMRIR.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(13, mir_id, "MRIR", "MRIR_SUPP", Response);
       
    }

    protected void grdMRIR_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mir_id = item.GetDataKeyValue("MIR_ID").ToString();
            string mrir_no = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID = " + mir_id);
            string filename = mrir_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MRIR'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MRIR'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='MRIR PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =11 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =11";
            DataTable lbl_dt = WebTools.getDataTable(lbl_query);
            Label[] descLabel = new Label[30];
            int i = 0;
            foreach (DataRow row in lbl_dt.Rows)
            {
                string lbl_col = row["LBL_COL_NAME"].ToString();

                string str = (dataItem[lbl_col].Controls[0] as TextBox).Text;
                descLabel[i] = new Label();
                descLabel[i].Text = str;
                dataItem[lbl_col].Controls.Add(descLabel[i]);
                i++;
            }

        }
    }

    protected void grdMRIR_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MRIR_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MRIR_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
      
    }

    protected void grdMRIR_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MRIR_DELETE"))
        {
            grdMRIR.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)grdMRIR.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MIR_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)grdMRIR.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            grdMRIR.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MRIR_EDIT"))
        {
            grdMRIR.AllowAutomaticUpdates = false;
        }
        else
        {
            grdMRIR.AllowAutomaticUpdates = true;
        }

    }

    protected void RadCreateESD_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedItems.Count == 0)
        {
            Master.ShowMessage("Please select MRIR to proceed.");
            return;
        }
        string esd_no = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE MAT_RCV_ID='" + grdMRIR.SelectedValue + "'");
        if (esd_no.Trim().Length > 0)
        {
            Master.ShowMessage("ESD already created for this MRIR. Please go to ESD Page to make further changes.");
            return;
        }
        string count = WebTools.GetExpr("MIR_ID", "PRC_MAT_INSP_DETAIL", " WHERE MIR_ID = " + grdMRIR.SelectedValue + " AND (PRC_MAT_INSP_DETAIL.excess_qty > 0 OR PRC_MAT_INSP_DETAIL.shortage_qty > 0 OR PRC_MAT_INSP_DETAIL.damage_qty > 0)");
        if (count.Trim().Length == 0)
        {
            Master.ShowError("Invalid Request. There is no excess/shortage/damage in selected MIR.");
            return;
        }
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        string sc_id = WebTools.GetExpr("MRIR_SC_ID", "PRC_MAT_INSP", " MIR_ID = '" + grdMRIR.SelectedValue + "'");
        prefix += "-ESD-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + sc_id + "'") + "-";
        string rep_no = WebTools.NextSerialNo("PIP_MAT_EXCEPTION_REP", "REP_NO", prefix, 4, " SC_ID = '" + sc_id + "'");
        int store_id = int.Parse(WebTools.GetExpr("STORE_ID", "PRC_MAT_INSP", " MIR_ID = '" + grdMRIR.SelectedValue + "'"));

        string sql = "INSERT INTO PIP_MAT_EXCEPTION_REP (PROJ_ID, REP_NO, MAT_RCV_ID, REP_DATE, SC_ID, TYPE_ID, STORE_ID) VALUES (";
        sql += "1, '" + rep_no + "', '" + grdMRIR.SelectedValue + "', '" + System.DateTime.Now.ToString("dd-MMM-yyyy") + "'," + sc_id + ",1,"+ store_id + ")";

        string sql1 = string.Empty;
        string excp_id = string.Empty;
        try
        {
            WebTools.ExeSql(sql);
            excp_id = WebTools.GetExpr("EXCP_ID", "PIP_MAT_EXCEPTION_REP", " WHERE REP_NO='" + rep_no + "'");
            sql = "SELECT MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, excess_qty,shortage_qty, damage_qty FROM PRC_MAT_INSP_DETAIL WHERE MIR_ID = " + grdMRIR.SelectedValue + " AND (PRC_MAT_INSP_DETAIL.excess_qty > 0 OR PRC_MAT_INSP_DETAIL.shortage_qty > 0 OR PRC_MAT_INSP_DETAIL.damage_qty > 0) ";
            DataTable dt = General_Functions.GetDataTable(sql);
            foreach (DataRow row in dt.Rows)
            {
                if (row["excess_qty"].ToString().Length > 0 && decimal.Parse(row["excess_qty"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','E', '" + row["excess_qty"] + "')";

                    WebTools.ExeSql(sql1);
                }

                if (row["shortage_qty"].ToString().Length > 0 && decimal.Parse(row["shortage_qty"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','S', '" + row["shortage_qty"] + "')";

                    WebTools.ExeSql(sql1);
                }

                if (row["damage_qty"].ToString().Length > 0 && decimal.Parse(row["damage_qty"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','D', '" + row["damage_qty"] + "')";

                    WebTools.ExeSql(sql1);
                }
            }

            Master.ShowSuccess("ESD Created Successfully.");
        }
        catch (Exception ex)
        {
            //Rollback           
            excp_id = WebTools.GetExpr("EXCP_ID", "PIP_MAT_EXCEPTION_REP", " WHERE REP_NO='" + rep_no + "'");
            if (excp_id.Trim().Length > 0)
            {
                sql = "DELETE FROM PIP_MAT_EXCEPTION_REP_DETAIL WHERE EXCP_ID = " + excp_id;
                WebTools.ExeSql(sql);
                sql = "DELETE FROM PIP_MAT_EXCEPTION_REP WHERE EXCP_ID = " + excp_id;
                WebTools.ExeSql(sql);
            }

            Master.ShowError(ex.Message);
        }
    }
    public class SessionStorageProvider : IStateStorageProvider
    {
        private System.Web.SessionState.HttpSessionState session = HttpContext.Current.Session;
        static string storageKey;

        public static string StorageProviderKey
        {
            set { storageKey = value; }
        }

        public void SaveStateToStorage(string key, string serializedState)
        {
            session[storageKey] = serializedState;
        }

        public string LoadStateFromStorage(string key)
        {

            return session[storageKey].ToString();
        }
    }
    protected void itemsGrid_PreRender(object sender, System.EventArgs e)
    {

        SessionStorageProvider.StorageProviderKey = "MatInsp_SESSION";
        RadPersistenceManager1.SaveState();
    }

}