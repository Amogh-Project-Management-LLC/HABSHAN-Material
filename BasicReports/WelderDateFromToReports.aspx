<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WelderDateFromToReports.aspx.cs" Inherits="WelderDateFromToReports"
    Title="Select Date From And To" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 110px; background-color: gainsboro; vertical-align: top;">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateFrom" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtDateFrom" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: gainsboro; vertical-align: top;">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateTo" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtDateTo" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnArea" runat="server" Text="Welders Control Sheet by Nos" Width="220" OnClick="btnArea_Click"></telerik:RadButton>
    </div>
</asp:Content>