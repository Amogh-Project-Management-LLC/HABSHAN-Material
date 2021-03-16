using Ionic.Zip;
using iTextSharp.text.pdf;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Procurement_IRN : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage = "Inspection Release Note (IRN)";

            try
            {
                if (Session["IRN_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    itemsGrid.Rebind();

                }
            }
            catch (Exception ex)
            {

            }

        }
        if (!WebTools.UserInRole("PO_IRN_ADD"))
        {
            btnNew.Visible = false;
        }
        //if (!WebTools.UserInRole("IRN"))
        //{
        //   // Master.ShowError("Dont have access to this page");
        //      Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select any IRN number to continue.");
            return;
        }
        Response.Redirect("IRN_Detail.aspx?IRN_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select IRN to continue");
            return;
        }
        //////////////////////////////
        string irn = WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + itemsGrid.SelectedValue + "'");
        irn = irn.Replace("/", "-");
        bool file_exist = System.IO.File.Exists(System.Web.Hosting.HostingEnvironment.MapPath("~/ImgFolder/"
            + irn + ".gif"));
        Context.Response.ContentType = "image/gif";
        if (irn.Length > 0 && !file_exist)
        {
            Barcode128 code128 = new Barcode128();
            code128.CodeType = Barcode.CODE128;
            code128.ChecksumText = true;
            code128.GenerateChecksum = true;
            code128.Code = irn;
            System.Drawing.Bitmap bm = new System.Drawing.Bitmap(code128.CreateDrawingImage(System.Drawing.Color.Black, System.Drawing.Color.White));
            bm.Save(Context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Gif);
            bm.Save(System.Web.Hosting.HostingEnvironment.MapPath("~/ImgFolder/"
            + irn + ".gif"));
        }

        //////////////////////////////////

        Response.Redirect("ReportViewer.aspx?Arg1=" + itemsGrid.SelectedValue + "&ReportID=1");
    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        Response.Redirect("IRNAdd.aspx");
    }

    protected void RadButton1_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select IRN to continue");
            return;
        }

        tblUpload.Visible = tblUpload.Visible ? false : true;
        tblUpload2.Visible = false;
    }

    protected void btnHide_Click(object sender, EventArgs e)
    {
        tblUpload.Visible = false;
        tblUpload2.Visible = false;
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            if (itemsGrid.SelectedIndexes.Count == 0)
            {
                Master.ShowError("Select IRN to continue");
                return;
            }

            if (!FileUpload1.HasFile) return;

            string irn_id=itemsGrid.SelectedValue.ToString();
            string irn_no=WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + irn_id + "'");
            irn_no = irn_no.Replace("/", "-");
            string proj_id = Session["PROJECT_ID"].ToString();
            
            //Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FileName = irn_no + Extension;
            string u_file_name = Path.GetFileName(FileUpload1.PostedFile.FileName);
            u_file_name.Replace("'", "");
            //  string FolderPath = "G:\\AMC work\\temp\\irn\\";
            string FolderPath= WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=5");
            // WebTools.SessionDataPath();
      
            string FilePath = FolderPath + FileName;
            System.IO.File.Delete(FilePath);
            FileUpload1.SaveAs(FilePath);
            string delquery="DELETE FROM PIP_PO_IRN_DOCS WHERE IRN_ID="+irn_id;
            WebTools.ExeSql(delquery);
            string query = "INSERT INTO PIP_PO_IRN_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME) VALUES(" + irn_id + ",'" + FileName + "','" + Extension + "','" + 5 + "','"+ u_file_name + "')";
            WebTools.ExeSql(query);
            Master.ShowSuccess("IRN File Uploaded");
        }
        catch(Exception ex)
        {
            Master.ShowError("Path Not Found:" + ex.Message);
        }
    }

    protected void btnUpload2_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select IRN to continue");
            return;
        }

        //string filepath = "G:\\AMC work\\temp\\ir\\";
        string filepath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");
        //Server.MapPath("\\Upload");
        HttpFileCollection uploadedFiles = Request.Files;
        try
        {
            string irn_id = itemsGrid.SelectedValue.ToString();
            string irn_no = WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + irn_id + "'");
            irn_no = irn_no.Replace("/", "-");
            string queryupload = "SELECT COUNT(IRN_ID) FROM PIP_PO_IR_DOCS WHERE IRN_ID='" + irn_id + "'";
            string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
            int doccnt = 0;
            if(maxdoc=="")
            {
                doccnt = 1;
            }
            else
            {
                doccnt= int.Parse(maxdoc);
            }
            for (int i = 0; i < uploadedFiles.Count; i++)
            {
                ++doccnt;
                HttpPostedFile userPostedFile = uploadedFiles[i];           
                    if (userPostedFile.ContentLength > 0)
                    {
                        string Extension= Path.GetExtension(userPostedFile.FileName);
                        string u_file_name = Path.GetFileName(userPostedFile.FileName);
                        u_file_name = u_file_name.Replace("'", "");
                        string Filename =  irn_no +"_"+ doccnt + Extension;
                        userPostedFile.SaveAs(filepath + "\\" + Filename);
                        string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','"+ u_file_name + "')";
                        WebTools.ExeSql(query);
                    }         
            }
            Master.ShowSuccess("IR Files Saved");
        }
        
        catch (Exception Ex)
        {
            Master.ShowError(Ex.Message);
        }
    }


    protected void RadButton2_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select IRN to continue");
            return;
        }

        tblUpload.Visible = false;
        tblUpload2.Visible = tblUpload.Visible ? false : true;
    }

    protected void btnDownloadIR_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select IRN to continue");
            return;
        }
        ZipFile zip_file=new ZipFile();
        string irn_id = itemsGrid.SelectedValue.ToString();
        string irn_no = WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + irn_id + "'");
        string sql = "";
        string FileName = "";
        string folderPath = WebTools.GetExpr("path", "dir_objects", " DIR_ID='"+ 6 + "'");
        string filePath = string.Empty;
        string path = WebTools.SessionDataPath();
        string zip_file_path = path + "IRN" + ".zip";
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
                //Isometric
                sql = "SELECT * FROM VIEW_PO_IRN_IR_FILES WHERE IRN_ID='" + irn_id +"'";            
                using (OracleCommand cmd = new OracleCommand(sql, conn))
                {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);

                        if (File.Exists(folderPath + dataReader["FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["FILE_NAME"],"files");
                        }

                    }
                }//OracleDataReader1
            }//OracleCommand1            
        }//OracleConnection
        zip_file.Save(zip_file_path);
        var updateFile = new FileInfo(zip_file_path);
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        Response.AddHeader("content-length", updateFile.Length.ToString());
        Response.TransmitFile(updateFile.FullName);
        Response.Flush();
    }

    protected void itemsGrid_DataBinding(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("PO_IRN_DELETE"))
        {
            itemsGrid.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "IRN_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            itemsGrid.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("PO_IRN_EDIT"))
        {
            itemsGrid.AllowAutomaticUpdates = false;
        }
        else
        {
            itemsGrid.AllowAutomaticUpdates = true;
        }
    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string irn_id=item.GetDataKeyValue("IRN_ID").ToString();
            string irn_no = WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " IRN_ID = " + irn_id );
            string filename = irn_no.Replace("/","-") + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_IRN'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_IRN'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");

          
            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='IRN PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon= (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =5 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =5";
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

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_IRN_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_IRN_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void btnVendorData_Click(object sender, EventArgs e)
    {
        Response.Redirect("POVendorData.aspx");
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Please select a record to continue.");
            return;
        }
        Response.Redirect("IRNView.aspx?IRN_ID=" + itemsGrid.SelectedValue);
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

        SessionStorageProvider.StorageProviderKey = "IRN_SESSION";
        RadPersistenceManager1.SaveState();
    }

    protected void bulkIrnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=9&RetUrl=~/Procurement/irn.aspx");
    }
}
