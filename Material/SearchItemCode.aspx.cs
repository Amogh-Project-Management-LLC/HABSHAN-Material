using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_SearchItemCode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Search Material Code");
        }
    }

    protected void ddlSizeDesc_DataBinding(object sender, EventArgs e)
    {
        ddlSizeDesc.Items.Clear();
        ddlSizeDesc.Items.Add(new Telerik.Web.UI.DropDownListItem("(ALL)", "XXX"));
    }

    protected void ddlSchedule_DataBinding(object sender, EventArgs e)
    {
        ddlSchedule.Items.Clear();
        ddlSchedule.Items.Add(new Telerik.Web.UI.DropDownListItem("(ALL)", "XXX"));
    }

    protected void ddlClass_DataBinding(object sender, EventArgs e)
    {
        ddlClass.Items.Clear();
        ddlClass.Items.Add(new Telerik.Web.UI.DropDownListItem("(ALL)", "XXX"));
    }

    protected void ddlItemNameList_DataBinding(object sender, EventArgs e)
    {
        ddlItemNameList.Items.Clear();
        ddlItemNameList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
}