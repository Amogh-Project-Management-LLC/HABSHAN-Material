<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableSessionState="ReadOnly"
    CodeFile="FilterRdlc.aspx.cs" Inherits="DefaultCS" Title="RDLC Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {

            var width = document.getElementById("PageHeader").clientWidth;
            document.getElementById("divRadgrid").style.width = width - 10 + "px";
        }

    </script>
    
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ConfiguratorPanel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="radGridID">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="radGridID"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">
        <div style="-moz-border-radius: 3px; -webkit-border-radius: 5px;   border: outset; -moz-box-shadow: 0 0 10px #4e707c; -webkit-box-shadow: 0 0 20px #4e707c; box-shadow: 0 0 5px #4e707c; width: 100%">
            <table style="padding-bottom: 10px; width:100%;  text-align:start; border:solid skyblue">
                <tr class="header" style="border-left: 6px; background-color: skyblue; border: outset;font-family:monospace;font-size:16px;">                 
                    <th>Select Report</th>
                    <th>Select Columns To export</th>
                     <th>Select Filter</th>
                </tr>
                <tr style="vertical-align:top;">
                   
                    <td style="padding:5px">
                        <telerik:RadComboBox ID="ddlReportSelect" runat="server" DataSourceID="ReportsDatasource" DataTextField="EXPT_TITLE" AllowCustomText="true"
                            Filter="Contains" DataValueField="EXPT_ID" Width="250px" Height="200px"
                            OnSelectedIndexChanged="ddlReportSelect_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                        </telerik:RadComboBox>
                    </td>

                    <td style="padding:5px">

                        <telerik:RadComboBox RenderMode="Lightweight" ID="ddlSelectColumn" runat="server" Height="200px" Width="250px" AllowCustomText="true" Filter="Contains"
                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" DataTextField="Text" DataValueField="Value" 
                            OnSelectedIndexChanged="ddlSelectColumn_SelectedIndexChanged" AutoPostBack="true" />
                    </td>
                     <td style="padding:5px ; ">
                         
                        <telerik:RadFilter RenderMode="Lightweight" runat="server" ID="RadFilter1" FilterContainerID="RadGrid1" ContextMenu-EnableAutoScroll="true" ContextMenu-DefaultGroupSettings-Height="100" BorderWidth="3px"  BorderColor="SkyBlue"
                            ExpressionPreviewPosition="Bottom" onkeypress="handleSpace(event)">
                        </telerik:RadFilter>

                    </td>
                </tr>
            </table>
        </div>

        <div style="display: inline-block;" id="divRadgrid">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" PageSize="50" PagerStyle-AlwaysVisible="true" GridLines="None" OnNeedDataSource="RadGrid1_NeedDataSource"
                AllowSorting="true" AllowPaging="True" AllowFilteringByColumn="true" onkeypress="handleSpace(event)" OnColumnCreated="RadGrid1_ColumnCreated"
                AutoGenerateColumns="true" OnItemCreated="RadGrid1_ItemCreated" OnPreRender="RadGrid1_PreRender" ShowGroupPanel="True">

                <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ExportOnlyData="true">
                    <Pdf PageHeight="300mm" PageWidth="600mm" DefaultFontFamily="Arial Unicode MS" PageTopMargin="50mm" BorderType="AllBorders"
                        BorderStyle="Medium" BorderColor="#666666" ForceTextWrap="true">
                    </Pdf>
                </ExportSettings>

                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                <GroupingSettings ShowUnGroupButton="true"></GroupingSettings>
                <ClientSettings>
                    <Selecting AllowRowSelect="true" />
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                </ClientSettings>
                <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" ReorderColumnsOnClient="true">
                    <Scrolling AllowScroll="true" UseStaticHeaders="true"></Scrolling>

                </ClientSettings>
                <MasterTableView CommandItemDisplay="Top" IsFilterItemExpanded="false" TableLayout="Auto" AllowMultiColumnSorting="true">
                    <CommandItemSettings ShowExportToPdfButton="true" ShowExportToCsvButton="true" ShowExportToExcelButton="true" ShowExportToWordButton="true"
                        ShowAddNewRecordButton="false" />
                    <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />

                    <%--   <commanditemtemplate>
                    <asp:image id="image1" runat="server" imageurl="~/images/pipieline.jpg" alternatetext="amogh data" Height="200px"
                        width="100%"></asp:image>
                </commanditemtemplate>--%>
                    <Columns>
                    </Columns>
                </MasterTableView>
                <GroupingSettings CaseSensitive="false" />

            </telerik:RadGrid>
        </div>
        <asp:SqlDataSource ID="ReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT EXPT_ID, EXPT_TITLE FROM VIEW_IPMS_SYS_EXPORT ORDER BY REPORT_ORDER"></asp:SqlDataSource>
    </asp:Panel>

</asp:Content>
