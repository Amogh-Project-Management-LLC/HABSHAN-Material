<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PO.aspx.cs" Inherits="Material_PO" Title="Purchase Order" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80px"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="View Items" Width="90px" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:ImageButton ID="ImageButtonPreview" runat="server" ImageUrl="~/Images/icons/printer.png" OnClick="ImageButtonPreview_Click" />
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="PO_GridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            PageSize="18" Width="100%" OnDataBound="PO_GridView_DataBound" SkinID="GridViewSkin"
            DataKeyNames="PO_ID" DataSourceID="PO_DataSource" OnRowUpdating="PO_GridView_RowUpdating">
            <EmptyDataTemplate>
                No Data!
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="PO_NO" HeaderText="PO No" SortExpression="PO_NO" />
                <asp:BoundField DataField="PO_TITLE" HeaderText="PO Title" SortExpression="PO_TITLE" />
                <asp:BoundField DataField="PO_DATE" HeaderText="PO Date" SortExpression="PO_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                <asp:TemplateField HeaderText="PO AMD" SortExpression="PO_AMD">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PO_AMD") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("PO_AMD") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="MANUFACTURE" HeaderText="Manufacture" SortExpression="MANUFACTURE" />
                <asp:TemplateField HeaderText="Origin Country" SortExpression="ORIGIN_COUNTRY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ORIGIN_COUNTRY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("ORIGIN_COUNTRY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PO Terms" SortExpression="PO_TERMS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PO_TERMS") %>' Width="80px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PO_TERMS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PO Place" SortExpression="PO_PLACE">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PO_PLACE") %>' Width="80px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PO_PLACE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="PO_DataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsPO_ShipmentTableAdapters.PIP_POTableAdapter"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="PO_DATE" Type="DateTime" />
            <asp:Parameter Name="PO_TITLE" Type="String" />
            <asp:Parameter Name="PO_AMD" Type="String" />
            <asp:Parameter Name="MANUFACTURE" Type="String" />
            <asp:Parameter Name="ORIGIN_COUNTRY" Type="String" />
            <asp:Parameter Name="PO_TERMS" Type="String" />
            <asp:Parameter Name="PO_PLACE" Type="String" />
            <asp:Parameter Name="Original_PO_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>