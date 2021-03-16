<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Users.aspx.cs" Inherits="Admin_Users" Title="Users" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function ModuleRole_click() {
            try {
                var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("USER_ID");
                radopen("../Admin/UserModuleRoles.aspx?USER_ID=" + id, "RadWindow2", 800, 600);
            }
            catch (err) {
                txt = "Select any User!";
                alert(txt);
            }
        }
         function Role_click() {
            try {
                var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("USER_ID");
                radopen("../Admin/UserRoles.aspx?USER_ID=" + id, "RadWindow1", 800, 600);
            }
            catch (err) {
                txt = "Select any User!";
                alert(txt);
            }
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }

        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            var divButton = document.getElementById("btndiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }
    </script>
    <div id="btndiv">
        <table >
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>
                <td>
                      <asp:LinkButton ID="LinkRoles" runat="server" OnClientClick="Role_click(); return false;">
                        <telerik:RadButton ID="btnRole" runat="server" Text="Roles" Width="80"></telerik:RadButton>
                    </asp:LinkButton>
                    
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="ModuleRole_click(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="Column Wise Access" Width="150"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click" Width="100px"></telerik:RadButton>
                </td>
                <td style="text-align: right; width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtFilter" runat="server" Width="150" EmptyMessage="Search User" AutoPostBack="True"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" PageSize="50" AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowMultiRowSelection="true"
                    OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnUpdateCommand="RadGrid1_UpdateCommand" AllowFilteringByColumn="true">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling UseStaticHeaders="true" AllowScroll="true"  />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="USER_ID" DataSourceID="itemsDataSource" ClientDataKeyNames="USER_ID"
                        EditMode="InPlace" HierarchyLoadMode="Client">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridClientSelectColumn>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="55px" />
                                <HeaderStyle Width="55px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>

                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="User Name" SortExpression="USER_NAME" UniqueName="USER_NAME" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EMP_CODE" FilterControlAltText="Filter EMP_CODE column" HeaderText="Employee Code" SortExpression="EMP_CODE" UniqueName="EMP_CODE" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DISABLED" FilterControlAltText="Filter DISABLED column" HeaderText="Disabled" SortExpression="DISABLED" UniqueName="DISABLED" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EMAIL" FilterControlAltText="Filter EMAIL column" HeaderText="Email" SortExpression="EMAIL" UniqueName="EMAIL" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="300px" />
                                <HeaderStyle Width="300px" />
                            </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="DESIGNATION" FilterControlAltText="Filter DESIGNATION column" HeaderText=" DESIGNATION" SortExpression="DESIGNATION" UniqueName="DESIGNATION" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="COMPANY_NAME" FilterControlAltText="Filter COMPANY_NAME column" HeaderText="COMPANY NAME" SortExpression="COMPANY_NAME" UniqueName="COMPANY_NAME" AutoPostBackOnFilter="true" FilterControlWidth="60px"> 
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ACCESS_BY" FilterControlAltText="Filter ACCESS_BY column" HeaderText="ACCESS BY" SortExpression="ACCESS_BY" UniqueName="ACCESS_BY" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ALL_RECORDS" FilterControlAltText="Filter ALL_RECORDS column" HeaderText="ALL RECORDS" SortExpression="ALL_RECORDS" UniqueName="ALL_RECORDS" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QUESTION" FilterControlAltText="Filter QUESTION column" HeaderText="Security Question" SortExpression="QUESTION" UniqueName="QUESTION" ReadOnly="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ANSWER" FilterControlAltText="Filter ANSWER column" HeaderText="Security Answer" SortExpression="ANSWER" UniqueName="ANSWER" ReadOnly="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="IS_ADMIN" FilterControlAltText="Filter IS_ADMIN column" HeaderText="Is Admin" SortExpression="IS_ADMIN" UniqueName="IS_ADMIN" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                          
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                            <PopUpSettings Modal="True" />
                        </EditFormSettings>
                    </MasterTableView>
                     <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsUsersTableAdapters.VIEW_USERSTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" OnSelecting="itemsDataSource_Selecting" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_USER_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFilter" DefaultValue="%" Name="USER_NAME" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="EMP_CODE" Type="String" />
            <asp:Parameter Name="DISABLED" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="IS_ADMIN" Type="String" />
            <asp:Parameter Name="DESIGNATION" Type="String" />
            <asp:Parameter Name="COMPANY_NAME" Type="String" />
            <asp:Parameter Name="ACCESS_BY" Type="String" />
            <asp:Parameter Name="ALL_RECORDS" Type="String" />
            <asp:Parameter Name="Original_USER_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>
