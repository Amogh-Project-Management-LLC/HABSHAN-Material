<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_HeatNo.aspx.cs" Inherits="Material_Reports_Material_Stock_HeatNo"
    Title="Material - Heat No" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMore_Click" ></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%">
        <tr>
            <td>
                <asp:RadioButtonList ID="heatNos" runat="server" DataSourceID="hnDataSource" DataTextField="HEAT_NO"
                    DataValueField="HEAT_NO" Font-Bold="False" Font-Italic="False" Font-Size="9pt" >
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="hnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT HEAT_NO  FROM PRC_MAT_INSP_DETAIL WHERE (MAT_ID = :MAT_ID) GROUP BY HEAT_NO ORDER BY HEAT_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>