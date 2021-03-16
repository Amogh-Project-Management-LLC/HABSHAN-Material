using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Ionic.Zip;
using System.IO;
using System.Data.OracleClient;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Material_MatReceive : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Session["MRIR_FILTER"].ToString();
        //    if (filter_ != "") txtSearch.Text = filter_;
            Master.HeadingMessage = "Material Receipt Report (MRR)";
            try
            {
                if (Session["MatReceive_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    MatReceiveGridView.Rebind();

                }
            }
            catch (Exception ex)
            {

            }
          
        }
        if (WebTools.UserInRole("MRR_IRN_VISIBLE"))
        {
            btnMrrIrnItems.Visible = true;
            return;
        }
    }
    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the report number first.");
            return;
        }
        Response.Redirect("MatReceiveItems.aspx?MAT_RCV_ID=" + MatReceiveGridView.SelectedValue.ToString());
    }
    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("No Access!");
            return;
        }
        Response.Redirect("MatReceiveNew.aspx");
    }
   
   
    protected void MatReceiveGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void MatReceiveGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //MatReceiveGridView.DeleteRow(MatReceiveGridView.SelectedIndex);
            //Master.ShowMessage("Report deleted.");
            dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_RCVTableAdapter mrv = new dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_RCVTableAdapter();
            mrv.DeleteQuery(decimal.Parse(MatReceiveGridView.SelectedValue.ToString()));
            MatReceiveGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void MatReceiveGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < MatReceiveGridView.PageCount; i++)
        {
            System.Web.UI.WebControls.ListItem pageListItem = new System.Web.UI.WebControls.ListItem(String.Concat("Page ", i + 1, " of ", MatReceiveGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == MatReceiveGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        MatReceiveGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire MRIR number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=9.1&Arg1=" + MatReceiveGridView.SelectedValue.ToString());
    }
    //protected void txtSearch_TextChanged(object sender, EventArgs e)
    //{
    //    txtSearch.Text = txtSearch.Text.Trim().ToUpper();
    //    Session["MRIR_FILTER"] = txtSearch.Text;
    //}

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
            Master.ShowMessage(ex.Message);
        }
    }

    public void createTable(string FileName, int mat_id, string id_1)
    {

        //72 point =1 inch
        //  
         var r = new iTextSharp.text.Rectangle(220, 144)
        //var r = new iTextSharp.text.Rectangle(144, 72)
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
        cell.Image = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        img.ScaleToFit(r);
        cell.Colspan = 2;
        cell.Border = 0;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        table.AddCell(cell);
        rdr.Read();
        Font font = new Font(Font.FontFamily.TIMES_ROMAN,12f);
        table.AddCell(new Paragraph("Material Code:" + rdr[0].ToString(),font));
        //table.AddCell(new Paragraph("MESC Code:" + rdr[1].ToString(), bigFont));
        table.AddCell(new Paragraph("", bigFont));
        table.AddCell(new Paragraph("Size:" + rdr[2].ToString(),font));
        table.AddCell(new Paragraph("", bigFont));
        //table.AddCell(new Paragraph("Thk/Sch:" + rdr[3].ToString(), bigFont));
        table.AddCell(new Paragraph("Item Name:" + rdr[4].ToString(), font));
        table.AddCell("");
        //NEW CONDITION
        rdr.Close();
        //END
        conn.Close();
        dc.Add(table);
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
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string mat_rcv_id = MatReceiveGridView.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(11, mat_rcv_id, "MRR", "MRR_SUPP", Response);

    }

    protected void MatReceiveGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mat_rcv_id = item.GetDataKeyValue("MAT_RCV_ID").ToString();
            string mr_no = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " MAT_RCV_ID = " + mat_rcv_id);
            string filename = mr_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MRR'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MRR'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='MRR PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =7 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =7";
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



        protected void MatReceiveGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MRR_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MRR_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
     
    }

    protected void MatReceiveGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MRR_DELETE"))
        {
            MatReceiveGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)MatReceiveGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_RCV_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)MatReceiveGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            MatReceiveGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MRR_EDIT"))
        {
            MatReceiveGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            MatReceiveGridView.AllowAutomaticUpdates = true;
        }

    }
    protected void btnMrrIrnItems_Click(object sender, EventArgs e)
    {
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the report number.");
            return;
        }

        Response.Redirect("IrnItems.aspx?MAT_RCV_ID=" + MatReceiveGridView.SelectedValue.ToString());
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

        SessionStorageProvider.StorageProviderKey = "MatReceive_SESSION";
        RadPersistenceManager1.SaveState();
    }

}