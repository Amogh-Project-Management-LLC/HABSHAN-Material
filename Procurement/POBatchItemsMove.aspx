<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POBatchItemsMove.aspx.cs" Inherits="Procurement_POBatchImport" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 70 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }

    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
       
        <telerik:RadButton ID="btnLabel" runat="server" Text="Select Batch to Move" Width="300px" Enabled="false">
            <Icon PrimaryIconUrl="../Images/New-Icons/Right-Arrow.png"/>
        </telerik:RadButton>
        
        <telerik:RadComboBox runat="server" ID="ddlBatchNO" DataSourceID="BatchDataSource" DataTextField="BATCH_NO" DataValueField="BATCH_ID" AllowCustomText="true"></telerik:RadComboBox>
         <telerik:RadButton ID="btnMove" runat="server" Text="Move Items" Width="150px" OnClick="btnMove_Click">
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="true" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BATCH_ITEM_ID" AllowFilteringByColumn="true" PageSize="50">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"  OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemStyle Width="15px" />
                        <HeaderStyle Width="15px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="BATCH_ITEM_ID" FilterControlAltText="Filter BATCH_ITEM_ID column" HeaderText="BATCH_ITEM_ID" SortExpression="BATCH_ITEM_ID" UniqueName="BATCH_ITEM_ID" AllowFiltering="false">
                        <ItemStyle Width="1px" />
                        <HeaderStyle Width="1px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO_ITEM_NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="400px">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO_QTY" SortExpression="PO_QTY" UniqueName="PO_QTY" AllowFiltering="false">
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_QTY" DataType="System.Decimal" FilterControlAltText="Filter BATCH_QTY column" HeaderText="BATCH QTY" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY" AllowFiltering="false">
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BATCH_QTY" DataType="System.Decimal" FilterControlAltText="Filter BATCH_QTY column" HeaderText="QTY TO MOVE" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY" AllowFiltering="false">
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                        <ItemTemplate>
                            <asp:TextBox ID="BATCH_QTYTextBox" runat="server" Text='<%# Bind("BATCH_QTY") %>' Width="50px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
             <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="BATCH_ID" QueryStringField="BATCH_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
       
    <asp:SqlDataSource ID="BatchDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BATCH_ID, PO_NO||'/'||BATCH_NO AS BATCH_NO FROM VIEW_PO_BATCH_PLAN WHERE PO_ID=:PO_ID AND BATCH_ID<>:BATCH_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="BATCH_ID" QueryStringField="BATCH_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="hiddenPO_ID" Name="PO_ID" DefaultValue="-1" PropertyName="Value"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField runat="server" ID="hiddenPO_ID" />
</asp:Content>

