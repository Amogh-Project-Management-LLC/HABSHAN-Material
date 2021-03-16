<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="IRNItemAdd.aspx.cs" Inherits="PO_IRN_ADD" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td>Search Item</td>
            <td>:</td>
            <td colspan="3">
                <telerik:RadTextBox ID="txtSearch" runat="server" Width="150px" AutoPostBack="true" EmptyMessage="Search Material here..."></telerik:RadTextBox>
            
                 <telerik:RadDropDownList ID="ddlMatCode" AutoPostBack="true" runat="server" Width="200px"  AppendDataBoundItems="True" OnDataBinding="ddlMatCode_DataBinding" 
                  DataSourceID="matDataSource"  DataTextField="MAT_CODE1" DataValueField="MAT_ID" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged" CausesValidation="false"></telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td>Material Code</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtMatCode" runat="server"></telerik:RadTextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMatCode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>PO No</td>
            <td>:</td>
            <td>
                <telerik:RadDropDownList runat="server" ID="ddlPO" DataSourceID="PODataSource" DataTextField="PO_NO" DataValueField="PO_ID" />
            </td>
        </tr>
        <tr>
            <td>PO Item No</td>
            <td>:</td>
            <td>
                <telerik:RadDropDownList ID="ddlPOItem" DataSourceID="POITEMDataSource" DataTextField="PO_ITEM" DataValueField="PO_ITEM" runat="server"></telerik:RadDropDownList>
            </td>
        </tr>
          <tr>
            <td>Balance to Release</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtBalRel" runat="server" Enabled="false" BackColor="LightGray"></telerik:RadTextBox>
            </td>
        </tr>
         <tr>
            <td>Inspection Qty</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtInspQty" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
          <tr>
            <td>Release Qty</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtReleaseQty" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        
          <tr>
            <td>Heat No.</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtHeatNo" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
          <tr>
            <td>TC No</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtTCNo" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadButton runat="server" ID="Save" Text="Save" OnClick="Save_Click"></telerik:RadButton>
            </td>
        </tr>
     </table>
     <asp:SqlDataSource ID="matDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_CODE1,MAT_ID FROM VIEW_PO_INSP_REQUEST_REP 
         WHERE PROJECT_ID = :PROJECT_ID AND MAT_CODE1 LIKE FNC_FILTER(:FILTER) AND RFI_ID=:RFI_ID ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />       
             <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" />
            <asp:QueryStringParameter  DefaultValue="-1" Name="RFI_ID" QueryStringField="RFI_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
         <asp:SqlDataSource ID="PODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID,PO_NO FROM VIEW_PO_INSP_REQUEST_REP
         WHERE PROJECT_ID = :PROJECT_ID AND RFI_ID= :RFI_ID AND MAT_ID=:MAT_ID">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
             <asp:QueryStringParameter  DefaultValue="-1" Name="RFI_ID" QueryStringField="RFI_ID"/>
            <asp:ControlParameter ControlID="ddlMatCode" PropertyName="SelectedValue" Name="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
     <asp:SqlDataSource ID="POITEMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ITEM FROM VIEW_PO_INSP_REQUEST_REP 
         WHERE RFI_ID=:RFI_ID AND MAT_ID=:MAT_ID AND PO_ID=:PO_ID AND RFI_ID=:RFI_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" PropertyName="SelectedValue" Name="MAT_ID" />
             <asp:QueryStringParameter  DefaultValue="-1" Name="RFI_ID" QueryStringField="RFI_ID"/>
            <asp:ControlParameter ControlID="ddlPO" PropertyName="SelectedValue" Name="PO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

