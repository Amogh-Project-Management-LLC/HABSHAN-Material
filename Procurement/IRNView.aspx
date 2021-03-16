<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="IRNView.aspx.cs" Inherits="Procurement_IRNView" Title="IRNView" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--    <script type="text/javascript">
    $(function () {
          $("[id*=irnDate]").datepicker({
            showOn: 'button',
            buttonImageOnly: true,
            buttonImage: '../Images/calendar.gif'
        });
    });
</script>--%>
    <div style="background-color: whitesmoke;">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right; padding: 2px;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; text-align: right; padding: 2px;">
    </div>

    <div>
        <asp:DetailsView ID="irnDetailsView" runat="server" AllowPaging="True" AutoGenerateRows="False"
            DataKeyNames="IRN_ID" DataSourceID="IRNViewDataSource" SkinID="DetailsViewSkin"
            OnModeChanging="irnDetailsView_ModeChanging" Width="600px" OnDataBound="irnDetailsView_DataBound"
            OnPageIndexChanged="irnDetailsView_PageIndexChanged">
            <EmptyDataTemplate>
                No data Found!
            </EmptyDataTemplate>
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:CommandField ShowEditButton="True" ButtonType="Image"
                    CancelImageUrl="~/Images/icon-cancel.gif"
                    EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif"
                    UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="IRN_NO" HeaderText="IRN NO" SortExpression="IRN_NO" ReadOnly="true" />
                <asp:BoundField DataField="IRN_REV" HeaderText="IRN REV" SortExpression="IRN_REV" />
                <asp:TemplateField HeaderText="IRN DATE" HeaderStyle-Width="10%"  ItemStyle-Width="50px">
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="irnDate" runat="server" SelectedDate='<%# Bind("IRN_DATE") %>'></telerik:RadDatePicker>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IRN_DATE", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblIrndate" runat="server" Text='<%#Bind("IRN_DATE","{0:dd-MMM-yyyy}")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--  <asp:BoundField ApplyFormatInEditMode="True" DataField="IRN_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="IRN Date" HtmlEncode="False" SortExpression="IRN_DATE" />--%>
                <asp:TemplateField HeaderText="VENDOR TYPE" SortExpression="VENDOR_TYPE">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlVendorType" SelectedValue='<%# Bind("VENDOR_TYPE") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Vendor/Supplier" Value="Vendor/Supplier" />
                            <asp:ListItem Text="Subcontractor" Value="Subcontractor" />
                            <asp:ListItem Text="All" Value="All" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="vendorTypeLabel" runat="server" Text='<%# Eval("VENDOR_TYPE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="PO STATUS" SortExpression="PO_STATUS">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlPOStatus" SelectedValue='<%# Bind("PO_STATUS") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Complete" Value="Complete" />
                            <asp:ListItem Text="Incomplete" Value="Incomplete" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="POStatusLabel" runat="server" Text='<%# Eval("PO_STATUS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="VENDOR_NAME" HeaderText="VENDOR NAME" SortExpression="VENDOR_NAME" ReadOnly="true" />
                <asp:TemplateField HeaderText="VENDOR REPORT" SortExpression="IS_REPORT">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlVendorReport" SelectedValue='<%# Bind("IS_REPORT") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Y" Value="Y" />
                            <asp:ListItem Text="N" Value="N" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="VendorReportLabel" runat="server" Text='<%# Eval("IS_REPORT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="USER_NAME" HeaderText="USER NAME" SortExpression="USER_NAME" ReadOnly="true" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="Create Date" HtmlEncode="False" SortExpression="CREATE_DATE" ReadOnly="true" />
                <asp:BoundField DataField="PO_NO" HeaderText="PO NO" SortExpression="PO_NO" ReadOnly="true" />


                <asp:TemplateField HeaderText="IRN RESULT" SortExpression="IRN_RESULT">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlIRNResult" SelectedValue='<%# Bind("IRN_RESULT") %>'>
                            <asp:ListItem Text="(Select)" Value="" />
                            <asp:ListItem Text="Accepted" Value="Accepted" />
                            <asp:ListItem Text="Accepted With Condition" Value="Accepted With Condition" />
                            <asp:ListItem Text="Reject" Value="Reject" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="IRNResultLabel" runat="server" Text='<%# Eval("IRN_RESULT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="PO_CONTACT_NAME" HeaderText="PO CONTACT NAME" SortExpression="PO_CONTACT_NAME" />
                <asp:BoundField DataField="PO_CONTACT_EMAIL" HeaderText="PO CONTACT EMAIL" SortExpression="PO_CONTACT_EMAIL" />
                <asp:BoundField DataField="PO_CONTACT_PHONE" HeaderText="PO CONTACT PHONE" SortExpression="PO_CONTACT_PHONE" />
                <asp:BoundField DataField="VENDOR_CONTACT_NAME" HeaderText="VENDOR CONTACT NAME" SortExpression="VENDOR_CONTACT_NAME" />
                <asp:BoundField DataField="VENDOR_CONTACT_PHONE" HeaderText="VENDOR CONTACT PHONE" SortExpression="VENDOR_CONTACT_PHONE" />

                <asp:TemplateField HeaderText="DIS_CLIENT" SortExpression="DIS_CLIENT">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlDIS_CLIENT" SelectedValue='<%# Bind("DIS_CLIENT") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Y" Value="Y" />
                            <asp:ListItem Text="N" Value="N" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DIS_CLIENTlabel" runat="server" Text='<%# Eval("DIS_CLIENT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="DIS_SUPP" SortExpression="DIS_SUPP">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlDIS_SUPP" SelectedValue='<%# Bind("DIS_SUPP") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Y" Value="Y" />
                            <asp:ListItem Text="N" Value="N" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DIS_SUPPlabel" runat="server" Text='<%# Eval("DIS_SUPP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="DIS_SUBSUPP" SortExpression="DIS_SUBSUPP">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlDIS_SUBSUPP" SelectedValue='<%# Bind("DIS_SUBSUPP") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Y" Value="Y" />
                            <asp:ListItem Text="N" Value="N" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DIS_SUBSUPPlabel" runat="server" Text='<%# Eval("DIS_SUBSUPP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="DIS_SUBCON" SortExpression="DIS_SUBCON">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlDIS_SUBCON" SelectedValue='<%# Bind("DIS_SUBCON") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Y" Value="Y" />
                            <asp:ListItem Text="N" Value="N" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DIS_SUBCONlabel" runat="server" Text='<%# Eval("DIS_SUBCON") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- <asp:BoundField DataField="DIS_CLIENT" HeaderText="DIS CLIENT" SortExpression="DIS_CLIENT" />
                <asp:BoundField DataField="DIS_SUPP" HeaderText="DIS SUPP" SortExpression="DIS_SUPP" />
                <asp:BoundField DataField="DIS_SUBSUPP" HeaderText="DIS SUBSUPP" SortExpression="DIS_SUBSUPP" />
                <asp:BoundField DataField="DIS_SUBCON" HeaderText="DIS SUBCON" SortExpression="DIS_SUBCON" />--%>
                <asp:BoundField DataField="PREPARED_BY" HeaderText="PREPARED BY" SortExpression="PREPARED_BY" />
                <asp:BoundField DataField="REVIEWED_BY" HeaderText="REVIEWED_BY" SortExpression="REVIEWED_BY" />
                <asp:BoundField DataField="APPROVED_BY" HeaderText="APPROVED BY" SortExpression="APPROVED BY" />
                <asp:TemplateField HeaderText="REMARKS" SortExpression="REMARKS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REMARKS") %>' Width="98%"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
    </div>
    <%--<div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="80" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="80" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>--%>
    <asp:ObjectDataSource ID="IRNViewDataSource" runat="server" SelectMethod="GetData" TypeName="Procurement_BTableAdapters.PIP_PO_IRNTableAdapter"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="IRN_ID" QueryStringField="IRN_ID" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_IRN_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="IRN_REV" Type="String" />
            <asp:Parameter Name="IRN_DATE" Type="DateTime" />
            <asp:Parameter Name="VENDOR_TYPE" Type="String" />
            <asp:Parameter Name="PO_STATUS" Type="String" />
            <asp:Parameter Name="IS_REPORT" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />

            <asp:Parameter Name="IRN_RESULT" Type="String" />

            <asp:Parameter Name="PO_CONTACT_NAME" Type="String" />
            <asp:Parameter Name="PO_CONTACT_EMAIL" Type="String" />
            <asp:Parameter Name="PO_CONTACT_PHONE" Type="String" />
            <asp:Parameter Name="VENDOR_CONTACT_NAME" Type="String" />
            <asp:Parameter Name="VENDOR_CONTACT_PHONE" Type="String" />
            <asp:Parameter Name="DIS_CLIENT" Type="String" />
            <asp:Parameter Name="DIS_SUPP" Type="String" />
            <asp:Parameter Name="DIS_SUBSUPP" Type="String" />
            <asp:Parameter Name="DIS_SUBCON" Type="String" />
            <asp:Parameter Name="PREPARED_BY" Type="String" />
            <asp:Parameter Name="REVIEWED_BY" Type="String" />
            <asp:Parameter Name="APPROVED_BY" Type="String" />
            <asp:Parameter Name="original_IRN_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <%-- <asp:SqlDataSource ID="markerDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MARKER_ID, UPPER(MARKER_NAME) AS MARKER_NAME FROM DWG_MARKER WHERE PROJECT_ID = :PROJECT_ID ORDER BY MARKER_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sguserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SG_USER_ID, UPPER(USER_NAME) AS USER_NAME FROM SG_USERS WHERE PROJECT_ID = :PROJECT_ID ORDER BY USER_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="statusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STATUS_ID, STATUS_CODE FROM ISOME_STATUS ORDER BY ISOME_STATUS.STATUS_CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sgtypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIP_SG_TYPE.SG_TYPE, PIP_SG_TYPE.DESCR FROM PIP_SG_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DIR_ID, DIR_OBJ FROM DIR_OBJECTS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY DIR_OBJ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlBackCheck" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT upper(USER_NAME) as USER_NAME
FROM USERS
ORDER BY USER_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHoldType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM HOLD_REQUEST_TYPE ORDER BY TYPE_NAME"></asp:SqlDataSource>
    --<asp:HiddenField ID="YesNoStatusHiddenField" runat="server" />
    --%>
</asp:Content>
