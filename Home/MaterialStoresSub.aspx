<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStoresSub.aspx.cs" Inherits="Material_StoresSub" Title="Substores" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= storeGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooterButton - divFooter - 50 + "px";
            //grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server"
                        Text="Back" Width="77px" OnClick="btnBack_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server"
                        Text="Entry" Width="80px" OnClick="btnEntry_Click" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div>
        <telerik:RadGrid ID="storeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CssClass="DataWebControlStyle" DataKeyNames="SUBSTORE_ID" DataSourceID="storeDataSource"
            OnRowEditing="storeGridView_RowEditing" PageSize="50" Width="100%">
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="SUBSTORE_ID" AllowAutomaticUpdates="true" TableLayout="Fixed" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="MAIN STORE" ReadOnly="True" SortExpression="STORE_NAME">
                         <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="SUB STORE" SortExpression="STORE_L1">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("STORE_L1") %>' Width="100px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("STORE_L1") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="LOCATION" SortExpression="LOCATION">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LOCATION") %>' Width="107px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>
    <div style="background-color: whitesmoke" id="divFooterHeight">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server"
                        Text="Delete" Width="78px" OnClick="btnDelete_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server"
                        Text="Yes" Width="39px" OnClick="btnYes_Click" EnableViewState="False" Visible="False" />
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server"
                        Text="No" Width="39px" EnableViewState="False" Visible="False" />
                </td>
                <td align="right" style="width: 100%">
                    <telerik:RadTextBox ID="txtStore" runat="server" Visible="False" Width="200px"
                        EmptyMessage="New Substore">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server"
                        Text="Submit" Width="84px" Visible="False" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="storeDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.PIP_STORE_SUBTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SUBSTORE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="STORE_L1" Type="String" />
            <asp:Parameter Name="LOCATION" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_SUBSTORE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="STORE_ID" QueryStringField="STORE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
