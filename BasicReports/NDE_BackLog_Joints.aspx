<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_BackLog_Joints.aspx.cs" Inherits="BasicReports_NDE_NDE_BackLog_Joints"
    Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: Gainsboro; vertical-align: top;">Category
                </td>
                <td>
                    <asp:RadioButtonList ID="rblCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCat_SelectedIndexChanged"
                        Width="140px">
                        <asp:ListItem Selected="True" Value="1">Shop</asp:ListItem>
                        <asp:ListItem Value="2">Field</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">Subcon
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                        Width="150px" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="99">-Select-</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="99" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro" valign="top">NDE Type
                </td>
                <td>
                    <asp:RadioButtonList ID="NdeType" runat="server" DataSourceID="NdeTypeDataSource"
                        DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID" AutoPostBack="True" OnSelectedIndexChanged="NdeType_SelectedIndexChanged"
                        RepeatColumns="2" OnDataBound="NdeType_DataBound">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro" valign="top">RT (Optional)
                </td>
                <td class="TableStyle">
                    <asp:RadioButtonList ID="RtType" runat="server" Enabled="False">
                        <asp:ListItem Selected="True" Value="4">Any</asp:ListItem>
                        <asp:ListItem Value="1">Reject</asp:ListItem>
                        <asp:ListItem Value="2">Reshoot/ Retake</asp:ListItem>
                        <asp:ListItem Value="3">No Report</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="NdeTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM "PIP_NDE_TYPE" ORDER BY "NDE_TYPE"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE &#13;&#10;(PROJ_ID = :PROJECT_ID)&#13;&#10;AND ((:CAT=1 AND FAB_SC = 'Y') OR(:CAT=2 AND FIELD_SC='Y'))&#13;&#10; ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="rblCat" DefaultValue="-1" Name="CAT" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>