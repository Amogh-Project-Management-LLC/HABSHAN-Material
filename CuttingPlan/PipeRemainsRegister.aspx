<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemainsRegister.aspx.cs" Inherits="CuttingPlan_PipeRemainsRegister"
    Title="Pipe Remains" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
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
                <td style="width: 130px; background-color: gainsboro">Options</td>
                <td>
                    <asp:RadioButtonList ID="EntryTypeList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="EntryTypeList_SelectedIndexChanged">
                        <asp:ListItem Value="1" Text="From Jobcard" Selected="True" />
                        <asp:ListItem Value="2" Text="Enter Item Code" />
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: gainsboro">Job Card Number
                </td>
                <td>
                    <asp:UpdatePanel ID="mivUpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboIssue" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="issueDataSource" DataTextField="ISSUE_NO" DataValueField="ISSUE_ID"
                                Width="255px" OnDataBinding="cboIssue_DataBinding">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="issueValidator" runat="server" ControlToValidate="cboIssue"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: gainsboro">Material Code
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" InputType="Text" DropDownHeight="200px" DropDownWidth="350" runat="server" DataSourceID="ItemCodeDataSource"
                                DataTextField="MAT_CODE1" DataValueField="MAT_ID" Filter="StartsWith" MinFilterLength="2" Width="250px"
                                AllowCustomEntry="false" Visible="False">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                            <asp:DropDownList ID="cboMatCode" runat="server" DataSourceID="JocardItemCodeDataSource"
                                DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="255px" OnDataBinding="cboMatCode_DataBinding"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="matCodeValidator" runat="server" ControlToValidate="cboMatCode"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: gainsboro">Paint Code
                </td>
                <td>
                    <asp:TextBox ID="txtPaintCode" runat="server" Width="86px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="paintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: gainsboro">Heat Number
                </td>
                <td>
                    <asp:TextBox ID="txtHeatNo" runat="server" Width="86px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: gainsboro">Piece Length
                </td>
                <td>
                    <asp:TextBox ID="txtLength" runat="server" Width="85px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="lengthValidator" runat="server" ControlToValidate="txtLength"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: gainsboro">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="350px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="JocardItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1 FROM VIEW_JC_MIV_REQUIRED
WHERE (ISSUE_ID = :ISSUE_ID)
AND (ITEM_ID=19)
ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboIssue" DefaultValue="-1" Name="ISSUE_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="issueDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISSUE_ID, ISSUE_NO FROM VIEW_JC_MIV WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY ISSUE_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
          
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MAT_CODE1'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>