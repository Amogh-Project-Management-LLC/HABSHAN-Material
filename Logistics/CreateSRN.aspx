<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="CreateSRN.aspx.cs" Inherits="Logistics_CreateSRN" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            width:120px;
            height:20px;
            padding-left:3px;
            background-color:whitesmoke;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">Packing List Number:</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtSRNNo" Width="150px" required></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Packing List Date</td>
            <td>
                <telerik:RadDatePicker runat="server" ID="txtSRNDate" DateInput-DateFormat="dd-MMM-yyyy"
                     Width="150px"></telerik:RadDatePicker>
            </td>
            <td class="Heading">Delivery Point:</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtSRNDeliveryPoint" Width="150px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">IRN Number</td>
            <td>
                <telerik:RadAutoCompleteBox runat="server" ID="txtAutoPONo" EmptyMessage="Search IRN Number..." DataSourceID="sqlIRNSource" DataTextField="IRN_NO" DataValueField="IRN_ID" InputType="Text">
                    <TextSettings SelectionMode="Single" />
                </telerik:RadAutoCompleteBox>
            </td>        
            <td class="Heading">SCN Number</td>
            <td>
                <telerik:RadAutoCompleteBox runat="server" ID="txtSCN" EmptyMessage="Search SCN Number..." DataSourceID="sqlSCNSource" DataTextField="SCN_NO" DataValueField="SCN_ID" InputType="Text">
                    <TextSettings SelectionMode="Single" />
                </telerik:RadAutoCompleteBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Packing List Revision</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtSRNRev"></telerik:RadTextBox>
            </td>        
            <td class="Heading">Revision Date</td>
            <td>
                <telerik:RadDatePicker runat="server" ID="txtRevDate" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Create By</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtIssueBy"></telerik:RadTextBox>
            </td>        
            <td class="Heading">Created Date</td>
            <td>
                <telerik:RadDatePicker runat="server" ID="txtIssueDate" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Remarks</td>
            <td colspan="3">
                <telerik:RadTextBox runat="server" ID="txtRemarks" Width="400px" TextMode="MultiLine"></telerik:RadTextBox>
            </td>                    
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadButton runat="server" ID="btnCreate" Text="Register" Width="100px" OnClick="btnCreate_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sqlIRNSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT IRN_ID, IRN_NO
FROM PIP_PO_IRN"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSCNSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SCN_ID, SCN_NO
FROM PRC_SCN_MASTER"></asp:SqlDataSource>

</asp:Content>

