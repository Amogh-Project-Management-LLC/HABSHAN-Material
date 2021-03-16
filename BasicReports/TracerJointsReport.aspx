<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TracerJointsReport.aspx.cs" Inherits="BasicReports_TracerJointsReport"
    Title="Tracer Joints Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="False"></telerik:RadButton>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 125px; background-color: gainsboro;">
                    <asp:Label ID="Label2" runat="server" Text="Subcon"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" Width="230px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>