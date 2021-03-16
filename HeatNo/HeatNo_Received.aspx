<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_Received.aspx.cs" Inherits="HeatNo_HeatNo_Received" Title="Heat No - MRV" %>

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
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="ReceiveGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="receiveDataSource" Width="100%" AllowPaging="True" PageSize="50"  onkeypress="handleSpace(event)"
            OnDataBound="ReceiveGridView_DataBound">
            <ClientSettings>
                 <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView TableLayout="Fixed">
            <Columns>
                
                <telerik:GridBoundColumn DataField="MIR_NO" HeaderText="Receive No" SortExpression="MIR_NO" 
                    ItemStyle-Width="200px" HeaderStyle-Width="200px"/>
                <telerik:GridBoundColumn DataField="INSP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Receive Date"
                    HtmlEncode="False" SortExpression="INSP_DATE" ItemStyle-Width="110px" HeaderStyle-Width="110px"/>
                <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" 
                     ItemStyle-Width="160px" HeaderStyle-Width="160px"/>
                <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"/>
                <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" 
                    ItemStyle-Width="70px" HeaderStyle-Width="70px"/>
                <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" SortExpression="WALL_THK" 
                    ItemStyle-Width="90px" HeaderStyle-Width="90px"/>
                <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM" 
                    ItemStyle-Width="150px" HeaderStyle-Width="150px"/>
                <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO" 
                    ItemStyle-Width="120px" HeaderStyle-Width="120px"/>
                <telerik:GridBoundColumn DataField="RCV_QTY" HeaderText="Recv'd Qty" SortExpression="RCV_QTY" 
                    ItemStyle-Width="120px" HeaderStyle-Width="120px"/>
                <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" 
                    ItemStyle-Width="50px" HeaderStyle-Width="50px"/>
            </Columns>
                </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="receiveDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM VIEW_MAT_MRIR_SUMMARY
WHERE ((PROJECT_ID = :PROJECT_ID) AND (HEAT_NO = :HEAT_NO))'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>