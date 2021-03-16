<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitutionNew.aspx.cs" Inherits="Material_MaterialSubstitutionNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            background-color:whitesmoke;
            width:120px;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
        <table>
            <tr>
                <td class="Heading">
                    Subcon
                </td>
                <td>
                    <asp:DropDownList ID="ddlSubcon" runat="server" Width="200px" Height="28px" AutoPostBack="True" 
                        DataSourceID="sqlSubconSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        AppendDataBoundItems="true" OnDataBinding="ddlSubcon_DataBinding"
                        OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Request Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReqNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Request Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtReqDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Create By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCreateBy" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Store Name
                </td>
                <td>
                    <asp:DropDownList ID="ddlStoreList" runat="server" Width="200px" Height="28px" AutoPostBack="True" 
                        DataSourceID="sqlStoreSource" DataTextField="STORE_NAME" DataValueField="STORE_ID"
                        AppendDataBoundItems="true" OnDataBinding="ddlStoreList_DataBinding"></asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="80px"></telerik:RadButton>

                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE SC_ID = :SC_ID ORDER BY STORE_NAME">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
        </ContentTemplate>
    </asp:UpdatePanel>
       
</asp:Content>

