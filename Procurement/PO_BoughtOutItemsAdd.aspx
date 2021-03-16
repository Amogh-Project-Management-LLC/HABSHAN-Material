<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PO_BoughtOutItemsAdd.aspx.cs" Inherits="Procurement_PO_BoughtOutItemsAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
        .Heading {
            background-color:whitesmoke;
            width:120px;
            padding-left:5px;
        }
    </style>
    <div>
        <asp:UpdatePanel runat="server" ID="UpdatePanelEntryTable">
            <ContentTemplate>
                <table>
                    <tr>
                        <td class="Heading">Inspection Type</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlInspType" AppendDataBoundItems="True" Height="20px" DataSourceID="sqlInspectionSource" 
                                DataTextField="INSP_TYPE_DESC" DataValueField="INSP_TYPE_ID" OnDataBinding="ddlInspType_DataBinding"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Inspection Report</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtInspRep"></telerik:RadTextBox>
                        </td>
                    </tr>
                     <tr>
                        <td class="Heading">Inspection Date</td>
                        <td>
                            <telerik:RadDatePicker runat="server" ID="txtInspDate" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                        </td>
                    </tr>
                     <tr>
                        <td class="Heading">Inspection Result</td>
                        <td>
                            <asp:RadioButtonList runat="server" ID="radInspResult" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Accept" Value="ACCEPT"></asp:ListItem>
                                <asp:ListItem Text="Reject" Value="REJECT"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                     <tr>
                        <td class="Heading">Remarks</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtRemaeks"></telerik:RadTextBox>
                        </td>
                    </tr>

                     <tr>
                        <td class="Heading">Upload Report</td>
                        <td>
                            <asp:FileUpload runat="server" ID="fileupload1" />
                        </td>
                    </tr>
                   
                     <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click">
                                <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="sqlInspectionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM PO_BOUGHT_INSP_CAT"></asp:SqlDataSource>
</asp:Content>

