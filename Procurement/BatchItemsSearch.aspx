<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="BatchItemsSearch.aspx.cs" Inherits="BatchItemsSearch" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            background-color: whitesmoke;
            width: 120px;
            padding-left: 5px
        }

        table {
            padding: 5px;
        }
    </style>
    <div style="background-color: whitesmoke">
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <telerik:RadGrid runat="server" DataSourceID="batchitemsDataSource" AutoGenerateColumns="false" AllowFilteringByColumn="true" PageSize="50" AllowPaging="true" PagerStyle-AlwaysVisible="true" >
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn DataField="PO_NO" AllowFiltering="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" >
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="PO_ITEM" AllowFiltering="true" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM NO" SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BATCH_NO" AllowFiltering="true" FilterControlAltText="Filter BATCH_NO column" HeaderText="BATCH NO" SortExpression="BATCH_NO" UniqueName="BATCH_NO" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MAT_CODE1" AllowFiltering="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" >
                            </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PO_QTY" AllowFiltering="true" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="BATCH_QTY" AllowFiltering="true" FilterControlAltText="Filter BATCH_QTY column" HeaderText="BATCH QTY" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="BAL_TO_BATCH" AllowFiltering="true" FilterControlAltText="Filter BAL_TO_BATCH column" HeaderText="BALANCE TO BATCH QTY" SortExpression="BAL_TO_BATCH" UniqueName="BAL_TO_BATCH" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </div>
            <asp:ObjectDataSource ID="batchitemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_TOTAL_PO_BATCH_ITEMSTableAdapter"></asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

