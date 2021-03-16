<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_MTC.aspx.cs" Inherits="Material_Reports_Material_Stock_HeatNo"
    Title="Heat No - MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff" class="biglinks">
                <asp:HyperLink ID="BackLink" runat="server" ForeColor="Blue" NavigateUrl="javascript:history.back(1)">Back</asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td>
                <asp:RadioButtonList ID="MTC" runat="server" DataSourceID="tcDataSource" DataTextField="TC_CODE"
                    DataValueField="TC_ID" Font-Bold="False" Font-Italic="False" Font-Size="9pt"
                    Width="363px">
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="height: 20px; background-color: #99ccff">
                <asp:Button ID="btnMore" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="More" Width="80px" OnClick="btnMore_Click" />
                <asp:Button ID="btnPDF" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="View PDF" Width="77px" OnClick="btnPDF_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="tcDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TC_ID, TC_CODE FROM VIEW_ADAPTER_TC_DETAIL WHERE (HEAT_NO = :HEAT_NO) AND (PROJECT_ID = :PROJECT_ID) AND (MAT_ID = :MAT_ID) GROUP BY TC_ID, TC_CODE ORDER BY TC_CODE">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
