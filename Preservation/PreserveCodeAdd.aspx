<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PreserveCodeAdd.aspx.cs" Inherits="Preservation_PreserveCodeAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table runat="server" id="EntryTable">
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">Code
            </td>
            <td>
                <telerik:RadTextBox ID="txtCodes" runat="server" ReadOnly="true" Text="X-X-XXX"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">Storage Class
            </td>
            <td>
                <telerik:RadDropDownList ID="ddlStorageClass" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlStorageClass" DataTextField="DESCRIPTION" DataValueField="SYMBOL" OnDataBinding="ddlStorageClass_DataBinding" OnSelectedIndexChanged="ddlStorageClass_SelectedIndexChanged"></telerik:RadDropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="Add"
                    ControlToValidate="ddlStorageClass"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">WBS
            </td>
            <td>
                <telerik:RadDropDownList ID="ddlWBS" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlWBS" DataTextField="DESCRIPTION" DataValueField="SYMBOL" OnDataBinding="ddlWBS_DataBinding" OnSelectedIndexChanged="ddlWBS_SelectedIndexChanged"></telerik:RadDropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ValidationGroup="Add"
                    ControlToValidate="ddlWBS"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">Company / Vendor
            </td>
            <td>
                <telerik:RadDropDownList ID="ddlCompanyVendor" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlCompany" DataTextField="DESCRIPTION" DataValueField="SYMBOL" OnDataBinding="ddlCompanyVendor_DataBinding" OnSelectedIndexChanged="ddlCompanyVendor_SelectedIndexChanged"></telerik:RadDropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ValidationGroup="Add"
                    ControlToValidate="ddlCompanyVendor"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">Preservation Frequency
            </td>
            <td>
                <telerik:RadDropDownList ID="ddlPreservFreq" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlFrequency" DataTextField="DESCRIPTION" DataValueField="SYMBOL" OnDataBinding="ddlPreservFreq_DataBinding" OnSelectedIndexChanged="ddlPreservFreq_SelectedIndexChanged"></telerik:RadDropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ValidationGroup="Add"
                    ControlToValidate="ddlPreservFreq"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7">Description
            </td>
            <td>
                <telerik:RadTextBox ID="txtDescription" runat="server"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ValidationGroup="Add"
                    ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: #EBF5F7"></td>
            <td>
                <telerik:RadButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="Add"></telerik:RadButton>                
            </td>
        </tr>
    </table>
                <asp:SqlDataSource ID="sqlStorageClass" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SYMBOL, DESCRIPTION FROM VIEW_PRES_CODE_GUIDE_DETAIL WHERE CODE_CAT_ID = 1"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlWBS" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SYMBOL, DESCRIPTION FROM VIEW_PRES_CODE_GUIDE_DETAIL WHERE (CODE_CAT_ID = 2)"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlCompany" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SYMBOL, DESCRIPTION FROM VIEW_PRES_CODE_GUIDE_DETAIL WHERE CODE_CAT_ID = 3"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlFrequency" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SYMBOL, DESCRIPTION FROM VIEW_PRES_CODE_GUIDE_DETAIL WHERE CODE_CAT_ID = 4"></asp:SqlDataSource>
</asp:Content>

