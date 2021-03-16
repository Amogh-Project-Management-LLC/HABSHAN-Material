<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="VendorContacts.aspx.cs" Inherits="Vendors_VendorContacts" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
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
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="90px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add" Width="90px">
            <Icon PrimaryIconUrl="../Images/New-Icons/Person-New.png" />
        </telerik:RadButton>
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
    <div style="margin-top: 3px;">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
             AllowPaging="true" PageSize="50">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="CONTACT_ID" DataSourceID="itemsDataSource" AllowAutomaticDeletes="true"
                AllowAutomaticUpdates="true" EditMode="PopUp" PagerStyle-AlwaysVisible="true">
                <EditFormSettings CaptionFormatString="Edit Contact : {0}" CaptionDataField="FIRST_NAME" PopUpSettings-Modal="true">
                    <PopUpSettings CloseButtonToolTip="Close" OverflowPosition="Center" />
                </EditFormSettings>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                        ConfirmTextFormatString="Are you sure you want to delete {0} {1}?" ConfirmTextFields="FIRST_NAME, LAST_NAME">
                       <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="CONTACT_TITLE" FilterControlAltText="Filter CONTACT_TITLE column" HeaderText="TITLE" SortExpression="CONTACT_TITLE" UniqueName="CONTACT_TITLE">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FIRST_NAME" FilterControlAltText="Filter FIRST_NAME column" HeaderText="FIRST NAME" SortExpression="FIRST_NAME" UniqueName="FIRST_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LAST_NAME" FilterControlAltText="Filter LAST_NAME column" HeaderText="LAST NAME" SortExpression="LAST_NAME" UniqueName="LAST_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EMAIL_ID" FilterControlAltText="Filter EMAIL_ID column" HeaderText="EMAIL ID" ReadOnly="True" SortExpression="EMAIL_ID" UniqueName="EMAIL_ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PHONE_NO" FilterControlAltText="Filter PHONE_NO column" HeaderText="LANDLINE NO" SortExpression="PHONE_NO" UniqueName="PHONE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MOBILE_NO" FilterControlAltText="Filter MOBILE_NO column" HeaderText="MOBILE NO" SortExpression="MOBILE_NO" UniqueName="MOBILE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FAX_NO" FilterControlAltText="Filter FAX_NO column" HeaderText="FAX NO" SortExpression="FAX_NO" UniqueName="FAX_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DISABLE_FLG" FilterControlAltText="Filter DISABLE_FLG column" HeaderText="DISABLE" SortExpression="DISABLE_FLG" UniqueName="DISABLE_FLG">
                        <ItemStyle Width="75px" />
                        <HeaderStyle Width="75px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsVendorsTableAdapters.VENDOR_CONTACTSTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_CONTACT_ID" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VENDOR_ID" Type="Decimal" />
            <asp:Parameter Name="CONTACT_TITLE" Type="String" />
            <asp:Parameter Name="FIRST_NAME" Type="String" />
            <asp:Parameter Name="LAST_NAME" Type="String" />
            <asp:Parameter Name="EMAIL_ID" Type="String" />
            <asp:Parameter Name="PHONE_NO" Type="String" />
            <asp:Parameter Name="MOBILE_NO" Type="String" />
            <asp:Parameter Name="FAX_NO" Type="String" />
            <asp:Parameter Name="CREATE_BY" Type="Decimal" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="VENDOR_ID" QueryStringField="Arg1" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CONTACT_TITLE" Type="String" />
            <asp:Parameter Name="FIRST_NAME" Type="String" />
            <asp:Parameter Name="LAST_NAME" Type="String" />
            <asp:Parameter Name="EMAIL_ID" Type="String" />
            <asp:Parameter Name="PHONE_NO" Type="String" />
            <asp:Parameter Name="MOBILE_NO" Type="String" />
            <asp:Parameter Name="FAX_NO" Type="String" />
            <asp:Parameter Name="DISABLE_FLG" Type="String" />
            <asp:Parameter Name="original_CONTACT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

