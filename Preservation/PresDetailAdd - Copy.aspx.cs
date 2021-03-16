using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Preservation_PresDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage("Add Preservation Report");
        }
    }

    
    //protected void ddlSCList_DataBinding(object sender, EventArgs e)
    //{
    //    ddlSCList.Items.Clear();
    //    ddlSCList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select Subcon)", ""));
    //}
    protected void txtAutoMatCode_EntryAdded(object sender, Telerik.Web.UI.AutoCompleteEntryEventArgs e)
    {
        //int count = txtAutoMatCode.Entries.Count;
        //if (count > 1)
        //{
        //    txtAutoMatCode.Entries.RemoveAt(count - 1);
        //    Master.show_error("Only One Material Code can be Selected.");
        //    return;
        //}
        //hiddenMatID.Value = txtAutoMatCode.Entries[0].Value;
    }
    protected void ddlMirList_DataBinding(object sender, EventArgs e)
    {
        //ddlSubStore.Items.Clear();
        //ddlSubStore.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
    protected void ddlMirList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        //txtQuantity.Text = WebTools.GetExpr(
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsPreservationTableAdapters.VIEW_PRES_MAT_DETAILTableAdapter pres_mat = new dsPreservationTableAdapters.VIEW_PRES_MAT_DETAILTableAdapter();
        try
        {
            decimal mir_id = 0;
            decimal mat_id = 0;
            decimal qty = 0;
            DateTime date;
            //bool flg = decimal.TryParse(ddlSubStore.SelectedValue.ToString(), out mir_id);
            //if (!flg)
            //    throw new ApplicationException("Invalid Substore Selection.");

            //flg = decimal.TryParse(txtAutoMatCode.Entries[0].Value, out mat_id);
            //if (!flg)
            //    throw new ApplicationException("Invalid Material Code.");

            //flg = DateTime.TryParse(txtDate.SelectedDate.ToString(), out date);
            //if (!flg)
            //    throw new ApplicationException("Invalid Date Selection.");

            //flg = decimal.TryParse(txtQuantity.Text, out qty);
            //if (!flg || qty == 0)
            //    throw new ApplicationException("Quantity should be more than 0.");

            //pres_mat.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), mat_id, qty, txtReportNo.Text, date, txtInspBy.Text, txtRemarks.Text,
            //    decimal.Parse(ddlSCList.SelectedValue), decimal.Parse(ddlSubStore.SelectedValue));
            Master.show_success("Preservation Data Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            pres_mat.Dispose();
        }
    }

    protected void ddlSCList_DataBinding1(object sender, EventArgs e)
    {
        //ddlSCList.Items.Clear();
        //ddlSCList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
}