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
            Master.HeadingMessage = "Heat Numbers - MTC";
        }
    }

    protected void btnMore_Click(object sender, EventArgs e)
    {
        if (MTC.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire test certificate!");
            return;
        }
        Response.Redirect("~/HeatNo/TC_Details.aspx?TC_ID=" +
            MTC.SelectedValue.ToString() + "&Filte=");
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
}