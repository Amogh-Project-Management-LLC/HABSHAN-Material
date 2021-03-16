<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POBatchPlan - Copy.aspx.cs" Inherits="Procurement_POBatchPlan" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            grid.get_element().style.height = (height) - 260 + "px";
    
            grid.repaint();
        window.onresize = Test;

        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnCreate" runat="server" Text="Create Batch"></telerik:RadButton>
        <telerik:RadButton ID="btnRevision" runat="server" Text="Create Revision"></telerik:RadButton>
        <telerik:RadButton ID="btnBatchItems" runat="server" Text="Batch Items" OnClick="btnBatchItems_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSearchItems" runat="server" Text="Search Items"></telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" PageSize="50" Height="330px" AllowSorting="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BATCH_ID" AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ConfirmDialogType="RadWindow"
                         ConfirmTextFormatString="Are you sure you want to delete Batch No {0} from PO {1} ?"
                         ConfirmTextFields="BATCH_NO, PO_NO"></telerik:GridButtonColumn>                   
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_NO" FilterControlAltText="Filter BATCH_NO column" HeaderText="BATCH NO" SortExpression="BATCH_NO" UniqueName="BATCH_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MANUF_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter MANUF_DATE column" HeaderText="MANUFACTURING DATE" SortExpression="MANUF_DATE" UniqueName="MANUF_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_DT_F" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter INSP_DT_F column" HeaderText="INSP DATE" SortExpression="INSP_DT_F" UniqueName="INSP_DT_F">
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="INSP_DT_A" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter INSP_DT_A column" HeaderText="INSP DATE (A)" SortExpression="INSP_DT_A" UniqueName="INSP_DT_A">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="SLED_BBD_DT" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter SLED_BBD_DT column" HeaderText="SLED/BBD DATE" SortExpression="SLED_BBD_DT" UniqueName="SLED_BBD_DT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="ETA_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter ETA_DATE column" HeaderText="ETA DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE">
                    </telerik:GridBoundColumn>--%>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="BATCH_NO" Type="String" />
            <asp:Parameter Name="MANUF_DATE" Type="DateTime" />
            <asp:Parameter Name="INSP_DT_F" Type="DateTime" />
            <asp:Parameter Name="INSP_DT_A" Type="DateTime" />
            <asp:Parameter Name="SLED_BBD_DT" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="ETA_DATE" Type="DateTime" />
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

