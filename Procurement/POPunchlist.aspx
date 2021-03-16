<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POPunchlist.aspx.cs" Inherits="Procurement_POPunchlist" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
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
        function handleSpace(event)
        {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13)
            {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>
    
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnNewPunch" runat="server" Text="New Punch" Width="100px"></telerik:RadButton>
        <telerik:RadButton ID="btnItems" runat="server" Text="Items" Width="80px" OnClick="btnItems_Click"></telerik:RadButton>
         <telerik:RadButton ID="btnAddItems" runat="server" Text="Add Items" Width="100px" OnClick="btnAddItems_Click">
        </telerik:RadButton>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"  onkeypress="handleSpace(event)"
                    CellSpacing="0" GridLines="None" AutoGenerateColumns="False" DataSourceID="itemstDataSource"  AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                    PageSize="50">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" /> 
                        <Scrolling AllowScroll="true" UseStaticHeaders="true"/>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="PUNCH_ID" DataSourceID="itemstDataSource" EditMode="InPlace"
                        EditFormSettings-EditColumn-CancelImageUrl="../App_Themes/BlueTheme/images/cross.png"
                        EditFormSettings-EditColumn-InsertImageUrl="../App_Themes/BlueTheme/images/tick.png"
                        EditFormSettings-EditColumn-ButtonType="ImageButton" AllowMultiColumnSorting="true" PagerStyle-AlwaysVisible="true"
                        TableLayout="Fixed">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn 
                             ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="PUNCH_NO" FilterControlAltText="Filter PUNCH_NO column" HeaderText="PUNCH NO" SortExpression="PUNCH_NO" UniqueName="PUNCH_NO"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="230px">
                                <ItemStyle Width="300px" />
                                <HeaderStyle Width="300px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO"
                                UniqueName="PO_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ReadOnly="true" AllowFiltering="True">
                                <ItemStyle Width="170px" />
                                <HeaderStyle Width="170px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QTY" ReadOnly="true" FilterControlAltText="Filter QTY column" HeaderText="QTY" SortExpression="QTY" UniqueName="QTY" FilterControlWidth="30px">
                    <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="CREATE_DATE" FilterControlAltText="Filter CREATE_DATE column"
                                HeaderText="CREATED DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" ReadOnly="true"
                                AllowFiltering="false" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" ReadOnly="true"
                                HeaderText="CREATED BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="RAISED_BY" FilterControlAltText="Filter RAISED_BY column" ReadOnly="true"
                                HeaderText="RAISED BY" SortExpression="RAISED_BY" UniqueName="RAISED_BY" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                                SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PUNCH_MASTERTableAdapter" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <%--<DeleteParameters>
            <asp:Parameter Name="Original_QRNTINE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_QRNTINE_ID" Type="Decimal" />
        </UpdateParameters>--%>
    </asp:ObjectDataSource>
</asp:Content>

