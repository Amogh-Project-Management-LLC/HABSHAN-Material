<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatRequisitionImport.aspx.cs" Inherits="Procurement_MatRequisitionImport" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                   <%-- <tr>
                        <td style="background-color: whitesmoke; width: 120px; padding-left: 5px;">Import Option</td>
                        <td>
                            <asp:RadioButtonList ID="radImportOptions" runat="server">
                                <asp:ListItem Text="Delete All & Import" Value="D" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Overwrite Existing Data Only" Value="O"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="background-color: whitesmoke; width: 120px; padding-left: 5px;">Select File</td>
                        <td>
                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>
                        </td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnImport" Text="Import.." Width="80px"
                                 OnClick="btnImport_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:HyperLink runat="server" ID="hyperlink1"  NavigateUrl="~/Import_Format/PIP_BULK_MR_IMPORT.xlsx">
                                Sample File
                            </asp:HyperLink>
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

