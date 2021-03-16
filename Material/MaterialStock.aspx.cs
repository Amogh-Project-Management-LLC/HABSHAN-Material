using System;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Isome_MaterialStock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string mat_id = Request.QueryString["MAT_ID"];
            if (mat_id != null)
            {
                //ListBoxDataSource.SelectParameters.Clear();
                //ListBoxDataSource.SelectCommand = "SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK WHERE MAT_ID=" + mat_id;
                //txtItemCode.Enabled = false;
                //ListBox1.Visible = false;
            }
            Master.HeadingMessage = "Material Catalog";
            string mat_code = Session["STK_MAT_CODE"].ToString();
            if (mat_code != "") txtItemCode.Text = mat_code;

            Master.RadGridList = "";
            Master.AddModalPopup("~/Material/MaterialStockRegister.aspx", btnRegister.ClientID, 550, 750);

            if (Session["ITEM_CODE_SEARCH_MM"] != null)
                txtItemCode.Text = Session["ITEM_CODE_SEARCH_MM"].ToString();

        }
    }

    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (ListBox1.Items.Count > 1)
            {
                ListBox1.SelectedIndex = 1;
            }
            save_filter();
        }

    }

    protected void StockDetailsView_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString["MAT_ID"] != null & !IsPostBack)
        {
            ListBox1.Visible = false;
        }
    }

    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
        txtItemCode.Text = txtItemCode.Text.ToUpper().Trim();
        Session["ITEM_CODE_SEARCH_MM"] = txtItemCode.Text;
    }

    private void clear_listbox()
    {
        ListBox1.Items.Clear();
        ListBox1.DataBind();
    }

    protected void StockDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE") && e.NewMode == DetailsViewMode.Edit)
        {
            Master.ShowWarn("Access Denied - Error 403.");
            e.Cancel = true;
        }
    }

    protected void btnPOdepend_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnRecvd_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Received.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_HeatNo.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex < 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_MTC.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnJC_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_JC.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void save_filter()
    {
        Session["STK_MAT_CODE"] = txtItemCode.Text;
        Session["STK_LIST_INDEX"] = ListBox1.SelectedIndex.ToString();
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Joints.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //tip();
    }

    protected void txtSize_TextChanged(object sender, EventArgs e)
    {
        clear_listbox();
    }

    protected void btnAddIssue_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex < 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_Additional.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MaterialStockRegister.aspx");
    }

    protected void btnSummary_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStock_Recon_A.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_BOM_QTY.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }
    protected void btnInventoryAlloc_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Alloc.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }


    protected void Item_Click_MIR()
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnMRIR_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_MRIR.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnTrans_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Transfer.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnCatalogGrid_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialCatalogGrid.aspx");
    }
  
}