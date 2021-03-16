<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitutionItemNew.aspx.cs" Inherits="Material_MaterialSubstitutionItemNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .auto-style2 {
            width:200px;
            background-color:whitesmoke;
        }
    </style>
    <table class="auto-style1">
        <tr>
            <td class="auto-style2">Isometric Number</td>
            <td class="auto-style3">:</td>
            <td>
                <telerik:RadTextBox ID="txtIsometric" runat="server" AutoPostBack="True" Width="160px" OnTextChanged="txtIsometric_TextChanged">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="isoValidator" runat="server" ControlToValidate="txtIsometric"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">BOM Item</td>
            <td class="auto-style3">:</td>
            <td>
                <asp:DropDownList ID="ddBomItem" runat="server" AppendDataBoundItems="True" Width="350px"
                    DataSourceID="bomDataSource" DataTextField="BOM_ITEM_B" DataValueField="BOM_ID" OnSelectedIndexChanged="ddBomItem_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Value="-1">(BOM Item)</asp:ListItem>
                </asp:DropDownList>
                <asp:CompareValidator ID="bomValidator" runat="server" ControlToValidate="ddBomItem"
                    ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
            </td>
        </tr>

        <tr>
            <td class="auto-style2">New Item Code</td>
            <td class="auto-style3">:</td>
            <td>
                <telerik:RadAutoCompleteBox ID="txtItemCode" runat="server" DataSourceID="sqlMaterialList" DataTextField="MAT_CODE1" DataValueField="MAT_ID" 
                    DropDownHeight="150px" EmptyMessage="Start typing...." InputType="Text" MaxResultCount="20" TextSettings-SelectionMode="Single"></telerik:RadAutoCompleteBox>
                <asp:TextBox ID="txtItemCode1" runat="server" Width="220px" Visible="false"></asp:TextBox>
                <asp:RequiredFieldValidator ID="codeValidator" runat="server" ErrorMessage="*" ControlToValidate="txtItemCode"></asp:RequiredFieldValidator>                
            </td>
        </tr>
        <tr>
            <td class="auto-style2">New Quantity</td>
            <td class="auto-style3">:</td>
            <td>
                <telerik:RadTextBox ID="txtNewQty" runat="server" Width="80px" OnTextChanged="txtNewQty_TextChanged">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtNewQty"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">Remarks</td>
            <td class="auto-style3">:</td>
            <td>
                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="344px" TextMode="MultiLine" Height="64px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <telerik:RadButton ID="btnSubmit" runat="server" CssClass="btnSubmit" Text="Submit" OnClick="btnSubmit_Click">
                </telerik:RadButton>
            </td>
        </tr>        
    </table>
     <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM_B 
FROM VIEW_BOM_EREC_ITEM
WHERE PROJ_ID = :PROJECT_ID AND
ISO_TITLE1 = :ISO_TITLE1
ORDER BY BOM_ITEM_B">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsometric" DefaultValue="~" Name="ISO_TITLE1"
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMaterialList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT &quot;MAT_CODE1&quot;, &quot;MAT_ID&quot; FROM &quot;PIP_MAT_STOCK&quot;"></asp:SqlDataSource>
</asp:Content>

