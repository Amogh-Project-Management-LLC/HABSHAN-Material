<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MTNReceiveNew.aspx.cs" Inherits="Material_MTNReceiveNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">Receive Number :</td>
            <td>
                <telerik:RadTextBox ID="txtReceiveNo" runat="server" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Receive Date :</td>
            <td>
                <telerik:RadDatePicker ID="txtReceiveDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Receive By :</td>
            <td>
                <telerik:RadTextBox ID="txtReceiveBy" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Receive Store :</td>
            <td>
                <telerik:RadDropDownList ID="ddlReceiveStore" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlStoreSource" DataTextField="STORE_NAME" DataValueField="STORE_ID" OnDataBinding="ddlReceiveStore_DataBinding" OnSelectedIndexChanged="ddlReceiveStore_SelectedIndexChanged"></telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Heading">Transfer Number :</td>
            <td>
                <telerik:RadComboBox ID="cboTransNo" runat="server" AllowCustomText="True" Filter="Contains" Width="250px" DataSourceID="sqlTransSource" DataTextField="TRANSF_NO" DataValueField="TRANSF_ID" AutoPostBack="true" CausesValidation="false"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Container Number :</td>
            <td>
                <telerik:RadTextBox ID="txtContainer" runat="server" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Packing List No :</td>
            <td>
                <telerik:RadTextBox ID="txtPackingNo" runat="server" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Remarks :</td>
            <td>
                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="300px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME 
FROM STORES_DEF
"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlTransSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT TRANSF_ID, TRANSF_NO  FROM VIEW_MAT_TRANSFER_RCV_BAL WHERE B_STORE_ID = :B_STORE_ID ORDER BY  TRANSF_NO ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlReceiveStore" DefaultValue="-1" Name="B_STORE_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

