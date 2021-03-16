<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="IsometricMaterialStatus.aspx.cs" Inherits="BasicReports_IsometricMaterialStatus"
    Title="Material Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>

                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 110px; background-color: Gainsboro; vertical-align: top;">Area Name
                </td>
                <td>
                    <asp:RadioButtonList ID="AreaNameList" runat="server" DataSourceID="AreaL1DataSource"
                        DataTextField="AREA_L1" DataValueField="AREA_L1" AppendDataBoundItems="True"
                        OnDataBinding="AreaNameList_DataBinding">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: Gainsboro;">Isometric No
                </td>
                <td>
                    <asp:TextBox ID="txtIsomeNo" Width="200px" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="AreaL1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT AREA_L1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) ORDER BY AREA_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>