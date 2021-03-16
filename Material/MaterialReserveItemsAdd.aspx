<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserveItemsAdd.aspx.cs" Inherits="Material_MaterialReserveItemsAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <table>
                        <tr>
                            <td style="background-color: WHITESMOKE" class="auto-style1">
                                <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtMatcode" runat="server" AutoPostBack="true" EmptyMessage="Search MatCode1"
                                    Width="150px" OnTextChanged="txtMatcode_TextChanged">
                                </telerik:RadTextBox>
                                <asp:DropDownList runat="server" ID="ddMatcode" Width="250px"
                                    DataSourceID="dsMatStock" DataTextField="MAT_CODE1"
                                    DataValueField="MAT_ID" OnDataBinding="ddMatcode_DataBinding" AppendDataBoundItems="true">
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator5" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddMatcode" ValidationGroup="addItems" Font-Bold="true" ValueToCompare="-1"
                                    Operator="NotEqual"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: WHITESMOKE" class="auto-style1">Reserve Qty</td>
                            <td>
                                <telerik:RadTextBox ID="txtIssuedQty" runat="server" Width="80px">
                                </telerik:RadTextBox>

                                <asp:RequiredFieldValidator ID="issuedQtyValidator" runat="server"
                                    ControlToValidate="txtIssuedQty" ValidationGroup="addItems"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: WHITESMOKE" class="auto-style1">Release Qty</td>
                            <td>
                                <telerik:RadTextBox ID="txtReleaseQty" runat="server" Width="80px">
                                </telerik:RadTextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="txtReleaseQty" ValidationGroup="addItems"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td style="background-color: WHITESMOKE" class="auto-style1">Remarks</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="txtRemarks" Width="350px"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1"></td>
                            <td>
                                <asp:Button ID="btnAdd" Text="Add" runat="server" OnClick="btnAdd_Click" Width="80px" ValidationGroup="addItems" />
                               
                            </td>
                        </tr>
                    </table>
    </div>
     <asp:SqlDataSource ID="dsMatStock" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE (MAT_CODE1 LIKE FNC_FILTER(:MAT_CODE1))">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtMatcode" DefaultValue="%" Name="MAT_CODE1" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>

