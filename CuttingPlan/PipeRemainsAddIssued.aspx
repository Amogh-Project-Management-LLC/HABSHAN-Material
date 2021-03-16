<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemainsAddIssued.aspx.cs" Inherits="CuttingPlan_PipeRemainsAddIssued"
    Title="Pipe Remain" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= historyGridView.ClientID %>')
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
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="historyGridView" runat="server" PageSize="50" PagerStyle-AlwaysVisible="true" AutoGenerateColumns="False" 
                    SkinID="GridViewSkin" DataSourceID="AddIssuedDataSource">
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <MasterTableView TableLayout="Fixed">
                        <Columns>                            
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="MIV No" SortExpression="ISSUE_NO">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_DATE" HeaderText="Issue Date" SortExpression="ISSUE_DATE"
                                HtmlEncode="false" DataFormatString="{0:dd-MMM-yyyy}">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISSUED_QTY" HeaderText="Issued Qty" SortExpression="ISSUED_QTY" DataFormatString="{0:N2}">
                                <ItemStyle Width="100px" HorizontalAlign="Right"/>
                                <HeaderStyle Width="100px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="AddIssuedDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT REM_ID, ISSUE_NO, ISSUE_DATE, ISSUED_QTY, REMARKS FROM VIEW_ADD_ISSUE_REM_REP WHERE (REM_ID = :REM_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REM_ID" QueryStringField="REM_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
