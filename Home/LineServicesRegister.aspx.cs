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
using dsGeneralTableAdapters;

public partial class LineServicesRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Line sevices register";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_LINE_SERVICETableAdapter service = new PIP_LINE_SERVICETableAdapter();
        try
        {
            service.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtLineSrv.Text, txtDescr.Text,
                cboPriority.SelectedValue.ToString(), txtRemarks.Text);
            Master.ShowMessage("Line service created successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            service.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineServices.aspx");
    }
}