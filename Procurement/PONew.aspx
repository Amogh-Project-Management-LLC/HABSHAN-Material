<%@ Page Title="Po New" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PONew.aspx.cs" Inherits="Procurement_PONew" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            width:140px;
            background-color:whitesmoke;
        }
    </style>
    
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
         <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click">            
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnSaveImport" Text="Save & Import MTO From MR" OnClick="btnSaveImport_Click" Visible="false">            
        </telerik:RadButton>
    </div>
    <div>
        <table>
            <tr>
                <td class="Heading">
                    Discipline 
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlDiscipline" runat="server" Width="250px" DataSourceID="sqldiscipline" DataTextField="DISCIPLINE" 
                        DataValueField="DISCIPLINE_ID" AppendDataBoundItems="true" OnDataBinding="ddlDiscipline_DataBinding" AutoPostBack="True" 
                        OnSelectedIndexChanged="ddlDiscipline_SelectedIndexChanged" CausesValidation="false"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    PO Work Type
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlWorkType" runat="server" Width="250px">
                        <Items>
                            <telerik:DropDownListItem Text="Pre Work" Value="Pre Work" />
                            <telerik:DropDownListItem Text="Main Work" Value="Main Work" />
                            <telerik:DropDownListItem Text="Main Work/Pre Work" Value="Main Work/Pre Work" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    MR Number 
                </td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtMRNumber" runat="server" DataSourceID="sqlMRSource" DataTextField="MR_NO" DataValueField="MR_ID" 
                        EmptyMessage="Start typing Material Requisition...." InputType="Text" Width="250px" AutoPostBack="True" OnEntryAdded="txtMRNumber_EntryAdded"
                        OnTextChanged="txtMRNumber_TextChanged">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    PO Number 
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPO" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    PO Subject 
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPOSubject" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    PO Date 
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtPODate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>            
                <td class="Heading">
                    PO Revision 
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPORev" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    PO CDD Date 
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCDDDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>            
            </tr>
              <tr>
                <td class="Heading">
                    PO Vendor 
                </td>
                <td>
                    <telerik:RadComboBox ID="cboVendorList" runat="server" DataSourceID="sqlVendorList" DataTextField="VENDOR_FULL_NAME" DataValueField="VENDOR_CODE" 
                        Filter="Contains" Width="250px" DropDownAutoWidth="Enabled" Height="100px"></telerik:RadComboBox>
                </td>
            </tr>
           
            <tr>
                <td class="Heading">
                    Shipment to (Name) :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipToName" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Shipment Address 1 :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipToAdd1" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Shipment Address 2 :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipToAdd2" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Shipment Address 3 :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipToAdd3" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Shipment Remarks :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipRemarks" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    PO Delivery Point :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPODelivery" runat="server" Width="200px" ></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Fill" ControlToValidate="txtPODelivery" 
                        ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Buyer :
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBuyer" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Expeditor :
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlExpeditor" runat="server" DataSourceID="sqlExpeditorsList" DataTextField="USER_NAME" DataValueField="USER_ID" 
                        Filter="Contains" Width="150px" DropDownAutoWidth="Enabled" Height="100px" ></telerik:RadComboBox>
                </td>

            </tr>
            <tr>
                <td class="Heading">
                    PO Delivery Terms :
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPOTerms" runat="server" DataSourceID="sqlPODelivery" DataTextField="PO_DEL_TERMS" DataValueField="PO_DEL_TERMS"
                         Width="300px" AppendDataBoundItems="true" OnDataBinding="ddlPOTerms_DataBinding" 
                        OnSelectedIndexChanged="ddlPOTerms_SelectedIndexChanged" AutoPostBack="true" DropDownAutoWidth="Enabled"></telerik:RadDropDownList>                    
                </td>
            </tr>
            <tr>
                <td></td>
                <td class="Heading">
                    <telerik:RadTextBox ID="txtPOTerms" runat="server" Width="300px" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqldiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE_ID, DISCIPLINE FROM DISCIPLINE_DEF ORDER BY DISCIPLINE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlVendorList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VENDOR_CODE, VENDOR_FULL_NAME
FROM VIEW_VENDOR_MASTER
ORDER BY VENDOR_CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPODelivery" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM PO_DELIVERY_TERMS ORDER BY PO_DEL_TERMS"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlMRSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MR_ID, MR_NO 
FROM PIP_MAT_REQUISITION
WHERE DISCIPLINE_ID = :DISCIPLINE_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDiscipline" DefaultValue="-1" Name="DISCIPLINE_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
              <asp:SqlDataSource ID="sqlExpeditorsList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
         SelectCommand="SELECT USER_NAME,USERS.USER_ID FROM EXPEDITORS_EMAILS INNER JOIN USERS ON  USERS.USER_ID = EXPEDITORS_EMAILS.USER_ID 
                        WHERE  IS_EXPEDITOR='Y' ORDER BY USER_NAME"></asp:SqlDataSource>
</asp:Content>

