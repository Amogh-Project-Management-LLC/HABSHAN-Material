<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AmoghUpdates.aspx.cs" Inherits="Utilities_AmoghUpdates" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .image {
            width: 30px;
        }

        .Title {
            width: 200px;
        }

        .button {
            width: 50%;
            text-align: right;
        }

        .menu-right {
            text-align: right;
            float: right;
            margin-left: 10px;
        }
       
        .RadMenuStyle {
            z-index: 10;
            /*position:absolute;*/
        }
    </style>
    <script type="text/javascript">
        function confirmation() {
            if (confirm('Are you sure to proceed'))
                return true;
            else
                return false;
        }


    </script>
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" OnTabClick="RadTabStrip1_TabClick">
        <Tabs>
            <telerik:RadTab Text="Imports" Selected="true" ImageUrl="../Images/icons/db-import.png">
            </telerik:RadTab>
            <telerik:RadTab Text="System Updates" ImageUrl="../Images/icons/db_update.png"></telerik:RadTab>
            <telerik:RadTab Text="Simulations" ImageUrl="../Images/icons/sim.png"></telerik:RadTab>
            <telerik:RadTab Text="Running Jobs" ImageUrl="../Images/icons/batch-job.png"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
        <telerik:RadPageView ID="RadPageView1" runat="server">
            <div style="margin-top: 10px">
                <asp:Panel ID="Panel5" runat="server" GroupingText="External Data Imports" Width="400px">
                    <table>
                        <tr>
                            <td class="image">
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                            </td>
                            <td class="Title">Line MTO Import
                            </td>
                            <td class="button">
                                <telerik:RadButton ID="btnLineMTOImport" runat="server" Text="Proceed"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="image">
                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                            </td>
                            <td class="Title">ISO MTO Import
                            </td>
                            <td class="button">
                                <telerik:RadButton ID="btnIsoMTOImport" runat="server" Text="Proceed"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="image">
                                <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                            </td>
                            <td class="Title">Spoolgen Excel Import
                            </td>
                            <td class="button">
                                <telerik:RadButton ID="btnSGExcelImport" runat="server" Text="Proceed"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="image">
                                <asp:Image ID="Image4" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                            </td>
                            <td class="Title">Spoolgen Text Import
                            </td>
                            <td class="button">
                                <telerik:RadButton ID="btnSGTextImport" runat="server" Text="Proceed"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="radUpdatePage" runat="server">
            <div style="margin-top: 10px">
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="Panel1" runat="server" GroupingText="Amogh Internal Updates" Height="400px" Width="400px">
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image5" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Update Spoolgen Data
                                        </td>
                                        <td class="menu-right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadMenu ID="menuUpdateSGData" CssClass="RadMenuStyle" Enabled="false" runat="server" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                                                            <Items>
                                                                <telerik:RadMenuItem CssClass="menu-right">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnSGUpdate" runat="server" Text="Proceed" Font-Underline="false"
                                                                            OnClientClick="return confirmation()" OnClick="btnSGUpdate_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenu>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image6" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Update Spool & BOM
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnUpdateSpoolBOM" runat="server" Text="Proceed"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image7" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Update Welders
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnUpdateWelders" runat="server" Text="Proceed"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image8" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Update NDE
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnUpdateNDE" runat="server" Text="Proceed"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image9" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Update All
                                        </td>
                                        <td class="menu-right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadMenu ID="menuUpdateAll" CssClass="RadMenuStyle" runat="server" Width="100%"
                                                            Style="top: 0px; left: 0px" EnableViewState="false">
                                                            <Items>
                                                                <telerik:RadMenuItem CssClass="menu-right">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnServerUpdate" runat="server" Text="Proceed"
                                                                            Font-Underline="false"
                                                                            OnClientClick="return confirmation()"
                                                                            OnClick="btnServerUpdate_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenu>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="Panel3" runat="server" GroupingText="PDF Collection & Other Updates" Height="400px" Width="400px">
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image19" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">PDF Collect & Flag
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnCollectPDF" runat="server" Text="Proceed"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image20" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Delete Un-registerd IDF
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnDeleteUnRegIDF" runat="server" Text="Proceed"></telerik:RadButton>
                                        </td>
                                    </tr>                                   
                                </table>
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="Panel2" runat="server" GroupingText="External Databases Updates" Height="400px" Width="400px">
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image10" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">PPCS PO Update
                                        </td>
                                        <td class="menu-right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadMenu CssClass="RadMenuStyle" ID="menuUpdPOLink" runat="server" EnableViewState="false">
                                                            <Items>
                                                                <telerik:RadMenuItem CssClass="menu-right">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnPOUpdate" runat="server" Text="Proceed" Font-Underline="false"
                                                                            OnClientClick="return confirmation()" OnClick="btnPOUpdate_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenu>
                                                    </td>
                                                </tr>
                                            </table>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image25" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">
                                            Add-on Material on PPCS
                                        </td>
                                         <td class="menu-right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadButton ID="btnAddOnPO" runat="server" Text="Proceed" Width="85" OnClick="btnAddOnPO_Click"></telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image11" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">SRN Update
                                        </td>
                                        <td class="menu-right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadButton ID="btnSRNUpdate" runat="server" Text="Proceed" Width="85"></telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image12" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                                        </td>
                                        <td class="Title">Talisman Update
                                        </td>
                                        <td class="button">
                                            <telerik:RadButton ID="btnUpdateTalisman" runat="server" Text="Proceed" Width="88" OnClick="btnUpdateTalisman_Click"></telerik:RadButton>
                                        </td>
                                    </tr>

                                </table>
                                <br />
                               
                               
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="radSimulPage" runat="server">
            <table>
                <tr>
                    <td>
                        <asp:Panel ID="Panel4" runat="server" GroupingText="System Simulations" Width="400px">
                <table style="margin-top: 10px">
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image13" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">Line MTO Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnLineMTOSimulation" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image14" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">ISO MTO Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnSimulIsoMTO" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image15" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">Temporary Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnSimulTemp" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image16" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">Site BOM Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnSimulSiteBOM" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image17" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">Shop BOM Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnSimulShopBOM" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="image">
                            <asp:Image ID="Image18" runat="server" ImageUrl="~/Images/right-icon.png" Height="20" Width="20" />
                        </td>
                        <td class="Title">Full BOM Simulation
                        </td>
                        <td class="button">
                            <telerik:RadButton ID="btnSimulFull" runat="server" Text="Proceed"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
                    </td>
                    
                </tr>
            </table>
            

        </telerik:RadPageView>
        <telerik:RadPageView runat="server" ID="PageDeveloper">
            <div style="margin-top: 10px">
                <asp:Panel ID="Panel6" runat="server" GroupingText="Options">
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image21" runat="server" ImageUrl="~/Images/icons/blue-bullet.png" />
                                        </td>
                                        <td class="Title">Jobs & Steps
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnCheckCurrentStatus" runat="server" Text="Check Current Status" Width="150"
                                                OnClick="btnCheckCurrentStatus_Click">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image22" runat="server" ImageUrl="~/Images/icons/blue-bullet.png" />
                                        </td>
                                        <td class="Title">Reset All Jobs
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="RadButton1" runat="server" Width="150">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="btnStopJobs" runat="server" Text="Stop All Jobs" Font-Underline="false"
                                                        OnClientClick="return confirm('This will STOP all the running oracle jobs forcefully. Are you sure to proceed ?');"
                                                        OnClick="btnStopJobs_Click"></asp:LinkButton>
                                                </ContentTemplate>
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image23" runat="server" ImageUrl="~/Images/icons/blue-bullet.png" />
                                        </td>
                                        <td class="Title">Packaged Exception
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnCheckException" runat="server" Text="Check Exception" Width="150"
                                                OnClick="btnCheckException_Click">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td class="image">
                                            <asp:Image ID="Image24" runat="server" ImageUrl="~/Images/icons/blue-bullet.png" />
                                        </td>
                                        <td class="Title">Reset All Button Status
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="RadButton3" runat="server" Width="150">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="btnSetFlagCmplt" runat="server" Text="Set All Complete" Font-Underline="false"
                                                        OnClientClick="return confirm('This will only reset the flags (Running & Waiting) for all processes as COMPLETED. Running of jobs and processes will not be affected. Are you sure to reset ?');"
                                                        OnClick="btnSetFlagCmplt_Click"></asp:LinkButton>
                                                </ContentTemplate>
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <div>
                <table style="width: 100%;">
                    <tr id="errorTable" runat="server" visible="false" enableviewstate="true" style="vertical-align: top;">
                        <td style="vertical-align: top">
                            <table style="width: 100%; vertical-align: top;">
                                <tr>
                                    <td style="text-align: left; font-size: 12px; width: 120px;">
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <img alt="Bullet" src="../images/icons/Setting.png" height="16" width="16" />
                                                </td>
                                                <td>Select Package
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>:</td>
                                    <td>
                                        <asp:DropDownList ID="ddPackageSelect" runat="server" AutoPostBack="True" DataSourceID="dsPackages" DataTextField="OBJECT_NAME" DataValueField="OBJECT_NAME" AppendDataBoundItems="true" Width="250px" OnSelectedIndexChanged="ddPackageSelect_SelectedIndexChanged">
                                            <asp:ListItem Text="All Packages" Value="ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="width: 100%;">
                                    <td colspan="3">
                                        <telerik:RadGrid ID="gvExceptions" runat="server" AllowPaging="True" CellSpacing="0" DataSourceID="dsException" GridLines="None" AllowSorting="True" PageSize="10">
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="True" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" DataSourceID="dsException">
                                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="PACKAGE_NAME" FilterControlAltText="Filter PACKAGE_NAME column" HeaderText="Packaged" SortExpression="PACKAGE_NAME" UniqueName="PACKAGE_NAME">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="EXC_TIME" FilterControlAltText="Filter EXC_TIME column" HeaderText="Exception Time" SortExpression="EXC_TIME" UniqueName="EXC_TIME">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="SEARCH_TAG" FilterControlAltText="Filter SEARCH_TAG column" HeaderText="Search Tag" SortExpression="SEARCH_TAG" UniqueName="SEARCH_TAG">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="SQL_ERROR" FilterControlAltText="Filter SQL_ERROR column" HeaderText="SQL Error" SortExpression="SQL_ERROR" UniqueName="SQL_ERROR">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <PagerStyle PageSizeControlType="RadComboBox" />
                                            </MasterTableView>
                                            <PagerStyle PageSizeControlType="RadComboBox" />
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <table style="width: 100%;">
                <tr id="processTable" runat="server" visible="false" enableviewstate="true" style="vertical-align: top;">
                    <td style="vertical-align: top">
                        <table style="width: 100%; vertical-align: top;">
                            <tr style="width: 100%;">
                                <td style="text-align: left; font-size: 12px; width: 120px;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <img alt="Bullet" src="../images/icons/Setting.png" height="16" width="16" />
                                            </td>
                                            <td>Progress Status
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:DropDownList ID="ddStepsStatus" runat="server" AutoPostBack="True" AppendDataBoundItems="True" Width="150px" DataTextField="JOB_NAME" DataValueField="JOB_NAME"
                                        OnSelectedIndexChanged="ddStepsStatus_SelectedIndexChanged">
                                        <asp:ListItem Value="ALL" Text="All Steps" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="FAILED" Text="Falied Steps"></asp:ListItem>
                                        <asp:ListItem Value="NOT_STARTED" Text="Waiting Steps"></asp:ListItem>
                                        <asp:ListItem Value="RUNNING" Text="Running Steps"></asp:ListItem>
                                        <asp:ListItem Value="SUCCEEDED" Text="Succeeded Steps"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="width: 100%;">
                                <td style="vertical-align: top;" colspan="3">
                                    <telerik:RadGrid ID="gvProcesses" runat="server" AllowPaging="True" CellSpacing="0" DataSourceID="dsProcesses" GridLines="None" AllowSorting="True">
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="dsProcesses">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="JOB_NAME" FilterControlAltText="Filter JOB_NAME column" HeaderText="Job Name" SortExpression="JOB_NAME" UniqueName="JOB_NAME">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="STEP_NAME" FilterControlAltText="Filter STEP_NAME column" HeaderText="Step Name" SortExpression="STEP_NAME" UniqueName="STEP_NAME">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="Status" SortExpression="STATUS" UniqueName="STATUS">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="START_TIME" FilterControlAltText="Filter START_TIME column" HeaderText="Started" SortExpression="START_TIME" UniqueName="START_TIME">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="END_TIME" FilterControlAltText="Filter END_TIME column" HeaderText="Finished" SortExpression="END_TIME" UniqueName="END_TIME">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="DURATION" FilterControlAltText="Filter DURATION column" HeaderText="Duration" SortExpression="DURATION" UniqueName="DURATION">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="OVERALL_PROGRESS" FilterControlAltText="Filter OVERALL_PROGRESS column" HeaderText="Overall Progress" SortExpression="OVERALL_PROGRESS" UniqueName="OVERALL_PROGRESS">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <BatchEditingSettings EditType="Cell" />
                                            <PagerStyle PageSizeControlType="RadComboBox" />
                                        </MasterTableView>
                                        <PagerStyle PageSizeControlType="RadComboBox" />
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

           
        </telerik:RadPageView>
    </telerik:RadMultiPage>
     <div style="text-align: center; font-size: small; min-height: 30px;">
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </div>

            <telerik:RadMenu ID="RadMenu9" runat="server" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false" CssClass="RadMenuStyle">
                <Items>
                    <telerik:RadMenuItem CssClass="menu-right">
                        <ItemTemplate>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="text-align: left; width: 100%;">
                                        <asp:LinkButton ID="btnSavingArea" runat="server" Text="Server Status" Font-Underline="false"></asp:LinkButton>
                                        <td style="text-align: right;">
                                            <asp:LinkButton ID="btnRefresh" runat="server" Text="Refresh" Font-Underline="false"
                                                OnClick="btnRefresh_Click"></asp:LinkButton>
                                        </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadMenuItem>
                </Items>
            </telerik:RadMenu>

            <table style="width: 100%; font-family: Calibri; font-size: small; padding-top: 10px; min-height: 120px;">
                <tr>
                    <td>
                        <asp:Label ID="lblUpdateStatus" runat="server" Text="<b>Server Update</b>" Height="100%"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSimStatus" runat="server" Text="<b>BOM Simulation</b>" Height="100%"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPOStatus" runat="server" Text="<b>PO Link Update</b>" Height="100%"></asp:Label>
                    </td>
                </tr>
            </table>

    <asp:SqlDataSource ID="dsPackages" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM user_objects WHERE object_type='PACKAGE' ORDER BY CASE WHEN OBJECT_NAME ='PKG_UPDATE_ALL' THEN 1 ELSE 99 END, OBJECT_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsException" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT search_tag, Max(exc_time) exc_time, sql_error, package_name 
FROM packaged_exceptions
WHERE (package_name =:ddPackageName OR :ddPackageName='ALL') 
GROUP BY search_tag, sql_error, package_name">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddPackageSelect" DefaultValue="ALL" Name="ddPackageName" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsProcesses" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_RUNNING_PROCESSES"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenLastSelectedTab" runat="server" />
</asp:Content>

