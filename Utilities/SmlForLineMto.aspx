<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SmlForLineMto.aspx.cs" Inherits="Utilities_SmlForLineMto" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <asp:RadioButtonList ID="LineselectOption" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
                                        <asp:ListItem Text="All" Value="ALL" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Custom SRNs" Value="CUSTOM_SRN"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <telerik:RadMenu ID="menuIDFSmlRun" runat="server" Skin="Default" Width="100%">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menu-right">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnLineMtoSmlRun" runat="server" Text="Proceed" Font-Underline="false"
                                                         OnClick="btnLineMtoSmlRun_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                            <ProgressTemplate>
                                <img src="../Images/ajax-loader-bar.gif" alt="Please wait..." />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:Label ClientIDMode="AutoID" runat="server" ID="lblMessage" ForeColor="Green" EnableViewState="false" Text="" Height="10px" Width="100%"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
</asp:Content>

