using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using Telerik.Web.UI.PersistenceFramework;



public partial class Erection_MatIssueLoose : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Transfer";
            try
            {
                if (Session["MTN_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    IssueGridView.Rebind();

                }
            }
            catch (Exception ex)
            {

            }

        }
        if (WebTools.UserInRole("MTN_RCVFLG_VISIBLE"))
        {
            btnRCVstatus.Visible = true;
            return;
        }
    }
    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count < 0)
        {
            Master.ShowMessage("Select the entire row!");
            RadWindowManager1.RadAlert("Select the entire row!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("Mat_Transf_Items.aspx?TRANSF_ID=" + IssueGridView.SelectedValue.ToString());
    }
    //protected void LooseIssueGridView_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    if (!WebTools.UserInRole("MM_UPDATE"))
    //    {
    //        Master.ShowWarn("Access Denied!");
    //        RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
    //        e.Cancel = true;
    //    }
    //}

    protected void btnNewIssue_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("Mat_Transf_Regist.aspx");
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        IssueGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count < 0)
        {
            Master.ShowMessage("Select the transfer number!");
            RadWindowManager1.RadAlert("Select the transfer number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=22&Arg1=" + IssueGridView.SelectedValue.ToString());
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string transf_id = IssueGridView.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(16, transf_id, "MAT_TRANSFER", "MAT_TRANSF_SUPP", Response);

    }

    protected void IssueGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string transf_id = item.GetDataKeyValue("TRANSF_ID").ToString();
            string transf_no = WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " TRANSF_ID = " + transf_id);
            string filename = transf_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_TRANSFER'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_TRANSFER'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");
            string status_flg = WebTools.GetExpr("STATUS_FLG", "PIP_MAT_TRANSF", " TRANSF_ID = " + transf_id);
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
                string url = "<a title='TRANSFER PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }

        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =17 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =17";
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

    protected void IssueGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void IssueGridView_DataBinding(object sender, EventArgs e)
    {
        try
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                IssueGridView.AllowAutomaticDeletes = false;
                GridButtonColumn gridbutton = (GridButtonColumn)IssueGridView.MasterTableView.Columns[1];
            }
            else
            {
                string[] datafields = new string[1];
                datafields[0] = "TRANSF_NO";
                GridButtonColumn gridbutton = (GridButtonColumn)IssueGridView.MasterTableView.Columns[1];
                gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
                gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
                gridbutton.ConfirmTextFields = datafields;

                IssueGridView.AllowAutomaticDeletes = true;

            }
        }
        catch (Exception ex)
        {
            RadWindowManager1.RadAlert("Items Available in MATERIAL TRANSFER!", 400, 150, "Warning", "");

        }


        if (!WebTools.UserInRole("MM_EDIT"))
        {
            IssueGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            IssueGridView.AllowAutomaticUpdates = true;
        }
    }
    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            DataView dv;
            DataTable dt;
            string emailID;
            string trans_no;
            string B_STORE_ID;
            string B_STORE;
            string type_id = "2";
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            string userEmail = WebTools.GetExpr("EMAIL", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            dv = MailDataSource.Select(args) as DataView;
            dt = dv.ToTable() as DataTable;
            string TRANSF_ID = IssueGridView.SelectedValue.ToString();
            trans_no = WebTools.GetExpr("TRANSF_NO", "VIEW_ADAPTER_MAT_TRANSF", " WHERE TRANSF_ID='" + TRANSF_ID + "'");
            B_STORE_ID = WebTools.GetExpr("B_STORE_ID", "VIEW_ADAPTER_MAT_TRANSF", " WHERE TRANSF_ID='" + TRANSF_ID + "'");
            B_STORE = WebTools.GetExpr("B_STORE", "VIEW_ADAPTER_MAT_TRANSF", " WHERE TRANSF_ID='" + TRANSF_ID + "'");
            string STATUS_FLG = WebTools.GetExpr("STATUS_FLG", "PIP_MAT_TRANSF", " WHERE TRANSF_ID='" + TRANSF_ID + "'");
            if (STATUS_FLG == "N")
            {
                foreach (DataRow myRow in dt.Rows)
                {

                    emailID = WebTools.GetExpr("EMAIL", "USERS_PDF_MAIL_LIST", " WHERE USER_NAME='" + myRow["USER_NAME"] + "' AND STORE_ID ='" + B_STORE_ID + "' AND UPPER(MODULE_NAME) ='MATERIAL TRANSFER'");

                    if (emailID != "")
                    {

                        string str = AmoghPdfMail.SendEmail(emailID, trans_no, uname, userEmail, type_id);
                    }

                }
                string query = "UPDATE PIP_MAT_TRANSF SET STATUS_FLG ='Y' WHERE TRANSF_ID =" + TRANSF_ID;
                WebTools.ExeSql(query);
                Master.ShowSuccess("Email Sent To : " + B_STORE + " Users");
            }
            else
            {
                Master.ShowWarn("Status Already Updated");
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

        SessionStorageProvider.StorageProviderKey = "MTN_SESSION";
        RadPersistenceManager1.SaveState();
    }


    protected void btnRCVstatus_Click(object sender, EventArgs e)
    {
        string Recv_flg  = WebTools.GetExpr("Recv_flg", "PIP_MAT_TRANSF", " WHERE TRANSF_ID=" + IssueGridView.SelectedValue.ToString());
        if (Recv_flg == "N")
        {
            string query = "UPDATE PIP_MAT_TRANSF SET Recv_flg ='Y' WHERE TRANSF_ID =" + IssueGridView.SelectedValue.ToString(); 
            WebTools.ExeSql(query);
            Master.ShowSuccess("Status Updated");
        }
        else
        {
            Master.ShowWarn("Status Already Updated");
        }

    }
}