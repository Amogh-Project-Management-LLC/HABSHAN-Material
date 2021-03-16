<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="LineMTOImport.aspx.cs" Inherits="Utilities_LineMTOImport" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Import Line MTO">
        <table>
        <tr>
            <td>Select File</td>
            <td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </td>
            <td>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Import_Format/BULK_LINE_MTO_IMPORT.xlsx">Sample File to Upload</asp:HyperLink>
            </td>
        </tr>
        <tr style="padding-top:10px">
            <td></td>
            <td>
                <telerik:RadButton ID="btnImport" runat="server" Text="Submit" Width="90" OnClick="btnImport_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    </asp:Panel>
    
</asp:Content>

