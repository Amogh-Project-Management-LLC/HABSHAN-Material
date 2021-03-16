<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PreserveCodes.aspx.cs" Inherits="Preservation_PreserveCodes" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemeGridView.ClientID %>')
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
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="btnCodeGuide" runat="server" Text="Code Guide" Width="120px"></telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemeGridView" runat="server" DataSourceID="itemsDataSource" AllowPaging="true" PageSize="50"  onkeypress="handleSpace(event)"  OnItemCommand="itemeGridView_ItemCommand" OnDataBinding="itemeGridView_DataBinding">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="PRESERV_CODE_ID"
                 EditMode="InPlace" TableLayout="Fixed" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton"  >
                      
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="PRESERV_CODE" ReadOnly="true" FilterControlAltText="Filter PRESERV_CODE column" 
                        HeaderText="PRESERV_CODE" SortExpression="PRESERV_CODE" UniqueName="PRESERV_CODE">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORAGE_CLASS" ReadOnly="true" FilterControlAltText="Filter STORAGE_CLASS column" 
                        HeaderText="STORAGE_CLASS" SortExpression="STORAGE_CLASS" UniqueName="STORAGE_CLASS">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WBS_DESC" ReadOnly="true" FilterControlAltText="Filter WBS_DESC column" HeaderText="WBS_DESC" 
                        SortExpression="WBS_DESC" UniqueName="WBS_DESC">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="COMPANY_DESC" ReadOnly="true" FilterControlAltText="Filter COMPANY_DESC column" HeaderText="COMPANY_DESC" SortExpression="COMPANY_DESC" UniqueName="COMPANY_DESC">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRES_FREQ_DESC" ReadOnly="true" FilterControlAltText="Filter PRES_FREQ_DESC column" HeaderText="PRES_FREQ_DESC" SortExpression="PRES_FREQ_DESC" UniqueName="PRES_FREQ_DESC">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DESCRIPTION" FilterControlAltText="Filter DESCRIPTION column" HeaderText="DESCRIPTION" SortExpression="DESCRIPTION" UniqueName="DESCRIPTION">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPreservationTableAdapters.VIEW_PRESERV_CODE_MASTERTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_PRESERV_CODE_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="original_PRESERV_CODE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

