using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using Procurement_BTableAdapters;
using Procurement_CTableAdapters;

public partial class Procurement_ReportViewer : System.Web.UI.Page
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
                case "1":
                    VIEW_PO_IRN_HEADER_REPTableAdapter rep_1 = new VIEW_PO_IRN_HEADER_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\InspectionReleaseNote.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_1.GetData(decimal.Parse(Arg1))));

                    VIEW_PO_IRN_DETAIL_REPTableAdapter rep_2 = new VIEW_PO_IRN_DETAIL_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\InspectionReleaseNote.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet2",
                        (DataTable)rep_2.GetData(decimal.Parse(Arg1))));

                    VIEW_PO_IRN_RESULTTableAdapter rep_3 = new VIEW_PO_IRN_RESULTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\InspectionReleaseNote.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet3",
                        (DataTable)rep_3.GetData(decimal.Parse(Arg1))));

                    VIEW_PO_IRN_REPORT_TYPETableAdapter rep_4 = new VIEW_PO_IRN_REPORT_TYPETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\InspectionReleaseNote.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet4",
                        (DataTable)rep_4.GetData(decimal.Parse(Arg1))));
                    break;
                case "10.2":
                    //dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_REPTableAdapter mrir_c = new dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_REPTableAdapter();
                    VIEW_PO_INSP_REQUEST_REPTableAdapter rfi = new VIEW_PO_INSP_REQUEST_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\po_rfi.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rfi.GetData(decimal.Parse(Arg1))));
                    break;
                case "11":
                    VIEW_PO_REPORTTableAdapter rep_11 = new VIEW_PO_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\PurchaseOrder.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_11.GetData(decimal.Parse(Arg1))));
                    break;
                case "12":
                    VIEW_MR_REPORTTableAdapter rep_12 = new VIEW_MR_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Procurement\\Reports\\MatRequisition.rdlc";
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