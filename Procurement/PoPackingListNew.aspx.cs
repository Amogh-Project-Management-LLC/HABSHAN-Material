using PO_PackingListTableAdapters;
using System;

public partial class PoPackingListNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Packing List - New";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_MAT_PK_LISTTableAdapter issue = new VIEW_MAT_PK_LISTTableAdapter();
        try
        {
            issue.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtPackingListNo.Text,
                txtPoNo.Text,
                txtVendorName.Text,
                txtCargoReadyDate.SelectedDate,
                txtFOB_Date.SelectedDate,
                txtPortOfLoading.Text,
                txtStorageCode.Text,
                txtRemarks.Text);

            Master.ShowMessage(txtPackingListNo.Text + " Saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("PoPackingList.aspx");
    }
}