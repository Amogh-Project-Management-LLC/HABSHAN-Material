<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectArea.aspx.cs" Inherits="BasicReports_SelectArea" Title="Select Area" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 110px; background-color: gainsboro; vertical-align: top">Area Name
                </td>
                <td>
                    <asp:RadioButtonList ID="AreaNameList" runat="server" DataSourceID="AreaL1DataSource"
                        DataTextField="AREA_L1" DataValueField="AREA_L1" AppendDataBoundItems="True"
                        OnDataBinding="AreaNameList_DataBinding" RepeatColumns="3">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: gainsboro; vertical-align: top">Report
                </td>
                <td>
                    <asp:RadioButtonList ID="ReportList" runat="server">
                        <asp:ListItem Value="13" Text="Area Wise/ Size Wise Spool Status" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="15" Text="Fluid Wise Spool Installation and Field Welding"></asp:ListItem>
                        <asp:ListItem Value="16" Text="Field Jobcard Wise Summary"></asp:ListItem>
                        <asp:ListItem Value="17" Text="Foreman Wise Summary"></asp:ListItem>
                        <asp:ListItem Value="18" Text="Size Range wise Spools Status"></asp:ListItem>
                        <asp:ListItem Value="19" Text="Site Material Shortage Report"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnArea" runat="server" Text="Preview" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="AreaL1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT AREA_L1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) ORDER BY AREA_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>