<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStockRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Material - New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <div>
        <table style="width: 100%" class="TableStyle">
            <tr>
                <td style="width: 150px; background-color: gainsboro">Material Code1
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode1" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="marCode1Validator" runat="server" ControlToValidate="txtMatCode1"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 150px; background-color: gainsboro">Material Code2
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode2" runat="server" Width="200px"></asp:TextBox>
                  
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Material Code3
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode3" runat="server" Width="200px"></asp:TextBox>                  
                </td>
            </tr>

             <tr>
                <td style="width: 150px; background-color: gainsboro">Material Code4
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode4" runat="server" Width="200px"></asp:TextBox>             
                </td>
            </tr>
             <tr>
                <td style="width: 150px; background-color: gainsboro">GL Code
                </td>
                <td>
                    <asp:TextBox ID="txtglcode" runat="server" Width="200px"></asp:TextBox>
                  
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Size Descriprion
                </td>
                <td>
                    <asp:TextBox ID="txtSizeDesc" runat="server" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="SizeValidator" runat="server" ControlToValidate="txtSizeDesc"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Size1
                </td>
                <td>
                    <asp:TextBox ID="txtSize1" runat="server" Width="83px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Size2
                </td>
                <td>
                    <asp:TextBox ID="txtSize2" runat="server" Width="83px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro;">Schedule
                </td>
                <td style="height: 26px">
                    <asp:TextBox ID="txtSchDesc" runat="server" Width="120px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Schedule1
                </td>
                <td>
                    <asp:TextBox ID="txtSch1" runat="server" Width="83px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Schedule2
                </td>
                <td>
                    <asp:TextBox ID="txtSch2" runat="server" Width="83px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">Bolt Length
                </td>
                <td>
                    <asp:TextBox ID="txtBoltLength" runat="server" Width="83px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro;">Type
                </td>
                <td style="height: 24px">
                    <%--<asp:DropDownList ID="cboItem" runat="server" DataSourceID="ItemDataSource" DataTextField="ITEM_NAM"
                        DataValueField="ITEM_ID" Width="200px" AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">-Select One-</asp:ListItem>
                    </asp:DropDownList>--%>
                    <telerik:RadComboBox ID="cboItem" runat="server" Width="200px" DataSourceID="ItemDataSource" DataTextField="ITEM_NAM" DataValueField="ITEM_ID" 
                        AppendDataBoundItems="true" AllowCustomText="true" Filter="Contains" AutoPostBack="true" CausesValidation="false">
                      <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="-(Select One)-" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:CompareValidator ID="itemValidator" runat="server" ControlToValidate="cboItem"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro">UOM
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboUOM" runat="server" DataSourceID="UomDataSource" DataTextField="UOM"
                        DataValueField="UNIT_ID" Width="200px" AppendDataBoundItems="True" EnableDirectionDetection="true">
                        <Items>
                        <telerik:DropDownListItem runat="server" Value="-1" Text="-Select One-" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="uomValidator" runat="server" ControlToValidate="cboUOM"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: gainsboro; vertical-align: top;">Description
                </td>
                <td>
                    <asp:TextBox ID="txtDesc" runat="server" Width="450px" Height="50px" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="descValidator" runat="server" ControlToValidate="txtDesc"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="UomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT UNIT_ID,UOM FROM UOM_DESCR ORDER BY UOM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ItemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ITEM_ID, ITEM_NAM FROM PIP_MAT_ITEM ORDER BY ITEM_NAM"></asp:SqlDataSource>
</asp:Content>