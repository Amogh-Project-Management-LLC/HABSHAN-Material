using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Material_MaterialRequest : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Request / Material Return";
            Master.RadGridList = RadGrid1.ClientID;
            Master.AddModalPopup("~/Material/MaterialRequestRegister.aspx", btnAdd.ClientID, 450, 630);
            try
            {
                if (Session["MAT_REQ_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    RadGrid1.Rebind();

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

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("MRIR_DELETE"))
        //{
        //    Master.ShowWarn("Access Denied!");
        //    return;
        //}
        //if (RadGrid1View.SelectedIndex < 0)
        //{
        //    Master.ShowWarn("Select a row!");
        //    return;
        //}
        //Master.ShowWarn("Proceed delete the selected row?");
        //btnYes.Visible = true;
        //btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //RadGrid1View.DeleteRow(RadGrid1View.SelectedIndex);
            // Master.ShowMessage("Row deleted successfully.");
            RadWindowManager1.RadAlert("Row deleted successfully.", 400, 150, "Warning", "");
        }
        catch (Exception ex)
        {
            // Master.ShowWarn("Unable to delete the Row!" + ex.Message);
            RadWindowManager1.RadAlert("Unable to delete the Row!", 400, 150, "Warning", "");
        }
    }
   
    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            //Master.ShowWarn("Select a row!");
            RadWindowManager1.RadAlert("Select a row!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("MaterialRequestItems.aspx?MAT_REQ_ID=" + RadGrid1.SelectedValue.ToString());
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the entire MIR number!");
            RadWindowManager1.RadAlert("Select the entire MIR number!", 400, 150, "Warning", "");
            return;
        }
        //Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() + "&Arg1=" + RadGrid1View.SelectedValue.ToString());
    }
  
    
    protected void btnPreview_Click1(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count < 0)
        {
            // Master.ShowWarn("Select a row!");
            RadWindowManager1.RadAlert("Select a row!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=5&Arg1=" + RadGrid1.SelectedValue);
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string mat_req_id = RadGrid1.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(14, mat_req_id, "MAT_REQUEST", "MAT_REQ_SUPP", Response);

    }
    protected void btnMR_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=13&RetUrl=~/Material/MaterialRequest.aspx");
    }


    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mat_req_id = item.GetDataKeyValue("MAT_REQ_ID").ToString();
            string mat_req_no = WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " MAT_REQ_ID = " + mat_req_id);
            string filename = mat_req_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_REQUEST'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_REQUEST'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");
            string status_flg = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " MAT_REQ_ID = " + mat_req_id);
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                if (status_flg == "Y" && !WebTools.UserInRole("ADMIN"))
                {
                    ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                    btnEdit.Visible = false;

                    ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                    btnDelete.Visible = false;
                }
            }


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='REQUEST PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =15 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =15";
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

    protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MAT_REQUEST_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MAT_REQUEST_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void RadGrid1_DataBinding(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("MAT_REQUEST_DELETE"))
        {
            RadGrid1.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "MAT_REQ_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            RadGrid1.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MAT_REQUEST_EDIT"))
        {
            RadGrid1.AllowAutomaticUpdates = false;
        }
        else
        {
            RadGrid1.AllowAutomaticUpdates = true;
        }
    }
    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            DataView dv;
            DataTable dt;
            string emailID;
            string mr_no;
            string type_id = "1";
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            string userEmail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            dv = MailDataSource.Select(args) as DataView;
            dt = dv.ToTable() as DataTable;
            string mr_id = RadGrid1.SelectedValue.ToString();
            mr_no = WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + mr_id + "'");
            string STATUS_FLG = WebTools.GetExpr("STATUS_FLG", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + mr_id + "'");
            if (STATUS_FLG == "N")
            {
                foreach (DataRow myRow in dt.Rows)
                {

                    emailID = WebTools.GetExpr("EMAIL", "USERS_PDF_MAIL_LIST", " WHERE USER_NAME='" + myRow["USER_NAME"] + "' AND UPPER(MODULE_NAME) ='MATERIAL REQUEST'");

                    if (emailID != "")
                    {

                        string str = AmoghPdfMail.SendEmail(emailID, mr_no, uname, userEmail, type_id);
                    }

                }
                string query = "UPDATE MATERIAL_REQUEST SET STATUS_FLG ='Y' WHERE MAT_REQ_ID =" + mr_id;
                WebTools.ExeSql(query);
                Master.ShowSuccess("Email Sent To : WAREHOUSE CENTRE users:");
            }
            else
            {
                Master.ShowWarn("Status Already Updated ");
            }
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
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

        SessionStorageProvider.StorageProviderKey = "MAT_REQ_SESSION";
        RadPersistenceManager1.SaveState();
    }

}
