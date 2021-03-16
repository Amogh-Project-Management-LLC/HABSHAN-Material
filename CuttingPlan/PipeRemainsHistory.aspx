<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemainsHistory.aspx.cs" Inherits="CuttingPlan_PipeRemainsHistory"
    Title="Pipe Remain" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= historyGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	   // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - divFooterButton - 60 + "px";
	   //grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
}
    </script>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div style="margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="historyGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
                    DataKeyNames="USE_REM_ID" DataSourceID="historyDataSource" Width="100%">
                    <MasterTableView DataKeyNames="USE_REM_ID" AllowAutomaticUpdates="true" TableLayout="Fixed">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="MIV No" ReadOnly="true" SortExpression="ISSUE_NO">
                                 <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>                            
                            <telerik:GridTemplateColumn HeaderText="Used Date" SortExpression="USED_DATE">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("USED_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("USED_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </itemtemplate>
                                 <ItemStyle Width="110px" />
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="BOM_ITEM" HeaderText="BOM Item" ReadOnly="true" SortExpression="BOM_ITEM">
                                 <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Used Qty" SortExpression="USED_QTY">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("USED_QTY") %>' Width="60px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("USED_QTY") %>'></asp:Label>
                            </itemtemplate>
                                 <ItemStyle Width="90px" HorizontalAlign="Right" />
                                <HeaderStyle Width="90px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Allowance" SortExpression="CUT_ALW">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CUT_ALW") %>' Width="60px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("CUT_ALW") %>'></asp:Label>
                            </itemtemplate>
                                <ItemStyle Width="90px" HorizontalAlign="Right" />
                                <HeaderStyle Width="90px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Weld Gap" SortExpression="WELD_GAP">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("WELD_GAP") %>' Width="50px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("WELD_GAP") %>'></asp:Label>
                            </itemtemplate>
                                <ItemStyle Width="90px" HorizontalAlign="Right" />
                                <HeaderStyle Width="90px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Pipe Angle" SortExpression="PIPE_ANGLE">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("PIPE_ANGLE") %>' Width="50px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("PIPE_ANGLE") %>'></asp:Label>
                            </itemtemplate>
                                <ItemStyle Width="90px"/>
                                <HeaderStyle Width="90px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS">
                                
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div style="background-color: whitesmoke;" id="divFooterHeight">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click" CausesValidation="False"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" CausesValidation="False"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset" CausesValidation="False"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik" CausesValidation="False"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table runat="server" visible="false" id="EntryTable">
                    <tr>
                        <td style="width: 80px; background-color: gainsboro;">BOM Item
                        </td>
                        <td style="width: 190px">
                            <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True"
                                OnTextChanged="txtIsome_TextChanged" EmptyMessage="Spool Drawing" Width="180px">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboBOM" runat="server" DataSourceID="bomDataSource" DataTextField="BOM_ITEM"
                                DataValueField="BOM_ID" Width="441px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtQty" runat="server" EmptyMessage="Used Qty"
                                Width="70px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="historyDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsCuttingPlanTableAdapters.PIP_PIPE_REMAIN_USETableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_USE_REM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="USED_DATE" Type="DateTime" />
            <asp:Parameter Name="USED_QTY" Type="Decimal" />
            <asp:Parameter Name="CUT_ALW" Type="Decimal" />
            <asp:Parameter Name="WELD_GAP" Type="Decimal" />
            <asp:Parameter Name="PIPE_ANGLE" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_USE_REM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REM_ID" QueryStringField="REM_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM FROM VIEW_BOM_EREC_ITEM
WHERE (PROJ_ID = :PROJECT_ID) AND
(ISO_TITLE1 = :ISO) AND
(SPOOL LIKE 'SPL-%') AND
(MAT_ID = :MAT_ID)
ORDER BY BOM_ITEM">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="-1" Name="ISO" PropertyName="Text" />
            <asp:ControlParameter ControlID="matIdField" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="matIdField" runat="server" />
</asp:Content>
