using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialQuarantineAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Material Quarantine - Register");
            txtCreateBy.Text = Session["USER_NAME"].ToString();
            txtCreateBy.Enabled = false;
        }
    }

    protected void ddlSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlSubcon.Items.Clear();
        ddlSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        string sc_id = ddlSubcon.SelectedValue;
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + sc_id + "'");
        prefix += "-QRNT-";
        txtQuarantineNo.Text = WebTools.NextSerialNo("PIP_QUARANTINE", "QRNTINE_NO", prefix, 4, " PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND SC_ID='" + ddlSubcon.SelectedValue + "'");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsMaterialDTableAdapters.VIEW_QUARANTINETableAdapter mat = new dsMaterialDTableAdapters.VIEW_QUARANTINETableAdapter();
            mat.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtQuarantineNo.Text, txtCreateBy.Text, txtRemarks.Text, decimal.Parse(ddlSubcon.SelectedValue), decimal.Parse(ddlStore.SelectedValue));
            Master.show_success(txtQuarantineNo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}