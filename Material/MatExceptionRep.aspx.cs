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
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;
using System.IO;

public partial class Material_MatExceptionRep : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "ESD Report";
            try
            {
                if (Session["ESD_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    ReportsGridView.Rebind();

                }
            }
            catch (Exception ex)
            {

            }


        }
    }
    protected void btnNewReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatExceptionRepNew.aspx");
    }
    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            // Master.ShowMessage("Select the report number!");
            RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("MatExceptionRepItems.aspx?EXCP_ID=" + ReportsGridView.SelectedValue.ToString());
    }

    //protected void btnAddItems_Click(object sender, EventArgs e)
    //{
    //    if (!WebTools.UserInRole("MM_INSERT"))
    //    {
    //        Master.ShowWarn("Access Denied.");
    //        return;
    //    }
    //    if (ReportsGridView.SelectedIndex < 0)
    //    {
    //        Master.ShowMessage("Select the report number!");
    //        return;
    //    }
    //    Response.Redirect("MatExceptionRepNewItem.aspx?EXCP_ID=" + ReportsGridView.SelectedValue.ToString());
    //}

    protected void ReportsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void ReportsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            //Master.ShowWarn("Access Denied.");
            RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }
    protected void ReportsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            //Master.ShowWarn("Access Denied.");
            RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");
            e.Cancel = true;
        }
        if (Session["CONNECT_AS"].ToString() != "99")
        {

        }
        else
        {

        }

    }
    protected void ReportsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < ReportsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", ReportsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == ReportsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("MM_DELETE"))
        //{
        //    //Master.ShowWarn("Access Denied!");
        //    RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");

        //    return;
        //}
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the report number.");
            RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the report?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            dsPO_ShipmentATableAdapters.PIP_MAT_EXCEPTION_REPTableAdapter esd = new dsPO_ShipmentATableAdapters.PIP_MAT_EXCEPTION_REPTableAdapter();
            esd.DeleteQuery(decimal.Parse(ReportsGridView.SelectedValue.ToString()));
            ReportsGridView.Rebind();
            Master.ShowMessage("Report deleted.");

            esd.Dispose();
        }
        catch (Exception ex)
        {
            // Master.ShowWarn(ex.Message);
            RadWindowManager1.RadAlert("Items Available in ESD!", 400, 150, "Warning", "");
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void ReportsGridView_EditCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            //Master.ShowWarn("Access Denied.");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Canceled = true;

        }
        if (Session["CONNECT_AS"].ToString() != "99")
        {

        }
        else
        {

        }
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            //Master.ShowMessage("Select the report number.");
            RadWindowManager1.RadAlert("Select the report number!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("~/Material/ReportViewer.aspx?ReportID=34&Arg1=" + ReportsGridView.SelectedValue);
    }

    protected void ReportsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
       
    }

    protected void ReportsGridView_DataBinding(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("MM_EDIT"))
        {
            ReportsGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            ReportsGridView.AllowAutomaticUpdates = true;
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

        SessionStorageProvider.StorageProviderKey = "ESD_SESSION";
        RadPersistenceManager1.SaveState();
    }


    protected void ReportsGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string EXCP_ID = item.GetDataKeyValue("EXCP_ID").ToString();
            string REP_NO = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " EXCP_ID = " + EXCP_ID);
            REP_NO = REP_NO.Replace("/", "-");
            string filename = REP_NO + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'ESD'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'ESD'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='ESD PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
        if (e.Item.IsInEditMode && e.Item is GridEditableItem)
        {

            string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                           " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =13 ";
            DataTable dt = WebTools.getDataTable(query);
            GridEditableItem dataItem = e.Item as GridEditableItem;

            foreach (DataRow row in dt.Rows)
            {
                string hide_col = row["HIDE_COL_NAME"].ToString();
                dataItem[hide_col].Enabled = false;
                dataItem[hide_col].Controls[0].Visible = false;
            }
            string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =13";
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
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            // Master.ShowError("Select Transmittal to continue");
            RadWindowManager1.RadAlert("Select Transmittal to continue", 400, 150, "Warning", "");
            return;
        }
        string mir_id = ReportsGridView.SelectedValue.ToString();
        General_Functions fun = new General_Functions();
        fun.download_zip(31, mir_id, "ESD", "ESD_SUPP", Response);

    }
}