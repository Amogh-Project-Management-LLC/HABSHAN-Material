<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SCNCreate.aspx.cs" Inherits="Logistics_SCNCreate" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            width:120px;
            padding-left:3px;
            background-color:whitesmoke;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">SCN Number</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtSCNNno" Width="140px" required></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading"> Ship Number</td>
                <td>
                    <telerik:RadAutoCompleteBox runat="server" ID="AutoShipNumber" InputType="Text" Width="140px" DataSourceID="sqlShipSource" DataTextField="SHIP_NO" DataValueField="SHIP_ID">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">SCN Date</td>
                <td>
                    <telerik:RadDatePicker runat="server" ID="dateSCN" DateInput-DateFormat="dd-MMM-yyyy" Width="140px"></telerik:RadDatePicker>
                </td>
            </tr>                        
            <tr>
                <td class="Heading">Remarks</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtRemarks" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton runat="server" ID="txtSubmit" Text="Create" Width="100" OnClick="txtSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlShipSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SHIP_NO, SHIP_ID
FROM PRC_SHIP_MASTER
WHERE PROJECT_ID = :PROJECT_ID">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

