<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DailyFitupWelding_Joint.aspx.cs" Inherits="BasicReports_DailyWelding_Joint"
    Title="Fitup and Welding" %>

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
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnFitup" runat="server" Text="Fitup" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnWelding" runat="server" Text="Welding" Width="80" OnClick="btnWelding_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnWeldingJGC" runat="server" Text="Welding-JGC" Width="120" OnClick="btnWeldingJGC_Click" ></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Category
                </td>
                <td>
                    <asp:RadioButtonList ID="rblCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCat_SelectedIndexChanged"
                        Width="226px" BackColor="WhiteSmoke">
                        <asp:ListItem Selected="True" Value="1">Shop</asp:ListItem>
                        <asp:ListItem Value="2">Field</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Subcon
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                        Width="226px">
                        <asp:ListItem Selected="True" Value="99">-Select-</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Material Type
                </td>
                <td>
                    <asp:DropDownList ID="ddMaterial" runat="server" Width="200px" AppendDataBoundItems="True"
                        DataSourceID="MatTypeDataSource" DataTextField="MAT_TYPE" DataValueField="MAT_TYPE"
                        OnDataBinding="ddMaterial_DataBinding">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="background-color: Gainsboro; width: 150px;">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateFrom" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateFrom" ForeColor="Red">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateTo" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateTo" ForeColor="Red">
                    </asp:CustomValidator>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE &#13;&#10;(PROJ_ID = :PROJECT_ID)&#13;&#10;AND ((:CAT=1 AND FAB_SC = 'Y') OR(:CAT=2 AND FIELD_SC='Y'))&#13;&#10; ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="rblCat" DefaultValue="-1" Name="CAT" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MatTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_TYPE FROM PIP_SPOOL WHERE (MAT_TYPE IS NOT NULL) ORDER BY MAT_TYPE"></asp:SqlDataSource>
</asp:Content>