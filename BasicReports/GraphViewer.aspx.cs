using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BasicReports_GraphViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID = Request.QueryString["ReportID"].ToString();
            string Arg1 = Request.QueryString["Arg1"];
            string Arg2 = Request.QueryString["Arg2"];
            string Arg3 = Request.QueryString["Arg3"];
            string Arg4 = Request.QueryString["Arg4"];

            switch (ReportID)
            {
                case "1":
                    AmoghReportsLibrary.Fab_Spool_Status grph003 = new AmoghReportsLibrary.Fab_Spool_Status();
                    grph003.ReportParameters["ROWFROM"].Value = Arg1;
                    grph003.ReportParameters["ROWTO"].Value = Arg2;
                    ReportViewer1.ReportSource = grph003;
                    break;

                case "2":
                    AmoghReportsLibrary.Spl_milestone_rep grph013 = new AmoghReportsLibrary.Spl_milestone_rep();
                    grph013.ReportParameters["FROMMONTH"].Value = Arg1;
                    grph013.ReportParameters["TOMONTH"].Value = Arg2;
                    grph013.ReportParameters["SUBCONID"].Value = Arg3;
                    ReportViewer1.ReportSource = grph013;
                    break;

                case "3":
                    AmoghReportsLibrary.Spool_Inch_Dia_Summary1 grph004 = new AmoghReportsLibrary.Spool_Inch_Dia_Summary1();
                    grph004.ReportParameters["FROMMONTH"].Value = Arg1;
                    grph004.ReportParameters["TOMONTH"].Value = Arg2;
                    grph004.ReportParameters["SUBCONID"].Value = Arg3;
                    ReportViewer1.ReportSource = grph004;
                    break;

                case "4":
                    AmoghReportsLibrary.Weekly_Repair_Prcnt g4 = new AmoghReportsLibrary.Weekly_Repair_Prcnt();
                    g4.ReportParameters["DATEFROM"].Value = Arg1;
                    g4.ReportParameters["DATETO"].Value = Arg2;
                    g4.ReportParameters["WELDERID"].Value = Arg3;
                    ReportViewer1.ReportSource = g4;
                    break;

                case "6":
                    AmoghReportsLibrary.FabricationPlan fab_plan = new AmoghReportsLibrary.FabricationPlan();
                    fab_plan.ReportParameters["PROJECTID"].Value = Session["PROJECT_ID"].ToString();
                    fab_plan.ReportParameters["FROMMONTH"].Value = Arg1;
                    fab_plan.ReportParameters["TOMONTH"].Value = Arg2;
                    ReportViewer1.ReportSource = fab_plan;
                    break;
            }
        }
    }
}