<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat_Request_Items.aspx.cs" Inherits="Erection_Additional_MatItems"
    Title="Additional Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    //var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
	    //grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
}
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div  id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Add Items" Width="100" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImportBarcode" runat="server" Text="Import Barcode" Width="120" OnClick="btnImportBarcode_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table id="EntryTable" runat="server" visible="false">

            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtMatCode" runat="server" EmptyMessage="Start typing Material Code.. " Width="250px"
                        DataSourceID="itemCodeSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" InputType="Text" AutoPostBack="true"
                        OnTextChanged="txtMatCode_TextChanged">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
           
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Item Description"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatDescr" runat="server" Width="400px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label8" runat="server" Text="Available Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtAvlQty" runat="server" Width="400px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>

            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="114px" AutoPostBack="True"></telerik:RadTextBox>
                   
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaintCode" runat="server" Width="114px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="Cable Drum No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCableDrumNo" runat="server" Width="110px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Issued Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="80px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticUpdates="true"
            DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO,CABLE_DRUM_NO" DataSourceID="itemsDataSource" SkinID="GridViewSkin" AllowSorting="true"
            OnDataBound="itemsGridView_DataBound" PageSize="50"  OnItemCommand="itemsGridView_ItemCommand" OnDataBinding="itemsGridView_DataBinding">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView  DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO,CABLE_DRUM_NO" EditMode="InPlace" AllowMultiColumnSorting="true" 
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                  <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn  ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                            <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                        </telerik:GridButtonColumn>

                
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1"
                        ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR"
                        ReadOnly="true">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" SortExpression="ITEM_NAM"
                        ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="SIZE" SortExpression="SIZE_DESC"
                        ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="THK" SortExpression="WALL_THK" AllowFiltering="false"
                        ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" HeaderText="UNIT" SortExpression="UOM_NAME"
                        ReadOnly="true">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="HEAT NO" SortExpression="HEAT_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="81px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                     <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="PAINT CODE" SortExpression="PAINT_CODE" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="ISSUE_QTY" HeaderText="ISSUED QTY" SortExpression="ISSUE_QTY" ReadOnly="true" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                    <%--<telerik:GridTemplateColumn HeaderText="ISSUED QTY" SortExpression="ISSUE_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ISSUE_QTY") %>' Width="57px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("ISSUE_QTY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridTemplateColumn>--%>
                   
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" >
                            <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.PIP_MAT_ISSUE_ADD_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
             <asp:Parameter Name="original_CABLE_DRUM_NO" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
           <%-- <asp:Parameter Name="ISSUE_QTY" Type="Decimal" />--%>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
            <asp:Parameter Name="original_CABLE_DRUM_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUED_ID" QueryStringField="ADD_ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="mrirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_RCV_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="itemCodeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1
FROM PIP_MAT_STOCK 
WHERE PROJ_ID= :PROJ_ID AND MAT_ID IN (SELECT MAT_ID FROM PIP_MAT_TRANSFER_RCV_DT)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sqlMaterialRequest" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_REQ_ID, MAT_REQ_NO
    FROM VIEW_MAT_REQ_ISSUE_BAL
    WHERE BAL_QTY &gt; 0 
    AND REQ_TO_STORE_ID IN (SELECT STORE_ID FROM PIP_MAT_ISSUE_ADD WHERE ADD_ISSUE_ID = :ADD_ISSUE_ID)
    AND MAT_ID IN (SELECT MAT_ID FROM PIP_MAT_STOCK WHERE MAT_CODE1 = :MAT_CODE1)">
<SelectParameters>
    <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUE_ID" QueryStringField="ADD_ISSUE_ID" />
    <asp:ControlParameter ControlID="txtMatCode" DefaultValue="-1" Name="MAT_CODE1" PropertyName="Text" />
</SelectParameters>
</asp:SqlDataSource>
</asp:Content>
