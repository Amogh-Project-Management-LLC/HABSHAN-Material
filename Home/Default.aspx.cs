using System;
using Telerik.Web.UI;


public partial class ipms_Home : BasePage
{
    bool isExport = false;

    

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Home";
        if (!IsPostBack)
        {
            RadChart1.DataSource = MMSqlDataSource;
            RadChart1.DataBind();

        }
    }
   
    protected void RadChart1_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        //e.SeriesItem.Name = ((DataRowView)e.DataItem)["Name"].ToString();
    }

    protected void RadChart2_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        //e.SeriesItem.Name = ((DataRowView)e.DataItem)["Name"].ToString();
    }
    protected void btnItemCode_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/FATA/GenerateItemCode.aspx");
    }
    

    protected void RadGrid1_ItemCommand(object source, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
            isExport = true;
    }

   
}