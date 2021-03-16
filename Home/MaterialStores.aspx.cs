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

public partial class Material_Stores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Stores for " + Session["JOB_CODE"].ToString();
        }
    }
    protected void storeGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void storeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            // Master.ShowWarn("Access Denied!");
            RadWindowManager1.RadAlert("Access denied.", 400, 150, "Warning", "");
            e.Cancel = true;
        }
    }
    protected void btnSubstore_Click(object sender, EventArgs e)
    {
        if (storeGridView.SelectedIndexes.Count <= 0)
        {
            // Master.ShowMessage("Select the entire store!");
            RadWindowManager1.RadAlert("Select the store!", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("MaterialStoresSub.aspx?STORE_ID=" + storeGridView.SelectedValue.ToString());
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("STORE_ADD"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        Response.Redirect("MaterialStoresRegister.aspx");
    }
 
  
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }

    protected void storeGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }

    }

    protected void storeGridView_DataBinding(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            storeGridView.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)storeGridView.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "STORE_NAME";
            GridButtonColumn gridbutton = (GridButtonColumn)storeGridView.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            storeGridView.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("ADMIN"))
        {
            storeGridView.AllowAutomaticUpdates = false;
        }
        else
        {
            storeGridView.AllowAutomaticUpdates = true;
        }
    }
}