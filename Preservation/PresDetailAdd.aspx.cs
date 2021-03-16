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
        txtCreateBy.Text = Session["USER_NAME"].ToString();
        txtCreateDate.SelectedDate = System.DateTime.Today;
    }

   
  
   
    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsPreservationTableAdapters.VIEW_PRES_MASTERTableAdapter pres_mat = new dsPreservationTableAdapters.VIEW_PRES_MASTERTableAdapter();
        try
        {
            decimal mir_id = 0;
            decimal mat_id = 0;
            decimal qty = 0;
            DateTime date;

            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");

            pres_mat.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtPresvNo.Text, decimal.Parse(ddlPreservCode.SelectedValue), txtInspBy.Text,txtPreservRep.Text, txtPreservDate.SelectedDate, decimal.Parse(ddlMRIRNo.SelectedValue),decimal.Parse(user_id), txtCreateDate.SelectedDate, txtRemarks.Text);

            Master.show_success("Preservation Registered.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            pres_mat.Dispose();
        }
    }
    
    protected void set_Pres_Seq()
    {
        string prefix = "PRESERV";
        prefix += "-" + ddlMRIRNo.SelectedText.ToString() + "-";
        txtPresvNo.Text = WebTools.NextSerialNo("PRES_MAT", "PRESERV_NO", prefix, 3, " WHERE MIR_ID=" + ddlMRIRNo.SelectedValue.ToString());
    }

    protected void ddlMRIRNo_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        set_Pres_Seq();
    }

    protected void ddlMRIRNo_DataBinding(object sender, EventArgs e)
    {
        ddlMRIRNo.Items.Clear();
        ddlMRIRNo.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlPreservCode_DataBinding(object sender, EventArgs e)
    {
        ddlPreservCode.Items.Clear();
        ddlPreservCode.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
}