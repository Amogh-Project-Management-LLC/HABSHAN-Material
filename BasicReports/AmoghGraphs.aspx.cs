using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BasicReports_AmoghGraphs : System.Web.UI.Page
{
    string queryString = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Graphical Reports";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql1 = string.Empty;
        string sql2 = string.Empty;
        string sql3 = string.Empty;
        switch (RadioButtonList1.SelectedValue)
        {
            case "1":
                SetFilter(true, true, false, false, false, false);
                sql1 = "SELECT DISTINCT ROW_NUM, MONTH FROM VIEW_SPL_SITE_RCV_REP_A ORDER BY ROW_NUM";
                SetddlFromMonth(sql1, "MONTH", "ROW_NUM");
                SetddlToMonth(sql1, "MONTH", "ROW_NUM");
                break;

            case "2":
            case "3":
                SetFilter(true, true, false, false, true, false);
                //sql1 = "SELECT DISTINCT MONTH_ID, MONTH_DESC FROM VIEW_SPL_MILESTONE_GRAPH_A ORDER BY MONTH_ID";
                sql1 = "SELECT DISTINCT TO_CHAR(TODAY_DATE, 'YY') || TO_CHAR(TODAY_DATE, 'MM') AS MONTH_ID, " +
                  "TO_CHAR(TODAY_DATE, 'MON') ||'-'|| TO_CHAR(TODAY_DATE, 'YY') AS MONTH_DESC " +
                    "FROM PROJ_CALENDAR " +
                    "WHERE  TO_CHAR(TODAY_DATE, 'YY') <= TO_CHAR(SYSDATE, 'YY') " +
                    "ORDER BY TO_CHAR(TODAY_DATE, 'YY') || TO_CHAR(TODAY_DATE, 'MM')";
                SetddlFromMonth(sql1, "MONTH_DESC", "MONTH_ID");
                SetddlToMonth(sql1, "MONTH_DESC", "MONTH_ID");
                break;

            //case "3":
            //    SetFilter(true, true, false, false, true, false);
            //    sql1 = "SELECT DISTINCT MONTH_ID, MONTH_DESC FROM VIEW_SPL_INCH_DIA_GRAPH ORDER BY MONTH_ID";
            //    SetddlFromMonth(sql1, "MONTH_DESC", "MONTH_ID");
            //    SetddlToMonth(sql1, "MONTH_DESC", "MONTH_ID");
            //    break;

            case "4":
                SetFilter(true, true, false, false, false, true);
                sql1 = "SELECT DISTINCT CREATE_MONTH FROM VIEW_MONTHLY_REPAIR_REP ORDER BY CREATE_MONTH";
                SetddlFromMonth(sql1, "CREATE_MONTH", "CREATE_MONTH");
                SetddlToMonth(sql1, "CREATE_MONTH", "CREATE_MONTH");
                break;

            case "6":
                SetFilter(true, true, false, false, false, false);
                sql1 = "SELECT DISTINCT MONTH_ID, MONTH_LETTER FROM VIEW_FAB_PLAN_C ORDER BY MONTH_ID";
                SetddlFromMonth(sql1, "MONTH_LETTER", "MONTH_ID");
                SetddlToMonth(sql1, "MONTH_LETTER", "MONTH_ID");
                break;
        }
    }

    protected void SetddlFromMonth(string sql, string TextField, string ValueField)
    {
        sqlFromMonthSource.SelectCommand = sql;
        ddlFromMonth.DataSource = sqlFromMonthSource;
        ddlFromMonth.DataTextField = TextField;
        ddlFromMonth.DataValueField = ValueField;
        ddlFromMonth.DataBind();
    }

    protected void SetddlToMonth(string sql, string TextField, string ValueField)
    {
        sqlToMonthSource.SelectCommand = sql;
        ddlToMonth.DataSource = sqlToMonthSource;
        ddlToMonth.DataTextField = TextField;
        ddlToMonth.DataValueField = ValueField;
        ddlToMonth.DataBind();
    }

    protected void SetFilter(bool IsfromMonth, bool IstoMonth, bool Isfromdate, bool Istodate, bool Issubcon, bool IsWelderVisible)
    {
        fromMonth.Visible = IsfromMonth;
        toMonth.Visible = IstoMonth;
        fromDate.Visible = Isfromdate;
        toDate.Visible = Istodate;
        Subcon.Visible = Issubcon;
        WelderRow.Visible = IsWelderVisible;
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex < 0)
        {
            Master.ShowWarn("Please Select a report to view.");
            return;
        }
        switch (RadioButtonList1.SelectedValue)
        {
            case "1":
            case "6":
                queryString = "ReportID=" + RadioButtonList1.SelectedValue + "&Arg1=" + ddlFromMonth.SelectedValue + "&Arg2=" + ddlToMonth.SelectedValue;
                break;
            case "2":
            case "3":
                queryString = "ReportID=" + RadioButtonList1.SelectedValue + "&Arg1=" + ddlFromMonth.SelectedValue + "&Arg2=" + ddlToMonth.SelectedValue + "&Arg3=" + ddlScList.SelectedValue.ToString();
                break;
            case "4":
                queryString = "ReportID=" + RadioButtonList1.SelectedValue + "&Arg1=" + ddlFromMonth.SelectedValue + "&Arg2=" + ddlToMonth.SelectedValue + "&Arg3=" + ddWelder.SelectedValue.ToString();
                break;
        }
        Response.Redirect("GraphViewer.aspx?" + queryString);

    }

    protected void ddlScList_DataBinding(object sender, EventArgs e)
    {
        ddlScList.Items.Clear();
        ddlScList.Items.Add(new ListItem("(Select Sub-Contractor)", ""));
    }

    protected void ddlFromMonth_DataBinding(object sender, EventArgs e)
    {
        ddlFromMonth.Items.Clear();
        ddlFromMonth.Items.Add(new ListItem("(Select)", ""));
    }

    protected void ddlToMonth_DataBinding(object sender, EventArgs e)
    {
        ddlToMonth.Items.Clear();
        ddlToMonth.Items.Add(new ListItem("(Select)", ""));
    }
}