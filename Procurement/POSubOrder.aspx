<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POSubOrder.aspx.cs" Inherits="Procurement_POSubOrder" %>
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
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <table>
            <tr>
                <td class="Heading">
                    Sub Order Place Date
                </td>
                <td>
                    <telerik:RadDatePicker runat="server" ID="txtSubOrderDate" Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="checkSubOrdNotRequired" Text="Sub Order Not Required" AutoPostBack="true"
                         OnCheckedChanged="checkSubOrdNotRequired_CheckedChanged"/>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Material Received at Factory
                </td>
                <td>
                    <telerik:RadDatePicker runat="server" ID="txtMatReceived" Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="CheckMatReceivedNotRequired" Text="Not Required" />
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Remarks
                </td>
                <td colspan="2">
                    <telerik:RadTextBox runat="server" ID="txtRemarks" TextMode="MultiLine" Width="300px"></telerik:RadTextBox>
                </td>                
            </tr>
            <tr>
                <td></td>
                <td colspan="2">
                    <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png"/>
                    </telerik:RadButton>
                </td>                
            </tr>
        </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        
    </div>
</asp:Content>

