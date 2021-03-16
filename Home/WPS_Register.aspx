<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Register.aspx.cs" Inherits="WeldingInspec_WPS_Register" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" CausesValidation="False" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Submit" Width="80px" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label1" runat="server" Text="WPS Number1:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtWPS1" runat="server" Width="150px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="wps1FieldValidator" runat="server" ErrorMessage="*"
                                ControlToValidate="txtWPS1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="WPS Number2:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtWPS2" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label4" runat="server" Text="Revision:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRevision" runat="server" Width="60px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label5" runat="server" Text="Subcon:"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                                Width="150px">
                                <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label6" runat="server" Text="Material:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaterial" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label7" runat="server" Text="Process:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtProcess" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label8" runat="server" Text="PWHT(Y/N):"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPWHT" runat="server" Width="34px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label9" runat="server" Text="Size From:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSizeFrom" runat="server" Width="75px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label10" runat="server" Text="Size To:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSizeTo" runat="server" Width="75px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label11" runat="server" Text="Thick From:"></asp:Label>
                        </td>
                        <td class="TableStyle">
                            <asp:TextBox ID="txtThkFrom" runat="server" Width="75px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label12" runat="server" Text="Thick To:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtThkTo" runat="server" Width="75px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label13" runat="server" Text="Connect A:"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboConnA" runat="server" Width="100px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                                <asp:ListItem>PIPE</asp:ListItem>
                                <asp:ListItem>FITTING</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label14" runat="server" Text="Connect B:"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboConnB" runat="server" Width="100px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                                <asp:ListItem>PIPE</asp:ListItem>
                                <asp:ListItem>FITTING</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label15" runat="server" Text="PIPE Class:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPipeClass" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label18" runat="server" Text="Remarks:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="471px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
