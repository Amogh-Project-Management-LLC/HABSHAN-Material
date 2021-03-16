<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SearchItemCode.aspx.cs" Inherits="Material_SearchItemCode" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table>
        <tr>
            <td>Item Name:</td>
            <td>
                <telerik:RadDropDownList ID="ddlItemNameList" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlItemName" DataTextField="ITEM_NAM" DataValueField="ITEM_NAM" OnDataBinding="ddlItemNameList_DataBinding"></telerik:RadDropDownList>
            </td>        
            <td>Size:</td>
            <td>
                <telerik:RadDropDownList ID="ddlSizeDesc" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlItemSize" DataTextField="SIZE_DESC" DataValueField="SIZE_DESC" OnDataBinding="ddlSizeDesc_DataBinding"></telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td>Schedule/Thk:</td>
            <td>
                <telerik:RadDropDownList ID="ddlSchedule" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlItemSch" DataTextField="WALL_THK" DataValueField="WALL_THK" OnDataBinding="ddlSchedule_DataBinding"></telerik:RadDropDownList>
            </td>        
            <td>Class:</td>
            <td>
                <telerik:RadDropDownList ID="ddlClass" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlItemClass" DataTextField="CLASS" DataValueField="CLASS" OnDataBinding="ddlClass_DataBinding"></telerik:RadDropDownList>
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlItemCode" AllowPaging="True"
         AllowFilteringByColumn="True">
        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
        <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlItemCode">
            <Columns>
                <telerik:GridBoundColumn DataField="MAT_CODE1" AllowFiltering="false" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MAT_CODE2" AllowFiltering="false" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT_CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                </telerik:GridBoundColumn>
            </Columns>
            <FilterItemStyle Width="80px" />
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sqlItemCode" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_CODE1, MAT_CODE2, ITEM_NAM, SIZE_DESC, WALL_THK, MAT_DESCR FROM VIEW_STOCK WHERE (ITEM_NAM = :ITEM_NAM)  AND (SIZE_DESC = :SIZE_DESC OR :SIZE_DESC  = 'XXX') AND (WALL_THK = :THK OR :THK = 'XXX') AND (CLASS = :CLASS OR :CLASS = 'XXX')
ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlItemNameList" DefaultValue="XXX" Name="ITEM_NAM" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlSizeDesc" DefaultValue="XXX" Name="SIZE_DESC" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlSchedule" DefaultValue="XXX" Name="THK" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlClass" DefaultValue="XXX" Name="CLASS" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlItemName" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ITEM_NAM
FROM VIEW_STOCK
ORDER BY ITEM_NAM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlItemSize" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SIZE_DESC
FROM VIEW_STOCK
WHERE ITEM_NAM = :ITEM_NAM
ORDER BY SIZE_DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlItemNameList" DefaultValue="-1" Name="ITEM_NAM" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlItemSch" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT WALL_THK
FROM VIEW_STOCK
WHERE ITEM_NAM = :ITEM_NAM 
ORDER BY WALL_THK">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlItemNameList" DefaultValue="XX" Name="ITEM_NAM" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlItemClass" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT CLASS 
                       FROM VIEW_STOCK
                       WHERE ITEM_NAM = :ITEM_NAM">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlItemNameList" DefaultValue="-1" Name="ITEM_NAM" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

