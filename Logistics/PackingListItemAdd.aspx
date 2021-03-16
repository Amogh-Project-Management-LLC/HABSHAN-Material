<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PackingListItemAdd.aspx.cs" Inherits="Logistics_PackingListItemAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
        .TableStyle {
           width:120px;
           background-color:whitesmoke;           
           padding-left:5px;
        }
    </style>
   <table>
       <tr>
           <td class="TableStyle">
               Purchase Order
           </td>
           <td>
               <telerik:RadTextBox ID="txtPONo" runat="server" Width="150px" Enabled="false"></telerik:RadTextBox>
           </td>
       </tr>
         <tr>
           <td class="TableStyle">
               Search Item
           </td>
           <td>
               <telerik:RadTextBox ID="txtSearchItem" runat="server" Width="150px" EmptyMessage="Search Matcode.." AutoPostBack="true" OnTextChanged="txtSearchItem_TextChanged"></telerik:RadTextBox>
           </td>
             <td>
                 <telerik:RadDropDownList ID="ddlMatcode" runat="server" Width="200px" AutoPostBack="True" DataSourceID="sqlPOItemSource" DataTextField="MAT_ITEM" DataValueField="PO_ITEM">

                 </telerik:RadDropDownList>
             </td>
       </tr>
       <tr>
           <td>
               Select Split ID
           </td>
           <td colspan="2">
               <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlSplitItems" GridLines="Both" ShowFooter="true">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                   <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlSplitItems">
                       <Columns>
                          
                          <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                  <telerik:RadRadioButton runat="server" ID="radioSelectSplit" ></telerik:RadRadioButton>
                              </ItemTemplate>
                          </telerik:GridTemplateColumn>
                           <telerik:GridBoundColumn DataField="SPLIT_ID" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT_ID" SortExpression="SPLIT_ID" UniqueName="SPLIT_ID">
                           </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                           </telerik:GridBoundColumn>

                           <telerik:GridBoundColumn DataField="SPLIT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_QTY column" HeaderText="SPLIT_QTY" SortExpression="SPLIT_QTY" UniqueName="SPLIT_QTY">
                           </telerik:GridBoundColumn>
                           <telerik:GridBoundColumn DataField="SPLIT_EXTRA_QTY" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_EXTRA_QTY column" HeaderText="SPLIT_EXTRA_QTY" SortExpression="SPLIT_EXTRA_QTY" UniqueName="SPLIT_EXTRA_QTY">
                           </telerik:GridBoundColumn>
                           <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN_NO" SortExpression="IRN_NO" UniqueName="IRN_NO">
                           </telerik:GridBoundColumn>                       
                           <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="PKL No" SortExpression="SRN_NO" UniqueName="SRN_NO">
                           </telerik:GridBoundColumn>                          
                       </Columns>                      
                   </MasterTableView>
                   
               </telerik:RadGrid>
           </td>
       </tr>
   </table>

      <asp:SqlDataSource ID="sqlPOItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
          SelectCommand="SELECT PIP_PO_IRN_DETAIL.PO_ITEM, fnc_concat_a(PIP_PO_IRN_DETAIL.PO_ITEM, PIP_MAT_STOCK.MAT_CODE1) AS mat_item FROM PIP_PO_IRN_DETAIL, PIP_MAT_STOCK WHERE PIP_PO_IRN_DETAIL.MAT_ID = PIP_MAT_STOCK.MAT_ID AND (PIP_PO_IRN_DETAIL.IRN_ID = :irn_id) AND (fnc_concat_a(PIP_PO_IRN_DETAIL.PO_ITEM, PIP_MAT_STOCK.MAT_CODE1) LIKE FNC_FILTER(:filter))">
          <SelectParameters>
              <asp:ControlParameter ControlID="hiddenIRN_ID" DefaultValue="-1" Name="irn_id" PropertyName="Value" />
              <asp:ControlParameter ControlID="txtSearchItem" DefaultValue="XXX" Name="filter" PropertyName="Text" />
          </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenIRN_ID" runat="server" />
    <asp:ObjectDataSource ID="sqlSplitItems" runat="server" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsLogistics_ATableAdapters.VIEW_SPLIT_DETAILTableAdapter">
        <InsertParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="PO_ITEM_NO" Type="String" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="SPLIT_QTY" Type="Decimal" />
            <asp:Parameter Name="SPLIT_EXTRA_QTY" Type="Decimal" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatcode" DefaultValue="-1" Name="PO_ITEM_NO" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtPONo" DefaultValue="XX" Name="PO_NO" PropertyName="Text" Type="String" />
        </SelectParameters>

    </asp:ObjectDataSource>
</asp:Content>

