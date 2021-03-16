using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsLogistics_ATableAdapters;
using Microsoft.Reporting.WebForms;

public partial class Logistics_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            String Arg1, Arg2, Arg3;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Arg3 = Request.QueryString["Arg3"];
            Master.HeadingMessage = "Preview Report";
            switch (ReportID)
            {
                case "11":
                    VIEW_SCN_REPORTTableAdapter rep_11 = new VIEW_SCN_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Logistics\\Reports\\ShippingNotification.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_11.GetData(decimal.Parse(Arg1))));
                    break;
                case "12":
                    VIEW_SRN_PACKING_LISTTableAdapter rep_12 = new VIEW_SRN_PACKING_LISTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Logistics\\Reports\\PackingList.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_12.GetData(decimal.Parse(Arg1))));
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