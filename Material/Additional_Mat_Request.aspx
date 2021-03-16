<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat_Request.aspx.cs" Inherits="Erection_MatIssueLoose" Title="Additional Mat Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script type="text/javascript">
            //<![CDATA[

            function upload_pdf() {
                try {
                    var id = $find("<%=IssueGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("ADD_ISSUE_REQ_ID");
                    radopen("../Common/FileImport.aspx?TYPE_ID=15&REF_ID=" + id, "RadWindow2", 650, 450);
                }
                catch (err) {
                    txt = "Select any Transmittal!";
                    alert(txt);
                }
            }

            function RefreshParent(sender, eventArgs) {
                location.href = location.href;
         }
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= IssueGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            //var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - divFooterButton - 70 + "px";
            //grid.get_element().style.width = width - 5 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
}
            //]]>
        </script>

<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New MIV Request" Width="150" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPipeRemain" runat="server" Text="Remain" Width="80" OnClick="btnPipeRemain_Click" Visible="false"></telerik:RadButton>
                </td>
                <%--    <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>--%>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Items" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddReports" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Value="11" Text="Bulk Material Report" Selected="true" />
                            <telerik:DropDownListItem Value="12" Text="Use Remains Report" />
                            <%-- <telerik:DropDownListItem Value="12.1" Text="Bill of Materials Report" />--%>
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="True" EmptyMessage="Search Here"
                        OnTextChanged="txtSearch_TextChanged" Width="200px" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="issueDataSource" PageSize="50" Width="100%"  AllowFilteringByColumn="true"
            OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="IssueGridView_DataBound" AllowSorting="true" OnItemDataBound="IssueGridView_ItemDataBound"
            DataKeyNames="ADD_ISSUE_REQ_ID" OnItemCommand="IssueGridView_ItemCommand" OnDataBinding="IssueGridView_DataBinding">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>

            <MasterTableView EditMode="InPlace" DataKeyNames="ADD_ISSUE_REQ_ID" AllowMultiColumnSorting="true" ClientDataKeyNames="ADD_ISSUE_REQ_ID" PagerStyle-AlwaysVisible="true">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                      <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow">
                              
                          <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>

                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="PDF">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="DISCILINE" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditDiscipline" runat="server" DataSourceID="sqlDisciplineSource" DataTextField="DISCIPLINE"
                                DataValueField="DISCIPLINE_ID" SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabelMatdiscipline" runat="server" Text='<%# Bind("DISCIPLINE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ISSUE_REQ_NO" HeaderText="ISSUE REQUEST NO" SortExpression="ISSUE_REQ_NO" FilterControlWidth="80px" ReadOnly="true" AutoPostBackOnFilter="true">
                       <%-- <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ISSUE_NO") %>' Width="96px"></asp:TextBox>
                        </EditItemTemplate>--%>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ISSUE_REQ_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px"/>
                        <HeaderStyle Width="150px"/>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="REFERENCE_NO" HeaderText="REFERENCE NO" SortExpression="REFERENCE_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBoxMatScope" runat="server" Text='<%# Bind("REFERENCE_NO") %>' Width="100px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabelMatScope" runat="server" Text='<%# Bind("REFERENCE_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="REQUEST_DATE" HeaderText="REQUEST DATE" SortExpression="REQUEST_DATE" AllowFiltering="false" ReadOnly="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("REQUEST_DATE", "{0:dd-MMM-yyyy}") %>'
                                Width="93px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("REQUEST_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="REQUEST_BY" HeaderText="REQUEST BY" SortExpression="REQUEST_BY" ItemStyle-Width="60px" AllowFiltering="false" ReadOnly="true">
                     <%--   <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ISSUE_BY") %>' Width="88px"></asp:TextBox>
                        </EditItemTemplate>--%>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("REQUEST_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="SUB_CON_NAME" HeaderText="SUBCON" SortExpression="SUB_CON_NAME" FilterControlWidth="60px" ReadOnly="true" AutoPostBackOnFilter="true">
                       <%-- <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                Width="97px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>--%>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="CATEGORY" HeaderText="CATEGORY" SortExpression="CATEGORY" FilterControlWidth="60px" ReadOnly="true" AutoPostBackOnFilter="true">
                       <%-- <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="catDataSource"
                                DataTextField="CATEGORY" DataValueField="CAT_ID" SelectedValue='<%# Bind("CAT_ID") %>'
                                Width="104px">
                            </asp:DropDownList>
                        </EditItemTemplate>--%>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("CATEGORY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="STORE" HeaderText="STORE" SortExpression="STORE_NAME" AllowFiltering="false" ReadOnly="true">
                        <%--<EditItemTemplate>
                            <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                Width="102px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>--%>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" 
                        SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("REMARKS") %>' Width="161px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro;" id="divFooterHeight">
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
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE PROJ_ID = :PROJECT_ID
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.PIP_MAT_ISSUE_ADD_REQUESTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />          
            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="REFERENCE_NO" Type="String" />
            <asp:Parameter Name="original_ADD_ISSUE_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"  Type="String" />
                <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CATEGORY" FROM "PIP_MAT_ISSUE_ADD_CAT"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDisciplineSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID 
FROM DISCIPLINE_DEF
ORDER BY DISCIPLINE"></asp:SqlDataSource>
</asp:Content>
