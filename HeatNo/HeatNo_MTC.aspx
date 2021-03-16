<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_MTC.aspx.cs" Inherits="HeatNo_HeatNo_MTC" Title="Heat No - MTC" %>

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
            DataValueField="TC_ID" Font-Bold="False" Font-Italic="False" Font-Size="9pt"
            Width="300px" OnSelectedIndexChanged="MTC_SelectedIndexChanged" AutoPostBack="True" OnDataBound="MTC_DataBound">
        </asp:RadioButtonList>
    </div>
    <asp:SqlDataSource ID="tcDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TC_ID,TC_CODE FROM  VIEW_ADAPTER_TC_DETAIL WHERE HEAT_NO = :HEAT_NO&#13;&#10;AND PROJECT_ID = :PROJECT_ID&#13;&#10;GROUP BY TC_ID, TC_CODE&#13;&#10;ORDER BY TC_CODE">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="XYZ" Name="HEAT_NO" QueryStringField="HEAT_NO" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>