<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserve.aspx.cs" Inherits="Material_MaterialReserve" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="btnItems" runat="server" Text="Material" Width="80px" OnClick="btnItems_Click"></telerik:RadButton>
    </div>
    <div>
         <telerik:RadGrid ID="gvMatReserve" runat="server" DataSourceID="dsMatReserve" 
                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" CellSpacing="0" GridLines="None"
                AllowPaging="True" AllowFilteringByColumn="True" PageSize="20" AllowSorting="True">
                <GroupingSettings CaseSensitive="False" />

                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>

                <MasterTableView AutoGenerateColumns="False" DataSourceID="dsMatReserve"
                    ClientDataKeyNames="MAT_RES_ID"  EditMode="InPlace" DataKeyNames="MAT_RES_ID">                   
                    <Columns>                    
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton" Width="20px" />
                            <HeaderStyle Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                        </telerik:GridButtonColumn>
                        <telerik:GridBoundColumn DataField="MAT_RES_NO" HeaderText="RESERVE NO" SortExpression="MAT_RES_NO" UniqueName="MAT_RES_NO" FilterControlAltText="Filter MAT_RES_NO column" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn DataField="MAT_RES_DATE" DataType="System.DateTime" HeaderText="RESERVE DATE"
                            SortExpression="MAT_RES_DATE" UniqueName="MAT_RES_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                            <ItemStyle Width="200px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="STORE_NAME"
                            FilterControlAltText="Filter STORE_NAME column" HeaderText="STORES" SortExpression="STORE_NAME" UniqueName="STORE_NAME" ReadOnly="true">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddToStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                                    DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("MAT_RES_STORE") %>'
                                    Width="180px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column"
                            HeaderText="SUBCON" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME" ReadOnly="true">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddToSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("MAT_RES_SUBCON") %>'
                                    Width="180px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label50" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="MAT_RES_TYPE" HeaderText="RESERVE TYPE" ReadOnly="true" SortExpression="MAT_RES_TYPE"
                            UniqueName="MAT_RES_TYPE" AllowFiltering="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_RES_BY" HeaderText="CREATE BY" SortExpression="MAT_RES_BY"
                            UniqueName="MAT_RES_BY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_RES_REMARKS" FilterControlAltText="Filter MAT_RES_REMARKS column" HeaderText="REMARKS"
                            SortExpression="MAT_RES_REMARKS" UniqueName="MAT_RES_REMARKS" AllowFiltering="false">
                        </telerik:GridBoundColumn>
                    </Columns>

                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    </EditFormSettings>
                    <BatchEditingSettings EditType="Cell"></BatchEditingSettings>
                    <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
                </MasterTableView>
                <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
                <FilterMenu EnableImageSprites="False"></FilterMenu>
            </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="dsMatReserve" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MAT_RESERVETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_MAT_RES_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_RES_NO" Type="String" />
            <asp:Parameter Name="MAT_RES_DATE" Type="DateTime" />
            <asp:Parameter Name="MAT_RES_BY" Type="String" />
            <asp:Parameter Name="MAT_RES_REMARKS" Type="String" />
            <asp:Parameter Name="Original_MAT_RES_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
         FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_ID">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME
         FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>

