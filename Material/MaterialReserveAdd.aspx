<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserveAdd.aspx.cs" Inherits="Material_MaterialReserveAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">
                    <asp:Label ID="Label1" runat="server" Text="Reserve Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReserveNo" runat="server" AutoPostBack="true" EmptyMessage="Enter Reserve No"
                        Width="250px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Reserve Type</td>
                <td>
                    <asp:DropDownList ID="ddReserveType" runat="server" Width="200px" AutoPostBack="True">
                        <asp:ListItem Text="SG Complete" Value="SG_COMPLETE" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="SG Balance" Value="SG_BALANCE"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Subcon</td>
                <td>
                    <asp:DropDownList ID="ddSubcon" runat="server" Width="200px" DataSourceID="dsSubCon"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddSubcon_SelectedIndexChanged" AutoPostBack="True" OnDataBinding="ddSubcon_DataBinding">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="*" ValidationGroup="addReserve" ControlToValidate="ddSubcon" ValueToCompare="-1" Operator="NotEqual"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Stores</td>
                <td>
                    <asp:DropDownList ID="ddStores" runat="server" Width="200px" DataSourceID="dsStores" DataTextField="STORE_NAME" DataValueField="STORE_ID" OnDataBinding="ddStores_DataBinding" AppendDataBoundItems="true"></asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="*" ValidationGroup="addReserve" ControlToValidate="ddStores" ValueToCompare="-1" Operator="NotEqual"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Create Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtResvDate" runat="server">
                        <Calendar ID="Calendar1" runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Bisque" />
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="issuedQtyValidator" runat="server" ControlToValidate="txtResvDate"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Create By</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtCreateby"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WHITESMOKE">Remarks</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtRemarks" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px"></td>
                <td>
                    <asp:Button ID="btnAdd" Text="Add" runat="server" OnClick="btnAdd_Click" Width="80px" ValidationGroup="addReserve" />
                   

                </td>
            </tr>
        </table>
         <asp:SqlDataSource ID="dsSubCon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT PROJ_ID, SUB_CON_ID, SUB_CON_NAME, SHORT_NAME, FIELD_SC, FAB_SC, 
             REMARKS FROM SUB_CONTRACTOR"></asp:SqlDataSource>

        <asp:SqlDataSource ID="dsStores" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, 
             STORE_ID, STORE_NAME, SC_ID, LOCATION, REMARKS FROM STORES_DEF WHERE (SC_ID = :SUB_CON_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddSubcon" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

