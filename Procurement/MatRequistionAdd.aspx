<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatRequistionAdd.aspx.cs" Inherits="Procurement_MatRequistionAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .Heading {
            background-color: whitesmoke;
            width: 120px;
            padding-left: 5px
        }
    </style>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td class="Heading">Discipline</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlDiscipline" runat="server" DataSourceID="sqlDiscipline" DataTextField="DISCIPLINE"
                                DataValueField="DISCIPLINE_ID" DropDownHeight="200px" AppendDataBoundItems="true" CausesValidation="false"
                                OnDataBinding="ddlDiscipline_DataBinding" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="ddlDiscipline_SelectedIndexChanged">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Type</td>
                        <td>
                            <telerik:RadDropDownList ID="mrType" runat="server" CausesValidation="false" Width="200px" AutoPostBack="true">
                                <Items>
                                    <telerik:DropDownListItem Text="MR" Value="MR" Selected="true" />
                                    <telerik:DropDownListItem Text="MPR" Value="MPR" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Number</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtMRNo" Width="200px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMRNo" ErrorMessage="*" ForeColor="Red" ID="MRNoValidator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtMRDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMRDate" ErrorMessage="*" ForeColor="Red" ID="RequiredFieldValidator1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Revision</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtRevision" Width="200px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRevision" ErrorMessage="*" ForeColor="Red" ID="RequiredFieldValidator2"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Title</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtMRTitle" Width="200px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMRTitle" ErrorMessage="*" ForeColor="Red" ID="RequiredFieldValidator3"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Discipline Code</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtDisCode" Width="200px" ReadOnly="true" Enabled="false" BackColor="LightGray"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">MR Status</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtStatus" Width="200px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStatus" ErrorMessage="*" ForeColor="Red" ID="RequiredFieldValidator4"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Remarks</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtRemarks" Width="250px" TextMode="MultiLine"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="AddHeaderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        InsertCommand="INSERT INTO PIP_MAT_REQUISITION
                        (PROJECT_ID, MR_NO,MR_DATE, MR_REV, MR_TITLE, DISCIPLINE_CODE, STATUS, CREATE_BY, REMARKS, DISCIPLINE_ID,MR_TYPE)
                        VALUES (:PROJECT_ID, :MR_NO,:MR_DATE, :MR_REV,:MR_TITLE, :DISCIPLINE_CODE, :STATUS, :CREATE_BY, :REMARKS, :DISCIPLINE_ID, :MR_TYPE)">
        <InsertParameters>
            <asp:SessionParameter Name="PROJECT_ID"  Type="String" />
            <asp:ControlParameter Name="MR_NO" ControlID="txtMRNo" Type="String" />
            <asp:ControlParameter Name="MR_DATE" ControlID="txtMRDate" Type="DateTime" />
            <asp:ControlParameter Name="MR_REV" ControlID="txtRevision" Type="String" />
            <asp:ControlParameter Name="MR_TITLE" ControlID="txtMRTitle" Type="String" />
            <asp:ControlParameter Name="DISCIPLINE_CODE" ControlID="txtDisCode" Type="String" />
            <asp:ControlParameter Name="STATUS" ControlID="txtStatus" Type="String" />
            <asp:SessionParameter Name="CREATE_BY"  Type="Decimal" />
            <asp:ControlParameter Name="REMARKS" ControlID="txtRemarks" Type="String" />
            <asp:ControlParameter Name="DISCIPLINE_ID" ControlID="ddlDiscipline" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter Name="MR_TYPE" ControlID="mrType" Type="String" />

        </InsertParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID
FROM DISCIPLINE_DEF
ORDER BY DISCIPLINE"></asp:SqlDataSource>
</asp:Content>

