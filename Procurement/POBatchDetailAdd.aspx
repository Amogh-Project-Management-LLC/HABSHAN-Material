<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POBatchDetailAdd.aspx.cs" Inherits="Procurement_POBatchDetailAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
        .Heading {
            background-color: whitesmoke;
            width: 120px;
            padding-left: 5px
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">PO Item</td>
                <td>
                    <telerik:RadTextBox ID="txtPOSearch" runat="server" EmptyMessage="Search PO Item...." Width="120px"
                         AutoPostBack="true"></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlPOItemList" runat="server" Width="200px" DataSourceID="sqlPOListSource" DataTextField="PO_ITEM" 
                        DataValueField="PO_ITEM_ID" AppendDataBoundItems="true" OnDataBinding="ddlPOItemList_DataBinding"
                        OnSelectedIndexChanged="ddlPOItemList_SelectedIndexChanged" AutoPostBack="true"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">PO Qty</td>
                <td>
                    <telerik:RadTextBox ID="txtPOQty" runat="server" EmptyMessage="PO Qty" Width="120px" Enabled="false"></telerik:RadTextBox>                    
                </td>
            </tr>
             <tr>
                <td class="Heading">Batch Qty</td>
                <td>
                    <telerik:RadTextBox ID="txtBatchQty" runat="server" EmptyMessage="Batch Qty" Width="120px"></telerik:RadTextBox>                    
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" EmptyMessage="Remarks..." Width="320px"
                        TextMode="MultiLine">
                    </telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Create" Width="100px" OnClick="btnSave_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sqlPOListSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_PO_BATCH_BAL
WHERE PO_ID = :PO_ID AND PO_ITEM LIKE FNC_FILTER(:FILTER)">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenPOID" DefaultValue="-1" Name="PO_ID" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenPOID" runat="server" />
    </div>
</asp:Content>

