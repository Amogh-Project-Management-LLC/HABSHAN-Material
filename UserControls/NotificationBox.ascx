<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NotificationBox.ascx.cs" Inherits="UserControls_NotificationBox" %>
<style type="text/css">
    .info, .success, .warning, .error, .validation {
        border: 1px solid;
        margin: 10px 0px;
        padding: 15px 10px 15px 50px;
        background-repeat: no-repeat;
        background-position: 10px center;
    }

    .info {
        color: #00529B;
        background-color: #BDE5F8;
        background-image: url('../Images/knob/info.png');
    }

    .success {
        color: #4F8A10;
        background-color: #DFF2BF;
        background-image: url('../Images/knob/Valid-Green.png');
    }

    .warning {
        color: #9F6000;
        background-color: #FEEFB3;
        background-image: url('../Images/knob/Attention.png');
    }

    .error {
        color: #D8000C;
        background-color: #FFBABA;
        background-image: url('../Images/knob/Cancel.png');
    }

    .validation {
        color: #D63301;
        background-color: #FFCCBA;
        background-image: url('../Images/knob/Remove-Red.png');
    }
</style>
<asp:Panel ID="MessagePanel" runat="server" CssClass="info" Visible="false" EnableViewState="false">
    <asp:Label ID="MsgLabel" runat="server"></asp:Label>
</asp:Panel>