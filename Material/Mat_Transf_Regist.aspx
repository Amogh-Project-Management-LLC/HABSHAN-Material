<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf_Regist.aspx.cs" Inherits="Erection_Additional_Mat_Regist"
    Title="Material Transfer - New" %>

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
                <td style="width: 120px; background-color: whitesmoke">
                    Transfer Request No
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlReqNo" runat="server" Width="200px" DataSourceID="RequestDataSource" DataTextField="MAT_REQ_NO" DataValueField="MAT_REQ_ID" 
                        AppendDataBoundItems="true" AllowCustomText="true" Filter="Contains"  OnSelectedIndexChanged="ddlReqNo_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                      <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="-(Select One)-" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>

                       <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlReqNo"
                        ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Transfer No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransfNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="transfNoValidator" runat="server" ControlToValidate="txtTransfNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
         
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Create Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px" Enabled="false">
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
           <%-- <tr>
                <td style="width: 120px; background-color: whitesmoke">Scope</td>
                <td>
                    <asp:DropDownList ID="ddScope" runat="server" DataSourceID="Scope_SqlDataSource" DataTextField="MAT_SCOPE" DataValueField="MAT_SCOPE_CODE" Width="150px">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Create by
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCreateBy" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="CreateByValidator" runat="server" ControlToValidate="txtCreateBy"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">From Store
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddFrom" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px">
                        <Items>
                            <telerik:DropDownListItem runat="server" Text="-(Select One)-" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="fromValidator" runat="server" ControlToValidate="ddFrom"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">To Store
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddTo" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px">
                         <Items>
                            <telerik:DropDownListItem runat="server" Text="-(Select One)-" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="toValidator" runat="server" ControlToValidate="ddTo" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF
WHERE (PROJECT_ID = :PROJECT_ID)
ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Scope_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_SCOPE_CODE, MAT_SCOPE FROM MATERIAL_SCOPE WHERE (PROJECT_ID = :PROJECT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="RequestDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_REQ_ID, MAT_REQ_NO FROM VIEW_BALANCE_MAT_REQUEST WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_REQ_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>