<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitutionItems.aspx.cs" Inherits="Material_MaterialSubstitutionItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Items" Width="100px"></telerik:RadButton>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="itemsGridDetail" runat="server" CellSpacing="0" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                    DataSourceID="itemsDataSource" GridLines="None" PageSize="15" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                    OnItemDataBound="RadGrid1_ItemDataBound" OnItemCommand="RadGrid1_ItemCommand">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BOM_ID,SEC_KEY" EditMode="InPlace">
                        <Columns>
                            <%-- GRID VIEW EDIT COLUMN --%>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="20" />
                            </telerik:GridEditCommandColumn>
                            <%-- GRID VIEW COLUMN END --%>

                            <%-- GRID VIEW DELETE COLUMN --%>
                            <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" Width="20" CssClass="MyImageButton" />
                            </telerik:GridButtonColumn>
                            <%-- GRID VIEW DELETE COLUMN END --%>

                            <telerik:GridBoundColumn DataField="BOM_ITEM" FilterControlAltText="Filter BOM_ITEM column" HeaderText="OLD MATERIAL" SortExpression="BOM_ITEM" UniqueName="BOM_ITEM" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Left" Width="310" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OLD_QTY" DataType="System.Decimal" DataFormatString="{0:#0.00}" FilterControlAltText="Filter OLD_QTY column" HeaderText="OLD QTY" SortExpression="OLD_QTY" UniqueName="OLD_QTY" ReadOnly="True" AllowFiltering="False">
                                <ItemStyle HorizontalAlign="Right" Width="40" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NEW_MAT_CODE" FilterControlAltText="Filter NEW_MAT_CODE column" HeaderText="NEW MATERIAL" SortExpression="NEW_MAT_CODE" UniqueName="NEW_MAT_CODE" ReadOnly="True" AllowFiltering="False">
                                <ItemStyle HorizontalAlign="Left" Width="65" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NEW_SIZE" FilterControlAltText="Filter NEW_SIZE column" DataFormatString="{0:#0.00}" HeaderText="NEW SIZE" SortExpression="NEW_SIZE" UniqueName="NEW_SIZE" ReadOnly="True" AllowFiltering="False">
                                <ItemStyle HorizontalAlign="Right" Width="40" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NEW_WT" FilterControlAltText="Filter NEW_WT column" HeaderText="NEW WT" DataFormatString="{0:#0.00}" SortExpression="NEW_WT" UniqueName="NEW_WT" ReadOnly="True" AllowFiltering="False">
                                <ItemStyle HorizontalAlign="Right" Width="45" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="NEW_QTY" DataType="System.Decimal" FilterControlAltText="Filter NEW_QTY column" HeaderText="NEW QTY" SortExpression="NEW_QTY" UniqueName="NEW_QTY" AllowFiltering="False">
                                <EditItemTemplate>
                                    <asp:TextBox ID="NEW_QTYTextBox" runat="server" Text='<%# Bind("NEW_QTY", "{0:#0.00}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="NEW_QTYLabel" runat="server" Text='<%# Bind("NEW_QTY", "{0:#0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="40" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="SS_FLAG" FilterControlAltText="Filter SS_FLAG column" HeaderText="FLAG" SortExpression="SS_FLAG" UniqueName="SS_FLAG" AllowFiltering="False">
                                <ItemStyle HorizontalAlign="Center" Width="40" />
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="flagDataSource"
                                        DataTextField="SS_FLAG" DataValueField="FLAG_ID" SelectedValue='<%# Bind("FLAG_ID") %>'
                                        Width="80px">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SS_FLAG") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                                <EditItemTemplate>
                                    <asp:TextBox ID="REMARKSTextBox" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REMARKSLabel" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_ADP_SUBSTITUTE_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SEC_KEY" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="req_id" QueryStringField="REQ_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NEW_QTY" Type="Decimal" />
            <asp:Parameter Name="FLAG_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SEC_KEY" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="flagDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT FLAG_ID, SS_FLAG FROM PIP_SUBSTITUTE_FLAG ORDER BY SS_FLAG"></asp:SqlDataSource>

    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
</asp:Content>

