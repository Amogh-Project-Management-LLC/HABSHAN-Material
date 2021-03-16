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
using System.IO;
using Telerik.Web.UI;
using System.Data.SqlClient;

public partial class Mrr_Irn_items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Mrr Irn Items";
        }
    }
    

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceive.aspx");
    }



    protected void MrrGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit") 
        {
            if (!WebTools.UserInRole("MRR_IRN_UPDATE"))
            {
                Master.ShowWarn("Access denied!");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MRR_IRN_DELETE"))
            {
                Master.ShowWarn("Access denied!");
            }
        }


    }
    protected void Rad_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem edititem = (GridEditableItem)e.Item;
            RadComboBox radcombo = (RadComboBox)edititem.FindControl("rdcmbSource1");
            radcombo.DataSource = IrnDataSource;
            radcombo.DataTextField = "IRN_NO";
            radcombo.DataValueField = "IRN_ID";
            radcombo.DataBind();
        }
    }

    



    protected void OnSelectedIndexChangedHandler(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Session["IRN_ID"] = e.Value;
        
    }
    protected void OnItemDataBoundHandler(object sender, GridItemEventArgs e)
    {
        if (e.Item.IsInEditMode)
        {
            GridEditableItem item = (GridEditableItem)e.Item;

            if (!(e.Item is IGridInsertItem))
            {
                RadComboBox combo = (RadComboBox)item.FindControl("RadComboBox1");

                RadComboBoxItem selectedItem = new RadComboBoxItem();
                selectedItem.Text = ((DataRowView)e.Item.DataItem)["IRN_NO"].ToString();
                selectedItem.Value = ((DataRowView)e.Item.DataItem)["IRN_ID"].ToString();
                combo.Items.Add(selectedItem);

                selectedItem.DataBind();

                Session["IRN_ID"] = selectedItem.Value;
            }
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        
        if (!EntryTable.Visible)
        {
            btnSave.Visible = true;
            EntryTable.Visible = true;
        }
        else
        {
            btnSave.Visible = false;
            EntryTable.Visible = false;
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            MrrViewDataSource.Insert();
            Master.ShowMessage("Saved succesfully!");

        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}

