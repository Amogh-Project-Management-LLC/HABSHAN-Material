<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POTechnicalSubmissionNew.aspx.cs" Inherits="Procurement_POTechnicalSubmissionNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">    
    <style type="text/css">
        .Heading {
            background-color:whitesmoke;
            min-width:120px;
            padding-left:5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">PO Number</td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtPO" runat="server" EmptyMessage="Start typing PO Number..." Width="200px" DataSourceID="sqlPOSource" DataTextField="PO_NO" 
                        InputType="Text" DropDownHeight="300px">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">ITP Submit Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtITPSubmitDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">ITP Review Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtITPReview" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">ITP Approve Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtITPApproved" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Drawing Spec Submit Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtDWGSub" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Drawing Spec Review Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtDWGReview" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Drawing Spec Approve Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtDWGApprove" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="250px" TextMode="MultiLine" Height="50px" MaxLength="100"
                         ></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton runat="server" ID="btnSubmit" Text="Save" Width="80px" Icon-PrimaryIconUrl="~/Images/New-Icons/document-save.png"
                         OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sqlPOSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO 
FROM PIP_PO"></asp:SqlDataSource>
    </div>
</asp:Content>

