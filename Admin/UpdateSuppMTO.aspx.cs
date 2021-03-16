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
using System.IO;
using System.Web.Hosting;
using System.Linq;
using System.Data.OracleClient;
using System.Globalization;
using System.Data.OleDb;
using System.Text;

public partial class UpdateSuppMTO : System.Web.UI.Page
{
    private long file_size = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Update Support MTO";

            if (!WebTools.UserInRole("ADMIN"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    
    protected void btnRun_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string set_param = "dbms_scheduler.set_job_argument_value(job_name => 'JOB_UPDATE_SPL_BOM', argument_position => {0}, argument_value => {1});";

        string arg_1 = Session["PROJECT_ID"].ToString(); // proj_id

        sb.Append("BEGIN");
        sb.AppendLine();
        sb.Append(string.Format(set_param, 1, arg_1));
        sb.AppendLine();
        sb.Append("dbms_scheduler.enable('JOB_UPDATE_SPL_BOM');");
        sb.AppendLine();
        sb.Append("END;");

        WebTools.ExecNonQuery(sb.ToString());
        
        Master.ShowSuccess("Update MTO Started!");
    }
}