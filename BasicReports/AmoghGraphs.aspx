<%@ Page Title="Graphical Reports" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AmoghGraphs.aspx.cs" Inherits="BasicReports_AmoghGraphs" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadButton ID="btnPreview" runat="server"
                                Text="Preview" Width="90px" OnClick="btnPreview_Click">
                            </telerik:RadButton>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <table>
                    <tr>
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">Select Report
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                                <asp:ListItem Value="1">Spools Sent to Site Report</asp:ListItem>
                                <asp:ListItem Value="2">Spool Milestone Report</asp:ListItem>
                                <asp:ListItem Value="3">Spool Inch Dia Summary</asp:ListItem>
                                <asp:ListItem Value="4">Monthly Repair Rate</asp:ListItem>
                                <asp:ListItem Value="6">Fabrication Plan</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr runat="server" id="fromMonth" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">From Month</td>
                        <td>
                            <asp:DropDownList ID="ddlFromMonth" runat="server" AppendDataBoundItems="true" OnDataBinding="ddlFromMonth_DataBinding"
                                Font-Names="Calibri" Font-Size="10pt" Width="150px">
                            </asp:DropDownList></td>
                    </tr>
                    <tr runat="server" id="toMonth" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">To Month</td>
                        <td>
                            <asp:DropDownList ID="ddlToMonth" runat="server" AppendDataBoundItems="true" OnDataBinding="ddlToMonth_DataBinding"
                                Font-Names="Calibri" Font-Size="10pt" Width="150px">
                            </asp:DropDownList></td>
                    </tr>
                    <tr runat="server" id="fromDate" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">From Date</td>
                        <td>
                            <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="toDate" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">To Date</td>
                        <td>
                            <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="Subcon" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">Sub Contractor</td>
                        <td>
                            <asp:DropDownList ID="ddlScList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlSCSource" DataTextField="SUB_CON_NAME"
                                DataValueField="SUB_CON_ID" OnDataBinding="ddlScList_DataBinding" Width="150px"
                                Font-Names="Calibri" Font-Size="10pt">
                            </asp:DropDownList></td>
                    </tr>
                    <tr runat="server" id="WelderRow" visible="false">
                        <td style="width: 150px; background-color: gainsboro; vertical-align: top">Welder No</td>
                        <td>
                            <asp:DropDownList ID="ddWelder" runat="server" DataSourceID="Welder_SqlDataSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:SqlDataSource ID="sqlFromMonthSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlToMonthSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSCSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Welder_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS WHERE (PROJECT_ID = :PROJECT_ID) AND (LENGTH(WELDER_NO) &gt; 1) ORDER BY WELDER_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>