<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserveItems.aspx.cs" Inherits="Material_MaterialReserveItems" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add Material" Width="100px"></telerik:RadButton>
    </div>
     <div>
            <telerik:RadGrid ID="gvHoldDetails" runat="server" DataSourceID="dsHoldItemDetails" 
                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                AllowPaging="True" AllowFilteringByColumn="True" PageSize="20">
                <GroupingSettings CaseSensitive="False" />

                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>

                <MasterTableView AutoGenerateColumns="False" DataSourceID="dsHoldItemDetails"
                    ClientDataKeyNames="MAT_RES_ID,MAT_ID" EditMode="InPlace" DataKeyNames="MAT_RES_ID,MAT_ID">
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="50px"></HeaderStyle>
                        <ItemStyle Width="50px" />
                    </RowIndicatorColumn>

                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="50px"></HeaderStyle>
                        <ItemStyle Width="50px" />
                    </ExpandCollapseColumn>

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
                        <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MATCODE" SortExpression="MAT_CODE1"
                            UniqueName="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" ReadOnly="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" SortExpression="ITEM_NAM"
                            UniqueName="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SIZE1" FilterControlAltText="Filter SIZE1 column" HeaderText="SIZE DESC"
                            SortExpression="SIZE1" UniqueName="SIZE1" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_RES_QTY" FilterControlAltText="Filter MAT_RES_QTY column"
                            HeaderText="RESERVE QTY"
                            SortExpression="MAT_RES_QTY" UniqueName="MAT_RES_QTY" AllowFiltering="false">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_REL_QTY" FilterControlAltText="Filter MAT_REL_QTY column" HeaderText="RELEASE QTY"
                            SortExpression="MAT_REL_QTY" UniqueName="MAT_REL_QTY" AllowFiltering="false">
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
    <asp:ObjectDataSource ID="dsHoldItemDetails" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_ADAPTER_RES_MATTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_RES_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RES_ID" QueryStringField="REQ_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_RES_QTY" Type="Decimal" />
            <asp:Parameter Name="MAT_REL_QTY" Type="Decimal" />
            <asp:Parameter Name="MAT_RES_REMARKS" Type="String" />
            <asp:Parameter Name="Original_MAT_RES_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>

</asp:Content>

