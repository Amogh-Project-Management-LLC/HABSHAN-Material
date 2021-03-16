<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Numbers.aspx.cs" Inherits="WeldingInspec_WPS_Numbers" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Register"
                                Width="80px" BackColor="PowderBlue" BorderColor="SteelBlue" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox EmptyMessage="Search.." ID="txtSearch" runat="server" Width="200px"
                                OnTextChanged="txtSearch_TextChanged"></telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="140px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="wpsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="WPS_ID" DataSourceID="wpsDataSource"
                    PageSize="15" Width="100%" OnDataBound="wpsGridView_DataBound">
                    <PagerSettings PageButtonCount="15" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="WPS_NO1" HeaderText="WPS Number" ReadOnly="True" SortExpression="WPS_NO1" />
                        <asp:BoundField DataField="REV" HeaderText="Rev" SortExpression="REV" />
                        <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" />
                        <asp:BoundField DataField="PROCESS" HeaderText="Process" SortExpression="PROCESS">
                            <ItemStyle Font-Size="85%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PWHT" HeaderText="PWHT" SortExpression="PWHT" />
                        <asp:BoundField DataField="SIZE_FROM" HeaderText="Size From" SortExpression="SIZE_FROM" />
                        <asp:BoundField DataField="SIZE_TO" HeaderText="Size To" SortExpression="SIZE_TO" />
                        <asp:BoundField DataField="THK_FROM" HeaderText="Thick From" SortExpression="THK_FROM" />
                        <asp:BoundField DataField="THK_TO" HeaderText="Thick To" SortExpression="THK_TO" />
                        <asp:BoundField DataField="PIPE_CLASS" HeaderText="PIPE Class" SortExpression="PIPE_CLASS">
                            <ItemStyle Font-Size="85%" />
                        </asp:BoundField>
                    </Columns>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <EmptyDataTemplate>
                        No WPS found! use the search box.
                    </EmptyDataTemplate>
                    <PagerStyle Font-Bold="True" ForeColor="DarkGreen" />
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnWPS_Details" runat="server" OnClick="btnWPS_Details_Click" Text="Details"
                                Width="80px" BackColor="SkyBlue" BorderColor="SteelBlue" />
                        </td>
                        <td>
                            <asp:Button ID="btnViewPDF" runat="server" Text="PDF" Width="80px" BackColor="SkyBlue"
                                BorderColor="SteelBlue" OnClick="btnViewPDF_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnDelete_Click" Text="Delete" Width="80px" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" BackColor="LightBlue" BorderColor="SteelBlue"
                                EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="41px" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" BackColor="LightBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="41px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="wpsDataSource" runat="server" SelectMethod="GetData" TypeName="dsWeldingBTableAdapters.PIP_WPS_NOTableAdapter"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="SC_ID" SessionField="CONNECT_AS" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_WPS_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
