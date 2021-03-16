using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Data;

public partial class Material_MaterialQuarantine : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Quarantine";
            Master.AddModalPopup("~/Material/MaterialQuarantineAdd.aspx", btnRegister.ClientID, 350, 550);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            // Master.ShowWarn("Select a row to conitnue.");
            RadWindowManager1.RadAlert("Select a row to conitnue.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("MaterialQuarantineDetail.aspx?id=" + RadGrid1.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            // Master.ShowWarn("Select a row to conitnue.");
            RadWindowManager1.RadAlert("Select a row to conitnue.", 400, 150, "Warning", "");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=32&Arg1=" + RadGrid1.SelectedValue);
    }

    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("MM_EDIT"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
    }

    protected void RadGrid1_DataBinding(object sender, EventArgs e)
    {

        if (!WebTools.UserInRole("MM_DELETE"))
        {
            RadGrid1.AllowAutomaticDeletes = false;
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
        }
        else
        {
            string[] datafields = new string[1];
            datafields[0] = "QRNTINE_NO";
            GridButtonColumn gridbutton = (GridButtonColumn)RadGrid1.MasterTableView.Columns[1];
            gridbutton.ConfirmDialogType = GridConfirmDialogType.RadWindow;
            gridbutton.ConfirmTextFormatString = "Are you sure you want to delete {0} ?";
            gridbutton.ConfirmTextFields = datafields;

            RadGrid1.AllowAutomaticDeletes = true;
        }
        if (!WebTools.UserInRole("MM_EDIT"))
        {
            RadGrid1.AllowAutomaticUpdates = false;
        }
        else
        {
            RadGrid1.AllowAutomaticUpdates = true;
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string qrntine_id = item.GetDataKeyValue("QRNTINE_ID").ToString();
            string qrntine_no = WebTools.GetExpr("QRNTINE_NO", "PIP_QUARANTINE", " QRNTINE_ID = " + qrntine_id);
            qrntine_no = qrntine_no.Replace("/", "-");
            string filename = qrntine_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_QUARANTINE'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_QUARANTINE'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");
            //string status_flg = WebTools.GetExpr("STATUS_FLG", "PIP_QUARANTINE", " QRNTINE_ID = " + qrntine_id);
            

            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='QRNTINE PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
            if (e.Item.IsInEditMode && e.Item is GridEditableItem)
            {

                string query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                               " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND HIDE_COL_NAME IS NOT NULL  AND  MODULE_ID =24 ";
                DataTable dt = WebTools.getDataTable(query);
                GridEditableItem dataItem = e.Item as GridEditableItem;

                foreach (DataRow row in dt.Rows)
                {
                    string hide_col = row["HIDE_COL_NAME"].ToString();
                    dataItem[hide_col].Enabled = false;
                    dataItem[hide_col].Controls[0].Visible = false;
                }
                string lbl_query = "SELECT * FROM USER_MODULE_COLUMNS WHERE NOT  EXISTS (SELECT 1 FROM USER_MODULE_ROLES WHERE  " +
                    " SEQ =USER_MODULE_COLUMNS.SEQ   AND  USER_ID IN (SELECT USER_ID FROM USERS WHERE USER_NAME ='" + Session["USER_NAME"] + "' ))  AND LBL_COL_NAME IS NOT NULL  AND  MODULE_ID =24";
                DataTable lbl_dt = WebTools.getDataTable(lbl_query);
                Label[] descLabel = new Label[30];
                int i = 0;
                foreach (DataRow row in lbl_dt.Rows)
                {
                    string lbl_col = row["LBL_COL_NAME"].ToString();

                    string str = (dataItem[lbl_col].Controls[0] as TextBox).Text;
                    descLabel[i] = new Label();
                    descLabel[i].Text = str;
                    dataItem[lbl_col].Controls.Add(descLabel[i]);
                    i++;
                }
            }
        }
    }
}