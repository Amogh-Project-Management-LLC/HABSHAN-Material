<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="FileImport.aspx.cs" Inherits="Common_FileImport" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                 
                    <tr>
                        <td style="background-color: whitesmoke; width: 150px; padding-left: 5px;">Select PDF File</td>
                        <td>
                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>
                        </td>
                        </tr>
                    <tr>
                        <td style="background-color: whitesmoke; width: 150px; padding-left: 5px;">Select Supporting File</td>
                         <td>
                            <telerik:RadAsyncUpload ID="RadAsyncUpload2" runat="server" MultipleFileSelection="Automatic"></telerik:RadAsyncUpload>
                        </td>
                    </tr>
                    <tr>
                         <td>
                            <telerik:RadButton runat="server" ID="btnImport" Text="Import.." Width="80px"
                                 OnClick="btnImport_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="../Images/ajax-loader-bar.gif" />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

