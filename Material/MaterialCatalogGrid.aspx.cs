using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI.PersistenceFramework;
using Telerik.Web.UI;

public partial class MaterialCatalogGrid : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Catalog";
            Master.AddModalPopup("~/Material/MaterialStockRegister.aspx", btnRegister.ClientID, 550, 750);
            try
            {
                if (Session["CATLOG_SESSION"] != null)
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

    protected void btnBack_Click(object sender, EventArgs e)
    {

        Response.Redirect("~/Home/Default.aspx");
    }

    protected void btnStatus_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select Status to continue.");
            return;
        }
        Response.Redirect("MaterialStatus.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }

   
    protected void btnSummary_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select Status to continue.");
            return;
        }
        Response.Redirect("MaterialStock_Recon_A.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MaterialStockRegister.aspx");
    }
    protected void btnPOdepend_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnRecvd_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            Response.Redirect("MaterialStock_Received.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnMRIR_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            Response.Redirect("MaterialStock_MRIR.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            //Response.Redirect("MaterialStock_HeatNo.aspx?MAT_ID=" + itemsGrid.SelectedValue);
            Response.Redirect("../HeatNo/MatWiseHeatNo.aspx?MAT_ID=" + itemsGrid.SelectedValue);
        
    }
    protected void btnTrans_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            Response.Redirect("MaterialStock_Transfer.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnAddIssue_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_Additional.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_MTC.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnJC_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count > 0)
            Response.Redirect("MaterialStock_JC.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStatusView.aspx?MAT_ID=" + itemsGrid.SelectedValue);
    }


    protected void itemsGrid_PreRender(object sender, EventArgs e)
    {

        SessionStorageProvider.StorageProviderKey = "CATLOG_SESSION";
        RadPersistenceManager1.SaveState();

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



    protected void itemsGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        itemsGrid.ToolTip = "Double Click on Row To See Material Total Status";
    }

    protected void btnImportMat_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BulkImport/BulkReportImport.aspx?IMPORT_ID=16");
    }
}