<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PPCSCustomSrn.aspx.cs" Inherits="Utilities_PPCSCustomSrn" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="right_content">

        <asp:UpdatePanel ID="MainUpdatePanel" runat="server">
            <ContentTemplate>               
                <div style="background-color:whitesmoke">
                    <telerik:RadButton ID="btnAdd" runat="server" Text="ADD SRN" Width="110" OnClick="btnAdd_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnUpdate" runat="server" Text="Update PPCS Data" Width="150" OnClick="btnUpdate_Click"></telerik:RadButton>
                </div>
                <div style="margin-top:5px">
                    <asp:Panel ID="panel1" runat="server" DefaultButton="btnSave">
                        <table runat="server" visible="false" id="entryTable">
                            <tr>
                                <td class="auto-style1">Custom SRN No.</td>
                                <td>
                                    <telerik:RadTextBox ID="txtSrnNo" runat="server" OnTextChanged="txtSrnNo_TextChanged" AutoPostBack="true" DisplayText="Search SRN"></telerik:RadTextBox></td>
                                <td>
                                    <telerik:RadDropDownList ID="ddSrnNo" runat="server" AppendDataBoundItems="True" DataSourceID="dsPPCSSrnNumber" DataTextField="SRN_NO" DataValueField="SRN_NO" OnSelectedIndexChanged="ddSrnNo_SelectedIndexChanged" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="Select SRN Number" Value="-1" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:CompareValidator ValidationGroup="addNew" ID="CompareValidator1" runat="server" ErrorMessage="*" ControlToValidate="ddSrnNo" ValueToCompare="-1" Operator="NotEqual" SetFocusOnError="true" ForeColor="Red"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">Custom SRN Date</td>
                                <td>
                                    <telerik:RadDatePicker ID="txtSrnDate" runat="server" DateInput-DisplayDateFormat="dd-MMM-yyyy">
                                        <Calendar ID="Calendar1" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Bisque" />
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ValidationGroup="addNew" ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtSrnDate" InitialValue="" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <telerik:RadButton ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save"  ValidationGroup="addNew"></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>

                   
                    <!-- TELERIK GRID VIEW START -->
                    <telerik:RadGrid DataSourceID="dsGridView" ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowPaging="True" CellSpacing="0" GridLines="None" PageSize="20" AutoGenerateColumns="False">
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />                           
                        </ClientSettings>

                        <MasterTableView DataSourceID="dsGridView" DataKeyNames="SRN_NO" EditMode="PopUp" EditFormSettings-EditColumn-ButtonType="ImageButton" AllowFilteringByColumn="True">
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>

                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                            </ExpandCollapseColumn>

                            <Columns>
                                <%-- RAD EDIT COLUMN --%>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                    <ItemStyle CssClass="MyImageButton" Width="20" />
                                </telerik:GridEditCommandColumn>
                                <%-- RAD EDIT COLUMN END --%>

                                <%-- RAD DELETE COLUMN --%>
                                <telerik:GridButtonColumn ConfirmText="Are you sure to delete?" ConfirmDialogType="RadWindow"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn">
                                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20" />
                                </telerik:GridButtonColumn>
                                <%-- RAD DELETE COLUMN END --%>

                                <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="SRN NUMBER" SortExpression="SRN_NO" UniqueName="SRN_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemStyle Width="180" />
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn DataField="SRN_DATE" DataType="System.DateTime" FilterControlAltText="Filter SRN_DATE column" HeaderText="SRN DATE" SortExpression="SRN_DATE" UniqueName="SRN_DATE" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="true" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                    <ItemStyle Width="80px" HorizontalAlign="Right" />
                                </telerik:GridDateTimeColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                            </EditFormSettings>
                            <BatchEditingSettings EditType="Cell"></BatchEditingSettings>
                            <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
                        </MasterTableView>
                        <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>

                    </telerik:RadGrid>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM PPCS_CUSTOM_SRN" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" ID="dsGridView" runat="server" DeleteCommand="DELETE FROM PPCS_CUSTOM_SRN WHERE  SRN_NO= :original_SRN_NO)" UpdateCommand="UPDATE PPCS_CUSTOM_SRN SET SRN_NO = :SRN_NO, SRN_DATE= :SRN_DATE WHERE SRN_NO=:original_SRN_NO">
            <DeleteParameters>
                <asp:Parameter Name="SRN_NO" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="SRN_NO" Type="String" />
                <asp:Parameter Name="SRN_DATE" Type="DateTime" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsPPCSSrnNumber" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT SRN_NO FROM PPCS_PO_DETAIL_SPLIT WHERE (SRN_NO IS NOT NULL) AND (SRN_NO LIKE '%' || :SEARCH_STRING || '%') GROUP BY SRN_NO ORDER BY SRN_NO">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSrnNo" DefaultValue="~" Name="SEARCH_STRING" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

