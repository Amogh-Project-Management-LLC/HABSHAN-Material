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
using Telerik.Web.UI;

public partial class PoItemWise : System.Web.UI.Page
{
    private bool isExport = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Item Wise Details";
            this._ordersExpandedState = null;
            this.Session["_ordersExpandedState"] = null;
            
        }
        itemsGrid.ExportSettings.FileName = "PO Item Wise Details";
    }


    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName.Contains("Export"))
        {
            isExport = true;
            if (RadioButtonList1.SelectedValue == "All")
            {
                itemsGrid.MasterTableView.HierarchyDefaultExpanded = true;
                itemsGrid.MasterTableView.DetailTables[0].HierarchyDefaultExpanded = true; 
            }
            if (RadioButtonList1.SelectedValue == "Expanded")
            {
                itemsGrid.ExportSettings.IgnorePaging = false;
                itemsGrid.Rebind();
            }
        }

        
        if (e.CommandName == RadGrid.ExpandCollapseCommandName)
        {
            
            if (!e.Item.Expanded)
            {
                
                this.ExpandedStates[e.Item.ItemIndexHierarchical] = true;
            }
            else 
            {
                this.ExpandedStates.Remove(e.Item.ItemIndexHierarchical);
                this.ClearExpandedChildren(e.Item.ItemIndexHierarchical);
            }
        }
    }

    protected void itemsGrid_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        
        if (isExport && CheckBox1.Checked)
        {
            if (e.Item is GridHeaderItem)
            {
                switch (e.Item.OwnerTableView.Name)
                {
                    //case "PoGrid": e.Item.OwnerTableView.BackColor = System.Drawing.Color.LightBlue; break;
                    case "BatchGrid": e.Item.OwnerTableView.BackColor = System.Drawing.Color.DarkSeaGreen; break;
                 
                }
            }
        }
       
        if (isExport && e.Item is GridFilteringItem)
            e.Item.Visible = false;

        
    }

    protected void itemsGrid_DataBound(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedValue == "Expanded")
        {
            
            string[] indexes = new string[this.ExpandedStates.Keys.Count];
            this.ExpandedStates.Keys.CopyTo(indexes, 0);

            ArrayList arr = new ArrayList(indexes);
            
            arr.Sort();

            foreach (string key in arr)
            {
                bool value = (bool)this.ExpandedStates[key];
                if (value)
                {
                    itemsGrid.Items[key].Expanded = true;
                }
            }
        }
    }
    private Hashtable _ordersExpandedState;
    private Hashtable ExpandedStates
    {
        get
        {
            if (this._ordersExpandedState == null)
            {
                _ordersExpandedState = this.Session["_ordersExpandedState"] as Hashtable;
                if (_ordersExpandedState == null)
                {
                    _ordersExpandedState = new Hashtable();
                    this.Session["_ordersExpandedState"] = _ordersExpandedState;
                }
            }

            return this._ordersExpandedState;
        }
    }

    
    private void ClearExpandedChildren(string parentHierarchicalIndex)
    {
        string[] indexes = new string[this.ExpandedStates.Keys.Count];
        this.ExpandedStates.Keys.CopyTo(indexes, 0);
        foreach (string index in indexes)
        {
            
            if (index.StartsWith(parentHierarchicalIndex + "_") ||
                index.StartsWith(parentHierarchicalIndex + ":"))
            {
                this.ExpandedStates.Remove(index);
            }
        }
    }

    protected void itemsGrid_PreRender(object sender, EventArgs e)
    {
        if (itemsGrid.IsExporting)
        {
            foreach (GridFilteringItem item in itemsGrid.MasterTableView.GetItems(GridItemType.FilteringItem))
            {
                item.Visible = false;
            }
          


        }
    }
    
}