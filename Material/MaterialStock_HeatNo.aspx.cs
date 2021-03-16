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

public partial class Material_Reports_Material_Stock_HeatNo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Stock - Heat Nos";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialCatalogGrid.aspx");
    }
    protected void btnMore_Click(object sender, EventArgs e)
    {
        if (heatNos.SelectedIndex < 0) return;
        Response.Redirect("HeatNo_MTC.aspx?MAT_ID=" + Request.QueryString["MAT_ID"] +
            "&HEAT_NO=" + heatNos.SelectedValue.ToString());
    }
    //protected void heatNos_DataBound(object sender, EventArgs e)
    //{
    //    if (heatNos.Items.Count == 0)
    //    {
    //        btnMTC.Enabled = false;
    //    }
    //    else
    //    {
    //        heatNos.Items[0].Selected = true;
    //    }
    //}
}