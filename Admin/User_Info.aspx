<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="User_Info.aspx.cs" Inherits="Admin_User_Info" Title="User Info" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="vertical-align: top">
                <div style="padding: 5px; background-color: whitesmoke; width: 300px;">
                    <telerik:RadButton ID="btnChangePass" runat="server" Text="Change My Password" Width="200px"></telerik:RadButton>
                </div>
                <div style="padding: 5px; background-color: whitesmoke; width: 300px;">
                    <telerik:RadButton ID="btnChangePic" runat="server" Text="Change My Account Picture" Width="200px" OnClick="btnChangePic_Click"></telerik:RadButton>
                </div>
                <div runat="server" id="ChangePicDiv" visible="false">
                    <table>
                        <tr>
                            <td>
                                <asp:FileUpload ID="FileUpload1" runat="server" Width="600px" />
                            </td>
                            <td>
                                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="vertical-align: top; text-align: right">
                <asp:Image ID="AccountImage" runat="server" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Height="150px" />
            </td>
        </tr>
    </table>
</asp:Content>