<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="ShipmentNew.aspx.cs" Inherits="Logistics_ShipmentNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            min-width:120px;
            background-color:whitesmoke;
            padding-left:5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">Ship No</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtShipNo" Width="120px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Ship Reference No</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtShipRefNo" Width="120px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Document Reference No</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtDocRefNo" Width="120px"></telerik:RadTextBox>
                </td>
                <td class="Heading">No of Pages</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtNoOfPages" Width="120px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Document Remarks</td>
                <td colspan="3">
                    <telerik:RadTextBox runat="server" ID="txtDocRemarks" Width="375px" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Transport Type</td>
                <td>
                    <telerik:RadDropDownList ID="ddlTransType" runat="server" Width="120">
                        <Items>
                            <telerik:DropDownListItem Text="(Select)" />
                            <telerik:DropDownListItem Text="BY AIR" Value="BY AIR" />
                            <telerik:DropDownListItem Text="BY SEA" Value="BY SEA" />
                            <telerik:DropDownListItem Text="BY LAND" Value="BY LAND" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                
            </tr>
            <tr>
                <td class="Heading">Cargo Type</td>
                <td colspan="3">
                    <telerik:RadDropDownList ID="ddlCargoType" runat="server" DataSourceID="sqlCargoType" Width="370px" AppendDataBoundItems="true" OnDataBinding="ddlCargoType_DataBinding"
                        DataTextField="CARGO_TYPE_DESC" DataValueField="CARGO_TYPE_ID" DropDownHeight="200px"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">Ship Consignor Name</td>
                <td colspan="3">
                    <telerik:RadTextBox runat="server" ID="txtShipConsignName" Width="240px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Container No</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtContainerNo" Width="120px"></telerik:RadTextBox>
                </td>
                <td class="Heading">Ship Contract</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtContract" Width="120px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Remarks</td>
                <td colspan="3">
                    <telerik:RadTextBox runat="server" ID="txtRemarks" Width="370px" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlCargoType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT CARGO_TYPE_ID, CARGO_TYPE_DESC
FROM PRC_CARGO_TYPES
ORDER BY CARGO_TYPE_CODE"></asp:SqlDataSource>
</asp:Content>

