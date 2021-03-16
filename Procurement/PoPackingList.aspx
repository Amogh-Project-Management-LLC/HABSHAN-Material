<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PoPackingList.aspx.cs" Inherits="PoPackingList" Title="Packing List" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New" Width="80" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPackages" runat="server" Text="Packages" Width="80" OnClick="btnPackages_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Materials" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server"
                        Width="212px" AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" Width="137px" OnSelectedIndexChanged="PageList_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="issueDataSource" PageSize="20" Width="100%" SkinID="GridViewSkin"
            OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="IssueGridView_DataBound" DataKeyNames="PKL_ID">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="PKL No" SortExpression="PKL_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PKL_NO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Font-Size="Smaller" Text='<%# Bind("PKL_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PO_NO" HeaderText="PO No" SortExpression="PO_NO" />
                <asp:TemplateField HeaderText="Vendor Name" SortExpression="VENDOR_NAME">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("VENDOR_NAME") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Font-Size="X-Small" Text='<%# Bind("VENDOR_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CARGO_READY_DATE" HeaderText="Cargo Ready Date" SortExpression="CARGO_READY_DATE"
                    ApplyFormatInEditMode="True" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                <asp:BoundField DataField="FOB_DATE" HeaderText="FOB Date" SortExpression="FOB_DATE"
                    ApplyFormatInEditMode="True" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                <asp:TemplateField HeaderText="Port of Loading" SortExpression="PORT_OF_LOADING">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PORT_OF_LOADING") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Font-Size="X-Small" Text='<%# Bind("PORT_OF_LOADING") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="STORAGE_CODE" HeaderText="Shortage Code" SortExpression="STORAGE_CODE" />
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: gainsboro;">
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

    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="PO_PackingListTableAdapters.VIEW_MAT_PK_LISTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PKL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PKL_NO" Type="String" />
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="VENDOR_NAME" Type="String" />
            <asp:Parameter Name="CARGO_READY_DATE" Type="DateTime" />
            <asp:Parameter Name="FOB_DATE" Type="DateTime" />
            <asp:Parameter Name="PORT_OF_LOADING" Type="String" />
            <asp:Parameter Name="STORAGE_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_PKL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="PKL_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>