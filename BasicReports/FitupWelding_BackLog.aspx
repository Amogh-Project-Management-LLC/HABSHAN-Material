<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FitupWelding_BackLog.aspx.cs" Inherits="BasicReports_Welding_FitupWelding_BackLog" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreviewFitup" runat="server" Text="Fitup Back Log" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreviewWelding" runat="server" Text="Welding Back Log" Width="110px" OnClick="btnPreview1_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <table style="width: 100%">
        <tr>
            <td style="width: 140px; background-color: gainsboro">Job Card Number
            </td>
            <td>
                <asp:DropDownList ID="cboJC" runat="server" AppendDataBoundItems="True" DataSourceID="jobCardDataSource"
                    DataTextField="WO_NAME" DataValueField="WO_ID" Width="298px">
                    <asp:ListItem Selected="True" Value="-1">(All Job Cards)</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="jobCardDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WO_ID, WO_NAME FROM PIP_WORK_ORD WHERE (PROJ_ID = :PROJECT_ID) ORDER BY WO_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>