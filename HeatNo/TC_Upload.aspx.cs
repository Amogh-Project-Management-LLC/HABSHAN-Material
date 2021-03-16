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

public partial class HeatNo_TC_Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnGrab_Click(object sender, EventArgs e)
    {
        upload_pdf();
    }
    void upload_pdf()
    {
        try
        {
            string path = tcDetailsView.Rows[2].Cells[1].Text;
            if (path == "")
            {
                Master.ShowWarn("directory not selected!");
                return;
            }
            string file_name = path + "\\" + tcDetailsView.Rows[0].Cells[1].Text + ".pdf";
            System.IO.File.Delete(file_name);
            pdfUpload.SaveAs(file_name);
            go_back();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void go_back()
    {
        Response.Redirect("TC_Index.aspx?Filter=" + Request.QueryString["Filter"] + "&grdIndex=" + Request.QueryString["grdIndex"]);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        go_back();
    }
    protected void tcDetailsView_DataBound(object sender, EventArgs e)
    {
        try
        {
            string file_name = tcDetailsView.Rows[2].Cells[1].Text + "\\" + tcDetailsView.Rows[0].Cells[1].Text + ".pdf";
            if (System.IO.File.Exists(file_name))
            {
                Master.ShowMessage("Pdf already uploaded! Old Pdf will replace with the new Pdf.");
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}   
