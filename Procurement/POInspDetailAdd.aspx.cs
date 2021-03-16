using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POInspDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(WebTools.UserInRole("RFI_ADD") || WebTools.UserInRole("ADMIN")))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }

        if (!IsPostBack)
        {
            Master.HeadingMessage = "RFI Add Material <br/>";
            Master.HeadingMessage += WebTools.GetExpr("RFI_NO", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + Request.QueryString["RFI_ID"].ToString() + "'");           
        }
    }

    protected void checkHeaderItems_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;

        foreach (GridDataItem item in itemsGrid.Items)
        {
            ((CheckBox)item["checkCol"].FindControl("checkItems")).Checked = cb.Checked;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Procurement_CTableAdapters.VIEW_PO_INSP_REQUEST_DTTableAdapter insp = new Procurement_CTableAdapters.VIEW_PO_INSP_REQUEST_DTTableAdapter();

        CheckBox cb;
        decimal mat_id;
        string insp_qty;
        decimal po_qty, rel_qty;
        try
        {
            foreach (GridDataItem item in itemsGrid.Items)
            {
                cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));

                if (cb.Checked)
                {
                    mat_id = WebTools.GetMatId(item["MAT_CODE1"].Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
                    insp_qty = (item["BAL_QTY"].FindControl("BAL_QTYTextBox") as TextBox).Text;
                    insp.InsertQuery(decimal.Parse(Request.QueryString["RFI_ID"]), item["PO_ITEM_NO"].Text, mat_id, decimal.Parse(insp_qty),
                        null);
                }
            }
            Master.ShowMessage("Selected Items Added.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally {
            insp.Dispose();
            itemsGrid.Rebind();
        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POInsp.aspx");
    }
}