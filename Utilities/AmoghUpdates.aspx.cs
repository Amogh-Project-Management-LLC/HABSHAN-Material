using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_AmoghUpdates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Amogh Updates";
            //Master.AddModalPopup("~/Utilities/LineMTOImport.aspx", btnLineMTOImport.ClientID, 600, 600);

            RadTabStrip1.Tabs[0].Selected = true;
            RadMultiPage1.SelectedIndex = 0;

            if (Session["LAST_TAB"] != null)
            {
                RadMultiPage1.SelectedIndex = Int32.Parse(Session["LAST_TAB"].ToString());
                RadTabStrip1.SelectedIndex = Int32.Parse(Session["LAST_TAB"].ToString());
            }

            Master.AddModalPopup("~/Utilities/LineMTOImport.aspx", btnLineMTOImport.ClientID, 250, 600);
            Master.AddModalPopup("~/Utilities/ImportIDFMTO.aspx", btnIsoMTOImport.ClientID, 250, 600);
            Master.AddModalPopup("~/Utilities/SmlForLineMto.aspx", btnLineMTOSimulation.ClientID, 200, 400);
            Master.AddModalPopup("~/Utilities/SmlForIdfMto.aspx", btnSimulIsoMTO.ClientID, 200, 400);
            Master.AddModalPopup("~/Utilities/PPCSCustomSrn.aspx", btnSRNUpdate.ClientID, 600, 800);
            Master.AddModalPopup("~/Utilities/CollectPDF.aspx", btnCollectPDF.ClientID, 500, 740);
            //Master.AddModalPopup("~/Utilities/POAddOn.aspx", btnAddOnPO.ClientID, 600, 900);
            disableOptions();
            CheckRunningProcess();
        }
    }

    protected void btnLineMTO_Click(object sender, EventArgs e)
    {
        //Master.HeadingMessage = "Server Click Event";
    }

    protected void disableOptions()
    {
        //btnCollectPDF.Enabled = false;
        btnDeleteUnRegIDF.Enabled = false;
       // btnIsoMTOImport.Enabled = false;
       // btnLineMTOImport.Enabled = false;
        btnSGExcelImport.Enabled = false;
        btnSGTextImport.Enabled = false;

        btnSimulFull.Enabled = false;
       // btnSimulIsoMTO.Enabled = false;
       // btnSimulLineMTO.Enabled = false;
        btnSimulShopBOM.Enabled = false;
        btnSimulSiteBOM.Enabled = false;
        btnSimulTemp.Enabled = false;

        //btnUpdateAll.Enabled = false;
        btnUpdateNDE.Enabled = false;
        //btnUpdatePPCSPO.Enabled = false;
        //btnUpdateSGData.Enabled = false;
        btnUpdateSpoolBOM.Enabled = false;
       // btnUpdateSRN.Enabled = false;
       // btnUpdateTalisman.Enabled = false;
        btnUpdateWelders.Enabled = false;
    }

    protected void btnPOUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            
            string po_status = "", any_update_run_count = "";

            any_update_run_count = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST", "CURRENT_STATUS='RUNNING' "
                + " AND (PROCESS_NAME LIKE '%SIMULATION%' OR PROCESS_GROUP='SERVER_UPDATE')");

            po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");

            if ((po_status.Equals("COMPLETED") || po_status.Equals("REQUEST_TO_RUN"))
                                        && any_update_run_count.Equals("0"))
            {
                string sql = "";
                sql = "UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='IMPORT_PO_DATA'";
                WebTools.ExeSql(sql);

                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='IMPORT_PO_DATA'");
                WebTools.ExeSql(sql);
                Master.ShowMessage("You request is under process, please wait...");
                SetPPCSRunning();
            }
            else if (!po_status.Equals("RUNNING"))
            {
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='IMPORT_PO_DATA'");
                Master.ShowMessage("You request is under process, please wait...");
            }
            else
                Master.ShowWarn("<font color='red'>Sorry, your request can not be processed now !!!</font>");
        }
        catch (Exception exc)
        {
            Master.ShowWarn(exc.Message);
        }
    }

    protected void CheckRunningProcess()
    {
        string status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " PROCESS_NAME = 'IMPORT_PO_DATA'");
        if (status == "RUNNING")
        {
            menuUpdPOLink.Items[0].Text = "Processing";
            menuUpdPOLink.Items[0].Enabled = false;
        }
    }

    protected void SetPPCSRunning()
    {
        string status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " PROCESS_NAME = 'IMPORT_PO_DATA'");
        if (status == "RUNNING")
        {

            menuUpdPOLink.Items[0].Text = "Processing";
            menuUpdPOLink.Items[0].Enabled = false;
        }
    }

    protected void ddPackageSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvExceptions.DataBind();
    }

    protected void ddStepsStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectCommand = "";

        if (!ddStepsStatus.SelectedValue.Equals("ALL"))
        {
            selectCommand = "SELECT * FROM VIEW_RUNNING_PROCESSES WHERE STATUS='" + ddStepsStatus.SelectedValue + "'";
            dsProcesses.SelectCommand = selectCommand;
        }
        dsProcesses.DataBind();
        gvProcesses.DataBind();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            lblPOStatus.Text = "<b>PO Link Update</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'JOB_PO_CLIENT_LINK_UPDATE')", "dual", "1=1");

            lblUpdateStatus.Text = "<b>Server Update</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'JOB_UPDATE_ALL_A')", "dual", "1=1");

            lblSimStatus.Text = "<b>BOM Simulation</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'JOB_SIMULATION_BOM')", "dual", "1=1");
            gvExceptions.DataBind();
            gvProcesses.DataBind();
            lblMessage.Text = "Refreshed !";

        }
        catch (Exception exc)
        {
            lblMessage.Text = exc.Message;
        }
    }

    protected void btnCheckCurrentStatus_Click(object sender, EventArgs e)
    {
        errorTable.Visible = false;
        processTable.Visible = true;
        gvProcesses.DataBind();
    }

    protected void btnStopJobs_Click(object sender, EventArgs e)
    {
        WebTools.exec_non_qry("BEGIN PROC_STOP_JOBS(); END;");
        lblMessage.Text = "All running jobs are stopped";
        gvProcesses.DataBind();
        gvExceptions.DataBind();
    }

    protected void btnCheckException_Click(object sender, EventArgs e)
    {
        errorTable.Visible = true;
        processTable.Visible = false;
        lblMessage.Text = "Please note: Exceptions will be cleared each time when its respective PACKAGE starts running !";
        ddPackageSelect_SelectedIndexChanged(sender, e);
    }

    protected void btnSetFlagCmplt_Click(object sender, EventArgs e)
    {
        WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='COMPLETED'");
        lblMessage.Text = "All running & waiting flags are set as Completed";
        gvProcesses.DataBind();
        gvExceptions.DataBind();
    }

    protected void btnSRNUpdate_Click(object sender, EventArgs e)
    {

    }

    protected void btnSGUpdate_Click(object sender, EventArgs e)
    {
        //menuUpdateSGData.Skin = "Sunset";
        //try
        //{
        //    string any_update_run_count = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST", "CURRENT_STATUS='RUNNING'"
        //    + " AND (PROCESS_GROUP='SERVER_UPDATE'  OR PROCESS_NAME='BOM_SIMULATION'  OR PROCESS_NAME='FULL_SIMULATION' OR PROCESS_NAME='UPDATE_ALL_EXT')");

        //    string sg_data_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='UPDATE_SG_DATA'");

        //    if (any_update_run_count.Equals("0"))
        //    {
        //        string sql = "";
        //        sql = "UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_GROUP='UPDATE_SG_DATA'";
        //        WebTools.ExeSql(sql);
        //        sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='UPDATE_SG_DATA'");
        //        WebTools.ExeSql(sql);
        //        lblMessage.Text = "You request is under process, please wait...";
        //    }
        //    else if (!sg_data_status.Equals("RUNNING"))
        //    {
        //        WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='UPDATE_SG_DATA'");
        //        lblMessage.Text = "You request is under process, please wait...";
        //    }
        //    else
        //        lblMessage.Text = "<font color='red'>Sorry, your request can not be processed now !!!</font>";
        //}
        //catch (Exception exc)
        //{
        //    lblMessage.Text = exc.Message;
        //}
    }

    protected void btnServerUpdate_Click(object sender, EventArgs e)
    {
        menuUpdateAll.Skin = "Sunset";
        try
        {
            string query = "UPDATE SIMULATION_SETTING SET UPDATE_USER='" + Session["USER_NAME"] + "', UPDATE_TIME=TO_CHAR(SYSDATE,'dd-Mon-yyyy (HH:MI AM)')";
            WebTools.exec_non_qry(query);

            string any_update_run_count = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST", "CURRENT_STATUS='RUNNING'"
            + " AND (PROCESS_GROUP='SERVER_UPDATE'  OR PROCESS_NAME='BOM_SIMULATION'  OR  PROCESS_NAME='FULL_SIMULATION'  OR PROCESS_NAME='IMPORT_PO_DATA')");

            string update_all_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='UPDATE_ALL'");

            if (any_update_run_count.Equals("0"))
            {
                string sql = "";
                sql = "UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_GROUP='SERVER_UPDATE'";
                WebTools.ExeSql(sql);
                
                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='UPDATE_ALL'");
                WebTools.ExeSql(sql);
                Master.ShowMessage("You request is under process, please wait...");
            }
            else if (!update_all_status.Equals("RUNNING"))
            {
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='UPDATE_ALL'");
                lblMessage.Text = "You request is under process, please wait...";
            }
            else
                lblMessage.Text = "<font color='red'>Sorry, your request can not be processed now !!!</font>";
        }
        catch (Exception exc)
        {
            lblMessage.Text = exc.Message;
        }
    }

    protected void btnUpdateTalisman_Click(object sender, EventArgs e)
    {
        Response.Redirect("ImportTalismanData.aspx");
    }

    protected void btnAddOnPO_Click(object sender, EventArgs e)
    {
        Response.Redirect("POAddOn.aspx");
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        Session["LAST_TAB"] = RadTabStrip1.SelectedIndex;
    }
}