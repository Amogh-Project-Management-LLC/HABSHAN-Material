<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveNew.aspx.cs" Inherits="Material_MatReceiveNew" Title="MRV - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro; padding: 2px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table class="TableStyle" style="width: 100%">
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">PO Number</td>
                <td>
                    <telerik:RadTextBox ID="txtPO" runat="server" EmptyMessage="Search PO.." AutoPostBack="true"></telerik:RadTextBox>
                    <asp:DropDownList ID="ddlPOList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlPOSource" DataTextField="PO_NO" 
                        DataValueField="PO_ID" Width="200px" Height="25px" OnDataBinding="ddlPOList_DataBinding" AutoPostBack="true" OnSelectedIndexChanged="ddlPOList_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Discipline
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlDiscipline" runat="server" DataSourceID="sqlDisciplineSource" DataTextField="DISCIPLINE" 
                        DataValueField="DISCIPLINE_ID" Width="200px" AppendDataBoundItems="true" OnDataBinding="ddlDiscipline_DataBinding"
                        AutoPostBack="true" CausesValidation="false" Enabled="false"></telerik:RadDropDownList>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: whitesmoke;">Store
                </td>
                <td>
                    <asp:DropDownList ID="cboStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px" AutoPostBack="True"
                        OnSelectedIndexChanged="cboMM_SELECTedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="StoreValidator" runat="server" ControlToValidate="cboStore"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">MRR Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportNo" runat="server" Width="200px" ReadOnly="true"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtReportNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Receive Date
                </td>
                <td><telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
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
                <td style="width: 130px; background-color: whitesmoke;">Receive by
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRecvby" runat="server" Width="200px" Enabled="false"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RecvbyValidator" runat="server" ControlToValidate="txtRecvby"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>   
              <tr>
                <td style="width: 130px; background-color: whitesmoke;">IRN Number</td>
                <td>
                    <%--<telerik:RadComboBox ID="cboIRNList" runat="server" DataSourceID="sqlIRNSource" DataTextField="IRN_NO" DataValueField="IRN_NO" Filter="Contains" Width="200px"></telerik:RadComboBox>--%>
                   <telerik:RadComboBox ID="cboIRNList" runat="server" DataSourceID="sqlIRNSource" DataTextField="IRN_NO" AllowCustomText="true" Filter="Contains" DataValueField="IRN_ID" Width="250px"
                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  CausesValidation="false">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Shipment No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="shipNoValidator" runat="server" ControlToValidate="txtShipNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Shipment Mode</td>
                <td>
                    <asp:RadioButtonList ID="radShipMode" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="AIR" Value="AIR"></asp:ListItem>
                        <asp:ListItem Text="SEA" Value="SEA"></asp:ListItem>
                        <asp:ListItem Text="LAND" Value="LAND"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: whitesmoke;">Supplier/Vendor</td>
                <td>
                    <telerik:RadTextBox ID="txtSupplierVendor" runat="server" Width="350px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
           
           
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Delivery Point
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDeliveryPoint" runat="server" Width="350px" Enabled="false"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="DelivetyPtValidator" runat="server" ControlToValidate="txtDeliveryPoint"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: whitesmoke;">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px" TextMode="MultiLine"></telerik:RadTextBox>                   
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: gainsboro; padding: 2px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID =:PROJECT_ID AND ( SC_ID = :SC_ID OR :SC_ID = 99 ) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:SessionParameter DefaultValue="-1" Name="SC_ID" SessionField="CONNECT_AS" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPOSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO WHERE (PO_NO LIKE FNC_FILTER(:PO)) ">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPO" DefaultValue="XXX" Name="PO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDisciplineSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID FROM DISCIPLINE_DEF"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlIRNSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT IRN_NO,IRN_ID FROM PIP_PO_IRN
                        WHERE PO_ID = :PO_ID
                        ORDER BY IRN_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlPOList" DefaultValue="-1" Name="PO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>