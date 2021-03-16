<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Vendors.aspx.cs" Inherits="Vendors_Vendors" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
                 window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	        //var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
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
        <telerik:RadButton runat="server" ID="btnNew" Text="New Vendor" Width="120px" Icon-PrimaryIconUrl="~/Images/New-Icons/new.png"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnConctacts" Text="Contacts" Width="120px" Icon-PrimaryIconUrl="~/Images/New-Icons/person.png" OnClick="btnConctacts_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnDocs" Text="Documents" Width="120px" Icon-PrimaryIconUrl="~/Images/New-Icons/document.png" OnClick="btnDocs_Click"></telerik:RadButton>
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            var popUp;
            function PopUpShowing(sender, eventArgs) {
                popUp = eventArgs.get_popUp();
                var gridWidth = sender.get_element().offsetWidth;
                var gridHeight = sender.get_element().offsetHeight;
                var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                popUp.style.top = ((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";      
            }
        </script>
    </telerik:RadCodeBlock>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource"  
            OnDeleteCommand="RadGrid1_DeleteCommand" PageSize="50"  AllowFilteringByColumn="true" AllowSorting="true"   onkeypress="handleSpace(event)"  OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="PopUp" EditFormSettings-PopUpSettings-Modal="true"
                 DataKeyNames="VENDOR_ID" AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <EditFormSettings CaptionFormatString="Edit Vendor : {0}" CaptionDataField="VENDOR_NAME">
                    <PopUpSettings CloseButtonToolTip="Close" OverflowPosition="Center" />
                </EditFormSettings>
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_CODE" FilterControlAltText="Filter VENDOR_CODE column" HeaderText="VENDOR CODE" SortExpression="VENDOR_CODE" UniqueName="VENDOR_CODE" AllowFiltering="true" AutoPostBackOnFilter="true"  FilterControlWidth="30px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_NAME" FilterControlAltText="Filter VENDOR_NAME column" HeaderText="VENDOR NAME" SortExpression="VENDOR_NAME" UniqueName="VENDOR_NAME" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_ADDR1" FilterControlAltText="Filter VENDOR_ADDR1 column" HeaderText="ADDRESS LINE1" SortExpression="VENDOR_ADDR1" UniqueName="VENDOR_ADDR1" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="130px">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_ADDR2" FilterControlAltText="Filter VENDOR_ADDR2 column" HeaderText="ADDRESS LINE2" SortExpression="VENDOR_ADDR2" UniqueName="VENDOR_ADDR2" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_ADDR3" FilterControlAltText="Filter VENDOR_ADDR3 column" HeaderText="ADDRESS LINE3" SortExpression="VENDOR_ADDR3" UniqueName="VENDOR_ADDR3" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="VENDOR_AREA" FilterControlAltText="Filter VENDOR_AREA column" HeaderText="AREA" SortExpression="VENDOR_AREA" UniqueName="VENDOR_AREA" AllowFiltering="false">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="COUNTRY_CODE" FilterControlAltText="Filter COUNTRY_CODE column" HeaderText="COUNTRY CODE" SortExpression="COUNTRY_CODE" UniqueName="COUNTRY_CODE" ReadOnly="true" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IS_APPROVED" FilterControlAltText="Filter IS_APPROVED column" HeaderText="APPROVED (Y/N)" SortExpression="IS_APPROVED" UniqueName="IS_APPROVED" AllowFiltering="true" AutoPostBackOnFilter="true"  FilterControlWidth="30px">
                         <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_PHONE" FilterControlAltText="Filter VENDOR_PHONE column" HeaderText="PHONE NO" SortExpression="VENDOR_PHONE" UniqueName="VENDOR_PHONE" AllowFiltering="false">
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_FAX" FilterControlAltText="Filter VENDOR_FAX column" HeaderText="FAX NO" SortExpression="VENDOR_FAX" UniqueName="VENDOR_FAX" AllowFiltering="false">
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS" ReadOnly="true" AllowFiltering="false">
                     <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" ReadOnly="true" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
              <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsVendorsTableAdapters.VIEW_VENDOR_MASTERTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_VENDOR_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="VENDOR_CODE" Type="String" />
            <asp:Parameter Name="VENDOR_NAME" Type="String" />
            <asp:Parameter Name="VENDOR_ADDR1" Type="String" />
            <asp:Parameter Name="VENDOR_ADDR2" Type="String" />
            <asp:Parameter Name="VENDOR_ADDR3" Type="String" />
            <asp:Parameter Name="VENDOR_AREA" Type="String" />
            <%--<asp:Parameter Name="VENDOR_COUNTRY" Type="Decimal" />--%>
            <asp:Parameter Name="IS_APPROVED" Type="String" />
            <asp:Parameter Name="VENDOR_PHONE" Type="String" />
            <asp:Parameter Name="VENDOR_FAX" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <%--<asp:Parameter Name="VENDOR_STATUS" Type="Decimal" />--%>
            <asp:Parameter Name="original_VENDOR_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
      <asp:HiddenField ID="ACCESS_BY" runat="server" />
    <asp:HiddenField ID="ALL_RECORDS" runat="server" />
</asp:Content>

