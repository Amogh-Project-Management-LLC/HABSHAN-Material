<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="ipms_Home" Title="Home" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var $ = $telerik.$;
        function exportPDF() {
            $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadHtmlChart"));
        }

        function pageLoad() {
            var chart = $find("<%= RadChart1.ClientID %>");
            chart._chartObject.options.series[0].gap = 30;
            chart.repaint();
        }


    </script>
    <style type="text/css">
        .simple_div {
            width: 400px;
            padding: 5px;
            background-color: whitesmoke;
            margin: 3px;
            border-radius: 5px;
            border-color: gainsboro;
            border-style: solid;
            border-width: medium;
        }
    </style>
    <table style="width: 100%;">
        <tr runat="server" visible="false" id="StatusRow">
            <td>
                <div class="simple_div">
                    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                </div>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top;">

                <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportPDF" Text="Export Chart to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
                <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
                </telerik:RadClientExportManager>
                <telerik:RadHtmlChart ID="RadChart1" runat="server" DefaultType="Bar"
                    OnItemDataBound="RadChart1_ItemDataBound" Width="1200px" Height="500px">

                    <PlotArea>
                        <Series>
                            <telerik:ColumnSeries DataFieldY="PO_MR_CNT" Name="01 Material Requistion" Gap="1" Spacing="4" >
                                <Appearance>
                                    <FillStyle BackgroundColor="Aqua" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="PO_CNT" Name="02 Purchase Order" >
                                <Appearance>
                                    <FillStyle BackgroundColor="Violet" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="PO_BAT_CNT" Name="03 Batch Plan"  >
                                <Appearance>
                                    <FillStyle BackgroundColor="Tomato" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <%-- <telerik:ColumnSeries DataFieldY="PO_RFI_CNT" Name="04 Request For Inspection(PO)" />--%>

                            <telerik:ColumnSeries DataFieldY="PO_IRN_CNT" Name="04 Inspection Release Note">
                                <Appearance>
                                    <FillStyle BackgroundColor="BlueViolet" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MR_CNT" Name="05 Material Receipt Report">
                                <Appearance>
                                    <FillStyle BackgroundColor="SteelBlue" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="RFI_CNT" Name="06 Request For Inspection">
                                <Appearance>
                                    <FillStyle BackgroundColor="Gold" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MRIR_CNT" Name="07 Material Recieve Inspection Report">
                                <Appearance>
                                    <FillStyle BackgroundColor="Gray" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MAT_REQ_CNT" Name="08 Material Request">
                                <Appearance>
                                    <FillStyle BackgroundColor="YellowGreen" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MAT_TRNS_CNT" Name="09 Material Transfer">
                                <Appearance>
                                    <FillStyle BackgroundColor="RoyalBlue" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MAT_TR_RC_CNT" Name="10 Material Recieve">
                                <Appearance>
                                    <FillStyle BackgroundColor="Thistle" />
                                </Appearance>
                            </telerik:ColumnSeries>
                            <telerik:ColumnSeries DataFieldY="MAT_ISUE_CNT" Name="11 Material Issue Voucher">
                                <Appearance>
                                    <FillStyle BackgroundColor="SeaGreen" />
                                </Appearance>
                            </telerik:ColumnSeries>
                        </Series>
                      
                    </PlotArea>
                    <ChartTitle Text="Material Chart">
                    </ChartTitle>
                </telerik:RadHtmlChart>
                <asp:Image ID="Image1" runat="server" Visible="false" />

            </td>
        </tr>
        <tr runat="server" visible="false" id="FataRow">
            <td>
                <telerik:RadButton ID="btnItemCode" runat="server" Text="FATA Item Code" Width="120" OnClick="btnItemCode_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="MMSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJECT_ID,PO_MR_CNT, PO_CNT, PO_BAT_CNT, PO_RFI_CNT, PO_IRN_CNT, MR_CNT, RFI_CNT, MRIR_CNT, MAT_REQ_CNT, MAT_TRNS_CNT, MAT_TR_RC_CNT, MAT_ISUE_CNT FROM VIEW_ALL_COUNT_GRAPH_MM WHERE (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
