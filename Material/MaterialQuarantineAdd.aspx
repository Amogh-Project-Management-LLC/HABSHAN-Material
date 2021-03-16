<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialQuarantineAdd.aspx.cs" Inherits="Material_MaterialQuarantineAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px">Quarantine Number:</td>
                <td>
                    <asp:TextBox ID="txtQuarantineNo" runat="server" Width="200"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px">Sub Contractor:</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="subconSource" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" Width="200" AutoPostBack="True" OnDataBinding="ddlSubcon_DataBinding" OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged">
                    </telerik:RadDropDownList>
                </td>
            </tr>
             <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px">Store Name:</td>
                <td>
                    <telerik:RadDropDownList ID="ddlStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeSource" DataTextField="STORE_NAME"
                        DataValueField="STORE_ID" Width="200" AutoPostBack="True" >
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px">Create By:</td>
                <td>
                    <asp:TextBox ID="txtCreateBy" runat="server" Width="200"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px">Remarks:</td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="200"></asp:TextBox>
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
    <asp:SqlDataSource ID="subconSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="storeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT STORE_ID,STORE_NAME FROM STORES_DEF"></asp:SqlDataSource>
</asp:Content>

