<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PresDetail - Copy.aspx.cs" Inherits="Preservation_PresDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= griItems.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            //grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Report" Width="100px"></telerik:RadButton>
        <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="100px"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="griItems" runat="server" DataSourceID="itemsDataSource" 
            CellSpacing="-1" AllowPaging="True" PageSize="15" OnItemCommand="griItems_ItemCommand" OnDataBinding="griItems_DataBinding">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" 
               DataKeyNames="PRES_ID" TableLayout="Fixed" PagerStyle-AlwaysVisible="true">
                <CommandItemSettings ExportToPdfText="Export to PDF" />
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" 
                        ConfirmDialogType="RadWindow">
                       <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" ReadOnly="true" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE_NAME" SortExpression="STORE_NAME"
                        UniqueName="STORE_NAME">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUBSTORE" ReadOnly="true" FilterControlAltText="Filter SUBSTORE column" HeaderText="SUBSTORE" SortExpression="SUBSTORE" UniqueName="SUBSTORE">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1"
                        UniqueName="MAT_CODE1">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" ReadOnly="true" DataType="System.Decimal" FilterControlAltText="Filter QTY column" HeaderText="QTY" SortExpression="QTY" UniqueName="QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRES_REP_NO" FilterControlAltText="Filter PRES_REP_NO column" HeaderText="PRES_REP_NO" SortExpression="PRES_REP_NO" UniqueName="PRES_REP_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="PRES_DATE" DataType="System.DateTime" FilterControlAltText="Filter PRES_DATE column" HeaderText="PRES_DATE" SortExpression="PRES_DATE" UniqueName="PRES_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("PRES_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PRES_DATELabel" runat="server" Text='<%# Eval("PRES_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="INSP_BY" FilterControlAltText="Filter INSP_BY column" HeaderText="INSP_BY" SortExpression="INSP_BY" UniqueName="INSP_BY">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
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
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPreservationTableAdapters.VIEW_PRES_MAT_DETAILTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_PRES_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PRES_REP_NO" Type="String" />
            <asp:Parameter Name="PRES_DATE" Type="DateTime" />
            <asp:Parameter Name="INSP_BY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_PRES_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

