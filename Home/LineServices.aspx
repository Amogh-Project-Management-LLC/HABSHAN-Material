<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LineServices.aspx.cs" Inherits="WeldingInspec_LineServices" Title="Line Services" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%">
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
                        </td>
                        <td align="right">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="140px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:GridView ID="serviceGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="LINE_SRV,PROJECT_ID" DataSourceID="LineSrvDataSource"
                    PageSize="15" Width="100%" OnRowUpdating="serviceGridView_RowUpdating" OnDataBound="serviceGridView_DataBound">
                    <PagerSettings PageButtonCount="15" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowSelectButton="True" ButtonType="Image"
                            CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            SelectImageUrl="~/Images/icon-select.gif" UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Line Service" SortExpression="LINE_SRV">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LINE_SRV") %>' Width="83px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="100px" />
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("LINE_SRV") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="SRV_DESCR" HeaderText="Service Description" SortExpression="SRV_DESCR" />
                        <asp:TemplateField HeaderText="Priority" SortExpression="PRIORITY">
                            <EditItemTemplate>
                                <asp:DropDownList ID="cboPriority" runat="server" AppendDataBoundItems="True" DataSourceID="priorityDataSource"
                                    DataTextField="TITLE" DataValueField="PRIORITY" SelectedValue='<%# Bind("PRIORITY") %>'
                                    Width="158px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("PRIORITY") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle Font-Bold="True" ForeColor="DarkBlue" />
                    <EmptyDataTemplate>
                        No line service defined yet!
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="width: 100%; background-color: #99ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnRegister" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Register" Width="84px" OnClick="btnRegister_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnDelete_Click" Text="Delete" Width="84px" />
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
    <asp:ObjectDataSource ID="LineSrvDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralTableAdapters.PIP_LINE_SERVICETableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="LINE_SRV" Type="String" />
            <asp:Parameter Name="SRV_DESCR" Type="String" />
            <asp:Parameter Name="PRIORITY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_LINE_SRV" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LINE_SRV" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="priorityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRIORITY, PRIORITY || ': ' || DESCR AS TITLE FROM IPMS_PRIORITY ORDER BY PRIORITY">
    </asp:SqlDataSource>
</asp:Content>
