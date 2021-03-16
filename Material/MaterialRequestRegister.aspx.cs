using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialCTableAdapters;

public partial class Material_MaterialRequestRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // set_req_no();
        Master.HeadingMessage("Material Request - Register");
        if (!IsPostBack)
        {
            if (Session["MR_FROM_STORE_ID"] != null)
            {
                ddlReqFrom.SelectedValue = Session["MR_FROM_STORE_ID"].ToString();
                set_req_no(Session["MR_FROM_STORE_ID"].ToString(), Session["MR_FROM_STORE_NAME"].ToString());
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string mat_req_id;
        VIEW_MATERIAL_REQUESTTableAdapter mrir = new VIEW_MATERIAL_REQUESTTableAdapter();
        try
        {
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            mrir.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtRequestNo.Text,
                decimal.Parse(ddDiscipline.SelectedValue.ToString()), txtReqDate.SelectedDate,
                ddlReqFrom.SelectedText, decimal.Parse(ddlStoreList.SelectedValue), txtRemarks.Text,RadSubAreaDDL.SelectedText,RadAreaDDL.SelectedText,decimal.Parse(user_id));
            mat_req_id = WebTools.GetExpr("MAT_REQ_ID", "MATERIAL_REQUEST", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND MAT_REQ_NO='" + txtRequestNo.Text + "'");
            Master.show_success("Material Request " + txtRequestNo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            mrir.Dispose();
        }
    }
   
    protected void ddlStoreList_DataBinding(object sender, EventArgs e)
    {
        ddlStoreList.Items.Clear();
        ddlStoreList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlReqFrom_DataBinding(object sender, EventArgs e)
    {
        ddlReqFrom.Items.Clear();
        ddlReqFrom.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlReqFrom_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        Session["MR_FROM_STORE_ID"] = ddlReqFrom.SelectedValue;
        Session["MR_FROM_STORE_NAME"] = ddlReqFrom.SelectedText;
        set_req_no(ddlReqFrom.SelectedValue,ddlReqFrom.SelectedText);
    }

    private void set_req_no(string from_store_id,string from_store_name)
    {
        //  string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        string prefix = "MAT-REQ-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = '" + from_store_id + "')") + "-";
        txtRequestNo.Text = WebTools.NextSerialNo("MATERIAL_REQUEST", "MAT_REQ_NO", prefix, 4, " REQ_FROM ='" + from_store_name + "'");
    }

}