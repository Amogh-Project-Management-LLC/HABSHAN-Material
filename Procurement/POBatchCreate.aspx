<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POBatchCreate.aspx.cs" Inherits="Procurement_POBatchCreate" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            background-color: whitesmoke;
            width: 180px;
            padding-left: 5px
        }
    </style>
    <div style="background-color: whitesmoke">
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                    <tr>
                        <td class="Heading">PO Number</td>
                        <td>

                            <telerik:RadComboBox ID="ddlPOList" runat="server" DataSourceID="sqlPOSource" DataTextField="PO_NO" AllowCustomText="true" Filter="Contains" DataValueField="PO_ID" Width="200px"
                                OnDataBinding="ddlPOList_DataBinding" OnSelectedIndexChanged="ddlPOList_SelectedIndexChanged" AutoPostBack="true">
                            </telerik:RadComboBox>
                        </td>
                         <td class="Heading">Create Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Batch No</td>
                        <td>
                            <telerik:RadTextBox ID="txtBatchNo" runat="server" EmptyMessage="Batch No.." Width="200px" >
                            </telerik:RadTextBox>
                        </td>
                         <td class="Heading">Create By </td>
                        <td>
                            <telerik:RadTextBox ID="txtCreateBy" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                         <td class="Heading">Status</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlStatus" runat="server" Enabled="false">
                                <Items>
                                    <telerik:DropDownListItem Text="Pending" Value="Pending" Selected="true" />
                                    <telerik:DropDownListItem Text="Approved" Value="Approved" />
                                    <telerik:DropDownListItem Text="Rejected" Value="Rejected" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
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
                            <telerik:RadButton ID="btnSave" runat="server" Text="Create Batch" Width="150px" OnClick="btnSave_Click">
                                <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="sqlPOSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO
                        ORDER BY PO_NO"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div>
                <table>
                    <tr>
                        <td colspan="6" style="align-items:center"><telerik:RadLabel runat="server" Text="Batch Revision" Font-Size="Larger" Font-Bold="true"></telerik:RadLabel></td>
                    </tr>
                    <tr>
                        <td class="Heading" style="display:none;">Batch Number</td>
                        <td style="display:none;">
                            <telerik:RadTextBox runat="server" ID="txtRevBatchNo"></telerik:RadTextBox>
                        </td>
                        <td class="Heading">Rev No</td>
                        <td>
                            <telerik:RadTextBox ID="txtRevNo" runat="server" EmptyMessage="Revision No.." Width="150px" ReadOnly="true"></telerik:RadTextBox>
                        </td>
                        <td class="Heading">Rev Create Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtRevCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>

                    </tr>
                    <tr>
                        <td class="Heading"  style="display:none;">PIM Initial</td>
                        <td  style="display:none;">
                            <telerik:RadDatePicker ID="txtPIMInitial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">PIM Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtPIMForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">PIM Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtPIMActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr style="display:none;"> 
                        <td class="Heading">Manufacturer Initial</td>
                        <td>
                            <telerik:RadDatePicker ID="txtManuIntial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Manufacturer Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtManuForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Manufacturer Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtManuActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td   style="display:none;">
                            <telerik:RadLabel Text="FAT Initial" runat="server"></telerik:RadLabel>
                        </td>
                        <td  style="display:none;">
                            <telerik:RadDatePicker ID="txtFATInitial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">FAT Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtFATForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">FAT Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtFATActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td  style="display:none;">
                            <telerik:RadLabel Text="Received Ex-Works Initial" runat="server">
                            </telerik:RadLabel>
                        </td>
                        <td  style="display:none;">
                            <telerik:RadDatePicker ID="txtReceivedExworksInitial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Ex-Works Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedExworksForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Ex-Works Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedExworksActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td  style="display:none;">
                            <telerik:RadLabel Text="Received Port Initial" runat="server">
                            </telerik:RadLabel>
                        </td>
                        <td  style="display:none;">
                            <telerik:RadDatePicker ID="txtReceivedPortInitial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Port Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedPortForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Port Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedPortActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr  style="display:none;">
                        <td class="Heading">Received Site Initial</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedSiteInitial" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Site Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedSiteForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Received Site Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtReceivedSiteActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td  style="display:none;">                            
                            <telerik:RadLabel Text="Delivery Site Base" runat="server">
                            </telerik:RadLabel>
                        </td>
                        <td  style="display:none;">
                            <telerik:RadDatePicker ID="txtDeliveryBase" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Delivery Site Forecast</td>
                        <td>
                            <telerik:RadDatePicker ID="txtDeliveryForecast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="Heading">Delivery Site Actual</td>
                        <td>
                            <telerik:RadDatePicker ID="txtDeliveryActual" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                         <td class="Heading">Revison Status</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlRevStatus" runat="server" Enabled="false">
                                <Items>
                                    <telerik:DropDownListItem Text="Pending" Value="Pending" Selected="true" />
                                    <telerik:DropDownListItem Text="Approved" Value="Approved" />
                                    <telerik:DropDownListItem Text="Rejected" Value="Rejected" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                        <td class="Heading" colspan="1">Reason For Revision</td>
                        <td colspan="3">
                            <telerik:RadTextBox ID="txtRevRemarks" runat="server" EmptyMessage="Remarks..." Width="300px"
                                TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnNewRevision" runat="server" Text="Create Revision" Width="180px" OnClick="btnNewRevision_Click">
                                <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO
                        ORDER BY PO_NO"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

