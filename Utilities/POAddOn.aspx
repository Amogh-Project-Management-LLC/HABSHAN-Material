<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POAddOn.aspx.cs" Inherits="Utilities_POAddOn" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" Width="100" OnClick="btnAdd_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnUpload" runat="server" Text="Import.." Width="100"></telerik:RadButton>
    </div>
    <div runat="server" id="EntryTable" visible="false">
        <table>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">PO Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPO" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">PO Item
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPOItem" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Mat Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSearchItem" runat="server"></telerik:RadTextBox>
                    <asp:DropDownList ID="ddlItemCodes" runat="server" DataSourceID="sqlMatCodeSoure" DataTextField="MAT_CODE1" DataValueField="MAT_ID"></asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td style="width: 100px; background-color: whitesmoke">Order Quantity
                </td>
                <td>
                    <telerik:RadTextBox ID="txtOrdQty" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Split Quantity
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td style="width: 100px; background-color: whitesmoke">Split ID
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSplitID" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">ETA Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtETADate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Skin="Default" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="80" Skin="Default" OnClick="btnCancel_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowAutomaticDeletes="True" 
            AllowAutomaticUpdates="True" MasterTableView-EditMode="InPlace" AllowPaging="true" PageSize="15" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="ITEM_ID">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ImageUrl="../Images/icon-cancel.gif" ItemStyle-Width="20px"
                        ConfirmDialogType="RadWindow" ConfirmText="Are you sure, you want to delete this record ?">
                        <ItemStyle Width="20px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="30px">
                        <ItemStyle Width="30px"></ItemStyle>
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" AllowFiltering="true" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_QTY column" HeaderText="SPLIT_QTY" SortExpression="SPLIT_QTY" UniqueName="SPLIT_QTY">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="ORD_QTY" AllowFiltering="false"  ReadOnly="true" DataType="System.Decimal" FilterControlAltText="Filter ORD_QTY column" HeaderText="ORD_QTY" SortExpression="ORD_QTY" UniqueName="ORD_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" AllowFiltering="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" AllowFiltering="true" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO_ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="ETA_DATE" AllowFiltering="true"  DataType="System.DateTime" FilterControlAltText="Filter ETA_DATE column" HeaderText="ETA_DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditETADate" runat="server" SelectedDate='<%# Bind("ETA_DATE") %>'
                                 DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>                            
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ETA_DATELabel" runat="server" Text='<%# Eval("ETA_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralATableAdapters.PIP_PPCS_ADD_MATTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SPLIT_QTY" Type="Decimal" />
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="ETA_DATE" Type="DateTime" />
            <asp:Parameter Name="original_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlMatCodeSoure" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1
FROM PIP_MAT_STOCK
WHERE MAT_CODE1 LIKE FNC_FILTER(:FILTER)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearchItem" DefaultValue="-1" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

