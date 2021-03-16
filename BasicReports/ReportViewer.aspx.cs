using dsDCS_ReportsTableAdapters;
using dsIsomeReportsATableAdapters;
using dsJcReports_ATableAdapters;
using dsJcReportsTableAdapters;
using dsNDE_ReportsATableAdapters;
using dsNDE_ReportsBTableAdapters;
using dsNDE_ReportsCTableAdapters;
using dsNDE_ReportsDTableAdapters;
using dsSpoolReportsATableAdapters;
using dsSpoolReportsCTableAdapters;
using dsWelderPerformanceTableAdapters;
using dsWeldingReportsATableAdapters;
using dsWeldingReportsBTableAdapters;
using dsWeldingReportsCTableAdapters;
using dsWeldingReportsDTableAdapters;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;

public partial class Default2 : System.Web.UI.Page
{
    public int post_bks;

    protected void Page_Load(object sender, EventArgs e)
    {
        //DCS Reports 100-199
        //Spool Reports 200-299
        //PO Shipping Reports 300-399
        //Weekly Reports 400-499
        if (!IsPostBack)
        {
            //Using query string expressions.
            //ReportID, Arg1, Arg2, Arg3, ...
            string ReportID;
            String Arg1, Arg2, Arg3, Arg4;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Arg3 = Request.QueryString["Arg3"];
            Arg4 = Request.QueryString["Arg4"];
            post_bks = 0;

            switch (ReportID)
            {
                case "1.1": //Fitup Report - Joint wise shop
                    VIEW_FITUP_REPORT_STableAdapter fitup_report_s = new VIEW_FITUP_REPORT_STableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyFitup_Joint_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_FITUP_REPORT_S",
                        (DataTable)fitup_report_s.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.1.1": //Fitup Report - Joint wise field
                    VIEW_FITUP_REPORT_FTableAdapter fitup_report_f = new VIEW_FITUP_REPORT_FTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyFitup_Joint_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_FITUP_REPORT_F",
                        (DataTable)fitup_report_f.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.2": //Welding Report - Joint wise shop
                case "1.2.2":
                    if (ReportID == "1.2")
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_Shop.rdlc"; // Std
                    else
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_ShopJGC.rdlc"; // JGC

                    VIEW_WELDING_REPORT_STableAdapter welding_report_s = new VIEW_WELDING_REPORT_STableAdapter();
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_WELDING_REPORT_S",
                        (DataTable)welding_report_s.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.2.1": //Welding Report - Joint wise field
                    VIEW_WELDING_REPORT_FTableAdapter welding_report_f = new VIEW_WELDING_REPORT_FTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_WELDING_REPORT_F",
                        (DataTable)welding_report_f.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "2": //Fitup and Welding Summary - Material wise
                    VIEW_WELDING_REPORT_MAT_TYPETableAdapter welding_report_sf = new VIEW_WELDING_REPORT_MAT_TYPETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_MatWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_MAT_TYPE",
                        (DataTable)welding_report_sf.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "2.1": //Fitup and Welding Summary - Material wise
                    VIEW_WELDING_REPORT_FIELD_MATTableAdapter rep_02P1 = new VIEW_WELDING_REPORT_FIELD_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_MatWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_MAT",
                        (DataTable)rep_02P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "3": //Fitup and Welding Summary - Area wise
                    VIEW_WELDING_REPORT_AREATableAdapter welding_report_sf_area = new VIEW_WELDING_REPORT_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_AreaWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_AREA",
                        (DataTable)welding_report_sf_area.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "3.1": //Fitup and Welding Summary Field - Area wise
                    VIEW_WELDING_REPORT_FIELD_AREATableAdapter rep_03P1 = new VIEW_WELDING_REPORT_FIELD_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_AreaWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_AREA",
                        (DataTable)rep_03P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4": //Fitup and Welding Summary - Size wise
                    VIEW_WELDING_REPORT_JNT_SIZETableAdapter welding_report_sf_size = new VIEW_WELDING_REPORT_JNT_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_SizeWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_JNT_SIZE",
                        (DataTable)welding_report_sf_size.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4.1": //Fitup and Welding Summary Field - Size wise
                    VIEW_WELDING_REPORT_FIELD_SIZETableAdapter rep_04P1 = new VIEW_WELDING_REPORT_FIELD_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_SizeWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_SIZE",
                        (DataTable)rep_04P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4.2": //Fitup and Welding Summary Field - Fab Shop Wise
                    VIEW_WELDING_REPORT_FAB_SHOPTableAdapter rep_04P2 = new VIEW_WELDING_REPORT_FAB_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_ShopWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_FAB_SHOP",
                        (DataTable)rep_04P2.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "5": //Welder Performance Report
                    VIEW_WELDER_PERF_REPORTTableAdapter welder_perf = new VIEW_WELDER_PERF_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\welder_performance.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "5.1": //Welder Performance Report - Monthly - Welderwise
                    VIEW_WELDER_PERF_REPORT_ATableAdapter rep_5_1 = new VIEW_WELDER_PERF_REPORT_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\welder_performance_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_5_1.GetData(
                        Arg1, Arg2,
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3)
                        )));
                    break;
                //PMI
                case "6": //PMI Summary Material wise - shop
                    VIEW_PMI_STATUS_SHOPTableAdapter pmi_status_mat_s = new VIEW_PMI_STATUS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PMI_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PMI_STATUS_SHOP",
                        (DataTable)pmi_status_mat_s.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "7": //PMI Summary Material wise - Field
                    VIEW_PMI_STATUS_FIELDTableAdapter pmi_status_mat_f = new VIEW_PMI_STATUS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PMI_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PMI_STATUS_FIELD",
                        (DataTable)pmi_status_mat_f.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;
                //-----------------------------------------------PWHT
                case "8": //PWHT Summary Material wise - shop
                    VIEW_PWHT_STATUS_SHOPTableAdapter pwht_status_mat_s = new VIEW_PWHT_STATUS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_STATUS_SHOP",
                        (DataTable)pwht_status_mat_s.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "9": //PWHT Summary Material wise - Field
                    VIEW_PWHT_STATUS_FIELDTableAdapter pwht_status_mat_f = new VIEW_PWHT_STATUS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_STATUS_FIELD",
                        (DataTable)pwht_status_mat_f.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                //Fitup Backlog
                //Welding Backlog
                case "10":
                case "11":
                    VIEW_WO_FITUP_WELDING_BACKLOGTableAdapter rep_0010 = new VIEW_WO_FITUP_WELDING_BACKLOGTableAdapter();
                    if (ReportID == "10")
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupBackLog.rdlc";
                        ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                            "DataSet1",
                            (DataTable)rep_0010.GetData(
                            decimal.Parse(Session["PROJECT_ID"].ToString()),
                            decimal.Parse(Arg1)
                            )));
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\WeldingBackLog.rdlc";
                        ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                            "DataSet1",
                            (DataTable)rep_0010.GetWeldingBackLog(
                            decimal.Parse(Session["PROJECT_ID"].ToString()),
                            decimal.Parse(Arg1)
                            )));
                    }
                    break;

                //Repair Status
                case "12":
                    VIEW_RT_REP_ATableAdapter rep_12 = new VIEW_RT_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Repair.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A",
                        (DataTable)rep_12.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "12.1":
                    VIEW_RT_REP_A_PRODTableAdapter rep_12_1 = new VIEW_RT_REP_A_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Repair_Prod.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A_PROD",
                        (DataTable)rep_12_1.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "12.2":
                    VIEW_RT_REP_A_WELD_DATETableAdapter rep_12_2 = new VIEW_RT_REP_A_WELD_DATETableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\NDE\NDE_RT_RepairWeldDate.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A_WELD_DATE",
                        (DataTable)rep_12_2.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "13":
                    VIEW_PWHT_PCWBS_SHOPTableAdapter rep_13 = new VIEW_PWHT_PCWBS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\PCWBS_PWHT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_PCWBS_SHOP",
                        (DataTable)rep_13.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["Arg1"])
                        )));
                    break;

                case "13.1":
                    VIEW_PWHT_PCWBS_FIELDTableAdapter rep_13_1 = new VIEW_PWHT_PCWBS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\PCWBS_PWHT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_PCWBS_FIELD",
                        (DataTable)rep_13_1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["Arg1"])
                        )));
                    break;

                //29-July-2015
                case "14"://NDE(Other) Back Log shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_0014 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_0014.GetDataFab(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]))));
                    break;

                case "14.1"://NDE(RT) Back Log Shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P1 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P1.GetDataByFabRedo(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 2)));
                    break;

                case "14.2"://NDE(RT) reshoot/ retake shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P2 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Redo_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P2.GetDataByFabRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 3)));
                    break;

                case "14.3"://NDE(RT) Back Log field
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P3 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P3.GetDataByFieldRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 2)));
                    break;

                case "14.5"://NDE(RT) reshoot/ retake field
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P5 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Redo_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P5.GetDataByFieldRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 3)));
                    break;

                case "14.6"://NDE(Other) Back Log filed
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P6 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P6.GetDataByField(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]))));
                    break;

                //Welder Performance
                case "15": //Welder Performance Report (Material wise)
                    VIEW_WELDER_PERF_REPORT_MATTableAdapter welder_perf_mat = new VIEW_WELDER_PERF_REPORT_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformanceMat.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_mat.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "16": //Welder Performance Report (Percent wise)
                    VIEW_WELDER_PERF_REPORT_PRCNTTableAdapter welder_perf_prnct = new VIEW_WELDER_PERF_REPORT_PRCNTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformancePercent.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_prnct.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "17": //Welder Performance Report (Size wise)
                    VIEW_WELDER_PERF_REPORT_SIZETableAdapter welder_perf_size = new VIEW_WELDER_PERF_REPORT_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformanceSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_size.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "18": //Isometric Joints Staus
                    VIEW_ISOME_JOINTS_REPTableAdapter isome_joints = new VIEW_ISOME_JOINTS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeJointsSummary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_ISOME_JOINTS_REP",
                        (DataTable)isome_joints.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Arg1)));
                    break;

                case "19": //Isometric NDE Staus
                    VIEW_ISOME_NDE_REPTableAdapter isome_nde = new VIEW_ISOME_NDE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeNDE_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_ISOME_NDE_REP",
                        (DataTable)isome_nde.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Arg1)));
                    break;

                case "20":
                    //VIEW_WELDER_NDE_STATUS_ATableAdapter rep_20 = new VIEW_WELDER_NDE_STATUS_ATableAdapter();
                    VIEW_WELDER_NDE_STATUS_BTableAdapter rep_20 = new VIEW_WELDER_NDE_STATUS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\WelderRT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_20.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                //case "20": //Isometric issuance Staus
                //    VIEW_ISOME_ISSUE_REPTableAdapter isome_issue = new VIEW_ISOME_ISSUE_REPTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeIssue.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsMatIssueA_VIEW_ISOME_ISSUE_REP",
                //        (DataTable)isome_issue.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), Arg2)));
                //    break;

                //case "21": //Isometric available Staus
                //    VIEW_ISOME_AVAIL_REPTableAdapter isome_avail = new VIEW_ISOME_AVAIL_REPTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeAvailable.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsMatIssueA_VIEW_ISOME_AVAIL_REP",
                //        (DataTable)isome_avail.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), Arg2)));
                //    break;

                case "22": //Isometric fabrication Staus
                    //Nothing...
                    break;

                case "23": //New Tracer Report
                    VIEW_TRACER_REPORT_ATableAdapter rep_23 = new VIEW_TRACER_REPORT_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Tracer_Joints_Rep_New.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsD_VIEW_TRACER_REPORT_A",
                        (DataTable)rep_23.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "25": //PTMT summary piping class wise - shop
                    VIEW_PTMT_STATUS_SHOPTableAdapter ptmt_status_mat_s = new VIEW_PTMT_STATUS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_PTMT_STATUS_SHOP",
                        (DataTable)ptmt_status_mat_s.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "26": //PTMT summary piping class wise - Field
                    VIEW_PTMT_STATUS_FIELDTableAdapter ptmt_status_mat_f = new VIEW_PTMT_STATUS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_PTMT_STATUS_FIELD",
                        (DataTable)ptmt_status_mat_f.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "27": //RTUT summary piping class wise - shop
                    VIEW_RTUT_STATUS_SHOPTableAdapter rtut_status_mat_s = new VIEW_RTUT_STATUS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RTUT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RTUT_STATUS_SHOP",
                        (DataTable)rtut_status_mat_s.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "28": //RTUT summary piping class wise - Field
                    VIEW_RTUT_STATUS_FIELDTableAdapter rtut_status_mat_f = new VIEW_RTUT_STATUS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RTUT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RTUT_STATUS_FIELD",
                        (DataTable)rtut_status_mat_f.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                //12-Jul-2013
                //================================================
                case "29": //RTUT summary piping class wise - Field
                    VIEW_FIELD_JOINTSTableAdapter rep_29 = new VIEW_FIELD_JOINTSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\Welding\DailyWelding_Joint_RepNo.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_FIELD_JOINTS",
                        (DataTable)rep_29.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["WELD_REP_NO"]
                        )));
                    break;

                //HT-SHOP
                case "30":
                    VIEW_HT_REP_A_SHOPTableAdapter rep_30 = new VIEW_HT_REP_A_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_HT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_30.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "31":
                    VIEW_HT_REP_A_FIELDTableAdapter rep_31 = new VIEW_HT_REP_A_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_HT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_31.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                //FT-Shop
                case "32":
                    VIEW_FT_REP_A_SHOPTableAdapter rep_32 = new VIEW_FT_REP_A_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_FT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_32.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                //FT-Field
                case "33":
                    VIEW_FT_REP_A_FIELDTableAdapter rep_33 = new VIEW_FT_REP_A_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_FT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_33.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "42": //Jc wise status
                    VIEW_JC_STATUS_ATableAdapter jc_status_a = new VIEW_JC_STATUS_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\JC_Status_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_A_VIEW_JC_STATUS_A",
                        (DataTable)jc_status_a.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                //============================================
                // D  C  S    R  E  P  O  R  T  S
                //============================================
                case "102"://Erection joint history sheet
                    VIEW_SPL_CLR_HSTableAdapter erec_hs = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Erection\\Erection_HistorySheet.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_CLR_HS",
                        (DataTable)erec_hs.GetData(Decimal.Parse(Arg1))));
                    break;
                case "102.1": //Erection Joint History Sheet -- Joint Categroy Wise
                    VIEW_SPL_CLR_HSTableAdapter erec_hs_1 = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Erection\\Erection_HistorySheet.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_CLR_HS",
                        (DataTable)erec_hs_1.GetDataByCatID(Decimal.Parse(Arg1), decimal.Parse(Request.QueryString["CAT_ID"].ToString()))));                    
                    break;
                case "104"://spoolgen status area wise
                    VIEW_SG_STATUS_BTableAdapter sg_status_b = new VIEW_SG_STATUS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusB.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_SG_STATUS_B",
                        (DataTable)sg_status_b.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "105"://spoolgen status lot wise
                    VIEW_ISOME_REP_BTableAdapter isome_rep_b = new VIEW_ISOME_REP_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusC.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_ISOME_REP_B",
                        (DataTable)isome_rep_b.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "106"://spoolgen status Size wise

                    VIEW_SG_STATUS_SIZETableAdapter isome_rep_size = new VIEW_SG_STATUS_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_SG_STATUS_SIZE",
                        (DataTable)isome_rep_size.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "107"://spoolgen status Area Wise, Size wise

                    VIEW_SG_STATUS_AREA_SIZETableAdapter rep_107 = new VIEW_SG_STATUS_AREA_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusAreaSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_107.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                //============================================
                // S  P  O  O  L      R  E  P  O  R  T  S
                //============================================
                case "200"://Spool History Sheet - A
                    VIEW_SPL_CLR_HSTableAdapter rep_200 = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolClear_HistorySheet_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_200.GetDataBySPL_ID(decimal.Parse(Arg1))));
                    break;

                case "202"://Spool id area wise
                    VIEW_SPL_ID_REP_AREATableAdapter spool_0202 = new VIEW_SPL_ID_REP_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryArea_ID.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA",
                        (DataTable)spool_0202.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "202.1":
                    VIEW_SPL_ID_REP_AREA_SCTableAdapter spool_2021 = new VIEW_SPL_ID_REP_AREA_SCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryArea_SPL.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA_SC",
                        (DataTable)spool_2021.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))
                        ));
                    break;

                case "202.3"://Spool id Mat wise
                    VIEW_SPL_ID_REP_MATTableAdapter spool_0203 = new VIEW_SPL_ID_REP_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryMat_ID.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_MAT",
                        (DataTable)spool_0203.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "202.4": // Spool id area wise/ Mat wise
                case "202.5":
                    VIEW_SPL_ID_REP_AREA_BTableAdapter spool_0203_4 = new VIEW_SPL_ID_REP_AREA_BTableAdapter();
                    if (ReportID == "202.4")
                    {
                        if (Request.QueryString["AGUG"] == "1")
                        {
                            ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_ID_AG.rdlc";
                        }
                        else if (Request.QueryString["AGUG"] == "2")
                        {
                            ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_ID_UG.rdlc";
                        }
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_SPL.rdlc";
                    }

                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA_B",
                        (DataTable)spool_0203_4.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["AGUG"]
                        )));
                    break;

                case "203"://SFR Release
                    VIEW_SFR_RELEASETableAdapter sfr_release_a = new VIEW_SFR_RELEASETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SFR_Release_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)sfr_release_a.GetData(decimal.Parse(Arg1))));
                    break;

                case "203.1"://SFR Release - project 1
                    VIEW_SPL_CLR_HS_MATTableAdapter rep_203_1 = new VIEW_SPL_CLR_HS_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SingleMaterialSpoolClear.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_203_1.GetData(Decimal.Parse(Arg1))));
                    break;

                //CRD Date wise Shop Inch Dia Status
                case "204"://SFR Release - project 1
                    VIEW_CRD_DATE_INCH_DIATableAdapter rep_2014 = new VIEW_CRD_DATE_INCH_DIATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\Spool\CRD_Date_InchDia.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2014.GetData(Decimal.Parse(
                        Session["PROJECT_ID"].ToString()
                        ))));
                    break;

                //case "206"://spool site summary
                //    VIEW_SPL_ID_REP_ERECTableAdapter rep_0206 = new VIEW_SPL_ID_REP_ERECTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolStatus_Erec.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsSpoolReportsC_VIEW_SPL_ID_REP_EREC", rep_0206.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                //    break;

                case "207"://Spool id subcon wise
                    VIEW_SPL_ID_REP_SC_AGUGTableAdapter spool_0207 = new VIEW_SPL_ID_REP_SC_AGUGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummarySC_AGUG.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsC_VIEW_SPL_ID_REP_SC_AGUG",
                        (DataTable)spool_0207.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "210"://Jobcard joints status
                    VIEW_WO_JNTS_SUMMARY_ATableAdapter wo_jnts = new VIEW_WO_JNTS_SUMMARY_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\JC_Joints.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_WO_JNTS_SUMMARY_A",
                        (DataTable)wo_jnts.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;
            }
        }
    }

    protected void ReportPreview_SubreportProcessing(Object sender, SubreportProcessingEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        switch (ReportID)
        {
            case "102":
            case "200":
            case "200.1":
            case "203":
            case "203.1":
                PIP_JOINT_REVTableAdapter jnt_rev = new PIP_JOINT_REVTableAdapter();
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsWeldingReportsB_PIP_JOINT_REV",
                    (DataTable)jnt_rev.GetData()));
                break;

            case "20":
                VIEW_RT_DEFECTTableAdapter rt_defect = new VIEW_RT_DEFECTTableAdapter();
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "DataSet2",
                    (DataTable)rt_defect.GetData()));
                break;
        }
    }
}