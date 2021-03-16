using dsJcReports_ATableAdapters;
using dsMatIssueATableAdapters;
using dsMatReportATableAdapters;
using dsPO_ReportsATableAdapters;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;
using dsMaterialATableAdapters;
using dsMaterialCTableAdapters;
using dsPO_ShipmentATableAdapters;
using dsMaterial_IssueATableAdapters;
using System.Configuration;
using System.Data.OracleClient;

public partial class Material_ReportViewer : System.Web.UI.Page
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
                    VIEW_MAT_RET_REPTableAdapter rep_1 = new VIEW_MAT_RET_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Return_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_1.GetData(decimal.Parse(Arg1))));
                    break;
                case "5":
                    VIEW_MATERIAL_REQ_REPTableAdapter mat_req = new VIEW_MATERIAL_REQ_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MaterialRequestForm.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMaterialD_VIEW_MATERIAL_REQ_REP",
                        (DataTable)mat_req.GetData(Decimal.Parse(Arg1))));
                    break;
                case "9":
                    VIEW_MRIR_SUMMARYTableAdapter mrir = new VIEW_MRIR_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\JcMRIR_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPO_ReportsA_VIEW_MRIR_SUMMARY",
                        (DataTable)mrir.GetData(decimal.Parse(Arg1))));
                    break;
                case "9.1":
                    VIEW_MRIR_SUMMARYTableAdapter mrir91 = new VIEW_MRIR_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Material_Receive_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mrir91.GetData(decimal.Parse(Arg1))));
                    break;               
                case "10":
                    VIEW_MRIR_ESDTableAdapter mrir_a = new VIEW_MRIR_ESDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Piping_MRIR_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mrir_a.GetData(decimal.Parse(Arg1))));
                    break;
                case "10.1":
                    VIEW_MRIR_ESDTableAdapter mrir_b = new VIEW_MRIR_ESDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MatInsp_cpecc.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mrir_b.GetData(decimal.Parse(Arg1))));
                    break;
                case "10.2":
                    dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_REPTableAdapter mrir_c = new dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MatInsp_cpecc.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mrir_c.GetData(decimal.Parse(Arg1))));
                    break;
                case "11":
                    VIEW_ADD_ISSUE_REPTableAdapter add_miv = new VIEW_ADD_ISSUE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\AddMIV_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMatIssueA_VIEW_ADD_ISSUE_REP",
                        (DataTable)add_miv.GetData(decimal.Parse(Arg1))));
                    break;
                case "11.1":
                    VIEW_ADD_ISSUE_REPTableAdapter add_miv1 = new VIEW_ADD_ISSUE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MaterialIssue_cpecc.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)add_miv1.GetData(decimal.Parse(Arg1))));
                    break;

                case "12":
                    VIEW_ADD_ISSUE_REM_REPTableAdapter add_miv_rem = new VIEW_ADD_ISSUE_REM_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\AddMIV_PipeRemain.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMatIssueA_VIEW_ADD_ISSUE_REM_REP",
                        (DataTable)add_miv_rem.GetData(decimal.Parse(Arg1))));
                    break;

                case "12.1":
                    VIEW_ADD_ISSUE_BOM_REPTableAdapter add_miv_bom = new VIEW_ADD_ISSUE_BOM_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\AddMIV_BOM.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMatIssueA_VIEW_ADD_ISSUE_BOM_REP",
                        (DataTable)add_miv_bom.GetData(decimal.Parse(Arg1))));
                    break;

                case "13":
                case "13.1":
                    VIEW_PAINT_BLK_REPTableAdapter blk_pnt = new VIEW_PAINT_BLK_REPTableAdapter();
                    if (ReportID == "13")
                    {
                        ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Bulk_Paint.rdlc";
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Bulk_Paint_MaterialReq.rdlc";
                    }
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMatReportA_VIEW_PAINT_BLK_REP",
                        (DataTable)blk_pnt.GetData(Decimal.Parse(Arg1))));
                    break;

                case "22":
                    VIEW_MAT_TRANSF_REPTableAdapter mat_transf = new VIEW_MAT_TRANSF_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Material_Transfer.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMatReportA_VIEW_MAT_TRANSF_REP",
                        (DataTable)mat_transf.GetData(Decimal.Parse(Arg1))));
                    break;

                case "23":
                    VIEW_TOTAL_SUBSTITUTETableAdapter mat_sub = new VIEW_TOTAL_SUBSTITUTETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Material_Substitution.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mat_sub.GetData(Decimal.Parse(Arg1))));
                    break;
                case "24":
                    VIEW_MAT_REUSE_REPTableAdapter mat_reuse = new VIEW_MAT_REUSE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\Material_Reuse.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)mat_reuse.GetData(Decimal.Parse(Arg1))));
                    break;

                case "30":
                    VIEW_TOTAL_POTableAdapter rep_30 = new VIEW_TOTAL_POTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\PO_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_30.GetData(Decimal.Parse(Arg1))));
                    break;
                case "32":
                    dsMaterialDTableAdapters.VIEW_QUARANTINE_REPTableAdapter rep_32 = new dsMaterialDTableAdapters.VIEW_QUARANTINE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\QuanrantineSummary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_32.GetData(Decimal.Parse(Arg1))));
                    break;
                case "33":
                    dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_REPTableAdapter rep_33 = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MaterialReceive_MTN.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_33.GetData(Decimal.Parse(Arg1))));
                    break;
                case "34":
                    dsMaterialBTableAdapters.VIEW_ESD_REPORTTableAdapter esd = new dsMaterialBTableAdapters.VIEW_ESD_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\ESD_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsProcReps_B_VIEW_ESD_REPORT",
                        (DataTable)esd.GetData(Decimal.Parse(Arg1))));
                    break;
                case "35": //MRR_Weekly_Report
                    VIEW_MRR_WEEKLY_REPORTTableAdapter MRRWeekly_Rep = new VIEW_MRR_WEEKLY_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MRR_Weekly_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "MRRWeeklyReport",
                        (DataTable)MRRWeekly_Rep.GetData(DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2))));
                    break;
                case "36":  //MIV_Weekly_Report
                    dsPO_ShipmentATableAdapters.VIEW_ADAPTER_ISSUE_ADD_DETAILTableAdapter MIVreport = new dsPO_ShipmentATableAdapters.VIEW_ADAPTER_ISSUE_ADD_DETAILTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\MIV_Weekly_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "MIVWeeklyReport",
                        (DataTable)MIVreport.GetData(DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2))));
                    break;
                case "37": //VIEW_DPR_WEEKLY
                    VIEW_DPR_WEEKLYTableAdapter DPRWeekly_Rep = new VIEW_DPR_WEEKLYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\DPR_Weekly_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "VIEW_DPR_WEEKLY",
                        (DataTable)DPRWeekly_Rep.GetData(Arg1,Arg2)));

                    VIEW_DPR_PIP_WEEKLYTableAdapter DPRPIPWeekly_Rep = new VIEW_DPR_PIP_WEEKLYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\DPR_Weekly_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "VIEW_DPR_PIP_WEEKLY",
                        (DataTable)DPRPIPWeekly_Rep.GetData(Arg1, Arg2)));
                    VIEW_DPR_ELEC_WEEKLYTableAdapter DPRelecWeekly_Rep = new VIEW_DPR_ELEC_WEEKLYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Material\\Reports\\DPR_Weekly_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "VIEW_DPR_ELEC_WEEKLY",
                        (DataTable)DPRelecWeekly_Rep.GetData(Arg1, Arg2)));
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