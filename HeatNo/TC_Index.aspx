<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_Index.aspx.cs" Inherits="HeatNo_TC_Index" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function upload_pdf() {
            try {
                radopen("../Common/MTCFileImport.aspx", "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
                alert(txt);
            }
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
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }

        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= tcGridView.ClientID %>')
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

        function show_mtc_pdf() {
            try {
                var id = $find("<%=tcGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("TC_ID");
                radopen("ShowMTC_PDF.aspx?TC_ID=" + id, "RadWindow4", 650, 550);
            }
            catch (err) {
                txt = "Select any Isometric!";
                alert(txt);
            }
        }
    </script>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnAddTC" runat="server" Text="New TC" Width="80" OnClick="btnAddTC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDetails" runat="server" Text="Details" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
                </td>
                  <td>
                    <telerik:RadButton ID="btnMTCHeatnos" runat="server" Text="Heat Nos" Width="80" OnClick="btnMTCHeatnos_Click"></telerik:RadButton>
                </td>

                <td>
                    <%--<telerik:RadButton ID="btnShowPDF" runat="server" Text="PDF" Width="80" oncli></telerik:RadButton>--%>
                    <asp:LinkButton ID="linkPDF" runat="server" OnClientClick="show_mtc_pdf(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton runat="server" ID="btnShowPDF" Width="80px" Text="PDF"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpload" runat="server" Text="Upload PDF" Width="100" OnClick="btnUpload_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtFilter" runat="server" OnTextChanged="txtFilter_TextChanged"
                        EmptyMessage="Search Here" Width="160px" AutoPostBack="true" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px" Visible="false">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="tcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="tcDataSource" DataKeyNames="TC_ID" SkinID="GridViewSkin" PageSize="50" PagerStyle-AlwaysVisible="true"
            Width="100%" OnRowEditing="tcGridView_RowEditing" OnDataBound="tcGridView_DataBound"  onkeypress="handleSpace(event)"
            OnSelectedIndexChanged="tcGridView_SelectedIndexChanged" OnItemCommand="tcGridView_ItemCommand" OnDataBinding="tcGridView_DataBinding" OnItemDataBound="tcGridView_ItemDataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="TC_ID" DataSourceID="tcDataSource" AllowFilteringByColumn="true"
                AllowMultiColumnSorting="true" ClientDataKeyNames="TC_ID" EditMode="InPlace">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">

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
                    <telerik:GridBoundColumn DataField="TC_CODE" FilterControlAltText="Filter TC_CODE column" HeaderText="TC NUMBER"
                        SortExpression="TC_CODE" UniqueName="TC_CODE" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER"
                        SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="true" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="220px" />
                        <HeaderStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>

                    <%--<telerik:GridTemplateColumn HeaderText="TC Number" SortExpression="TC_CODE" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TC_CODE") %>' Width="101px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("TC_CODE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>--%>
                    <%--<telerik:GridTemplateColumn HeaderText="PO Number" SortExpression="PO_NO">
                        <EditItemTemplate>
                            <asp:DropDownList ID="poDropDownList" runat="server" AppendDataBoundItems="True"
                                DataSourceID="poDataSource" DataTextField="PO_NO" DataValueField="PO_ID" Font-Size="90%"
                                SelectedValue='<%# Bind("PO_ID") %>' Width="210px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("PO_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>--%>
                    <%--<telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox1" runat="server" Text='<%# Bind("REMARKS") %>'></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label3" runat="server" Text='<%# Bind("REMARKS") %>'></telerik:RadLabel>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="tcDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsGeneralTableAdapters.PIP_TEST_CARDSTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_TC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TC_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_TC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="poDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PO_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
