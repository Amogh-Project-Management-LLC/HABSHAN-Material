using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;

public partial class Procurement_POBatchPlan : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Manufacturing Batch Plan";
            Master.AddModalPopup("~/Procurement/POBatchCreate.aspx", btnCreate.ClientID, 620, 900);
            //   Master.AddModalPopup("~/Procurement/POBatchRevNew.aspx", btnRevision.ClientID, 600, 800);
            Master.AddModalPopup("~/Procurement/BatchItemsSearch.aspx", btnSearchItems.ClientID, 600, 1000);
            Master.RadGridList = itemsGrid.ClientID;

            try
            {
                if (Session["PoBatch_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    itemsGrid.Rebind();

                }
            }
            catch (Exception ex)
            {

            }
        }
       

    }


    protected void btnBatchItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Please select a record to continue.");
            return;
        }
        Response.Redirect("POBatchDetail.aspx?Batch_ID=" + itemsGrid.SelectedValue);
    }



    protected void btnRevision_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Please select a record to continue.");
            return;
        }
        Response.Redirect("BatchRevision.aspx?Batch_ID=" + itemsGrid.SelectedValue);
    }


    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("BATCH_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("BATCH_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
      
    }

//protected void btnBulkImport_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=12&RetUrl=~/Procurement/POBatchPlan.aspx");
//    }
    


    protected void ddlStatus_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (ddlStatus.SelectedValue != "")
        {
            if (!WebTools.UserInRole("BATCH_ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                return;
            }
            if (itemsGrid.SelectedIndexes.Count == 0)
            {
                Master.ShowWarn("Please select a record to continue.");
                return;
            }
            try
            {
                string batch_id = itemsGrid.SelectedValue.ToString();
                string sql = "UPDATE PIP_PO_BATCH_PLAN SET STATUS='" + ddlStatus.SelectedValue + "' WHERE BATCH_ID=" + batch_id;
                WebTools.ExeSql(sql);
                RadWindowManager1.RadAlert("Batch Status Updated.", 300, 150, "Success", "");
            }
            catch (Exception ex)
            {
                Master.ShowError(ex.Message);
            }
            itemsGrid.Rebind();
            ddlStatus.DataBind();
        }

    }

    protected void ddlRevStatus_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (ddlRevStatus.SelectedValue != "")
        {
            if (!WebTools.UserInRole("BATCH_ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                return;
            }
            if (itemsGrid.SelectedIndexes.Count == 0)
            {
                Master.ShowWarn("Please select a record to continue.");
                return;
            }
            try
            {
                string batch_id = itemsGrid.SelectedValue.ToString();
                string rev_id = WebTools.GetExpr("REV_ID", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID=" + batch_id);
                if (rev_id == "")
                {
                    RadWindowManager1.RadAlert("No Revision Exists.", 300, 150, "Warning", "");
                    return;
                }

                string sql = "UPDATE PIP_PO_BATCH_REV SET REV_STATUS='" + ddlRevStatus.SelectedValue + "' WHERE REV_ID=" + rev_id;
                WebTools.ExeSql(sql);
                RadWindowManager1.RadAlert("Revision Status Updated.", 300, 150, "Success", "");
            }
            catch (Exception ex)
            {
                Master.ShowError(ex.Message);
            }
            itemsGrid.Rebind();
            ddlRevStatus.DataBind();
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

        SessionStorageProvider.StorageProviderKey = "PoBatch_SESSION";
        RadPersistenceManager1.SaveState();
    }

    protected void bulkBatchImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=8&RetUrl=~/Procurement/POBatchPlan.aspx");
    }
}
