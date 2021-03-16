<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SupportStatus.aspx.cs" Inherits="BasicReports_SupportStatus" Title="Support Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 4px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 110px; background-color: Gainsboro; vertical-align: top;">Report
                </td>
                <td>
                    <asp:RadioButtonList ID="ReportTypeList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ReportTypeList_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="1">Isometric Wise</asp:ListItem>
                        <asp:ListItem Value="2">By Area Name</asp:ListItem>
                        <asp:ListItem Value="3">By Area Group</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: Gainsboro; vertical-align: top;">Area Name
                </td>
                <td>
                    <asp:RadioButtonList ID="AreaNameList" runat="server" DataSourceID="AreaL1DataSource"
                        DataTextField="AREA_L1" DataValueField="AREA_L1" RepeatColumns="2"
                        AppendDataBoundItems="True" OnDataBinding="AreaNameList_DataBinding">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: Gainsboro; vertical-align: top;">Area Group
                </td>
                <td>
                    <asp:RadioButtonList ID="AreaGroupList" runat="server" DataSourceID="AreaL2DataSource"
                        DataTextField="AREA_L2" DataValueField="AREA_L2" RepeatColumns="2">
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke; padding: 4px;">
        <telerik:RadButton ID="btnArea" runat="server" Text="Preview" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="AreaL1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT AREA_L1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) ORDER BY AREA_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="AreaL2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT AREA_L2 FROM IPMS_AREA WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY AREA_L2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>