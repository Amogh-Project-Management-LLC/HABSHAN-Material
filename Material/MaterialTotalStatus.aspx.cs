using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.ExportInfrastructure;
using xls = Telerik.Web.UI.ExportInfrastructure;
public partial class TotalStatus : System.Web.UI.Page
{
    bool IsExporting = false;
    private xls.ExportStructure structure = new xls.ExportStructure();
    private xls.Table table = new xls.Table();
    private int row = 1;
    private int col = 1;
    private List<RadGrid> gridControlsFound = new List<RadGrid>();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage ("Material Details("+Request.QueryString["MAT_CODE1"]+")");
            MR.MasterTableView.AllowPaging = false;
            MR.Rebind();
            decimal mr_sum = WebTools.DSum("MR_QTY", "VIEW_MAT_REQUISITION","CLIENT_PART_NO='" + Request.QueryString["MAT_CODE1"]+"'");
            lblMrCnt.Text = "Count :"+MR.MasterTableView.Items.Count.ToString();
            lblMrSum.Text = "Sum :" + mr_sum.ToString();

            PO.MasterTableView.AllowPaging = false;
            PO.Rebind();
            decimal po_sum = WebTools.DSum("PO_QTY", "VIEW_PO_REPORT_MAIN", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblPoCnt.Text = "Count :" + PO.MasterTableView.Items.Count.ToString();
            lblPoSum.Text = "Sum :" + po_sum.ToString();

            Batch.MasterTableView.AllowPaging = false;
            Batch.Rebind();
            decimal batch_sum = WebTools.DSum("BATCH_QTY", "VIEW_PO_BATCH_PLAN_DETAIL", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblBatchCnt.Text = "Count :" + Batch.MasterTableView.Items.Count.ToString();
            lblBatchSum.Text = "Sum :" + batch_sum.ToString();

            IRN.MasterTableView.AllowPaging = false;
            IRN.Rebind();
            decimal irn_sum = WebTools.DSum("RELEASE_QTY", "VIEW_PO_IRN_DETAIL_REP", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblIrnCnt.Text = "Count :" + IRN.MasterTableView.Items.Count.ToString();
            lblIrnSum.Text = "Sum :" + irn_sum.ToString();

            MRR.MasterTableView.AllowPaging = false;
            MRR.Rebind();
            decimal mrr_sum = WebTools.DSum("RECV_QTY", "VIEW_MAT_RCV_REPORT_DT", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMrrCnt.Text = "Count :" + MRR.MasterTableView.Items.Count.ToString();
            lblMrrSum.Text = "Sum :" + mrr_sum.ToString();

            RFI.MasterTableView.AllowPaging = false;
            RFI.Rebind();
            decimal rfi_sum = WebTools.DSum("INSP_QTY", "VIEW_MAT_RFI_REPORT", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblRfiCnt.Text = "Count :" + RFI.MasterTableView.Items.Count.ToString();
            lblRfiSum.Text = "Sum :" + rfi_sum.ToString();

            MRIR.MasterTableView.AllowPaging = false;
            MRIR.Rebind();
            decimal mrir_sum = WebTools.DSum("ACPT_QTY", "VIEW_MAT_MRIR_REPORT", "MAT_CODE='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMrirCnt.Text = "Count :" + MRIR.MasterTableView.Items.Count.ToString();
            lblMrirSum.Text = "Sum :" + mrir_sum.ToString();

            MaterialRequest.MasterTableView.AllowPaging = false;
            MaterialRequest.Rebind();
            decimal mat_req_sum = WebTools.DSum("REQ_QTY", "VIEW_MATERIAL_REQUEST_DT1", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMaterialRequestCnt.Text = "Count :" + MaterialRequest.MasterTableView.Items.Count.ToString();
            lblMaterialRequestSum.Text = "Sum :" + mat_req_sum.ToString();

            MTN.MasterTableView.AllowPaging = false;
            MTN.Rebind();
            decimal mtn_sum = WebTools.DSum("TRANSF_QTY", "VIEW_ADAPTER_MAT_TRANSF_DT1", "MATERIAL_CODE='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMtnCnt.Text = "Count :" + MTN.MasterTableView.Items.Count.ToString();
            lblMtnSum.Text = "Sum :" + mtn_sum.ToString();

            MTNreceive.MasterTableView.AllowPaging = false;
            MTNreceive.Rebind();
            decimal mtn_recv_sum = WebTools.DSum("RCV_QTY", "VIEW_MAT_TRANSFER_RCV_DT", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMtnRcvCnt.Text = "Count :" + MTNreceive.MasterTableView.Items.Count.ToString();
            lblMtnRcvSum.Text = "Sum :" + mtn_recv_sum.ToString();

            MIV.MasterTableView.AllowPaging = false;
            MIV.Rebind();
            decimal miv_sum = WebTools.DSum("ISSUE_QTY", "VIEW_ADAPTER_ISSUE_ADD_DETAIL", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblMivCnt.Text = "Count :" + MIV.MasterTableView.Items.Count.ToString();
            lblMivSum.Text = "Sum :" + miv_sum.ToString();

            Reconcilation.MasterTableView.AllowPaging = false;
            Reconcilation.Rebind();
            decimal recon_sum = WebTools.DSum("BAL_QTY", "VIEW_ITEM_REP_A", "MAT_CODE1='" + Request.QueryString["MAT_CODE1"] + "'");
            lblReconCnt.Text = "Count :" + Reconcilation.MasterTableView.Items.Count.ToString();
            lblReconSum.Text = "Sum :" + recon_sum.ToString();
            
        }
     
    }
   
 
    private void FindGridsRecursive(Control control)
    {
        foreach (Control childControl in control.Controls)
        {
            if (childControl is RadGrid)
            {
                gridControlsFound.Add((RadGrid)childControl);
            }
            else
            {
                FindGridsRecursive(childControl);
            }
        }
    }

    bool isFirstItem = true;
    private void GenerateTable(RadGrid grid, xls.Table singleTable)
    {
        if (ExportingType.SelectedValue == "1")
        {
            singleTable = new xls.Table(grid.ID);
            singleTable.Title = grid.ID;
            row = 2;
            col = 1;
        }
        else
        {
            if (!isFirstItem)
                row++;
            else
                row = 2;
            isFirstItem = false;
        }
        
        GridHeaderItem headerItem = grid.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem;
        int[] sizearr = new int[15];
        for (int i = 2; i < headerItem.Cells.Count; i++)
        {
            //singleTable.InsertImage(new Range("A1", "B2"), "../Images/Company_Logo/ADNOC.png");
            
            singleTable.Cells[2, row - 1].Value = grid.ID;
            singleTable.Cells[2, row - 1].Style.ForeColor = System.Drawing.Color.GreenYellow;
            singleTable.Cells[2, row - 1].Style.Font.Size = 18;
            singleTable.Cells[2, row - 1].Style.Font.Bold = true;
            singleTable.Rows[row - 1].Height = 30;
            singleTable.Cells[3, 1].Value = " Date : " + DateTime.Now.ToString("dddd, dd MMMM yyyy h:mm tt");
            singleTable.Cells[3, row - 1].Style.ForeColor = System.Drawing.Color.Red;

            singleTable.Rows[row].Height = 25;
            singleTable.Cells[i - 1, row].Value = headerItem.Cells[i].Text.Replace("_"," ");
            singleTable.Cells[i - 1, row].Style.BackColor = System.Drawing.Color.LightGray;
            singleTable.Cells[i - 1, row].Style.Font.Bold = true;
            singleTable.Cells[i - 1, row].Style.Font.Size=10;
            singleTable.Cells[i - 1, row].Style.BorderLeftStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderRightStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderBottomStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderTopStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderRightColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderTopColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderLeftColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderBottomColor = System.Drawing.Color.Black;
            



        }

        row++;

        foreach (GridDataItem item in grid.MasterTableView.Items)
        {

            foreach (GridColumn column in grid.MasterTableView.AutoGeneratedColumns)
            {
                singleTable.Cells[col, row].Value = item[column.UniqueName].Text.Replace("&nbsp;", "");
                singleTable.Cells[col, row].Style.BorderLeftStyle = BorderStyle.Outset;
                singleTable.Cells[col, row].Style.BorderRightStyle = BorderStyle.Outset;
                singleTable.Cells[col, row].Style.BorderBottomStyle = BorderStyle.Outset;
                singleTable.Cells[col, row].Style.BorderTopStyle = BorderStyle.Outset;
                singleTable.Cells[col, row].Style.BorderRightColor = System.Drawing.Color.Black;
                singleTable.Cells[col, row].Style.BorderTopColor = System.Drawing.Color.Black;
                singleTable.Cells[col, row].Style.BorderLeftColor = System.Drawing.Color.Black;
                singleTable.Cells[col, row].Style.BorderBottomColor = System.Drawing.Color.Black;
                col++;
            }
            col = 1;
            row++;
        }

        GridFooterItem FooterItem = grid.MasterTableView.GetItems(GridItemType.Footer)[0] as GridFooterItem;
        for (int i = 2; i < FooterItem.Cells.Count; i++)
        {
           singleTable.Rows[row].Height = 25;
           singleTable.Cells[i - 1, row].Value = FooterItem.Cells[i].Text.Replace("_", " ").Replace("&nbsp;", "");
            singleTable.Cells[i - 1, row].Style.BackColor = System.Drawing.Color.LightBlue;
            singleTable.Cells[i - 1, row].Style.Font.Bold = true;
            singleTable.Cells[i - 1, row].Style.Font.Size = 10;
            singleTable.Cells[i - 1, row].Style.BorderLeftStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderRightStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderBottomStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderTopStyle = BorderStyle.Outset;
            singleTable.Cells[i - 1, row].Style.BorderRightColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderTopColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderLeftColor = System.Drawing.Color.Black;
            singleTable.Cells[i - 1, row].Style.BorderBottomColor = System.Drawing.Color.Black;

        }
        row++;
        row++;

        if (ExportingType.SelectedValue == "1")
        {
            structure.Tables.Add(singleTable);
        }
    }

    private void ExportGrid()
    {
        foreach (RadGrid grid in gridControlsFound)
        {
            grid.AllowPaging = false;
            grid.CurrentPageIndex = 0;
            grid.Rebind();
            GenerateTable(grid, table);
        }
        if (ExportingType.SelectedValue == "2")
        {
            structure.Tables.Add(table);
        }
        xls.XlsBiffRenderer renderer = new xls.XlsBiffRenderer(structure);
        byte[] renderedBytes = renderer.Render();
        Response.Clear();
        Response.AppendHeader("Content-Disposition:", "attachment; filename=ExportFile.xls");
        Response.ContentType = "application/vnd.ms-excel";
        Response.BinaryWrite(renderedBytes);
        Response.End();
    }
    protected void RadButton1_Click(object sender, EventArgs e)
    {
        IsExporting = true;
        FindGridsRecursive(Page);
        ExportGrid();
    }

    protected void RadGrids_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {

         e.Column.HeaderText = e.Column.UniqueName.ToString().Replace('_', ' ');

        if (e.Column.DataType == typeof(string))
        {
            e.Column.HeaderStyle.Width = Unit.Pixel(150);
            e.Column.FilterControlWidth = Unit.Pixel(100);
        }

        if (e.Column.DataType == typeof(DateTime))
        {
            e.Column.HeaderStyle.Width = Unit.Pixel(150);
            e.Column.ItemStyle.Width = Unit.Pixel(150);
            e.Column.FilterControlWidth = Unit.Pixel(120);
        }
        if (e.Column.DataType == typeof(decimal))
        {
            e.Column.HeaderStyle.Width = Unit.Pixel(50);
            e.Column.ItemStyle.Width = Unit.Pixel(50);
            e.Column.FilterControlWidth = Unit.Pixel(50);
        }
        if (e.Column is GridDateTimeColumn)
        {
            (e.Column as GridDateTimeColumn).DataFormatString = "{0:dd-MMM-yyyy}";
        }

        if (e.Column.UniqueName.Contains("BATCH REV"))
        {
        }
        else
        {
            if (e.Column.DataType == typeof(decimal) && !(e.Column.UniqueName.Contains("BATCH_REV")) && !(e.Column.UniqueName.Contains("MR_ITEM_NO")))
            {
                GridBoundColumn bndcol = (GridBoundColumn)e.Column;
                bndcol.Aggregate = GridAggregateFunction.Sum;
            }
        }

    }


   
    protected void Reconcilation_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column.UniqueName.Contains("BAL_QTY"))
        {
            GridBoundColumn bndcol = (GridBoundColumn)e.Column;
            bndcol.Aggregate = GridAggregateFunction.Sum;
        }
        e.Column.HeaderText = e.Column.UniqueName.ToString().Replace('_', ' ');
    }

    protected void RadGrids_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (IsExporting == false)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;

                foreach (TableCell cell in item.Cells)
                {
                    if (cell.Text.Length > 50)
                    {
                        cell.ToolTip = cell.Text;
                        cell.Text = cell.Text.Substring(0, 45) + " ....";

                    }
                }
            }
        }
     
                     
        

    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string mat_id = ddlMatCode.SelectedValue;

        if (!string.IsNullOrEmpty(mat_id))
        {
            Response.Redirect("MaterialTotalStatus.aspx?MAT_CODE1=" + ddlMatCode.Text);
        }
    }
}
