using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_PPCSCustomSrn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Custom SRN Update");
        }
    }

    protected void ddSrnNo_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

    }

    protected void txtSrnNo_TextChanged(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        entryTable.Visible = entryTable.Visible ? false : true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

    }
}