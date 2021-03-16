<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_RT_Reports.aspx.cs" Inherits="BasicReports_FitupWeldingProg_Reps" Title="NDE Reports" %>

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
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 130px; background-color: Gainsboro; vertical-align: top">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateFrom" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateFrom" ForeColor="Red">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: Gainsboro; vertical-align: top">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateTo" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateTo" ForeColor="Red">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: Gainsboro; vertical-align: top">
                    <asp:Label ID="Label4" runat="server" Text="Category:"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="rblCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCat_SelectedIndexChanged" BackColor="LightYellow">
                        <asp:ListItem Selected="True" Value="1">Shop</asp:ListItem>
                        <asp:ListItem Value="2">Field</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: Gainsboro; vertical-align: top">Report
                </td>
                <td>
                    <asp:RadioButtonList ID="ReportCode" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCat_SelectedIndexChanged" BackColor="WhiteSmoke">
                        <asp:ListItem Selected="True" Value="12">RT REPAIR STATUS (MATERIAL WISE) - RT BASE</asp:ListItem>
                        <asp:ListItem Value="12.2">RT REPAIR STATUS (MATERIAL WISE) - WELD DATE BASE</asp:ListItem>
                        <asp:ListItem Value="12.1">FIRST 10 JOINTS</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnPreview" runat="server" Text="RT Repair" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE &#13;&#10;(PROJ_ID = :PROJECT_ID)&#13;&#10;AND ((:CAT=1 AND FAB_SC = 'Y') OR(:CAT=2 AND FIELD_SC='Y'))&#13;&#10; ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="rblCat" DefaultValue="-1" Name="CAT" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>