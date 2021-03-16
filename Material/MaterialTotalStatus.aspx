<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialTotalStatus.aspx.cs" Inherits="TotalStatus" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">


        function toggle_visibility(id) {
            var e = document.getElementById(id);
            var DivShow = id.concat('show');
            var DivHide = id.concat('hide');
            var eDivShow = document.getElementById(DivShow);
            var eDivHide = document.getElementById(DivHide);

            if (e.style.display == 'none') {
                e.style.display = 'block';
                eDivHide.style.display = 'inline';
                eDivShow.style.display = 'none';


            }

            else {
                e.style.display = 'none';
                eDivHide.style.display = 'none';
                eDivShow.style.display = 'inline';

            }

        }

    </script>

    <style>
        .expand {
            /*text-align: center;
            font-family: 'Apple Chancery';
            font-size: large;
            color: orange*/
            color: black;
            font-size: large;
            padding: 3px 3px 3px 3px;
            text-align: center;
            margin: 5px;
            font-weight: bold;
            font-size: medium;
        }

        .section-header {
            background-color: #BDE5F8;
        }

        .header {
            text-align: center;
            font-family: Arial;
            font-size: large;
            color: red;
        }

        a {
            text-decoration: none;
        }
    </style>

    <telerik:RadButton RenderMode="Lightweight" ID="RadButton1" runat="server" Text="Export All Grids"
        Height="60px" OnClick="RadButton1_Click" Visible="false">
        <Icon PrimaryIconCssClass="rbSave"></Icon>
    </telerik:RadButton>
    <telerik:RadComboBox ID="ExportingType" runat="server" Width="300px">
        <Items>
            <telerik:RadComboBoxItem Text="Export to separate spreadsheets" Value="1" />
            <telerik:RadComboBoxItem Text="Export in a single spreadsheet" Value="2" />
        </Items>
    </telerik:RadComboBox>


    <telerik:RadButton RenderMode="Lightweight" ID="RadButton2" runat="server" Text="Export"
        Width="100px" OnClick="RadButton1_Click">
        <Icon PrimaryIconCssClass="rbSave"></Icon>
    </telerik:RadButton>

    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
        Filter="Contains" DataValueField="MAT_ID" Width="250px" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged"
        AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Matcode"
        ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
    </telerik:RadComboBox>

    <br />
    <div style="padding: 10px; padding-left: 80px">
        <asp:DetailsView ID="itemsView" runat="server" AutoGenerateRows="true" CellPadding="4" DataSourceID="SqlMatDtDataSource"
            ForeColor="#333333" GridLines="None" DataKeyNames="MAT_CODE1">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />

            <FieldHeaderStyle BackColor="#DEE8F5" />

            <FooterStyle BackColor="#507CD1" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </div>
    <div class="section-header">
        <%--   <a href="#" onclick="toggle_visibility('divMR');" class="expand">  
           <table> <tr><td id="divMRshow"> + </td><td id="divMRhide" style="display: none;"> - </td> <td>MR Details </td></tr>
             </table> 
            </a>--%>
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMRshow">+ </label>
                </td>
                <td>
                    <label id="divMRhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divMR');" class="expand">MR Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMrCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMrSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divMR" style="display: none; overflow-x: auto; overflow-y: auto" tabindex="0">
        <%--<div class="header"> Material Requisition Details </div>--%>
        <telerik:RadGrid ID="MR" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMrDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMrDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divPoshow">+ </label>
                </td>
                <td>
                    <label id="divPohide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divPo');" class="expand">PO Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblPoCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblPoSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divPo" style="display: none; overflow-x: auto; overflow-y: auto" tabindex="1">
        <%--<div class="header">Purchase Order Details </div>--%>
        <telerik:RadGrid ID="PO" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlPoDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlPoDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />

    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divBatchshow">+ </label>
                </td>
                <td>
                    <label id="divBatchhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divBatch');" class="expand">Batch Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblBatchCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblBatchSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divBatch" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">Batch Details </div>--%>
        <telerik:RadGrid ID="Batch" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlBatchDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlBatchDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divIRNshow">+ </label>
                </td>
                <td>
                    <label id="divIRNhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divIRN');" class="expand">IRN Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblIrnCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblIrnSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divIRN" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">IRN Details </div>--%>
        <telerik:RadGrid ID="IRN" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlIrnDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlIrnDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMRRshow">+ </label>
                </td>
                <td>
                    <label id="divMRRhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divMRR');" class="expand">MRR Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMrrCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMrrSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divMRR" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">MRR Details </div>--%>
        <telerik:RadGrid ID="MRR" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMrrDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMrrDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <br />
    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divRFIshow">+ </label>
                </td>
                <td>
                    <label id="divRFIhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px"><a href="#" onclick="toggle_visibility('divRFI');" class="expand">RFI Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblRfiCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblRfiSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divRFI" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">RFI Details </div>--%>
        <telerik:RadGrid ID="RFI" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlRfiDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlRfiDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMRIRshow">+ </label>
                </td>
                <td>
                    <label id="divMRIRhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divMRIR');" class="expand">MRIR Details</a>
                </td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMrirCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMrirSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divMRIR" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">MRIR Details </div>--%>
        <telerik:RadGrid ID="MRIR" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMrirDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMrirDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <br />
    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMaterialRequestshow">+ </label>
                </td>
                <td>
                    <label id="divMaterialRequesthide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divMaterialRequest');" class="expand">Material Request Details</a>
                </td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMaterialRequestCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMaterialRequestSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>

    </div>
    <div id="divMaterialRequest" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">Material Request Details </div>--%>
        <telerik:RadGrid ID="MaterialRequest" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMatReqDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMatReqDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMaterialTransfershow">+ </label>
                </td>
                <td>
                    <label id="divMaterialTransferhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divMaterialTransfer');" class="expand">Material Transfer Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMtnCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMtnSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>


    </div>
    <div id="divMaterialTransfer" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">Material Transfer Details(MTN) </div>--%>
        <telerik:RadGrid ID="MTN" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMtnDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMtnDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMaterialReceiveshow">+ </label>
                </td>
                <td>

                    <label id="divMaterialReceivehide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divMaterialReceive');" class="expand">Material Receive Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMtnRcvCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMtnRcvSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>



    </div>
    <div id="divMaterialReceive" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">Material Receive Details </div>--%>
        <telerik:RadGrid ID="MTNreceive" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMtnRecvDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMtnRecvDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">
        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divMIVshow">+ </label>
                </td>
                <td>
                    <label id="divMIVhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divMIV');" class="expand">MIV Details</a> </td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblMivCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblMivSum" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>


    <div id="divMIV" style="display: none; overflow-x: auto; overflow-y: auto">
        <%--<div class="header">MIV Details </div>--%>
        <telerik:RadGrid ID="MIV" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="SqlMivDataSource" GridLines="None" PageSize="5" OnColumnCreated="RadGrids_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="SqlMivDataSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <br />
    <div class="section-header">

        <table style="width: 100%">
            <tr>
                <td>
                    <label id="divReconcilationshow">+ </label>
                </td>
                <td>
                    <label id="divReconcilationhide" style="display: none;">- </label>
                </td>
                <td style="width: 250px; margin-top: 15px">
                    <a href="#" onclick="toggle_visibility('divReconcilation');" class="expand">Reconcilation Details</a></td>
                <td style="width: 50%; text-align: center; float: right;">
                    <telerik:RadLabel ID="lblReconCnt" runat="server" ForeColor="Red"></telerik:RadLabel>
                </td>
                <td style="padding-left: 250px;">
                    <telerik:RadLabel ID="lblReconSum" runat="server" ForeColor="Red"></telerik:RadLabel>

                </td>
            </tr>
        </table>
    </div>
    <div id="divReconcilation" style="display: none; overflow-x: auto; overflow-y: auto" tabindex="0">
        <%--<div class="header">Reconcilation Details </div>--%>
        <telerik:RadGrid ID="Reconcilation" runat="server" AutoGenerateColumns="true" AllowPaging="True" CellSpacing="0" EnableHeaderContextMenu="true" OnItemDataBound="RadGrids_ItemDataBound"
            EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" ShowFooter="true"
            DataSourceID="sqlReconcilationSource" GridLines="None" PageSize="5" OnColumnCreated="Reconcilation_ColumnCreated">
            <ExportSettings IgnorePaging="true" ExportOnlyData="true">
                <Excel Format="Xlsx" />
            </ExportSettings>
            <MasterTableView AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                PageSize="5" AllowFilteringByColumn="true" DataSourceID="sqlReconcilationSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>


    <asp:SqlDataSource ID="SqlMatDtDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  MAT_CODE1, MAT_CODE2, MAT_DESCR,SIZE_DESC, SIZE1, SIZE2, WALL_THK,THK1, THK2, UNIT_WEIGHT,  ITEM_NAM, UOM
                        FROM  VIEW_ADAPTER_MAT_STOCK
                        WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlMrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISCIPLINE, MR_NO, MR_REV, MR_TITLE, CLIENT_PART_NO AS MAT_CODE1, MR_QTY, DELIVERY_POINT, CONSTRUCTION_AREA 
                       FROM VIEW_MAT_REQUISITION 

                      WHERE CLIENT_PART_NO =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlPoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  DISCIPLINE, PO_NO, MR_NO,PO_DATE, PO_VEND_NAME, PO_CDD, PO_ITEM,MAT_CODE1, ITEM_NAM, SIZE_DESC, MAT_DESCR, PO_QTY, EXPEDITOR
                        FROM VIEW_PO_REPORT_MAIN
                      WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlBatchDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT   DISCIPLINE, PO_NO,  PO_ITEM_NO, BATCH_NO,BATCH_REV, MAT_CODE1,MAT_DESCR, ITEM_NAM, SIZE_DESC, WALL_THK, BATCH_QTY, DELIVERY_FORECAST 
                       FROM VIEW_PO_BATCH_PLAN_DETAIL
                      WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlIrnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISCIPLINE, PO_NO,  IRN_NO, IRN_DATE,PO_ITEM, MAT_CODE1, MAT_DESCR, ITEM_NAM,SIZE_DESC,WALL_THK, INSP_QTY, PIECES,RELEASE_QTY
                            FROM VIEW_PO_IRN_DETAIL_REP
                      WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMrrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISCIPLINE, MAT_RCV_NO, RECV_DATE, PO_NO, IRN_NO, MRR_ITEM,PO_ITEM, MAT_CODE1, ITEM_NAM, MAT_DESCR, WALL_THK, SIZE_DESC,
                             RECV_QTY, HEAT_NO, CABLE_DRUM_NO, SUB_STORE, AREA
                        FROM VIEW_MAT_RCV_REPORT_DT
                      WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlRfiDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISCIPLINE, MAT_RCV_NO, RFI_NO, CLIENT_RFI_NO, RFI_DATE, PO_NO, MAT_CODE1, MAT_DESCR, SHIPMENT_NO, INSP_QTY, HEAT_NO,STORE_NAME 
                      FROM VIEW_MAT_RFI_REPORT
                      WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMrirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT DISCIPLINE,MIR_NO,CLIENT_MRIR_NO,MIR_ITEM,PO_NO,PO_ITEM,INSP_DATE,SRN_NO,SHIP_NO,VENDOR_NAME,MODE_OF_SHIPMENT,INVOICE_NO,MRR_RCV_NO, 
                        MRR_RECV_DATE,RFI_NO,CLIENT_RFI_NO,ITEM_NAME,MAT_CODE AS MAT_CODE1,MATERIAL_DESCRIPTION,MAT_SIZE,WALL_THK,UNIT,RCV_QTY,ACPT_QTY,HEAT_NO,MTC_CODE,
                        CABLE_DRUM_NO,ESD_NO,ESD_QTY,CLEAR_QTY,ESD_FLAG,SUB_STORE,SUB_WAREHOUSE,LINE_NO,RACK_NO,SHELF_NO
                       FROM VIEW_MAT_MRIR_REPORT MRIR
                      WHERE MAT_CODE =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMatReqDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_NO,MAT_REQ_NO, AREA, SUB_AREA, FROM_STORE, TO_STORE, TRANSF_NO,MR_ITEM_NO, MAT_CODE1, MAT_DESCR, ITEM_NAM, SIZE_DESC,REQ_QTY, UOM, ISSUED_QTY 
                       FROM     VIEW_MATERIAL_REQUEST_DT1
                       WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMtnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  PO_NO,TRANSF_NO, AREA, SUB_AREA, DISCIPLINE, TRANSF_DATE,MAT_REQ_NO, MR_ITEM_NO, MAT_REQ_QTY, FROM_STORE, TO_STORE,
                         MATERIAL_CODE AS MAT_CODE1, MATERIAL_DESCRIPTION, ITEM_NAME, SIZE_DESC,UNIT, HEAT_NO, CABLE_DRUM_NO, TRANSF_QTY, NO_OF_PIECE
                      FROM VIEW_ADAPTER_MAT_TRANSF_DT1  
                      WHERE MATERIAL_CODE =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMtnRecvDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT RCV_NUMBER,AREA,SUB_AREA,RCV_DATE,TRANSFER_NO,RECEIVE_STORE,TRANSF_FROM_STORE,PO_NO,
                          MAT_CODE1,MR_ITEM_NO,MAT_DESCR,ITEM_NAM,SIZE_DESC,UOM_NAME,RCV_QTY,CONTAINER_NO,PACKING_LIST_NO,HEAT_NO,CABLE_DRUM_NO,PAINT_SYS
                        FROM VIEW_MAT_TRANSFER_RCV_DT
                        WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMivDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISCIPLINE,SUB_CON_NAME,STORE_NAME,MIV_NO,REFERENCE_NO as AREA,ISSUE_dATE,MAT_CODE1, MAT_DESCR,ITEM_NAM,SIZE_DESC,UOM_NAME AS UNIT,HEAT_NO,
                       CABLE_DRUM_NO,PAINT_CODE,ISSUE_QTY
                       FROM VIEW_ADAPTER_ISSUE_ADD_DETAIL 
                       WHERE MAT_CODE1 =:MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlReconcilationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_NAME, MAT_CODE1, MAT_CODE2,DISCIPLINE,PO_NO,MR_NO, SIZE_DESC, WALL_THK, MAT_DESCR, ITEM_NAM, UOM, PO_QTY,RCVD_QTY, ACPT_QTY, SD_QTY, SD_CLR_QTY, TRANS_RCV_QTY,JC_QTY, ADD_ISSUE AS MAT_MIV_QTY, TRANSF_OUT_QTY, REMAIN_QTY, QRNTINE_QTY,RETURN_QTY,BAL_QTY FROM VIEW_ITEM_REP_A
                      WHERE MAT_CODE1 =:MAT_CODE1">

        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_CODE1" QueryStringField="MAT_CODE1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_CODE1,MAT_ID FROM PIP_MAT_STOCK"></asp:SqlDataSource>
</asp:Content>

