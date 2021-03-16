<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="POPunchlistAdd.aspx.cs" Inherits="Procurement_POInspAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">PO Number
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlPOPunchlist" runat="server" DataSourceID="sqlPOPunchlistSource" DataTextField="PO_NO" AllowCustomText="true" Filter="Contains"
                        DataValueField="PO_ID" Width="250px" OnDataBinding="ddlPOPunchlist_DataBinding" OnSelectedIndexChanged="ddlPOPunchlist_SelectedIndexChanged"
                        AutoPostBack="true">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Punch Number</td>
                <td>
                    <telerik:RadTextBox ID="txtPunchNumber" runat="server" Width="250px" Enabled="False"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Created Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="250px"></telerik:RadDatePicker>
                </td>
            </tr>
            <%--<tr>
                <td class="Heading">Discipline
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlDisciplineList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlDiscipline"
                        DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" OnDataBinding="ddlDisciplineList_DataBinding"
                        Width="200px" Enabled="false">
                    </telerik:RadDropDownList>
                </td>
            </tr>--%>
            <tr>
                <td class="Heading">Raised By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRaisedBy" runat="server" Width="150px" ></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px" EmptyMessage="Remarks..." TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlPOPunchlistSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM pip_po">
        <%--<SelectParameters>
            <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID FROM DISCIPLINE_DEF ORDER BY DISCIPLINE"></asp:SqlDataSource>--%>
</asp:Content>

