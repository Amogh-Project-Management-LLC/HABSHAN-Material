<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatRFINew.aspx.cs" Inherits="Material_MatRFINew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">Store
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlStoreList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlStoreList" AutoPostBack="true" Width="200px"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" OnDataBinding="ddlStoreList_DataBinding" OnSelectedIndexChanged="ddlStoreList_SelectedIndexChanged">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">RFI Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRFINo" runat="server" Width="200px" EmptyMessage="RFI Number..." Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Client RFI Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtClientRFI" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">RFI Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtRFIDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">MRR Number
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlMRRNumber" runat="server"  AutoPostBack="True" AllowCustomText="true" Filter="Contains" 
                        DataSourceID="sqlMRRSource" DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" Width="200px"
                        OnDataBinding="ddlMRRNumber_DataBinding" OnSelectedIndexChanged="ddlMRRNumber_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    
                </td>
            </tr>
            <tr>
                <td class="Heading">PO Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPOSearch" runat="server" EmptyMessage="Search PO..." Width="120px" AutoPostBack="True" Enabled="false"></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlPOList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlPOSource" DataTextField="PO_NO" DataValueField="PO_ID" OnDataBinding="ddlPOList_DataBinding" OnSelectedIndexChanged="ddlPOList_SelectedIndexChanged" Enabled="false"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">Discipline
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlDisciplineList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlDiscipline"
                        DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" OnDataBinding="ddlDisciplineList_DataBinding"
                        Width="200px" Enabled="false">
                    </telerik:RadDropDownList>
                </td>
            </tr>

            <tr>
                <td class="Heading">Shipment No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="200px" EmptyMessage="Shipement Number..." Enabled="false"></telerik:RadTextBox>
                </td>
                  <td class="Heading">Reference Docs
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRefDocs" runat="server" Width="200px" EmptyMessage="Reference Docs"></telerik:RadTextBox>
                </td>
            </tr>
        
             <tr>
                <td class="Heading">Status
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="ACCEPTED" Value="ACCEPTED" />
                            <telerik:DropDownListItem Text="ACCEPTED WITH COMMENTS" Value="ACCEPTEDWITHCOMMENTS" />
                            <telerik:DropDownListItem Text="REJECTED" Value="REJECTED" />
                            <telerik:DropDownListItem Text="CANCELLED" Value="CANCELLED" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                  <td class="Heading">Criticality
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlCritical" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="1" Value="1" />
                            <telerik:DropDownListItem Text="2" Value="2" />
                            <telerik:DropDownListItem Text="3" Value="3" />
                            <telerik:DropDownListItem Text="4" Value="4" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
             
             <tr>
                <td class="Heading">Inspection Class
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlInspClass" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="I" Value="I" />
                            <telerik:DropDownListItem Text="II" Value="II" />
                            <telerik:DropDownListItem Text="III" Value="III" />
                            <telerik:DropDownListItem Text="IV" Value="IV" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                  <td class="Heading">Material Certification
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlMatCert" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="2.1" Value="2.1" />
                            <telerik:DropDownListItem Text="2.2" Value="2.2" />
                            <telerik:DropDownListItem Text="2.3" Value="2.3" />
                            <telerik:DropDownListItem Text="2.4" Value="2.4" />
                            <telerik:DropDownListItem Text="3.1" Value="3.1" />
                            <telerik:DropDownListItem Text="3.2" Value="3.2" />
                            <telerik:DropDownListItem Text="3.3" Value="3.3" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            
            <tr>
                <td class="Heading">Company
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCompany" runat="server" Width="200px" ></telerik:RadTextBox>
                </td>
                    <td class="Heading">Name
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
           
            <tr>
                <td class="Heading">Phone
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPhone" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
                 <td class="Heading">Email
                </td>
                <td>
                    <telerik:RadTextBox ID="txtEmail" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
         
            <tr>
                <td class="Heading">Location
                </td>
                <td>
                    <telerik:RadTextBox ID="txtLocation" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
                 <td class="Heading">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px" EmptyMessage="Remarks..." TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
          
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlPOSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO
FROM VIEW_ADAPTER_MAT_RCV
WHERE PO_NO LIKE FNC_FILTER(:FILTER) OR :FILTER = 'XXX'">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID FROM DISCIPLINE_DEF ORDER BY DISCIPLINE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM STORES_DEF
ORDER BY STORE_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMRRSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO
FROM VIEW_BALANCE_MRR
WHERE PROJECT_ID = :PROJECT_ID
ORDER BY MAT_RCV_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

