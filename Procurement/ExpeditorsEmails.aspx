<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"   
    CodeFile="ExpeditorsEmails.aspx.cs" Inherits="Expeditors_Emails" Title="Expeditors Emails" EnableSessionState="ReadOnly" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }

        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }



        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
         function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divwidth = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderDiv").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight

            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = divwidth - 15 + "px";
            grid.repaint();
        }

    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
   
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table>
            <tr>
                <td>
                    <div id="HeaderDiv">
                        <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                    </div>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Visible="false" Text="Save" Width="80px" OnClick="btnSave_Click" />
                </td>
                  <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Expeditor"  />
                </td>
                 <td>
                    <asp:ImageButton ID="ImageButtonProcedure" runat="server" ImageUrl="~/Images/knob/Refresh.png" ToolTip="Batch Status" OnClick="ImageButtonProcedure_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click" Width="100px" ></telerik:RadButton>
                </td>
            
                
            </tr>
        </table>
        <table runat="server" id="EntryTable" visible="false">

            <tr>
                <td style="width: 180px; background-color: gainsboro">EXPEDITOR NAME

                </td>
              
                <td>
             <telerik:RadComboBox ID="ddlEXPEDITOR_NAME" runat="server" Width="250px"  AllowCustomText="true" 
                                    Filter="Contains"  DataSourceID="UserDataSource" DataTextField="USER_NAME" DataValueField="USER_ID">
                                </telerik:RadComboBox>
                </td>
              <%--    <td>
                    <telerik:RadTextBox ID="txtEXPEDITOR_NAME" runat="server" Width="200px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="expValidator" runat="server" ControlToValidate="txtEXPEDITOR_NAME" ForeColor="Red"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>--%>

               </tr>
            <tr>
                
               
                <td style="width: 180px; background-color: gainsboro">IS EXPEDITOR

                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlIS_EXPEDITOR" runat="server">
                        <Items>
                            <telerik:DropDownListItem Text="Y" Value="Y" />
                            <telerik:DropDownListItem Text="N" Value="N" />

                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 180px; background-color: gainsboro">DEPARTMENT
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDEPARTMENT" runat="server" Width="200px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                </td>
                </tr>
            <tr>
                <td style="width: 180px; background-color: gainsboro">PHONE_NUMBER
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPHONE_NUMBER" runat="server" Width="200px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                </td>
            </tr>

        </table>
    </div>
    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true"
            CssClass="DataWebControlStyle" DataKeyNames="EXPEDITOR_ID" DataSourceID="itemsDataSource"
            PageSize="50" AllowSorting="true" PagerStyle-AlwaysVisible="true"
            OnPreRender="itemsGridView_PreRender" OnItemCommand="itemsGridView_ItemCommand" OnItemDataBound="itemsGridView_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" CaseSensitive="false"></GroupingSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <ClientSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView DataSourceID="itemsDataSource" DataKeyNames="EXPEDITOR_ID" AutoGenerateColumns="False" PageSize="50"
                AllowFilteringByColumn="true" EditMode="InPlace" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                AllowMultiColumnSorting="true" ClientDataKeyNames="EXPEDITOR_ID" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                     <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Are Sure Want To Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="USER_NAME" HeaderText="EXPEDITOR NAME" SortExpression="USER_NAME" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                   
                    <telerik:GridBoundColumn DataField="EMAIL" HeaderText="EMAIL" SortExpression="EMAIL" AutoPostBackOnFilter="true"  ReadOnly="true" FilterControlWidth="60px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IS_EXPEDITOR" HeaderText="IS EXPEDITOR" SortExpression="IS_EXPEDITOR" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DEPARTMENT" HeaderText="DEPARTMENT" SortExpression="DEPARTMENT" AllowFiltering="false" >
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PHONE_NUMBER" HeaderText="PHONE NUMBER" SortExpression="PHONE_NUMBER" AllowFiltering="false" >
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="BATCH_COUNT" HeaderText="EXPIRED BATCH COUNT" SortExpression="BATCH_COUNT" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="STATUS" HeaderText="EMAIL STATUS" SortExpression="STATUS" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="60px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                   
                      <telerik:GridBoundColumn DataField="START_DATE" HeaderText="EMAIL START DATE" SortExpression="START_DATE"  ReadOnly="true" AllowFiltering="false" >
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="COMPLETE_DATE" HeaderText="EMAIL COMPLETE DATE" SortExpression="COMPLETE_DATE"  ReadOnly="true" AllowFiltering="false">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT * FROM VIEW_BATCH_EMAILS_MODULE"
            DeleteCommand="DELETE FROM EXPEDITORS_EMAILS WHERE EXPEDITOR_ID =:EXPEDITOR_ID"
            UpdateCommand=" UPDATE EXPEDITORS_EMAILS SET IS_EXPEDITOR=:IS_EXPEDITOR,DEPARTMENT=:DEPARTMENT,PHONE_NUMBER=:PHONE_NUMBER 
                          WHERE (EXPEDITOR_ID = :EXPEDITOR_ID)"
            InsertCommand="INSERT INTO EXPEDITORS_EMAILS
                            (USER_ID,IS_EXPEDITOR,DEPARTMENT,PHONE_NUMBER)
                            VALUES 
                            (:USER_ID,:IS_EXPEDITOR,:DEPARTMENT,:PHONE_NUMBER )">

            <DeleteParameters>
                <asp:Parameter Name="EXPEDITOR_ID" Type="Decimal" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="IS_EXPEDITOR" Type="String" />
                <asp:Parameter Name="DEPARTMENT" Type="String" />
                <asp:Parameter Name="PHONE_NUMBER" Type="String" />
                <asp:Parameter Name="EXPEDITOR_ID" Type="Decimal" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter Name="USER_ID" ControlID="ddlEXPEDITOR_NAME" PropertyName="SelectedValue" Type="Decimal" /> 
                <asp:ControlParameter Name="IS_EXPEDITOR" ControlID="ddlIS_EXPEDITOR" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter Name="DEPARTMENT" ControlID="txtDEPARTMENT" Type="String" />
                <asp:ControlParameter Name="PHONE_NUMBER" ControlID="txtPHONE_NUMBER" Type="String" />

            </InsertParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT USER_ID, USER_NAME FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>

        <asp:SqlDataSource ID="MailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT distinct USER_NAME  FROM VIEW_BATCH_EMAIL GROUP BY USER_NAME 
                       ORDER BY Count(*)"></asp:SqlDataSource>
    </div>
</asp:Content>
