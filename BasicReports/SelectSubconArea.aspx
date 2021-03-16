<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectSubconArea.aspx.cs" Inherits="BasicReports_SelectSubconArea"
    Title="Select Subcon/ Area" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 5px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: Gainsboro; vertical-align: top">Subcon
                </td>
                <td>
                    <asp:RadioButtonList ID="SubconList" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="SubconList_DataBound">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro; vertical-align: top">Area Name
                </td>
                <td>
                    <asp:RadioButtonList ID="AreaNameList" runat="server" DataSourceID="AreaL1DataSource"
                        DataTextField="AREA_L1" DataValueField="AREA_L1" AppendDataBoundItems="True"
                        OnDataBinding="AreaNameList_DataBinding" RepeatColumns="3">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro; vertical-align: top">Report
                </td>
                <td>
                    <asp:RadioButtonList ID="ReportList" runat="server">
                        <asp:ListItem Value="14" Text="Area Wise/ Size Wise Field Welding Report" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke; padding: 5px;">
        <telerik:RadButton ID="btnArea" runat="server" Text="Preview" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="AreaL1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT AREA_L1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) ORDER BY AREA_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>