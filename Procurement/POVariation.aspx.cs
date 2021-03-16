using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "VARIATION ORDERS";                 
        }
      

    }

  


    //protected void itemsGrid_DataBinding(object sender, EventArgs e)
    //{
    //    if (!WebTools.UserInRole("PO_DELETE"))
    //    {
    //        itemsGrid.AllowAutomaticDeletes = false;
    //        GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
    //    }
    //    else
    //    {
    //        string[] datafields = new string[1];
    //        datafields[0] = "PO_NO";
    //        GridButtonColumn gridbutton = (GridButtonColumn)itemsGrid.MasterTableView.Columns[1];
    //        gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
    //        gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
    //        gridbutton.ConfirmTextFields = datafields;

    //        itemsGrid.AllowAutomaticDeletes = true;
    //    }
    //    if (!WebTools.UserInRole("PO_EDIT"))
    //    {
    //        itemsGrid.AllowAutomaticUpdates = false;
    //    }
    //    else
    //    {
    //        itemsGrid.AllowAutomaticUpdates = true;
    //    }
    //}

   


    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string vo_id = item.GetDataKeyValue("VO_ID").ToString();
            string vo_no = WebTools.GetExpr("VO_NO", "PIP_PO_VARIATION", " VO_ID = " + vo_id);
            vo_no = vo_no.Replace("/", "-");
            string filename = vo_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_VO'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PO_VO'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='VO PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

    protected void itemsGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PO_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("PO_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }


  

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POMaster.aspx");
    }

    protected void btnVOItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select VO to continue.");
            return;
        }

        Response.Redirect("POVariationDetails.aspx?VO_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Transmittal to continue");
            return;
        }
        string vo_id = itemsGrid.SelectedValue.ToString();
        string vo_no =WebTools.GetExpr("VO_NO", "PIP_PO_VARIAITON", " VO_ID=" + vo_id);
        General_Functions fun = new General_Functions();
        fun.download_zip(9, vo_id, vo_no, "PO_VO_SUPP", Response);

    }

}