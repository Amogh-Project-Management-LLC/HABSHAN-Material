<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialReuseItems.aspx.cs" Inherits="Material_MaterialReuseItems" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="120px"></telerik:RadButton>        
    </div>
    <div style="margin-top:5px">
                  <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" 
                      AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" PageSize="20" AutoGenerateColumns="False" Skin="Office2007" DataSourceID="returnDataSource" 
                      OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnItemDataBound="RadGrid1_ItemDataBound">
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView DataSourceID="returnDataSource" DataKeyNames="MRN_ITEM_ID" EditMode="InPlace">                   
                    <Columns>

                        <%-- GRID VIEW EDIT COLUMN --%>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton" Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <%-- GRID VIEW COLUMN END --%>
                        <%-- GRID VIEW DELETE COLUMN --%>
                        <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                        </telerik:GridButtonColumn>
                        <%-- GRID VIEW DELETE COLUMN END --%>
                        <telerik:GridTemplateColumn DataField="BOM_ITEM_B" FilterControlAltText="Filter BOM_ITEM_B column" HeaderText="BOM ITEM" SortExpression="BOM_ITEM_B" UniqueName="BOM_ITEM_B">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="bomDataSource"
                                    DataTextField="BOM_ITEM_B" DataValueField="BOM_ID" SelectedValue='<%# Bind("BOM_ID") %>'
                                    Width="300px">
                                </asp:DropDownList>
                            </EditItemTemplate>

                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("BOM_ITEM_B") %>'></asp:Label>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Left" Width="330" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="MRN_QTY" DataType="System.Decimal" FilterControlAltText="Filter MRN_QTY column" DataFormatString="{0:#0.00}" HeaderText="MRN QTY" SortExpression="MRN_QTY" UniqueName="MRN_QTY" AllowFiltering="False">
                            <ItemStyle HorizontalAlign="Right" Width="70" />
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>

            </telerik:RadGrid>
    </div>
     <asp:ObjectDataSource ID="returnDataSource" runat="server" DeleteMethod="DeleteQuery"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.PIP_MAT_REUSE_DETAILTableAdapter"
            UpdateMethod="UpdateQuery">
            <DeleteParameters>
                <asp:Parameter Name="Original_MRN_ITEM_ID" Type="Decimal" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="BOM_ID" Type="Decimal" />
                <asp:Parameter Name="MRN_QTY" Type="Decimal" />
                <asp:Parameter Name="REMARKS" Type="String" />
                <asp:Parameter Name="Original_MRN_ITEM_ID" Type="Decimal" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="-1" Name="MRN_ID" QueryStringField="REQ_ID"
                    Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
     <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM_B 
FROM  VIEW_BOM_EREC_ITEM
WHERE SF = 8 AND ISO_ID = :ISO_ID
ORDER BY BOM_ITEM_B">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>

