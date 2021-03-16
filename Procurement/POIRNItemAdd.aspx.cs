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
        if (!(WebTools.UserInRole("PO_IRN_ADD") || WebTools.UserInRole("ADMIN")))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }

        if (!IsPostBack)
        {
            Master.HeadingMessage = "IRN Add Material <br/>";
            Master.HeadingMessage += WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + Request.QueryString["IRN_ID"].ToString() + "'");           
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
        Procurement_BTableAdapters.VIEW_PO_IRN_DETAILTableAdapter irn = new Procurement_BTableAdapters.VIEW_PO_IRN_DETAILTableAdapter();

        CheckBox cb;
        decimal mat_id;
        string insp_qty, rel_qty,pieces;
        decimal po_qty,released_qty;
        int count = 0;
        int success_cnt = 0;
        string err_po_item_no = "";
        string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_IRN", " WHERE IRN_ID = '" + Request.QueryString["IRN_ID"] + "'");
        try
        {
            foreach (GridDataItem item in itemsGrid.Items)
            {
                cb = ((CheckBox)item["checkCol"].FindControl("checkItems"));
              
                if (cb.Checked)
                {

                    //Label lbl1 = (Label)item.FindControl("PO_QTY");
                    // po_qty = decimal.Parse(lbl1.Text);
                    //Label lbl2 = (Label)item.FindControl("REL_QTY");
                    //released_qty = decimal.Parse(lbl2.Text);
                    
                    mat_id = WebTools.GetMatId(item["MAT_CODE1"].Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
                    string bal_qty_left = WebTools.GetExpr("BAL_REL_QTY", "VIEW_PO_IRN_BAL", " WHERE PO_ID = '" + decimal.Parse(po_id) + "' AND PO_ITEM_NO='" + item["PO_ITEM_NO"].Text + "'");
                    insp_qty = (item["BAL_REL_QTY"].FindControl("BAL_REL_QTYTextBox") as TextBox).Text;
                    rel_qty = (item["BAL_REL_QTY"].FindControl("BAL_REL_QTYTextBox") as TextBox).Text;
                    pieces = (item["BAL_PIECES"].FindControl("BAL_PIECESTextBox") as TextBox).Text;
                    if(pieces=="N/A")
                    {
                        pieces = "0";
                    }

                    if (bal_qty_left == "" || bal_qty_left == string.Empty)
                    {
                        bal_qty_left = "0";
                    }

                    if (rel_qty == "" || rel_qty == string.Empty)
                    {
                        rel_qty = "0";
                    }

                 //   ELECTRICAL==2
                po_qty = decimal.Parse(WebTools.GetExpr("PO_QTY", "PIP_PO_DETAIL", " WHERE PO_ID = '" + decimal.Parse(po_id) + "' AND PO_ITEM='"+item["PO_ITEM_NO"].Text+"'"));
                    released_qty= WebTools.DSum("RELEASE_QTY","PIP_PO_IRN_DETAIL"," WHERE PO_ID="+decimal.Parse(po_id)+" AND PO_ITEM='"+item["PO_ITEM_NO"]+"'");
                    string discipline = WebTools.GetExpr("DISCIPLINE_ID", "PIP_PO", " WHERE PO_ID=" + decimal.Parse(po_id));
                    string chk_discipline = WebTools.GetExpr("DISCIPLINE_ID", "PIP_PO_DISCIPLINE", " WHERE DISCIPLINE_ID=" + discipline);

                    if ((decimal.Parse(bal_qty_left) >= decimal.Parse(rel_qty) && decimal.Parse(rel_qty) > 0 ) ||  (chk_discipline!=string.Empty))
                    {
                        if(decimal.Parse(bal_qty_left) < decimal.Parse(rel_qty))
                        {
                            err_po_item_no+= item["PO_ITEM_NO"].Text + " , ";
                        }
                        irn.InsertQuery(decimal.Parse(Request.QueryString["IRN_ID"]), item["PO_ITEM_NO"].Text, mat_id, decimal.Parse(rel_qty), decimal.Parse(insp_qty), decimal.Parse(po_id), decimal.Parse(pieces));
                        success_cnt++;
                    }
                    else
                    {
                        count++;
                        err_po_item_no += item["PO_ITEM_NO"].Text + " , ";
                    }
                }
              
            }
            
              string msg = "";
           
            if (err_po_item_no.Length > 0)
            {
                msg += "Rel Qty greater than PO Qty for Po Item No : " + err_po_item_no + "<br/> ";
            }
            if (success_cnt > 0)
            {
                msg = "Selected Item(s) Imported, <br/> ";
                Master.ShowSuccess("Selected Item(s) Imported");
            }
            else
            {
                Master.ShowWarn(msg);
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally {
            irn.Dispose();
            itemsGrid.Rebind();
        }
    }
   protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("IRN_Detail.aspx?IRN_ID=" + Request.QueryString["IRN_ID"]);
    }

}