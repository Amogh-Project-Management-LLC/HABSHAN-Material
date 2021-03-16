using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POVendorData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Heat No/MTC";

            Master.AddModalPopup("~/Procurement/POVendorDataImport.aspx", btnImportIRN.ClientID, 400, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        // WebTools.ExportDataSetToExcel(sqlDataDownload, "PO_Vendor_Data.xls");
        ExportToCSV(sqlDataDownload, "PO_Vendor_Data");
    }

    public void ExportToCSV(SqlDataSource dataSrc, string fileName)
    {
        //Add Response header

        Response.Clear();
        Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.csv", fileName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        //GET Data From Database

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ");

        OracleCommand cmd = new OracleCommand(query, cn);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
            OracleDataReader dr = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();

            //CSV Header
            for (int count = 0; count < dr.FieldCount; count++)
            {
                if (dr.GetName(count) != null)
                    sb.Append(dr.GetName(count));
                if (count < dr.FieldCount - 1)
                {
                    sb.Append(",");
                }
            }
            Response.Write(sb.ToString() + "\n");
            Response.Flush();

            //CSV Body
            while (dr.Read())
            {
                sb = new StringBuilder();

                for (int col = 0; col < dr.FieldCount - 1; col++)
                {
                    if (!dr.IsDBNull(col))
                    {
                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(col).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " "));
                        }
                    }
                    sb.Append(",");
                }

                if (!dr.IsDBNull(dr.FieldCount - 1))
                {
                    if (!dr.IsDBNull(dr.FieldCount - 1))
                    {
                        if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(dr.FieldCount - 1).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " "));
                        }
                    }
                }

                Response.Write(sb.ToString() + "\n");
                Response.Flush();
            }
            dr.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
        }
        Response.End();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("IRN.aspx");
    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string mtc_code = item.GetDataKeyValue("MTC_CODE").ToString();
          
            string filename = mtc_code + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MTC'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='MTC PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }
}