<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNoIndex.aspx.cs" Inherits="HeatNo_HeatNoIndex" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= HeatNoGridView.ClientID %>')
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
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRecvd" runat="server" Text="Received" Width="80" OnClick="btnRecvd_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnESD" runat="server" Text="ESD" Width="80" OnClick="btnESD_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJoints" runat="server" Text="Joints" Width="80" OnClick="btnJoints_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtFilter" runat="server" Width="150px" AutoPostBack="True" OnTextChanged="txtFilter_TextChanged" EmptyMessage="Search Here">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="HeatNoGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="HeatNoDataSource" PageSize="20" SkinID="GridViewSkin" AllowSorting="true"
            OnDataBound="HeatNoGridView_DataBound" OnRowEditing="HeatNoGridView_RowEditing"  onkeypress="handleSpace(event)"
            OnPageIndexChanged="HeatNoGridView_PageIndexChanged" DataKeyNames="HEAT_NO" OnItemCommand="HeatNoGridView_ItemCommand" OnDataBinding="HeatNoGridView_DataBinding">
            <ClientSettings>
                 <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="HeatNoDataSource" PagerStyle-AlwaysVisible="true"
                PageSize="50" DataKeyNames="HEAT_NO" AllowFilteringByColumn="true" EditMode="InPlace" AllowMultiColumnSorting="true"
                TableLayout="Fixed">
            <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton">
                    <ItemStyle Width="35px" />
                    <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                  <ItemStyle Width="35px" />
                    <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat No" ReadOnly="True" SortExpression="HEAT_NO"></telerik:GridBoundColumn>
            </Columns>
                </MasterTableView>
        </telerik:RadGrid>

    </div>
    <asp:ObjectDataSource ID="HeatNoDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralTableAdapters.VIEW_ADAPTER_HNTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="HEAT_NO" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>