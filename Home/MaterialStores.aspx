<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStores.aspx.cs" Inherits="Material_Stores" Title="Stores" %>

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
    <div style="background-color:whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server"   Text="Back" Width="80px" OnClick="btnBack_Click" />
        <telerik:RadButton ID="btnSubstore" runat="server"  OnClick="btnSubstore_Click" Text="Substores" Width="85px" />
        <telerik:RadButton ID="btnRegister" runat="server"  OnClick="btnRegister_Click" Text="Register" Width="85px"/>        
    </div>
    <div style="margin-top:3px">
        <telerik:RadGrid ID="storeGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                    DataSourceID="StoreDataSource" AllowPaging="True" Width="100%" DataKeyNames="STORE_ID"  onkeypress="handleSpace(event)"
                    OnRowUpdating="storeGridView_RowUpdating" OnRowEditing="storeGridView_RowEditing"
                    PageSize="50"  OnItemCommand="storeGridView_ItemCommand" OnDataBinding="storeGridView_DataBinding">
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="STORE_ID" TableLayout="Fixed" PagerStyle-AlwaysVisible="true">
                    <Columns>
                       <telerik:GridEditCommandColumn ButtonType="ImageButton">
                            <ItemStyle Width="35px" />
                           <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                           <HeaderStyle Width="35px" />
                   </telerik:GridButtonColumn>
                        <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="STORE NAME" SortExpression="STORE_NAME">
                            <ItemStyle Width="250px" />
                           <HeaderStyle Width="250px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JOB_CODE" HeaderText="JOB CODE" ReadOnly="True" SortExpression="JOB_CODE">
                            <ItemStyle Width="120px" />
                           <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="SUBCON NAME" SortExpression="SUB_CON_NAME">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                    Width="129px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="129px"></asp:Label>
                            </ItemTemplate>
                             <ItemStyle Width="200px" />
                           <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="LOCATION" HeaderText="LOCATION" SortExpression="LOCATION">
                             <ItemStyle Width="200px" />
                           <HeaderStyle Width="200px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS">
                        </telerik:GridBoundColumn>
                    </Columns>
                   
                        </MasterTableView>
                </telerik:RadGrid>
    </div>
    
   
    <asp:ObjectDataSource ID="StoreDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsMaterialATableAdapters.STORES_DEFTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_STORE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="STORE_NAME" Type="String" />
            <asp:Parameter Name="LOCATION" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_STORE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
