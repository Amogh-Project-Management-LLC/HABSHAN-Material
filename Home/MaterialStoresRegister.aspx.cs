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

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Store register";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStores.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql;
        sql = "INSERT INTO STORES_DEF (PROJECT_ID, STORE_NAME, SC_ID) VALUES(" +
            Session["PROJECT_ID"].ToString() + ",'" + txtStore.Text + "'," + cboSubcon.SelectedValue.ToString() + ")";
        General_Functions.ExeSql(sql);
        Master.ShowMessage("Store created successfully!");
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i <= cboSubcon.Items.Count; i++)
            {
                if (cboSubcon.Items[i].Value.ToString() == conn_as)
                {
                    cboSubcon.SelectedIndex = i;
                    break;
                }
            }
            cboSubcon.Enabled = false;
        }
    }
}