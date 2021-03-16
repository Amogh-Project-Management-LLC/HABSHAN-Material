<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Report_List.aspx.cs" Inherits="BasicReports_Report_List" Title="Piping Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 3px; background-color: gainsboro;">
        <telerik:RadButton ID="btnViewReport" runat="server" Text="Show Report" Width="120px" OnClick="btnViewReport_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid DataSourceID="SqlDataSource1" ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowSorting="true" Width="1000px" AllowPaging="True" PageSize="18">
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="REPORT_CODE">
                <Columns>
                    <telerik:GridBoundColumn DataField="REPORT_DESC" FilterControlAltText="Filter REPORT_DESC column" HeaderText="Report Title" SortExpression="REPORT_DESC" UniqueName="REPORT_DESC" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REPORT_CODE" FilterControlAltText="Filter REPORT_CODE column" HeaderText="Report Code" ReadOnly="True" SortExpression="REPORT_CODE" UniqueName="REPORT_CODE" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="GROUP_DESC" FilterControlAltText="Filter GROUP_DESC column" HeaderText="Group" ReadOnly="True" SortExpression="GROUP_DESC" UniqueName="GROUP_DESC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False"></FilterMenu>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM REPORT_INDEX
ORDER BY REPORT_DESC"></asp:SqlDataSource>
    <asp:HiddenField ID="Search_HiddenField" runat="server" />
</asp:Content>