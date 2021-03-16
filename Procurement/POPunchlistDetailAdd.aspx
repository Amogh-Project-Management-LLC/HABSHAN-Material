<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POPunchlistDetailAdd.aspx.cs" Inherits="Procurement_POPunchlistDetailAdd" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Save" Width="100px" OnClick="btnAdd_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsSource" PageSize="50" AllowPaging="true" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsSource" DataKeyNames="PO_ITEM_ID" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>
                     
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_ID" FilterControlAltText="Filter PO_ITEM_ID column" HeaderText="PO ITEM ID" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="PO_ITEM_ID" UniqueName="PO_ITEM_ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="CAT"  UniqueName="CAT" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlCAT" runat="server" Width="60px" >
                                <Items>
                                    <telerik:DropDownListItem Text="A" Value="A" />
                                    <telerik:DropDownListItem Text="B" Value="B" />
                                    <telerik:DropDownListItem Text="C" Value="C" />
                                </Items>
                            </telerik:RadDropDownList>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                     <telerik:GridBoundColumn DataField="PO_QTY" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="PO_QTY" UniqueName="PO_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PUNCH QTY" SortExpression="PO_QTY" UniqueName="PUNCH_QTY" AllowFiltering="false" FilterControlWidth="50" ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:TextBox ID="PO_QTYTextBox" runat="server" Text='<%# Bind("PO_QTY") %>' Width="50px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="PUNCH DESCRIPTION" UniqueName="Punch_Desc" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPunchDesc" runat="server" Width="150px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PUNCH DATE" UniqueName="PUNCH_DATE" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDatePicker ID="txtDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px"></telerik:RadDatePicker>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="selecT * from view_punch_add where PO_ID=:PO_ID">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="PO_ID" ControlID="hiddenPO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenPO_ID"  runat="server" />
</asp:Content>

