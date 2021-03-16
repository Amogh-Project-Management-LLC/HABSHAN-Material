<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POAddOnImport.aspx.cs" Inherits="Utilities_POAddOnImport" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-top:3px; border:1px solid #98EDFF; margin:5px">
       <div style="background-color:#DDF5FA; height:30px; vertical-align:middle; padding-top:8px; padding-left:3px;
                 font-weight:500">
           Import Excel File
        </div>
        <div style="padding-left:10px; margin-top:20px">
            <table style="height:50px; width:100%">
                <tr>
                    <td>Select Import Type:</td>
                    <td colspan="3">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="0">DELETE EXISTING DATA & IMPORT</asp:ListItem>
                            <asp:ListItem Value="1">APPEND TO EXISTING DATA</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                                    
                    
                    
                </tr>
                <tr>
                    <td>Select File:</td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                    </td>
                                    
                    <td>
                        <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"></telerik:RadButton>
                    </td>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Import_Format/PPCS_ADDON_MATERIAL.xlsx">Sample File</asp:HyperLink>
                    </td>
                    
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

