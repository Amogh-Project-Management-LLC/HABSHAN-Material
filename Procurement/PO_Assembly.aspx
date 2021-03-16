<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PO_Assembly.aspx.cs" Inherits="Procurement_PO_Assembly" %>
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
                <td class="Heading">Assembly Preparation Forecast</td>
                <td>
                    <telerik:RadDatePicker runat="server" DateInput-DateFormat="dd-MMM-yyyy" ID="txtAssemblyForecast"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Assembly Preparation Actual</td>
                <td>
                    <telerik:RadDatePicker runat="server" DateInput-DateFormat="dd-MMM-yyyy" ID="txtAssembly"></telerik:RadDatePicker>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
</asp:Content>

