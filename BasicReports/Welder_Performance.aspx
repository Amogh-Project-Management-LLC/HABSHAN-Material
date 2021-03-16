<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Welder_Performance.aspx.cs" Inherits="BasicReports_Welder_Performance"
    Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            var datepicker = $find("<%=txtDateFrom.ClientID %>");
            datepicker.clear();
            var datepicker2 = $find("<%=txtDateTo.ClientID %>");
            datepicker2.clear();
        }

        function ValidateDateFrom(sender, args) {
            var datepicker = $find("<%=txtDateFrom.ClientID %>");
            if (datepicker.get_textBox().control.get_value() == "")
                args.IsValid = false;
            else
                args.IsValid = true;
        }

        function ValidateDateTo(sender, args) {
            var datepicker = $find("<%=txtDateTo.ClientID %>");
            if (datepicker.get_textBox().control.get_value() == "")
                args.IsValid = false;
            else
                args.IsValid = true;
        }
    </script>
    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="False"></telerik:RadButton>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 110px; background-color: Gainsboro;">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateFrom" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateFrom">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: Gainsboro;">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateTo" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateTo">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: Gainsboro;">Subcon
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        Width="200px">
                        <asp:ListItem Selected="True" Value="-1" Text=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Welder Wise" Width="100" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMatWise" runat="server" Text="Material Wise" Width="100" OnClick="btnMatWise_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPercentWise" runat="server" Text="RT Percent" Width="100" OnClick="btnPercentWise_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSize" runat="server" Text="Weld Size" Width="100" OnClick="btnSize_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMonthly" runat="server" Text="Monthly" Width="100" OnClick="btnMonthly_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>