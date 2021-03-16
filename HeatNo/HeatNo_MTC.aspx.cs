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

public partial class HeatNo_HeatNo_MTC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heat_no = Request.QueryString["HEAT_NO"];

            Master.HeadingMessage = "MTC * " + heat_no;

            WebTools.Check_Session_Variable("popup_TC_ID");

            Master.AddModalPopup("~/HeatNo/ShowMTC_PDF.aspx", btnPDF.ClientID, 20, 500);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HeatNoIndex.aspx");
    }
    protected void btnPDF_Click(object sender, EventArgs e)
    {
        if (MTC.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire test certificate!");
            return;
        }
        string path = WebTools.GetTC_Path(Decimal.Parse(MTC.SelectedValue.ToString()));
        if (path == null)
        {
            Master.ShowWarn("Cant find the pdf for selected tc!");
        }
        else
        {
            Response.Redirect(path);
        }
    }
    protected void MTC_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_TC_ID"] = MTC.SelectedValue.ToString();
    }
    protected void MTC_DataBound(object sender, EventArgs e)
    {
        if (MTC.Items.Count > 0)
        {
            //MTC.Items[0].Selected = true;
            //Session["popup_TC_ID"] = MTC.Items[0].Value.ToString();
        }
    }
}