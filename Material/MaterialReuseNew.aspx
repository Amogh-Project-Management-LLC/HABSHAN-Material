<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialReuseNew.aspx.cs" Inherits="Material_MaterialReuseNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .auto-style2 {
            width:120px;
            background-color:whitesmoke;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">MRN Number</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtRetNumber" runat="server" Width="200px">
                        </telerik:RadTextBox>

                        <asp:RequiredFieldValidator ID="retNoValidator" runat="server" ControlToValidate="txtRetNumber"
                            ErrorMessage="*"></asp:RequiredFieldValidator>

                    </td>

                </tr>

                <tr>
                    <td class="auto-style2">MRN Date</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadDatePicker ID="txtRetDate" runat="server">
                            <Calendar ID="Calendar1" runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Bisque" />
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

                        <asp:RequiredFieldValidator ID="retDateValidator" runat="server" ControlToValidate="txtRetDate"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>


                <tr>
                    <td class="auto-style2">MRN By</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtRetby" runat="server" Width="150px">
                        </telerik:RadTextBox>


                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">To Store</td>
                    <td class="auto-style3">:</td>
                    <td>


                        <asp:DropDownList ID="cboStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                            DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="159px" AutoPostBack="True"
                            OnSelectedIndexChanged="cboStore_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                        </asp:DropDownList>

                        <asp:CompareValidator ID="storeValidator" runat="server" ControlToValidate="cboStore"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>


                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Remarks</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtRemarks" runat="server" Width="366px">
                        </telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td class="auto-style3">&nbsp;</td>
                    <td>
                        <telerik:RadButton ID="btnSubmit" runat="server" CssClass="btnSubmit" Text="Submit" OnClick="btnSubmit_Click">
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
     
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

