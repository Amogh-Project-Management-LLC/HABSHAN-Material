using Microsoft.Reporting.WebForms;
using System;
using System.Data;
using System.Configuration;
using System.Data.OracleClient;
using RdlcGenerator;
using System.Drawing.Printing;

public partial class Material_ReportViewerDynamic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dsName = WebTools.GetExpr("SOURCE", "IPMS_SYS_EXPORT", "EXPT_ID=" + Request.QueryString["ReportID"]);
            DataTable dt = new DataTable();
            String ConnString = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
            OracleConnection conn = new OracleConnection(ConnString);
            OracleCommand cmd = new OracleCommand("SELECT * FROM " + dsName, conn);
            cmd.CommandType = CommandType.Text;
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);

            ReportGenerator gen = new ReportGenerator(dt, dsName);
            ReportDataSource ds = new ReportDataSource(dsName, dt);
            ReportPreview.Reset();
            ReportPreview.LocalReport.DataSources.Add(ds);

            ReportPreview.LocalReport.DisplayName = dsName;
            ReportPreview.LocalReport.LoadReportDefinition(gen.GeneraReport());
        }

    }
}
    