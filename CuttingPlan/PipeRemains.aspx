<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemains.aspx.cs" Inherits="CuttingPlan_PipeRemains" Title="Pipe Remains" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= remainGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	   // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooterButton - divFooter - 60 + "px";
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
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnHistory" runat="server" Text="History" Width="80" OnClick="btnHistory_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnResgister" runat="server" Text="New PR" Width="90" OnClick="btnResgister_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddIssued" runat="server" Text="Add Items" Width="90" OnClick="btnAddIssued_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"
                        EmptyMessage="Search Here" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="110px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="remainGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="REM_ID" DataSourceID="remainDataSource" SkinID="GridViewSkin"  AllowSorting="true"
            PageSize="50" Width="100%" onkeypress="handleSpace(event)"  OnDataBound="remainGridView_DataBound" OnItemCommand="remainGridView_ItemCommand" OnDataBinding="remainGridView_DataBinding">
            <ClientSettings >
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="REM_ID" EditMode="InPlace" AllowMultiColumnSorting="true" 
                AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
            <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton">
                    <ItemStyle Width="35px" />
                    <HeaderStyle Width="35px" />
                </telerik:GridEditCommandColumn>                
                           
                <telerik:GridBoundColumn DataField="REM_SERIAL" HeaderText="REMAIN SERIAL" ReadOnly="True"
                    SortExpression="REM_SERIAL">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="ISSUE NO" SortExpression="ISSUE_NO"
                    ReadOnly="True">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MAT CODE1" SortExpression="MAT_CODE1"
                    ReadOnly="True">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR"
                    ReadOnly="True">
                    <ItemStyle Width="300px" />
                    <HeaderStyle Width="300px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="SIZE" ReadOnly="True" SortExpression="SIZE_DESC">
                    <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UOM_NAME" HeaderText="UNIT" ReadOnly="True" SortExpression="UOM_NAME">
                    <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" ReadOnly="True" SortExpression="ITEM_NAM">
                    <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="WALL THK" ReadOnly="True" SortExpression="WALL_THK">
                <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />    
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="HEAT NO" SortExpression="HEAT_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="80px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="120px" />
                    <HeaderStyle Width="120px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="PS" SortExpression="PS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PS") %>' Width="40px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("PS") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="LENGTH" SortExpression="LENGTH">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("REM_LEN") %>' Width="60px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("REM_LEN") %>'></asp:Label>
                    </ItemTemplate>
                     <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="THETA" SortExpression="PIPE_THETA">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox344" runat="server" Text='<%# Bind("PIPE_THETA") %>' Width="40px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label444" runat="server" Text='<%# Eval("PIPE_THETA") %>'></asp:Label>
                    </ItemTemplate>
                     <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM">
                     <ItemStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="DISABLE" SortExpression="DISABLED">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDsbl" runat="server" Text='<%# Bind("DISABLED") %>' Width="30px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("DISABLED") %>'></asp:Label>
                    </ItemTemplate>
                     <ItemStyle Width="70px" />
                    <HeaderStyle Width="70px" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
            </Columns>
                </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
        </telerik:RadGrid>
    </div>

    <table style="width: 100%" id="divFooterHeight">
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="remainDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsCuttingPlanTableAdapters.PIP_PIPE_REMAINTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="PS" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REM_LEN" Type="Decimal" />
            <asp:Parameter Name="DISABLED" Type="String" />
            <asp:Parameter Name="PIPE_THETA" Type="Decimal" />
            <asp:Parameter Name="FAB_SHOP_ID" Type="Decimal" />
            <asp:Parameter Name="FAB_GROUP_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_REM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>