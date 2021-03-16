<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReturnRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Material Return - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label1" runat="server" Text="Return Number"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRetNumber" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="retNoValidator" runat="server" ControlToValidate="txtRetNumber"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label2" runat="server" Text="Return Date"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label3" runat="server" Text="Return by"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRetby" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label4" runat="server" Text="From Area"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlArea" runat="server" DataSourceID="AreaDataSource" DataTextField="AREA_L2" DataValueField="AREA_L2"
                        AutoPostBack="true" CausesValidation="false" OnDataBinding="ddlArea_DataBinding" AppendDataBoundItems="true" Width="200px">
                    </telerik:RadDropDownList>

                    <asp:CompareValidator ID="storeValidator" runat="server" ControlToValidate="ddlArea"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label5" runat="server" Text="To Store"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboStore2" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource" AutoPostBack="true"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px" OnDataBinding="cboStore2_DataBinding" OnSelectedIndexChanged="cboStore2_SelectedIndexChanged" CausesValidation="false">
                    </telerik:RadDropDownList>

                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboStore2"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">
                    <asp:Label ID="Label7" runat="server" Text="Refer Subcon"></asp:Label>
                </td>
                <td>
                    <telerik:RadDropDownList ID="RadDropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="RefSubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="250px" AutoPostBack="True" OnDataBinding="RadDropDownList1_DataBinding"
                        CausesValidation="false">
                    </telerik:RadDropDownList>
                    
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <telerik:RadLabel ID="Label6" runat="server" Text="Remarks"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: gainsboro;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT AREA_L2, SUBCON_FIELD FROM VIEW_IPMS_AREA 
        UNION SELECT SUB_AREA AS AREA_L2, NULL AS SUBCON_FIELD FROM MATERIAL_SUB_AREA ORDER BY AREA_L2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="RefSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM REF_SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
