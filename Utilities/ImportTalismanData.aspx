<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportTalismanData.aspx.cs" Inherits="Utilities_ImportTalismanData" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100" OnClick="btnBack_Click"></telerik:RadButton>
    </div>
    <div style="width:700px; margin-top:3px; border:1px solid #98EDFF">
        <div style="background-color:#DDF5FA; height:30px; vertical-align:middle; padding-top:5px; padding-left:3px;
                 font-weight:500">
           Import Excel Files 
        </div>
        <table style="margin-top:5px; height:200px; padding-left:5px">
            <tr>
                <td>
                     Isometric MTO File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadIsoMTO" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server">Sample File</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                     Spool Status
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadSpoolStatus" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink2" runat="server">Sample File</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                     Welding MTO
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadWeldMTO" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink3" runat="server">Sample File</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                     Defects
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadDefects" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink4" runat="server">Sample File</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                     Test Pack Info
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadTestPack" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink5" runat="server">Sample File</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td></td>
                <td colspan="2">
                    <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" Width="85" OnClick="btnUpload_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
        <div style="background-color:#F8FACE; color:maroon">
            <div style="font-weight:500; height:25px; padding-top:4px; padding-left:3px">Import Instructions:</div>
            <div style="padding-left:10px;">
                1. Please choose correct sample file to upload data.<br />
                2. Do not change the column heading in sample file. <br />
                <br />                
            </div>
        </div>
    </div>
</asp:Content>

