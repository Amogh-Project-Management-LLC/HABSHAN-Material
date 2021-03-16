using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_SmlForLineMto : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Line MTO Simulation");
        }
    }

    protected void btnLineMtoSmlRun_Click(object sender, EventArgs e)
    {
        try
        {
            //CHECK status of 
            //1. PO link
            //2. IDF simulation 
            //if not running then proceed

            string po_status = "", line_sml_run_status = "", run_option = "";
            run_option = LineselectOption.SelectedValue;

            line_sml_run_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='LINE_MTO_SIMULATION'");

            if (line_sml_run_status.Equals("RUNNING"))
            {
                Master.show_info("Line MTO Simulation is already running!!!");
                return;
            }

            po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");

            //If IDF simulation and PO, both are completed
            if (!po_status.Equals("RUNNING"))
            {
                string sql = "";
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");
                if (run_option.Equals("ALL"))
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET RUN_OPTION='ALL' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");
                else
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET RUN_OPTION='CUSTOM' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");

                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='LINE_MTO_SIMULATION'");
                WebTools.ExeSql(sql);
                Master.show_info("You request is under process, please wait...");
            }

            //If IDF simulation is not running
            else
            {
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");
                if (run_option.Equals("ALL"))
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET RUN_OPTION='ALL' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");
                else
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET RUN_OPTION='CUSTOM' WHERE  PROCESS_NAME='LINE_MTO_SIMULATION'");
                lblMessage.Text = "You request is under process, please wait...";
            }
            Master.show_info("Process started, Please close the window");
        }
        catch (Exception exc)
        {
            if (exc.Message.Contains("ORA-27478"))
                Master.show_info("Simulation is already running !!!");
            else
                Master.show_error(exc.Message);
        }
    }
}