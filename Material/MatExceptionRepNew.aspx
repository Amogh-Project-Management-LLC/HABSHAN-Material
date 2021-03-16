<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRepNew.aspx.cs" Inherits="Material_MatExceptionRepNew"
    Title="ESD" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: gainsboro">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 170px; background-color: whitesmoke;">Sub Contractor</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSubconList" runat="server" AutoPostBack="True" DataSourceID="sqlSubconSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnSelectedIndexChanged="ddlSubconList_SelectedIndexChanged"
                        Width="200px" AppendDataBoundItems="true" OnDataBinding="ddlSubconList_DataBinding">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 170px; background-color: whitesmoke;">Material Source</td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                        OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                        <asp:ListItem Text="MRIR" Value="MRIR"></asp:ListItem>
                        <asp:ListItem Text="TRANSFER RECEIVE" Value="TRANS"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="ESD Report Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtReportNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label8" runat="server" Text="MRIR Number"></asp:Label>
                </td>
                <td>
                <%--    <telerik:RadTextBox runat="server" ID="txtSearchMIR" EmptyMessage="Search MRIR.." AutoPostBack="True"></telerik:RadTextBox>
                    <asp:DropDownList ID="cboMR" runat="server" AppendDataBoundItems="True" DataSourceID="mrDataSource"
                        DataTextField="MIR_NO" DataValueField="MIR_ID" Width="200px" Height="25" Enabled="false"
                        AutoPostBack="false" OnSelectedIndexChanged="cboMR_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>--%>

                       <telerik:RadComboBox ID="cboMR" runat="server" DataSourceID="mrDataSource" DataTextField="MIR_NO" AllowCustomText="true" Filter="Contains" DataValueField="MIR_ID" Width="250px" AutoPostBack="true" AppendDataBoundItems="true">
                       </telerik:RadComboBox>
                    <%--  <asp:CompareValidator ID="mrValidator" runat="server" ControlToValidate="cboMR" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label3" runat="server" Text="Transfer Receive Number"></asp:Label>
                </td>
                <td>
                      <telerik:RadComboBox ID="ddlTransRecive" runat="server" DataSourceID="rcvDatasource" DataTextField="RCV_NUMBER" AllowCustomText="true" Filter="Contains" DataValueField="RCV_ID" Width="250px" AutoPostBack="true"  AppendDataBoundItems="true">
                       </telerik:RadComboBox>

<%--                    <telerik:RadTextBox runat="server" ID="txtSearchMRR" EmptyMessage="Search Receive.." AutoPostBack="true"></telerik:RadTextBox>
                    <asp:DropDownList ID="ddlTransRecive" runat="server" AppendDataBoundItems="True" DataSourceID="rcvDatasource"
                        DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" Width="200px" Height="25" Enabled="false">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>--%>

                    <%-- <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboMR" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Report Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtReportDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: gainsboro">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="mrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MIR_ID, MIR_NO FROM prc_mat_insp WHERE (PROJ_ID = :PROJECT_ID) AND MRIR_SC_ID=:SUB_CON_ID ORDER BY MIR_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PROJECT_ID" SessionField="PROJECT_ID" />        
            <asp:ControlParameter ControlID="ddlSubconList" Name="SUB_CON_ID" DefaultValue="-1" PropertyName="SelectedValue"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="rcvDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT rcv_id, rcv_number FROM PIP_MAT_TRANSFER_RCV WHERE (PROJECT_ID = :PROJECT_ID)  ORDER BY RCV_NUMBER'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PROJECT_ID" SessionField="PROJECT_ID" />
           
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
</asp:Content>
