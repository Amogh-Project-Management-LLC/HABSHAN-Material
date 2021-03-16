<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialType.aspx.cs" Inherits="WeldingInspec_MaterialType" Title="Material Types" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox EmptyMessage="Search.." ID="txtFilter" runat="server" AutoPostBack="True"
                                OnTextChanged="txtFilter_TextChanged" Width="200px"></telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="137px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="PipingSpecGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="matTypeDataSource" PageSize="15"
                    Width="100%" OnDataBound="PipingSpecGridView_DataBound" DataKeyNames="PROJ_ID,MAT_TYPE">
                    <PagerSettings PageButtonCount="18" Position="Top" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowSelectButton="True" ButtonType="Image"
                            CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            SelectImageUrl="~/Images/icon-select.gif" UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Material Type" SortExpression="MAT_TYPE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox21" runat="server" Text='<%# Bind("MAT_TYPE") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mat Group" SortExpression="MAT_GROUP">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MAT_GROUP") %>' Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("MAT_GROUP") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mat Category" SortExpression="MAT_CAT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MAT_CAT") %>' Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MAT_CAT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PWHT" SortExpression="PWHT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PWHT") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("PWHT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PMI" SortExpression="PMI">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PMI") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("PMI") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PT" SortExpression="PT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("PT") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("PT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="RT/UT" SortExpression="RT_UT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("RT_UT") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("RT_UT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MT" SortExpression="MT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("MT") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("MT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="HT" SortExpression="HT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("HT") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("HT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TYPE_DESCR" HeaderText="Description" SortExpression="TYPE_DESCR" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Material Type Found!
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle CssClass="PagerStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnDelete" runat="server" Text="Delete" Width="80px" BackColor="SkyBlue"
                    Enabled="false" BorderColor="SteelBlue" />
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="matTypeDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralATableAdapters.VIEW_PIP_MAT_TYPETableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PROJ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_TYPE" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="MAT_GROUP" Type="String" />
            <asp:Parameter Name="MAT_CAT" Type="String" />
            <asp:Parameter Name="PWHT" Type="String" />
            <asp:Parameter Name="PMI" Type="String" />
            <asp:Parameter Name="PT" Type="String" />
            <asp:Parameter Name="RT_UT" Type="String" />
            <asp:Parameter Name="MT" Type="String" />
            <asp:Parameter Name="HT" Type="String" />
            <asp:Parameter Name="TYPE_DESCR" Type="String" />
            <asp:Parameter Name="Original_PROJ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_TYPE" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
