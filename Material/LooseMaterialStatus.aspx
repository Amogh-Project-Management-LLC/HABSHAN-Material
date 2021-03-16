<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LooseMaterialStatus.aspx.cs" Inherits="Material_LooseMaterialStatus" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="90px"></telerik:RadButton>
        <telerik:RadButton ID="btnErected" runat="server" Text="Erected" Width="90px"></telerik:RadButton>
    </div>
    <div>
          <telerik:RadGrid DataSourceID="SupportStatus" ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" 
              AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="15" AutoGenerateColumns="False" 
              OnPreRender="RadGrid1_PreRender" PagerStyle-ShowPagerText="false">          
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <MasterTableView DataSourceID="SupportStatus" DataKeyNames="BOM_ID" ClientDataKeyNames="BOM_ID">            
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISOMETRIC NO" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHEET" FilterControlAltText="Filter SHEET column" HeaderText="SHEET" SortExpression="SHEET" UniqueName="SHEET" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PT_NO" FilterControlAltText="Filter PT_NO column" DataFormatString="{0:#0.00}" HeaderText="PT NO" SortExpression="PT_NO" UniqueName="PT_NO" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE2" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="WALL THK" SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SF_FLG" FilterControlAltText="Filter SF_FLG column" HeaderText="SF" SortExpression="SF_FLG" UniqueName="SF_FLG" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NET_QTY" DataType="System.Decimal" FilterControlAltText="Filter NET_QTY column" HeaderText="NET QTY" SortExpression="NET_QTY" UniqueName="NET_QTY" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                </Columns>
                </MasterTableView>
        </telerik:RadGrid>
    </div>
     <asp:SqlDataSource ID="SupportStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1, SHEET, SPOOL, PT_NO, ITEM_NAM, MAT_CODE1, MAT_CODE2, SIZE_DESC, WALL_THK, SF_FLG, NET_QTY, BOM_ID FROM VIEW_TOT_BOM WHERE ROWNUM < 1000"></asp:SqlDataSource>
</asp:Content>

