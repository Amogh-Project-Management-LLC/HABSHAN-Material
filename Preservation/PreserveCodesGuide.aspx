<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PreserveCodesGuide.aspx.cs" Inherits="Preservation_PreserveCodesGuide" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <telerik:RadMenu ID="RadMenu1" runat="server" OnItemClick="RadMenu1_ItemClick">
            <Items>
                <telerik:RadMenuItem Text="Storage Class" Value="1"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="WBS" Value="2"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Client/Vendor" Value="3"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Preservation Frequency" Value="4"></telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
    <div style="margin-top: 2px;">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlDataSource"
            AllowPaging="True">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDataSource" DataKeyNames="ITEM_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete ?"
                        ConfirmDialogType="RadWindow">
                        <ItemStyle Width="20px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn ReadOnly="true" DataField="CODE_CAT" FilterControlAltText="Filter CODE_CAT column" HeaderText="CATEGORY" SortExpression="CODE_CAT" UniqueName="CODE_CAT">
                        <EditItemTemplate>
                            <asp:TextBox ID="CODE_CATTextBox" runat="server" Text='<%# Bind("CODE_CAT") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CODE_CATLabel" runat="server" Text='<%# Eval("CODE_CAT") %>'></asp:Label>
                        </ItemTemplate>                        
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ReadOnly="true" DataField="SYMBOL" FilterControlAltText="Filter SYMBOL column" HeaderText="CODE SYMBOL" SortExpression="SYMBOL" UniqueName="SYMBOL">
                        <EditItemTemplate>
                            <asp:TextBox ID="SYMBOLTextBox" runat="server" Text='<%# Bind("SYMBOL") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SYMBOLLabel" runat="server" Text='<%# Eval("SYMBOL") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <telerik:RadTextBox runat="server" ID="txtAddSymbol" width="80px"></telerik:RadTextBox>
                        </FooterTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ReadOnly="true" DataField="DESCRIPTION" FilterControlAltText="Filter DESCRIPTION column" HeaderText="DESCRIPTION" SortExpression="DESCRIPTION" UniqueName="DESCRIPTION">
                        <EditItemTemplate>
                            <asp:TextBox ID="DESCRIPTIONTextBox" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DESCRIPTIONLabel" runat="server" Text='<%# Eval("DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_PRES_CODE_GUIDE_DETAIL
WHERE CODE_CAT_ID = :CODE_CAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenCatID" DefaultValue="-1" Name="CODE_CAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenCatID" runat="server" />
</asp:Content>

