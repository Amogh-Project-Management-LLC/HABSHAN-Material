<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Received.aspx.cs" Inherits="HeatNo_HeatNo_Received" Title="Material - MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ReceiveGridView.ClientID %>')
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
    <div style="background-color: gainsboro; padding: 3px;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="ReceiveGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="receiveDataSource" Width="100%" AllowPaging="True" PageSize="50">
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <Columns>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" HeaderText="Receive No" SortExpression="MAT_RCV_NO">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECV_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Receive Date"
                        HtmlEncode="False" SortExpression="RECV_DATE">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1">
                        <ItemStyle Width="170px" />
                        <HeaderStyle Width="170px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" SortExpression="WALL_THK">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECEIVED" HeaderText="Received" SortExpression="RECEIVED">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS">
                        <itemstyle font-size="XX-Small" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="receiveDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM VIEW_MAT_RECV_SUMMARY WHERE (PROJECT_ID = :PROJECT_ID) AND (MAT_ID= :MAT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
