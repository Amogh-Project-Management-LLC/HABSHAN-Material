<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SubContractors.aspx.cs" Inherits="Home_SubContractors" Title="Sub-Contractors" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= PipingSpecGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	   // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
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
         function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= PipingSpecGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
     <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color:whitesmoke" id="HeaderButtons">
        <table style="width: 100%;">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click" CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server"  Visible="false" Text="Save" Width="80px" OnClick="btnSave_Click" />
                        </td>
                        <td style="width: 100%" align="right" >
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                                Width="137px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
    </div>
    
                <table style="width: 100%" runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">
                            Subcon ID
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconID" runat="server" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconIdValidator" runat="server" ControlToValidate="txtSubconID"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">
                            Subcon Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconName" runat="server" Width="160px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconNameValidator" runat="server" ControlToValidate="txtSubconName"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">
                            Short Code
                        </td>
                        <td>
                            <asp:TextBox ID="txtShortCode" runat="server" Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="shortCodeValidator" runat="server" ControlToValidate="txtShortCode"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">
                            Field Subcon
                        </td>
                        <td>
                            <asp:DropDownList ID="ddFieldSC" runat="server" Width="80px">
                                <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                <asp:ListItem Value="N" Text="No" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">
                            Fabrication Subcon
                        </td>
                        <td>
                            <asp:DropDownList ID="ddShopSC" runat="server" Width="80px">
                                <asp:ListItem Value="Y" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="N" Text="No"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            
 <div>      
                <telerik:RadGrid ID="PipingSpecGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="matTypeDataSource" PageSize="50" onkeypress="handleSpace(event)"
                     EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true" 
                     DataKeyNames="SUB_CON_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
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
                  <MasterTableView DataSourceID="matTypeDataSource" DataKeyNames="SUB_CON_ID" EditMode="InPlace" TableLayout="Fixed">
                      <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                           <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                           <HeaderStyle Width="35px" />
                       </telerik:GridButtonColumn>
                       
                        <telerik:GridBoundColumn DataField="SUB_CON_ID" HeaderText="SUBCON ID" SortExpression="SUB_CON_ID" ReadOnly="true" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                            <ItemStyle Width="100px" />
                           <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="SUBCON NAME" SortExpression="SUB_CON_NAME" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                            <ItemStyle Width="200px" />
                           <HeaderStyle Width="200px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="SHORT NAME" SortExpression="SHORT_NAME" FilterControlWidth="100px" AutoPostBackOnFilter="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SHORT_NAME") %>' ></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("SHORT_NAME") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="150px" />
                           <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="FIELD SC" SortExpression="FIELD_SC" FilterControlWidth="100px" AutoPostBackOnFilter="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FIELD_SC") %>' ></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("FIELD_SC") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="120px" />
                           <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="FAB SC" SortExpression="FAB_SC" AllowFiltering="false">
                            <EditItemTemplate> 
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("FAB_SC") %>' Width="60px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("FAB_SC") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="120px" />
                           <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                             <ItemStyle Width="150px" />
                           <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                    </Columns>
                      </MasterTableView>
                   
                </telerik:RadGrid>
     </div>     
    <asp:ObjectDataSource ID="matTypeDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralATableAdapters.VIEW_SUB_CONTRACTORTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SUB_CON_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SUB_CON_NAME" Type="String" />
            <asp:Parameter Name="SHORT_NAME" Type="String" />
            <asp:Parameter Name="FIELD_SC" Type="String" />
            <asp:Parameter Name="FAB_SC" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_SUB_CON_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
