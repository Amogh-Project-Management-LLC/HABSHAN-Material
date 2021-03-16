<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AreaList.aspx.cs" Inherits="Home_AreaList" Title="Areas/PCWBS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnHome" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnHome_Click" Text="Back" Width="77px" />
                        </td>
                        <td align="right">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="120px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="areaGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="PROJECT_ID,AREA_L1" DataSourceID="areaDataSource"
                    OnRowEditing="areaGridView_RowEditing" PageSize="15" Width="100%" OnDataBound="areaGridView_DataBound">
                    <PagerSettings PageButtonCount="15" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                            UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Area Level1" SortExpression="AREA_L1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("AREA_L1") %>' Width="60px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("AREA_L1") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Area Level2" SortExpression="AREA_L2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("AREA_L2") %>' Width="60px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("AREA_L2") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Area Level3" SortExpression="AREA_L3">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("AREA_L3") %>' Width="60px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("AREA_L3") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AREA_DESCR" HeaderText="Description" SortExpression="AREA_DESCR" />
                        <asp:TemplateField HeaderText="Priority" SortExpression="PRIORITY">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("PRIORITY") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("PRIORITY") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fab Start" SortExpression="FAB_START_DT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FAB_START_DT", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FAB_START_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fab Finish" SortExpression="FAB_FINISH_DT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FAB_FINISH_DT", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("FAB_FINISH_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Site Start" SortExpression="SITE_START_DT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SITE_START_DT", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("SITE_START_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Site Finish" SortExpression="SITE_FINISH_DT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SITE_FINISH_DT", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("SITE_FINISH_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Site CRD" SortExpression="SITE_CRD_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("SITE_CRD_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("SITE_CRD_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle Font-Bold="True" ForeColor="DarkRed" />
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                    <EmptyDataTemplate>
                        No Areas Dfined!
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnNew" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnNew_Click" Text="New" Width="77px" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnDelete_Click" Text="Delete" Width="77px" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="39px" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="39px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="areaDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionATableAdapters.VIEW_IPMS_AREATableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="AREA_L2" Type="String" />
            <asp:Parameter Name="AREA_L3" Type="String" />
            <asp:Parameter Name="AREA_DESCR" Type="String" />
            <asp:Parameter Name="PRIORITY" Type="Decimal" />
            <asp:Parameter Name="FAB_START_DT" Type="DateTime" />
            <asp:Parameter Name="FAB_FINISH_DT" Type="DateTime" />
            <asp:Parameter Name="SITE_START_DT" Type="DateTime" />
            <asp:Parameter Name="SITE_FINISH_DT" Type="DateTime" />
            <asp:Parameter Name="SITE_CRD_DATE" Type="DateTime" />
            <asp:Parameter Name="original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
