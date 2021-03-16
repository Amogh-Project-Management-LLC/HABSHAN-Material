using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BatchItemsSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Batch Items");
            string uname = Session["USER_NAME"].ToString();
           
         
        }
    }

   

 

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter batch = new Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter();
        try
        {
          
         //   batch.InsertQuery(txtBatchNo.Text,Session["USER_NAME"].ToString(), System.DateTime.Now, decimal.Parse(ddlPOList.SelectedValue),txtRemarks.Text);
          //  Master.show_success("Batch No " + txtBatchNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            batch.Dispose();
            GC.Collect();
        }
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //decimal batch_no = WebTools.DMax("BATCH_NO", "PIP_PO_BATCH_PLAN", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
       // txtBatchNo.Text = (batch_no + 1).ToString();
    }
}