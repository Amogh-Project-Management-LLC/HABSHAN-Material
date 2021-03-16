<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat_BOM.aspx.cs" Inherits="Material_Additional_Mat_BOM"
    Title="Additional Mat - BOM" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnregist" runat="server" Text="Entry" Width="80" OnClick="btnregist_Click" CausesValidation="false"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="entryUpdatePanel" runat="server">
            <ContentTemplate>
                <table runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">Isometric No
                        </td>
                        <td>
                            <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" Width="230px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ControlToValidate="txtIsome"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">BOM Item
                        </td>
                        <td>
                            <asp:DropDownList ID="cboBOM" runat="server" AppendDataBoundItems="True" DataSourceID="bomDataSource"
                                DataTextField="BOM_ITEM_B" DataValueField="BOM_ID" Width="600px" OnDataBinding="cboBOM_DataBinding"
                                AutoPostBack="True" OnSelectedIndexChanged="cboBOM_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="itemValidator" runat="server" ControlToValidate="cboBOM"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">Paint Code
                        </td>
                        <td>
                            <asp:TextBox ID="txtPaintCode" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">Issued Qty
                        </td>
                        <td>
                            <asp:TextBox ID="txtQty" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="returnGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="itemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin"
                    OnRowEditing="returnGridView_RowEditing" DataKeyNames="ADD_ISSUE_ID,BOM_ID">
                    <Columns>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                            UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                            ReadOnly="true" />
                        <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                        <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                        <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" ReadOnly="true" />
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1"
                            ReadOnly="true" />
                        <asp:BoundField DataField="SIZE_DESC" HeaderText="Size Desc" SortExpression="SIZE_DESC"
                            ReadOnly="true" />
                        <asp:BoundField DataField="WALL_THK" HeaderText="Schedule" SortExpression="WALL_THK"
                            ReadOnly="true" />
                        <asp:BoundField DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" />
                        <asp:BoundField DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                        <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div style="background-color: gainsboro;">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
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
                        <td>
                            <asp:HiddenField ID="scidField" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.VIEW_MAT_ISSUE_ADD_BOMTableAdapter"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUE_ID" QueryStringField="ADD_ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, BOM_ID, BOM_ITEM_B, SF FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE) ORDER BY BOM_ITEM_B">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>