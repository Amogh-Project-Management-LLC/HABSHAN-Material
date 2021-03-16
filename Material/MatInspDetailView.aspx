<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetailView.aspx.cs" Inherits="Material_MatInspDetailView" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <asp:DetailsView ID="itemsdetailsView" runat="server" Width="600px" AutoGenerateRows="False" 
            CellPadding="4" DataSourceID="ObjItemSource" ForeColor="#333333" GridLines="None"
            DataKeyNames="MIR_ITEM_ID">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="False" Width="170px" />
            
            <Fields>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:TemplateField HeaderText="PO ITEM" SortExpression="PO_ITEM">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MIR ITEM" SortExpression="MIR_ITEM">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MIR_ITEM") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MIR_ITEM") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("MIR_ITEM") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="MAT_CODE1" HeaderText="ITEM CODE" SortExpression="MAT_CODE1" ReadOnly="True" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="ITEM SIZE" SortExpression="SIZE_DESC" ReadOnly="True" />
                <asp:BoundField DataField="ITEM_NAM" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" ReadOnly="True" />
                <asp:BoundField DataField="MAT_DESCR" HeaderText="ITEM DESCRIPTION" SortExpression="MAT_DESCR" ReadOnly="True" />
                <asp:TemplateField HeaderText="RECEIVE QTY" SortExpression="RCV_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RCV_QTY") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RCV_QTY") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("RCV_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ACCEPT QTY" SortExpression="ACPT_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ACPT_QTY") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ACPT_QTY") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("ACPT_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AS PER PL QTY" SortExpression="AS_PER_PL_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("AS_PER_PL_QTY") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("AS_PER_PL_QTY") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("AS_PER_PL_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="HEAT NO" SortExpression="HEAT_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PAINT SYSTEM" SortExpression="PAINT_SYS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("PAINT_SYS") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("PAINT_SYS") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("PAINT_SYS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UOM" HeaderText="UoM" SortExpression="UOM" ReadOnly="True" />
                <asp:TemplateField HeaderText="MTC CODE" SortExpression="TC_CODE">
                    <EditItemTemplate>                        
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sqlItemSource"
                             DataTextField="TC_CODE" DataValueField="TC_ID" SelectedValue='<%# Bind("TC_ID") %>'
                             AppendDataBoundItems="true" OnDataBinding="DropDownList1_DataBinding"></asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("TC_CODE") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("TC_CODE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SUB STORE / LOCATION" SortExpression="STORE_L1">
                    <EditItemTemplate>                       
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sqlStoreSource"
                             DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" SelectedValue='<%# Bind("SUBSTORE_ID") %>'
                            AppendDataBoundItems="true" OnDataBinding="DropDownList2_DataBinding"></asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("STORE_L1") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("STORE_L1") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TOTAL_WT" HeaderText="TOTAL WEIGHT" SortExpression="TOTAL_WT" ReadOnly="True" />
                <asp:TemplateField HeaderText="CE VALUE" SortExpression="CEVALUE">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("CEVALUE") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("CEVALUE") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("CEVALUE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="REMARKS" SortExpression="REMARKS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
    </div>
    <asp:ObjectDataSource ID="ObjItemSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIR_DTTableAdapter" UpdateMethod="UpdateQuery1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ITEM_ID" SessionField="popUp_MIR_ITEM_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RCV_QTY" Type="Decimal" />
            <asp:Parameter Name="ACPT_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PAINT_SYS" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="MIR_ITEM" Type="String" />
            <asp:Parameter Name="TOTAL_WT" Type="Decimal" />
            <asp:Parameter Name="TC_ID" Type="Decimal" />
            <asp:Parameter Name="AS_PER_PL_QTY" Type="Decimal" />
            <asp:Parameter Name="Original_MIR_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT tc_id, tc_code 
FROM pip_test_cards 
WHERE po_id IN (SELECT po_id FROM prc_mat_insp WHERE mir_id = :mir_id)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="mir_id" SessionField="popUp_MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUBSTORE_ID, STORE_L1   
FROM stores_sub
WHERE store_id IN (SELECT store_id 
                   FROM PRC_MAT_INSP
                   WHERE MIR_ID = :MIR_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

