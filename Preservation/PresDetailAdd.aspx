<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PresDetailAdd.aspx.cs" Inherits="Preservation_PresDetailAdd" %>

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
                
                     <td style="width: 150px; background-color: #EBF5F7">MRIR No</td>
                <td>
                    <telerik:RadDropDownList ID="ddlMRIRNo" runat="server" DataSourceID="MRIRDataSource" DataTextField="MIR_NO" OnDataBinding="ddlMRIRNo_DataBinding"
                        Width="250px" DataValueField="MIR_ID" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlMRIRNo_SelectedIndexChanged" >

                    </telerik:RadDropDownList>
                </td>
                
            </tr>
              <tr>
                
                     <td style="width: 150px; background-color: #EBF5F7">Preservation Code</td>
                <td>
                    <telerik:RadDropDownList ID="ddlPreservCode" runat="server" DataSourceID="PresvCodeDataSource" DataTextField="PRESERV_CODE"
                        Width="250px" DataValueField="PRESERV_CODE_ID" AppendDataBoundItems="True" AutoPostBack="True" OnDataBinding="ddlPreservCode_DataBinding">
                    </telerik:RadDropDownList>
                </td>
                
            </tr>
         
              <tr>
                <td style="width: 150px; background-color: #EBF5F7">Preservation Number</td>
                <td>
                    <telerik:RadTextBox ID="txtPresvNo" runat="server" Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Inspection By</td>
                <td>
                    <telerik:RadTextBox ID="txtInspBy" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
              <tr>
                <td style="width: 150px; background-color: #EBF5F7">Preservation Report No</td>
                <td>
                    <telerik:RadTextBox ID="txtPreservRep" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td style="width: 150px; background-color: #EBF5F7" >Preservation Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtPreservDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px"></telerik:RadDatePicker>
                </td>
            </tr>
              <tr>
                <td style="width: 150px; background-color: #EBF5F7">Create By</td>
                <td>
                    <telerik:RadTextBox ID="txtCreateBy" runat="server"  Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
              <tr>
                <td style="width: 150px; background-color: #EBF5F7" >Create Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="150px"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server"  Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7"></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel"></telerik:RadButton>
                </td>
            </tr>

        </table>        
       
        <asp:HiddenField ID="hiddenMatID" runat="server" />
        <asp:SqlDataSource ID="MRIRDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_ID, MIR_NO FROM PRC_MAT_INSP">
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="PresvCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRESERV_CODE_ID, PRESERV_CODE FROM PRESERV_CODE_MASTER">
        </asp:SqlDataSource>
    </div>
</asp:Content>

