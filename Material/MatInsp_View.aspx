<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatInsp_View.aspx.cs" Inherits="Material_MatInsp_View" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:DetailsView ID="DetailsView1" runat="server" Width="500px" AutoGenerateRows="False" CellPadding="4"
        DataSourceID="objSrcMIR" ForeColor="#333333" GridLines="None" DataKeyNames="MIR_ID">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>

            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />

            <asp:BoundField DataField="SUB_CON_NAME" ReadOnly="true" HeaderStyle-Font-Bold="false" HeaderText="SUB_CON_NAME" SortExpression="SUB_CON_NAME">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="MIR_NO" HeaderStyle-Font-Bold="false" HeaderText="MIR_NO" SortExpression="MIR_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="PO_NO" ReadOnly="true" HeaderStyle-Font-Bold="false" HeaderText="PO_NO" SortExpression="PO_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:TemplateField HeaderText="INSP_DATE" SortExpression="INSP_DATE" HeaderStyle-Width="10%" ControlStyle-Width="100%">
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="txtEditInspDate" runat="server" SelectedDate='<%# Bind("INSP_DATE") %>'></telerik:RadDatePicker>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("INSP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("INSP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Font-Bold="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="CREATE_DATE" ReadOnly="true" HeaderStyle-Font-Bold="false" HeaderText="RECEIVE DATE" DataFormatString="{0:dd-MMM-yyyy}" SortExpression="CREATE_DATE">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="SRN_NO" HeaderStyle-Font-Bold="false" HeaderText="SRN_NO" SortExpression="SRN_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="SHIP_NO" HeaderStyle-Font-Bold="false" HeaderText="SHIP_NO" SortExpression="SHIP_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="SUPPLIER_VENDORNAME" HeaderStyle-Font-Bold="false" HeaderText="SUPPLIER_VENDORNAME" SortExpression="SUPPLIER_VENDORNAME">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="MODE_OF_SHIPMENT" HeaderStyle-Font-Bold="false" HeaderText="MODE_OF_SHIPMENT" SortExpression="MODE_OF_SHIPMENT">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="INVOICE_NO" HeaderStyle-Font-Bold="false" HeaderText="INVOICE_NO" SortExpression="INVOICE_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="PKG_LIST_NO" HeaderStyle-Font-Bold="false" HeaderText="PKG_LIST_NO" SortExpression="PKG_LIST_NO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="BL_AWB_TWBNO" HeaderStyle-Font-Bold="false" HeaderText="BL_AWB_TWBNO" SortExpression="BL_AWB_TWBNO">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="CREATE_BY" ReadOnly="true" HeaderStyle-Font-Bold="false" HeaderText="RECEIVE BY" SortExpression="CREATE_BY">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="MRV_NUMBER" ReadOnly="true" HeaderStyle-Font-Bold="false" HeaderText="MRV_NUMBER" SortExpression="MRV_NUMBER">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
            <asp:TemplateField HeaderText="STORE_NAME" SortExpression="STORE_NAME">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlStoreList" runat="server" DataSourceID="sqlStoreSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Font-Bold="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="REMARKS" HeaderStyle-Font-Bold="false" HeaderText="REMARKS" SortExpression="REMARKS">
                <HeaderStyle Font-Bold="False"></HeaderStyle>
            </asp:BoundField>
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>
    <asp:ObjectDataSource ID="objSrcMIR" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByMIR_ID" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter" UpdateMethod="UpdateQueryView">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MIR_NO" Type="String" />
            <asp:Parameter Name="INSP_DATE" Type="DateTime" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SRN_NO" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="MODE_OF_SHIPMENT" Type="String" />
            <asp:Parameter Name="INVOICE_NO" Type="String" />
            <asp:Parameter Name="PKG_LIST_NO" Type="String" />
            <asp:Parameter Name="BL_AWB_TWBNO" Type="String" />
            <asp:Parameter Name="SUPPLIER_VENDORNAME" Type="String" />
            <asp:Parameter Name="original_MIR_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM STORES_DEF WHERE SC_ID IN (SELECT MRIR_SC_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

