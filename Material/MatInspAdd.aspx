<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatInspAdd.aspx.cs" Inherits="Material_MatInspAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Title {
            width: 120px;
            padding-left: 10px;
            background-color:whitesmoke
        }

        .RightTitle {
            width: 120px;
            padding-left: 20px;
            background-color:whitesmoke
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                    <tr>
                        <td class="Title">Contractor/Subcontractor</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlSubcon" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlSrcSubcon" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBinding="ddlSubcon_DataBinding" OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged"></telerik:RadDropDownList>
                        </td>
                         <td class="Title">MRIR No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtMIRNo" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                         <td class="Title">Received At Store</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlStoreList" runat="server" Width="200px" DataSourceID="sqlSrcStore" DataTextField="STORE_NAME" DataValueField="STORE_ID"  AppendDataBoundItems="true" OnDataBinding="ddlStoreList_DataBinding"></telerik:RadDropDownList>
                        </td>
                        <td class="Title">Client Report No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtClientMIRNo" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Inspection Date</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtInspDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"></telerik:RadDatePicker>
                        </td>
                        <td class="RightTitle">Received Date</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtRecvdDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">RFI No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtAutoRFINo" runat="server" DataSourceID="sqlRFINumber" DataTextField="RFI_NO" 
                                DataValueField="RFI_ID" EmptyMessage="Type RFI Number....." InputType="Text" OnTextChanged="txtAutoRFINo_TextChanged"
                                Width="200px">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                        <td class="RightTitle">Received By</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtRcvBy" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">MRR No</td>
                        <td></td>
                        <td>
                            <telerik:RadDropDownList ID="ddlMRVList" runat="server" Width="200px" DataSourceID="sqlSrcMRV" 
                                DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlMRVList_SelectedIndexChanged"
                                OnDataBinding="ddlMRVList_DataBinding" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                         <td class="RightTitle" rowspan="2">IRN Number</td>
                        <td>:</td>
                        <td rowspan="2">
                            <telerik:RadTextBox ID="txtSRNNumber" runat="server" Width="200px" Enabled="false" TextMode="MultiLine" Rows="3"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">PO Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtPOSearch" EmptyMessage="Search PO Number" runat="server" Width="200px" AutoPostBack="True" Enabled="false"></telerik:RadTextBox>
                        </td>
                       
                    </tr>
                    <tr>
                        <td class="Title"></td>
                        <td></td>
                        <td>
                            <telerik:RadDropDownList ID="ddlPOList" runat="server" Width="200px" DataSourceID="sqlSrcPO" DataTextField="PO_NO" DataValueField="PO_ID" 
                                AppendDataBoundItems="True" OnDataBinding="ddlPOList_DataBinding" Enabled="false"></telerik:RadDropDownList>
                        </td>
                        <td class="RightTitle">Ship Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtShipNumber" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                      
                        <td class="Title">Shipment Mode</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtShipMode" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Invoice Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtInvoiceNo" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                        <td class="RightTitle">Packing List No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtPackingList" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Supplier/Vendor</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtSupplier" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                        </td>
                       <%-- <td class="RightTitle">AWB/BL/TWB No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtAWBBLTWB" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>--%>
                    </tr>
                    <tr>
                        <td class="Title">Remarks</td>
                        <td>:</td>
                        <td colspan="4">
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="550px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td colspan="4">
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>
                            <telerik:RadButton ID="btnReset" runat="server" Text="Reset" Width="100px"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="sqlSrcSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcMRV" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE MAT_RCV_ID = :MAT_RCV_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenMRVID" DefaultValue="-1" Name="MAT_RCV_ID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcPO" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO WHERE PO_NO LIKE FNC_FILTER(:FILTER) AND PROJECT_ID = :PROJECT_ID ORDER BY PO_NO ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" />
                    <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcStore" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM STORES_DEF WHERE SC_ID = :SC_ID ORDER BY STORE_NAME">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlRFINumber" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT RFI_ID, RFI_NO 
                                    FROM VIEW_BALANCE_RFI 
                                    WHERE STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID = :SC_ID) ORDER BY RFI_NO ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenMRVID" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>

