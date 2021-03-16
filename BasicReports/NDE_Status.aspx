<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_Status.aspx.cs" Inherits="BasicReports_NDE_Status" Title="NDE Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 130px; background-color: Gainsboro; vertical-align: top;">Category
                </td>
                <td>
                    <asp:RadioButtonList ID="rblCat" runat="server" AutoPostBack="True"
                        OnSelectedIndexChanged="rblCat_SelectedIndexChanged" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Shop</asp:ListItem>
                        <asp:ListItem Value="2">Field</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: Gainsboro">Subcon
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                        Width="226px">
                        <asp:ListItem Selected="True" Value="99">-Select-</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnArea" runat="server" Text="PWHT-Class Wise" Width="120px" OnClick="btnArea_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPWHT_Area" runat="server" Text="PWHT-PCWBS Wise" Width="130px" OnClick="btnPWHT_Area_Click" Enabled="False"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPMI" runat="server" Text="PMI" Width="80px" OnClick="btnPMI_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPT_MT" runat="server" Text="PT/ MT" Width="80px" OnClick="btnPT_MT_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRT_UT" runat="server" Text="RT/ UT" Width="80px" OnClick="btnRT_UT_Click"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnHT" runat="server" Text="HT" Width="80px" OnClick="btnHT_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnFT" runat="server" Text="FT" Width="80px" OnClick="btnFT_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE &#13;&#10;(PROJ_ID = :PROJECT_ID)&#13;&#10;AND ((:CAT=1 AND FAB_SC = 'Y') OR(:CAT=2 AND FIELD_SC='Y'))&#13;&#10; ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="rblCat" DefaultValue="-1" Name="CAT" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>