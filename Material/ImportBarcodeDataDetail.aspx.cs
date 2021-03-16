using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_ImportBarcodeDataDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage = "Import Barcode Data<br/>";
            Master.HeadingMessage += Request.QueryString["DOC_NO"].ToString();

            HiddenStoreID.Value = WebTools.GetExpr("STORE_ID", "VIEW_MATERIAL_DOC_MASTER", " WHERE DOC_NO = '" + Request.QueryString["DOC_NO"] + "'");
        }
    }

    protected void btnDetail_Click(object sender, EventArgs e)
    {
        string doc_no = Request.QueryString["doc_no"];
        string url = Request.QueryString["RetUrl"];
        Response.Redirect("ImportBarcodeData.aspx?doc_no=" + doc_no + "&RetUrl=" + url);
    }
}