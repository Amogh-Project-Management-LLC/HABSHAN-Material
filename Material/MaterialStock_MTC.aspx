<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_MTC.aspx.cs" Inherits="MaterialStock_MTC" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPDF" runat="server" Text="PDF" Width="80" OnClick="btnPDF_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:RadioButtonList ID="MTC" runat="server" DataSourceID="tcDataSource" DataTextField="TC_CODE"
            DataValueField="TC_ID" Font-Bold="False" Font-Italic="False" Font-Size="9pt" OnSelectedIndexChanged="MTC_SelectedIndexChanged" AutoPostBack="True" OnDataBound="MTC_DataBound">
        </asp:RadioButtonList>
    </div>
    <asp:SqlDataSource ID="tcDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT TC_ID, TC_CODE FROM VIEW_MAT_HEAT_NO_MTC WHERE (MAT_ID = :MAT_ID) AND (TC_ID IS NOT NULL) ORDER BY TC_CODE">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>