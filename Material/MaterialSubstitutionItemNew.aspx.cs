using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialSubstitutionItemNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "ADD MATERIAL (";
            heading += WebTools.GetExpr("REQ_NO", "PIP_MAT_SUBSTITUTE", " REQ_ID='" + Request.QueryString["REQ_ID"].ToString() + "'");
            heading += ")";
            Master.HeadingMessage(heading);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dsMaterialCTableAdapters.VIEW_ADP_SUBSTITUTE_DTTableAdapter substitu = new dsMaterialCTableAdapters.VIEW_ADP_SUBSTITUTE_DTTableAdapter();
        string old_mat_id, old_mat_qty;
        old_mat_id = WebTools.GetExpr("MAT_ID", "PIP_BOM", "BOM_ID=" + ddBomItem.SelectedValue.ToString());
        old_mat_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", "BOM_ID=" + ddBomItem.SelectedValue.ToString());
        decimal new_mat_id = WebTools.GetMatId(txtItemCode.Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (new_mat_id == 0)
        {
            Master.show_error("Material Not Found");
            return;
        }
        try
        {
            substitu.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"]), decimal.Parse(ddBomItem.SelectedValue.ToString()),
                decimal.Parse(old_mat_id), decimal.Parse(old_mat_qty),
                new_mat_id, decimal.Parse(txtNewQty.Text), txtRemarks.Text);            

            string count = WebTools.CountExpr("1", "PIP_MAT_SUBSTITUTE_DETAIL", "  WHERE  BOM_ID=" + ddBomItem.SelectedValue.ToString());
            //if (count == "1")
            //{
            //    //NEW  ADDITION
            //    string sql1 = "UPDATE  PIP_BOM  SET  OLD_MAT_ID=" + old_mat_id + "  WHERE BOM_ID=" + ddBomItem.SelectedValue.ToString();
            //    WebTools.exec_non_qry(sql1);
            //}
            string sql3 = "UPDATE  PIP_BOM  SET  NET_QTY=" + txtNewQty.Text + "  WHERE  BOM_ID=" + ddBomItem.SelectedValue.ToString();
            string sql2 = "UPDATE  PIP_BOM  SET  MAT_ID=" + new_mat_id.ToString() + "  WHERE  BOM_ID=" + ddBomItem.SelectedValue.ToString();
            WebTools.exec_non_qry(sql3);
            WebTools.exec_non_qry(sql2);
            Master.show_success("New Item Added.");
            
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
            return;            
        }
        finally
        {
            substitu.Dispose();
        }

    }

    protected void ddBomItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtNewQty.Text = WebTools.GetExpr("NET_QTY", "PIP_BOM", "BOM_ID=" + ddBomItem.SelectedValue.ToString());
    }
    protected void txtNewQty_TextChanged(object sender, EventArgs e)
    {

    }

    protected void txtIsometric_TextChanged(object sender, EventArgs e)
    {

        if (IsPostBack)
        {
            txtIsometric.Text = txtIsometric.Text.ToUpper();
            ddBomItem.Items.Clear();
            ddBomItem.Items.Add(new ListItem("(BOM Item)", "-1"));
        }
    }
}