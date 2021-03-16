using Microsoft.Reporting.WebForms;
using System;
using System.Data;
using dsRemainTransferTableAdapters;

public partial class Material_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            ReportID = Request.QueryString["ReportID"];
            Master.HeadingMessage = "Preview Report";
            switch (ReportID)
            {
                case "1":
                    VIEW_PIPE_REM_TRANSFER_REPTableAdapter rep_1 = new VIEW_PIPE_REM_TRANSFER_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "CuttingPlan\\Reports\\RemainTransfer.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_1.GetData(decimal.Parse(Request.QueryString["TRANSFER_ID"]))
                        ));
                    break;
            }
        }
    }

    protected void ReportPreview_SubreportProcessing(object sender, SubreportProcessingEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        switch (ReportID)
        {
            case "1000":
                //VIEW_CUTLEN_REP_DETAIL_BTableAdapter cutlen_detail_b = new VIEW_CUTLEN_REP_DETAIL_BTableAdapter();
                //e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //    "dsCuttingPlan_VIEW_CUTLEN_REP_DETAIL_B",
                //    (DataTable)cutlen_detail_b.GetData(Decimal.Parse(Request.QueryString["Arg1"]))
                //    ));
                break;
        }
    }
}