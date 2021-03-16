<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POHeader.aspx.cs" Inherits="Procurement_POHeader" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:DetailsView ID="itemsView" runat="server" Height="50px" Width="600px" AutoGenerateRows="False" CellPadding="4" DataSourceID="itemsDataSource" 
            ForeColor="#333333" GridLines="None" DataKeyNames="PO_ID">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
          
            <FieldHeaderStyle BackColor="#DEE8F5" />
            <Fields>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="MR_NO" HeaderText="MR NO" SortExpression="MR_NO" ReadOnly="true" />
                <asp:BoundField DataField="PO_NO" HeaderText="PO NO" SortExpression="PO_NO" ReadOnly="true" />
                <asp:BoundField DataField="PO_TITLE" HeaderText="PO TITLE" SortExpression="PO_TITLE" />
                <asp:TemplateField HeaderText="PO DATE" SortExpression="PO_DATE">
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("PO_DATE") %>'>
                        </telerik:RadDatePicker>                     
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PO_DATE") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PO_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PO_REVISION" HeaderText="PO REVISION" SortExpression="PO_REVISION" />
                <asp:BoundField DataField="PO_DESTINATION" HeaderText="PO DESTINATION" SortExpression="PO_DESTINATION" />
                <asp:BoundField DataField="PO_SUBJECT" HeaderText="PO SUBJECT" SortExpression="PO_SUBJECT" />
                <asp:BoundField DataField="PO_CURR_CODE" HeaderText="PO CURRENCY CODE" SortExpression="PO_CURR_CODE" />
                <asp:TemplateField HeaderText="PO VENDOR NAME" SortExpression="PO_VEND_NAME">
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="ddlVendorList" runat="server" DataSourceID="sqlPOVendorCode"
                             DataTextField="VENDOR_NAME" DataValueField="VENDOR_CODE" SelectedValue='<%#Bind("PO_VEND_CODE") %>'
                            Width="300px" AppendDataBoundItems="true" OnDataBinding="ddlVendorList_DataBinding"></telerik:RadDropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PO_VEND_NAME") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PO_VEND_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PO_VEND_ADDR1" HeaderText="VENDOR ADDRESS 1" SortExpression="PO_VEND_ADDR1"  ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_ADDR2" HeaderText="VENDOR ADDRESS 2" SortExpression="PO_VEND_ADDR2" ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_ADDR3" HeaderText="VENDOR ADDRESS 3" SortExpression="PO_VEND_ADDR3" ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_AREA" HeaderText="VENDOR AREA" SortExpression="PO_VEND_AREA" ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_COUNTRY" HeaderText="VENDOR COUNTRY" SortExpression="PO_VEND_COUNTRY" ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_PHONE" HeaderText="VENDOR PHONE" SortExpression="PO_VEND_PHONE" ReadOnly="true"/>
                <asp:BoundField DataField="PO_VEND_FAX" HeaderText="VENDOR FAX" SortExpression="PO_VEND_FAX" ReadOnly="true"/>
                <asp:BoundField DataField="PO_CDD" HeaderText="PO CDD" SortExpression="PO_CDD" />
                <asp:BoundField DataField="PO_SHIP_TO_NAME"  HeaderText="SHIPMENT TO" SortExpression="PO_SHIP_TO_NAME" />
                <asp:BoundField HeaderText="SHIP TO ADDRESS 1" DataField="PO_SHIP_TO_ADDRS1" SortExpression="PO_SHIP_TO_ADDRS1" />
                <asp:BoundField HeaderText="SHIP TO ADDRESS 2" DataField="PO_SHIP_TO_ADDRS2" SortExpression="PO_SHIP_TO_ADDRS2" />
                <asp:BoundField HeaderText="SHIP TO ADDRESS 3" DataField="PO_SHIP_TO_ADDRS3" SortExpression="PO_SHIP_TO_ADDRS3" />
                <asp:BoundField HeaderText="SHIPMENT REMARKS" DataField="PO_SHIP_TO_REMARKS" SortExpression="PO_SHIP_TO_REMARKS" />
                <asp:BoundField HeaderText="PO DELIVERY POINT" DataField="PO_DELIVERY_POINT" SortExpression="PO_DELIVERY_POINT" />
                <asp:BoundField HeaderText="PO DELIVERY TERMS" DataField="PO_DELV_TERMS" SortExpression="PO_DELV_TERMS" />
            </Fields>
            <FooterStyle BackColor="#507CD1" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByPOID" TypeName="Procurement_CTableAdapters.VIEW_ADAPTER_POTableAdapter" UpdateMethod="UpdateQuery1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_TITLE" Type="String" />
            <asp:Parameter Name="PO_DATE" Type="DateTime" />
            <asp:Parameter Name="PO_REVISION" Type="String" />
            <asp:Parameter Name="PO_DESTINATION" Type="String" />
            <asp:Parameter Name="PO_SUBJECT" Type="String" />
            <asp:Parameter Name="PO_CURR_CODE" Type="String" />
            <asp:Parameter Name="PO_VEND_CODE" Type="String" />
            <asp:Parameter Name="PO_CDD" Type="DateTime" />
            <asp:Parameter Name="PO_SHIP_TO_NAME" Type="String" />
            <asp:Parameter Name="PO_SHIP_TO_ADDRS1" Type="String" />
            <asp:Parameter Name="PO_SHIP_TO_ADDRS2" Type="String" />
            <asp:Parameter Name="PO_SHIP_TO_ADDRS3" Type="String" />
            <asp:Parameter Name="PO_SHIP_TO_REMARKS" Type="String" />
            <asp:Parameter Name="PO_DELIVERY_POINT" Type="String" />
            <asp:Parameter Name="PO_DELV_TERMS" Type="String" />
            <asp:Parameter Name="original_PO_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlPOVendorCode" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VENDOR_CODE, VENDOR_NAME
FROM VENDOR_MASTER
ORDER BY VENDOR_NAME"></asp:SqlDataSource>
</asp:Content>

