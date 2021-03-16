<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POVendorDataImport.aspx.cs" Inherits="Procurement_POVendorDataImport" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td style="vertical-align: top">Import Options:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="ImportOptions" runat="server" Enabled="false">
                            <asp:ListItem Text="Add Data" Value="ADD" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Replace Existing Data" Value="REPLACE"></asp:ListItem>
                            <asp:ListItem Text="Delete Everything & Import" Value="REIMPORT"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>Select File</td>
                    <td>
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>
                    </td>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Import_Format/VendorDataImport.xlsx">Sample File to Upload</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadButton ID="btnImport" runat="server" Text="Import" Width="80px" OnClick="btnImport_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="../Images/ajax-loader-bar.gif" />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

