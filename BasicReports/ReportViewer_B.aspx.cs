using dsFieldReportsATableAdapters;
using dsFieldReportsBTableAdapters;
using dsSuppReportsATableAdapters;
using dsWeldingReportsCTableAdapters;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;
using dsMaterialReportsATableAdapters;
using dsNDE_ReportsCTableAdapters;

//using dsScaffoldingTableAdapters;

public partial class BasicReports_ReportViewer_B : System.Web.UI.Page
{
    public int post_bks;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            string Arg1, Arg2, Arg3;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Arg3 = Request.QueryString["Arg3"];
            post_bks = 0;

            switch (ReportID)
            {
                case "7":
                    VIEW_TRACER_JOINTS_REPTableAdapter rep_7 = new VIEW_TRACER_JOINTS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\Welding\Tracer_Joints_Rep.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_TRACER_JOINTS_REP",
                        (DataTable)rep_7.GetData(
                            decimal.Parse(Session["PROJECT_ID"].ToString()),
                            decimal.Parse(Request.QueryString["SUB_CON_ID"])
                            )));
                    break;

                case "10":
                    VIEW_SUPP_EREC_ISOTableAdapter rep_10 = new VIEW_SUPP_EREC_ISOTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\PipeSupport\SupportReceiveInstallIsome.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSuppReportsA_VIEW_SUPP_EREC_ISO",
                        (DataTable)rep_10.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "11":
                case "12":
                    VIEW_SUPP_EREC_AREA_L1TableAdapter rep_11 = new VIEW_SUPP_EREC_AREA_L1TableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\PipeSupport\SupportReceiveInstallAreaL1.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSuppReportsA_VIEW_SUPP_EREC_AREA_L1",
                        ReportID == "11" ?
                        (DataTable)rep_11.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["AREA_L1"]
                        )
                        :
                        (DataTable)rep_11.GetDataByAREA_L2(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["AREA_L2"]
                        )
                        ));
                    break;

                case "13":
                    VIEW_SPL_FIELD_REP_ATableAdapter rep_13 = new VIEW_SPL_FIELD_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\SpoolFieldStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_SPL_FIELD_REP_A",
                        (DataTable)rep_13.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "14":
                    VIEW_WELDING_REP_FIELD_ATableAdapter rep_14 = new VIEW_WELDING_REP_FIELD_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\WeldingFieldStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_WELDING_REP_FIELD_A",
                        (DataTable)rep_14.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["SC_ID"]),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "15":
                    VIEW_FLUID_REPTableAdapter rep_15 = new VIEW_FLUID_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\FluidWiseStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_FLUID_REP",
                        (DataTable)rep_15.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "16":
                    VIEW_FJC_FOREMAN_REP_ATableAdapter rep_16 = new VIEW_FJC_FOREMAN_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\FieldJobcardWiseStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_FJC_FOREMAN_REP_A",
                        (DataTable)rep_16.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "17":
                    VIEW_FOREMAN_REP_ATableAdapter rep_17 = new VIEW_FOREMAN_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\ForemanWiseStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_FOREMAN_REP_A",
                        (DataTable)rep_17.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "18":
                    VIEW_SIZE_RANGE_SPL_REPTableAdapter rep_18 = new VIEW_SIZE_RANGE_SPL_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\SpoolFieldStatusRange.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsA_VIEW_SIZE_RANGE_SPL_REP",
                        (DataTable)rep_18.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "19":
                    VIEW_ISO_BOM_REP_ATableAdapter rep_19 = new VIEW_ISO_BOM_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\MaterialShortageField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsB_VIEW_ISO_BOM_REP_A",
                        (DataTable)rep_19.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"]
                        )));
                    break;

                case "20":
                    VIEW_ISO_BOM_REP_ATableAdapter rep_20 = new VIEW_ISO_BOM_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\FieldReports\IsomeMaterialStatus.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsFieldReportsB_VIEW_ISO_BOM_REP_A",
                        (DataTable)rep_20.GetDataTotal(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["AREA_L1"],
                        Request.QueryString["ISO_TITLE1"]
                        )));
                    break;

                //Material Reports
                case "30":
                    VIEW_SG_MTO_VS_PAINT_JCTableAdapter rep_30 = new VIEW_SG_MTO_VS_PAINT_JCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\Material\SpoolgenQtyVsPaintJobcard.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_30.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "31":
                    VIEW_RT_CLASS_SIZETableAdapter rep_31 = new VIEW_RT_CLASS_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\NDE\RT10_ClassSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_31.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                //Weekly Reports
                case "101":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_SG_STATUS_REP_ATableAdapter rep_101 = new dsWeeklyReport_AxsdTableAdapters.VIEW_SG_STATUS_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\SG_Status_AreaWise_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_101.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;
                case "102":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_SPL_REPORT_IDTableAdapter rep_102 = new dsWeeklyReport_AxsdTableAdapters.VIEW_SPL_REPORT_IDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\Spool_Summary_Inch_Dia.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_102.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;
                case "103":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_SPL_REPORT_SPLTableAdapter rep_103 = new dsWeeklyReport_AxsdTableAdapters.VIEW_SPL_REPORT_SPLTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\Spool_Summary_spl_count.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_103.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;
                case "104":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_ISO_FAB_STATUS_AREATableAdapter rep_104 = new dsWeeklyReport_AxsdTableAdapters.VIEW_ISO_FAB_STATUS_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\ISO_RELEASE_FAB_STATUS_ID.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_104.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;
                case "105":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_ISO_FAB_STATUS_SPL_COUNTTableAdapter rep_105 = new dsWeeklyReport_AxsdTableAdapters.VIEW_ISO_FAB_STATUS_SPL_COUNTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\ISO_RELEASE_FAB_STATUS_SPL.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_105.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;
                case "106":
                    dsWeeklyReport_AxsdTableAdapters.VIEW_CLIENT_HOLD_STATUSTableAdapter rep_106 = new dsWeeklyReport_AxsdTableAdapters.VIEW_CLIENT_HOLD_STATUSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\WeeklyReport\Hold_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_106.GetData()));
                    break;
            }
        }
    }

    protected void ReportPreview_SubreportProcessing(Object sender, SubreportProcessingEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        switch (ReportID)
        {
            case "200":
                //PIP_JOINT_REVTableAdapter jnt_rev = new PIP_JOINT_REVTableAdapter();
                //e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //    "dsWeldingReportsB_PIP_JOINT_REV", jnt_rev.GetData()));
                break;
        }
    }
}