using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_SmlForIdfMto : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("IDF MTO Simulation");
        }
    }

    protected void btnIDFMtoSmlRun_Click(object sender, EventArgs e)
    {
        try
        {
            //CHECK status of 
            //1. PO link
            //2. IDF simulation 
            //if not running then proceed

            string po_status = "", idf_sml_run_status = "", idf_option = "";
            idf_option = IDFselectOption.SelectedValue;

            idf_sml_run_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IDF_MTO_SIMULATION'");

            if (idf_sml_run_status.Equals("RUNNING"))
            {
                lblMessage.Text = "IDF MTO Simulation is already running!!!";
                return;
            }

            po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");

            //If IDF simulation and PO, both are completed
            if (!po_status.Equals("RUNNING"))
            {
                string sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='IDF_MTO_SIMULATION'"); ;

                if (idf_option.Equals("ALL"))
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING', RUN_OPTION='ALL' WHERE  PROCESS_NAME='IDF_MTO_SIMULATION'");
                else
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING', RUN_OPTION='CUSTOM' WHERE  PROCESS_NAME='IDF_MTO_SIMULATION'");

                WebTools.ExeSql(sql);
                lblMessage.Text = "You request is under process, please wait...";
            }

            //If IDF simulation is not running
            else
            {
                if (idf_option.Equals("ALL"))
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN', RUN_OPTION='ALL' WHERE  PROCESS_NAME='IDF_MTO_SIMULATION'");
                else
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN', RUN_OPTION='CUSTOM' WHERE  PROCESS_NAME='IDF_MTO_SIMULATION'");
                lblMessage.Text = "You request is under process, please wait...";
            }
            lblMessage.Text = "Process started, Please close the window";
        }
        catch (Exception exc)
        {
            if (exc.Message.Contains("ORA-27478"))
                lblMessage.Text = "Job Simulation is already running !!!";
            else
                lblMessage.Text = exc.Message;
        }
    }
}