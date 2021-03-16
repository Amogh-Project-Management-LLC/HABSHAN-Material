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

public partial class Material_StoresSub : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string store = WebTools.GetExpr("STORE_NAME", "STORES_DEF", " WHERE STORE_ID=" +
                Request.QueryString["STORE_ID"]);
            Master.HeadingMessage = "Stores for " + Session["JOB_CODE"].ToString() + "/ " + store;
        }
    }
    protected void storeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStores.aspx");
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("SUBSTORE_ADD"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        txtStore.Visible = true;
        btnSubmit.Visible = true;
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (storeGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected substore!?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //storeGridView.DeleteRow(storeGridView.SelectedIndex);
            //Master.ShowMessage("Substore deleted successfully!");
            //storeGridView.SelectedIndex = -1;
            dsMaterialATableAdapters.PIP_STORE_SUBTableAdapter substore = new dsMaterialATableAdapters.PIP_STORE_SUBTableAdapter();
            substore.DeleteQuery(decimal.Parse(storeGridView.SelectedValue.ToString()));
            storeGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtStore.Text == "")
        {
            Master.ShowMessage("Enter some thing in textbox!!");
            return;
        }
        try
        {
            General_Functions.ExeSql("INSERT INTO STORES_SUB(STORE_ID,STORE_L1)VALUES(" +
                Request.QueryString["STORE_ID"] + ",'" + txtStore.Text + "')");
            Master.ShowMessage("Substore created successfully. Use refresh button to see the new substore.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}