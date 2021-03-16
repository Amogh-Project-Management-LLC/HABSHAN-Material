<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POInspAdd.aspx.cs" Inherits="Procurement_POInspAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            width:120px;
            background-color:whitesmoke;
            padding-left:5px;
        }
    </style>
    <div>
        <table> 
             <tr>
                <td class="Heading">
                    PO Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPOSearch" runat="server" EmptyMessage="Search PO..." Width="120px" AutoPostBack="True"></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlPOList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlPOSource" DataTextField="PO_NO" 
                        DataValueField="PO_ID" OnDataBinding="ddlPOList_DataBinding" OnSelectedIndexChanged="ddlPOList_SelectedIndexChanged"
                        ></telerik:RadDropDownList>
                </td>
            </tr>
              <tr>
                <td class="Heading">
                    Discipline
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlDisciplineList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlDiscipline" 
                        DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" OnDataBinding="ddlDisciplineList_DataBinding"
                        Width="200px" Enabled="false"></telerik:RadDropDownList>
                </td>
            </tr>   
             <tr>
                <td class="Heading">
                    RFI Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRFINo" runat="server" Width="200px" EmptyMessage="RFI Number..." Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    RFI Create Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtRFIDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>  
            
            <tr>
                <td class="Heading">
                    RFI Report Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRFIReportNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    RFI Report Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtRFIReportDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>   
            <tr>
                <td class="Heading">
                    Remarks
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
FROM pip_po
WHERE PO_NO LIKE FNC_FILTER(:FILTER) OR :FILTER = 'XXX'">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID FROM DISCIPLINE_DEF ORDER BY DISCIPLINE"></asp:SqlDataSource>    
</asp:Content>

