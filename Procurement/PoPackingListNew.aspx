<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PoPackingListNew.aspx.cs" Inherits="PoPackingListNew"
    Title="Packing List - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="Button1_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Packing List No
                </td>
                <td>
                    <asp:TextBox ID="txtPackingListNo" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="packingListNoValidator" runat="server" ControlToValidate="txtPackingListNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">PO No</td>
                <td>
                    <asp:TextBox ID="txtPoNo" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="poNoValidator" runat="server" ControlToValidate="txtPoNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Vendor Name</td>
                <td>
                    <asp:TextBox ID="txtVendorName" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Cargo Ready Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtCargoReadyDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCargoReadyDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">FOB Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtFOB_Date" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtFOB_Date" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Port of Loading
                </td>
                <td>
                    <asp:TextBox ID="txtPortOfLoading" runat="server" Width="400px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="portOfLoadingValidator" runat="server" ControlToValidate="txtPortOfLoading"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Storage Code
                </td>
                <td>
                    <asp:TextBox ID="txtStorageCode" runat="server" Width="140px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="300px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>