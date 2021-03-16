<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_PO.aspx.cs" Inherits="Material_MaterialStock_PO" Title="Material PO" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= poGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
             var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: gainsboro;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <telerik:RadGrid ID="poGridView" runat="server" AutoGenerateColumns="False" DataSourceID="poDataSource"
            AllowPaging="True" DataKeyNames="PO_ID" PageSize="50" SkinID="GridViewSkin">
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <Columns>
                    
                    <telerik:GridBoundColumn DataField="PO_NO" HeaderText="PO Number" SortExpression="PO_NO">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_DATE" HeaderText="PO Date" SortExpression="PO_DATE"
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" HeaderText="PO Item" SortExpression="PO_ITEM">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" HeaderText="PO Qty" SortExpression="PO_QTY">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="poDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID, PO_NO, PO_DATE, PO_ITEM, MAT_CODE1, PO_QTY FROM VIEW_PO_REPORT WHERE (MAT_ID = :MAT_ID) ORDER BY PO_NO, PO_ITEM">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
