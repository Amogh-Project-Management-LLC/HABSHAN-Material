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

public partial class BasicReports_NDE_NDE_BackLog_Joints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "NDE back log joints";
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
            rblCat.Enabled = false;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (NdeType.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the NDE type!");
            return;
        }
        string report_id = "";
        switch (rblCat.SelectedValue.ToString())
        {
            case "1"://It's shop
                if (NdeType.SelectedValue.ToString() == "1" && RtType.SelectedValue.ToString() != "4")//RT
                {
                    if (RtType.SelectedValue.ToString() == "1")
                    { report_id = "14.1"; }//Repair shop
                    else if (RtType.SelectedValue.ToString() == "2")
                    { report_id = "14.2"; }//Reshoot /Retake shop
                    else
                    { report_id = "14"; }
                }
                else//Other NDE
                {
                    report_id = "14";
                }
                break;
            case "2"://It's field
                if (NdeType.SelectedValue.ToString() == "1" && RtType.SelectedValue.ToString() != "4")//RT
                {
                    if (RtType.SelectedValue.ToString() == "1")
                    { report_id = "14.3"; }//Repair field
                    else if (RtType.SelectedValue.ToString() == "2")
                    { report_id = "14.5"; }//Reshoot/ Retake field
                    else
                    { report_id = "14.6"; }
                }
                else//Other NDE
                {
                    report_id = "14.6";
                }
                break;
        }//End switch

        String url = String.Format("ReportViewer.aspx?ReportID={0}&NDE_TYPE_ID={1}&SC_ID={2}",
            report_id,
            NdeType.SelectedValue.ToString(),
            cboSubcon.SelectedValue.ToString());
        Response.Redirect(url);
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void NdeType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (NdeType.SelectedValue.ToString() == "1")
        {
            RtType.Enabled = true;
        }
        else
        {
            RtType.Enabled = false;
        }
    }
    protected void rblCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            cboSubcon.Items.Clear();
            cboSubcon.Items.Add(new ListItem("-Select-", "99"));
        }
    }
    protected void NdeType_DataBound(object sender, EventArgs e)
    {
        if (NdeType.Items.Count > 0)
        {
            NdeType.Items[0].Selected = true;
        }
    }
}