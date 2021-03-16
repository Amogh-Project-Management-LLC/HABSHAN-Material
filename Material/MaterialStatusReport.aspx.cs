using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialStatusReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MATERIAL STATUS (MSR)";
            //itemsGrid.ClientSettings.Scrolling.UseStaticHeaders = true;
        }
    }

    protected void btnPO_Click(object sender, EventArgs e)
    {
        if(itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnReceived_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_Received.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnMRIR_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_MRIR.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnJCIssued_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_JC.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_iso_mto.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnMTO_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_LineMTO.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlDownloadSource, "Material_Status_Report.xls");
    }

    protected void btndownShort_Click(object sender, EventArgs e)
    {
        //WebTools.ExportDataSetToExcel(sqlDownShort, "Material_Shortage.xls");
    }

    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_HeatNo.aspx?MAT_ID=" + itemsGrid.SelectedValue.ToString());
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_MTC.aspx?MAT_ID=" + itemsGrid.SelectedValue.ToString());
    }

    protected void btnAddIssue_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_Additional.aspx?MAT_ID=" + itemsGrid.SelectedValue.ToString());
    }

    protected void btnTrans_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        Response.Redirect("MaterialStock_Transfer.aspx?MAT_ID=" + itemsGrid.SelectedValue.ToString());
    }

    protected void btnStore_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStatusReportStore.aspx");
    }

    protected void itemsGrid_ColumnCreated(object sender, Telerik.Web.UI.GridColumnCreatedEventArgs e)
    {
        
            e.Column.AutoPostBackOnFilter = true;
            e.Column.FilterControlWidth = Unit.Percentage(50);
        
    }
}