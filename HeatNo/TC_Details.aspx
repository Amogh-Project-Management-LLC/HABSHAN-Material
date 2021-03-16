<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_Details.aspx.cs" Inherits="HeatNo_TC_HN" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= tcDetailsGridView.ClientID %>')
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
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke">MR Item
                </td>
                <td>
                    <asp:TextBox ID="txtMrItem" runat="server" Width="40px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="mrItemValidator" runat="server" ControlToValidate="txtMrItem"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">PO Item
                </td>
                <td>
                    <asp:TextBox ID="txtPoItem" runat="server" Width="40px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="poItemValidator" runat="server" ControlToValidate="txtPoItem" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Material Code
                </td>
                <td>
                    <asp:TextBox ID="txtItemCode" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeFieldValidator1" runat="server" ControlToValidate="txtItemCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Heat Number
                </td>
                <td>
                    <asp:TextBox ID="txtHeatNo" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="hnValidator2" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Quantity
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="tcDetailsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="tcDetailDataSource" AllowPaging="True" OnDataBound="tcDetailsGridView_DataBound" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
            PageSize="50" Width="100%" DataKeyNames="TC_ITEM_ID" onkeypress="handleSpace(event)">
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="TC_ITEM_ID" DataSourceID="tcDetailDataSource" AllowFilteringByColumn="true"
                AllowMultiColumnSorting="true" ClientDataKeyNames="TC_ITEM_ID" EditMode="InPlace" TableLayout="Fixed"
                PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                        ConfirmText="Are you sure you want to delete?" ConfirmTitle="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                   
                    <telerik:GridTemplateColumn HeaderText="MR Item" SortExpression="MR_ITEM" FilterControlWidth="40px">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox1" runat="server" Text='<%# Bind("MR_ITEM") %>' Width="49px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label1" runat="server" Text='<%# Bind("MR_ITEM") %>'></telerik:RadLabel>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Item" SortExpression="PO_ITEM" FilterControlWidth="40px">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox6" runat="server" Text='<%# Bind("PO_ITEM") %>' Width="39px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:Label>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TC_CODE" HeaderText="TC Code" ReadOnly="True" SortExpression="TC_CODE" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                        ReadOnly="True" FilterControlWidth="120px">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Heat Number" SortExpression="HEAT_NO" FilterControlWidth="100px">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox3" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="83px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label3" runat="server" Text='<%# Bind("HEAT_NO") %>'></telerik:RadLabel>
                        </ItemTemplate>
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Net Qty" SortExpression="NET_QTY" FilterControlWidth="50px">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox2" runat="server" Text='<%# Bind("NET_QTY") %>' Width="69px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label2" runat="server" Text='<%# Bind("NET_QTY") %>'></telerik:RadLabel>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" AllowFiltering="false">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox5" runat="server" Text='<%# Bind("REMARKS") %>'></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label5" runat="server" Text='<%# Bind("REMARKS") %>'></telerik:RadLabel>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="tcDetailDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralTableAdapters.PIP_TEST_CARDS_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TC_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="NET_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MR_ITEM" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_TC_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TC_ID" QueryStringField="TC_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
