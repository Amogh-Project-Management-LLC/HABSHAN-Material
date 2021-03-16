using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Procurement_POPunchlistDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!(WebTools.UserInRole("RFI_ADD") || WebTools.UserInRole("ADMIN")))
        //{
        //    Response.Redirect("~/ErrorPages/NoAccess.htm");
        //}

        if (!IsPostBack)
        {
            Master.HeadingMessage = "ADD Punch Material <br/>";
           // string po_id = WebTools.GetExpr("PO_ID", "PIP_PUNCH_MASTER", " PUNCH_ID=" + itemsGrid.SelectedValue);
            Master.HeadingMessage += WebTools.GetExpr("PUNCH_NO", "PIP_PUNCH_MASTER", " PUNCH_ID=" + Request.QueryString["PUNCH_ID"]);           
        }
        hiddenPO_ID.Value = WebTools.GetExpr("PO_ID", "PIP_PUNCH_MASTER", " PUNCH_ID=" + Request.QueryString["PUNCH_ID"]);
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
        Procurement_CTableAdapters.VIEW_PUNCHLIST_MASTER_DTTableAdapter punchlist_dt = new Procurement_CTableAdapters.VIEW_PUNCHLIST_MASTER_DTTableAdapter();

        CheckBox cb;
        //decimal discipline;
        decimal mat_id;
        string punch_qty;
        try
        {
            foreach (GridDataItem item in itemsGrid.Items)
            {
                cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));

                if (cb.Checked)
                {
                    mat_id = WebTools.GetMatId(item["MAT_CODE1"].Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
                    punch_qty = (item["PUNCH_QTY"].FindControl("PO_QTYTextBox") as TextBox).Text;
                    string cat = (item["CAT"].FindControl("ddlCAT") as RadDropDownList).SelectedValue;
                    string punch_desc = (item["Punch_Desc"].FindControl("txtPunchDesc") as TextBox).Text;
                    punchlist_dt.InsertQuery(decimal.Parse(Request.QueryString["PUNCH_ID"]), decimal.Parse(item["PO_ITEM_ID"].Text), cat, decimal.Parse(punch_qty), punch_desc, mat_id, (item["PUNCH_DATE"].FindControl("txtDate") as RadDatePicker).SelectedDate, null);
                }
            }
            Master.ShowMessage("Selected Items Added.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally
        {
            punchlist_dt.Dispose();
            itemsGrid.Rebind();
        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POPunchlist.aspx");
    }
}