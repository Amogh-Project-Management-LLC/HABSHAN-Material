<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatReceiveImport.aspx.cs" Inherits="Material_MatReceiveImport" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">
     function handleSpace(event) {
                var keyPressed = event.which || event.keyCode;
                if (keyPressed == 13) {
                    event.preventDefault();
                    event.stopPropagation();
                }
    }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="true"
            AllowMultiRowSelection="True" AllowFilteringByColumn="true" PageSize="50" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true">
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource"  TableLayout="Fixed">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect" FilterControlWidth="40px">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="IRN_ID" FilterControlAltText="Filter IRN_ID column" HeaderText="IRN ID" SortExpression="IRN_ID" UniqueName="IRN_ID"  AllowFiltering="false">
                        <HeaderStyle Width="1px"/>
                        <ItemStyle Width="1px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN NO" SortExpression="IRN_NO" UniqueName="IRN_NO" AutoPostBackOnFilter="true" FilterControlWidth="170px">
                        <HeaderStyle Width="230px"/>
                        <ItemStyle Width="230px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM"  AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <HeaderStyle Width="90px"/>
                        <ItemStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="90px">
                        <HeaderStyle Width="140px"/>
                        <ItemStyle Width="140px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="200px">
                        <HeaderStyle Width="250px"/>
                        <ItemStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AutoPostBackOnFilter="true" FilterControlWidth="50%">
                        <HeaderStyle Width="80px"/>
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <HeaderStyle Width="100px"/>
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UNIT" SortExpression="UOM" UniqueName="UOM" AllowFiltering="false">
                        <HeaderStyle Width="50px"/>
                        <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RELEASE_QTY" DataType="System.Decimal" FilterControlAltText="Filter RELEASE_QTY column" HeaderText="RELEASE QTY" SortExpression="RELEASE_QTY" UniqueName="RELEASE_QTY" AllowFiltering="false">
                        <HeaderStyle Width="70px"/>
                        <ItemStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RECV_QTY column" HeaderText="RECIEVED QTY" SortExpression="RECV_QTY" UniqueName="RECV_QTY" AllowFiltering="false">
                        <HeaderStyle Width="70px"/>
                        <ItemStyle Width="70px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="RECV_PIECES" DataType="System.Decimal" FilterControlAltText="Filter RECV_PIECES column" HeaderText="RECIEVED PIECES" SortExpression="RECV_PIECES" UniqueName="RECV_PIECES" AllowFiltering="false">
                        <HeaderStyle Width="70px"/>
                        <ItemStyle Width="70px" />
                    </telerik:GridBoundColumn>
                   
                     <telerik:GridTemplateColumn DataField="BAL_TO_RECV" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_RECV column" HeaderText="QTY TO RECIEVE" SortExpression="BAL_TO_RECV" UniqueName="BAL_TO_RECV" AllowFiltering="false">
                        <HeaderStyle Width="100px"/>
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_TO_RECVLabel" runat="server" Text='<%# Eval("BAL_TO_RECV") %>' onkeypress="handleSpace(event)"  Width="80px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn DataField="BAL_TO_RECV_PIECES"  FilterControlAltText="Filter BAL_TO_RECV_PIECES column" HeaderText="PIECES TO RECIEVE" SortExpression="BAL_TO_RECV_PIECES" UniqueName="BAL_TO_RECV_PIECES" AllowFiltering="false">
                        <HeaderStyle Width="80px"/>
                        <ItemStyle Width="80px" />
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_TO_RECV_PIECESLabel" runat="server" Text='<%# Eval("BAL_TO_RECV_PIECES") %>' onkeypress="handleSpace(event)"  Width="60px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT *
            FROM VIEW_IRN_BAL_TO_RECV
            WHERE IRN_ID IN (SELECT IRN_ID FROM PIP_MAT_RECEIVE_IRN WHERE MAT_RCV_ID = :MAT_RCV_ID)
            ORDER BY PO_ITEM">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

