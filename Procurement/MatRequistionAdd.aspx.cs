using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Procurement_BTableAdapters;

public partial class Procurement_MatRequistionAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New Material Requisition");

            
        }
        txtStatus.Text = "ISSUED";
        if (txtMRDate.SelectedDate == null)
        {
            txtMRDate.SelectedDate = System.DateTime.Today;
        }
        else
        {
            txtMRDate.SelectedDate = txtMRDate.SelectedDate; 
        }
        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
        //    VIEW_ADAPTER_MRTableAdapter mr = new VIEW_ADAPTER_MRTableAdapter();
        //    mr.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtMRNo.Text,txtMRDate.SelectedDate.Value, txtRevision.Text, txtMRTitle.Text, txtDisCode.Text,
        //        txtStatus.Text, decimal.Parse(user_id), txtRemarks.Text, decimal.Parse(ddlDiscipline.SelectedValue),mrType.SelectedValue.ToString());
        //    Master.show_success(txtMRNo.Text + " Added Successfully.");
        //}
        //catch (Exception ex)
        //{
        //    Master.show_error(ex.Message);
        //}
        try
        {
            string project_id = Session["PROJECT_ID"].ToString();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
            AddHeaderDataSource.InsertParameters["CREATE_BY"].DefaultValue = user_id;
            AddHeaderDataSource.InsertParameters["PROJECT_ID"].DefaultValue = project_id;
            string code_exist = WebTools.GetExpr("UPPER(MR_NO)", "AMOGH.PIP_MAT_REQUISITION", " WHERE UPPER(MR_NO)='" + txtMRNo.Text.ToUpper().Trim() + "'");
            if (code_exist != txtMRNo.Text.ToUpper().Trim())
            {
                AddHeaderDataSource.Insert();
                Master.show_success(" Saved succesfully!");
            }
            else
            {
                Master.show_error(code_exist + " Exist in Module!");
            }
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlDiscipline_DataBinding(object sender, EventArgs e)
    {
        ddlDiscipline.Items.Clear();
        ddlDiscipline.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlDiscipline_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtDisCode.Text = WebTools.GetExpr("DISCIPLINE_CODE", "DISCIPLINE_DEF", " WHERE DISCIPLINE_ID='" + ddlDiscipline.SelectedValue + "'");
    }
}