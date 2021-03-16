<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WeeklyReport.aspx.cs" Inherits="Home_WeeklyReport" Title="Weekly Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div_frame {
            width: 200px;
            padding: 5px;
            background-color: gainsboro;
            margin: 3px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: gainsboro; padding: 2px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnReport" runat="server" Text="Show Report" Width="120" OnClick="btnReport_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table class="TableStyle">

            <tr>
                <td style="width: 100px; background-color: whitesmoke;">Report Name
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboReport" runat="server" AppendDataBoundItems="True" DataSourceID="ReportDataSource"
                        DataTextField="EXPT_TITLE" DataValueField="EXPT_ID" Width="200px">
                        <Items>
                            <telerik:DropDownListItem runat="server" Selected="true" Text="-(Select One)-" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="StoreValidator" runat="server" ControlToValidate="cboReport"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">From Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtFromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtFromDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td style="width: 50px; background-color: whitesmoke;">To Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtToDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtToDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="ReportDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT EXPT_TITLE, EXPT_ID FROM IPMS_SYS_EXPORT WHERE WEEKLY_REP='Y'">
    </asp:SqlDataSource>
</asp:Content>
