<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitution.aspx.cs" Inherits="Material_MaterialSubstitution" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Create" Width="80px"></telerik:RadButton>
        
        <telerik:RadButton ID="btnDetails" runat="server" Text="Material List" Width="100px" OnClick="btnDetails_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnImport" runat="server" Text="Bulk Import.." Width="100px"></telerik:RadButton>
    </div>
    <div style="margin-top: 5px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
            AllowPaging="True" PageSize="15" AllowAutomaticUpdates="True" AllowAutomaticDeletes="True"
            AllowFilteringByColumn="True" OnItemCommand="itemsGrid_ItemCommand">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="REQ_ID">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ImageUrl="../Images/icon-cancel.gif"></telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="REQ_NO" AllowFiltering="true" AllowSorting="true" FilterControlAltText="Filter REQ_NO column" HeaderText="REQUEST NO" SortExpression="REQ_NO" UniqueName="REQ_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="REQ_DATE" DataType="System.DateTime" FilterControlAltText="Filter REQ_DATE column" HeaderText="REQUEST DATE" SortExpression="REQ_DATE" UniqueName="REQ_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditReqDate" runat="server" SelectedDate='<%# Bind("REQ_DATE") %>'></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REQ_DATELabel" runat="server" Text='<%# Eval("REQ_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REQ_BY" AllowFiltering="false" FilterControlAltText="Filter REQ_BY column" HeaderText="REQUEST BY" SortExpression="REQ_BY" UniqueName="REQ_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUB_CON_NAME" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlSubcon" runat="server"
                                DataSourceID="sqlSubconSource" DataTextField="SUB_CON_NAME" DataValueField="SC_ID"
                                SelectedValue='<%# Bind("SC_ID") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SUB_CON_NAMELabel" runat="server" Text='<%# Eval("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStoreList" runat="server" DataSourceID="sqlStoreSource" DataTextField="STORE_NAME"
                                DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="STORE_NAMELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MAT_SUBSTITUTETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REQ_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_REQ_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID AS SC_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF ORDER BY STORE_NAME">        
    </asp:SqlDataSource>
</asp:Content>

