using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class BatchRevision : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Batch Revision<br/>";
            heading += WebTools.GetExpr("PO_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");
            heading += "/";
            heading += WebTools.GetExpr("BATCH_NO", "VIEW_PO_BATCH_PLAN", " WHERE BATCH_ID='" + Request.QueryString["BATCH_ID"] + "'");

            Master.HeadingMessage = heading;

            Master.HeadingMessage = heading;
        }
    }
    protected void revisionDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.NewMode == DetailsViewMode.Edit)
        {
            if (!WebTools.UserInRole("PIP_DCS_UPDATE"))
            {
                e.Cancel = true;
                Master.ShowError("Access denied!");
            }
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_DELETE"))
        {
            Master.ShowError("Access denied!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        YesNoStatusHiddenField.Value = "1";
        Master.ShowWarn("Delete Revision?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            if (YesNoStatusHiddenField.Value.ToString() == "1")
            {
                revisionDetailsView.DeleteItem();
                Master.ShowSuccess("Revision deleted!");
            }
            else
            {
                WebTools.ExeSql(
                    "UPDATE PIP_REVISION SET MAT_CHK_DATE=TO_CHAR(SYSDATE,'DD-MON-YYYY'), MAT_CHK_BY='" +
                    Session["USER_NAME"].ToString().ToUpper() + "' WHERE REV_ID=" + revisionDetailsView.SelectedValue.ToString());
                revisionDetailsView.DataBind();
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
    protected void revisionDetailsView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < revisionDetailsView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Rev ", i + 1, " of ", revisionDetailsView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == revisionDetailsView.PageIndex)
                pageListItem.Selected = true;
        }

        if (!IsPostBack && revisionDetailsView.PageCount <= 0)
        {
            btnDelete.Enabled = false;
        }

      
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        revisionDetailsView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void revisionDetailsView_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnUpdateCheckDate_Click(object sender, EventArgs e)
    {
        YesNoStatusHiddenField.Value = "2";
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Update Material Check Date?");
    }

  

    protected void cboBackCheckBy_DataBinding(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("(Select)", ""));
    }

    protected void DropDownList1_DataBinding(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("(Select)", ""));
    }

    protected void ddlHoldTypes_DataBinding(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("(Select)", ""));
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("POBatchPlan.aspx");
    }
}