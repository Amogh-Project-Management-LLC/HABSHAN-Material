<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Details.aspx.cs" Inherits="WeldingInspec_WPS_Details" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100px; background-color: #99ccff;">
                <asp:LinkButton ID="btnBack" runat="server" OnClick="btnBack_Click" ForeColor="Blue"
                    Width="11px">Back</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:DetailsView ID="wpsDetailsView" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                    DataKeyNames="WPS_ID" DataSourceID="wpsDataSource" Height="50px" Width="731px"
                    OnItemUpdating="wpsDetailsView_ItemUpdating" OnModeChanging="wpsDetailsView_ModeChanging">
                    <Fields>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                        <asp:BoundField DataField="WPS_NO1" HeaderText="WPS No1" SortExpression="WPS_NO1" />
                        <asp:BoundField DataField="WPS_NO2" HeaderText="WPS No2" SortExpression="WPS_NO2" />
                        <asp:BoundField DataField="REV" HeaderText="Revision" SortExpression="REV" />
                        <asp:TemplateField HeaderText="Material" SortExpression="MATERIAL">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MATERIAL") %>' Width="360px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MATERIAL") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pipe Class" SortExpression="PIPE_CLASS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PIPE_CLASS") %>' Width="360px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("PIPE_CLASS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PROCESS" HeaderText="Process" SortExpression="PROCESS" />
                        <asp:BoundField DataField="PWHT" HeaderText="PWHT" SortExpression="PWHT" />
                        <asp:BoundField DataField="SIZE_FROM" HeaderText="Size From" SortExpression="SIZE_FROM" />
                        <asp:BoundField DataField="SIZE_TO" HeaderText="Size To" SortExpression="SIZE_TO" />
                        <asp:BoundField DataField="THK_FROM" HeaderText="Thick From" SortExpression="THK_FROM" />
                        <asp:BoundField DataField="THK_TO" HeaderText="Thick To" SortExpression="THK_TO" />
                        <asp:BoundField DataField="CONNEC_A" HeaderText="Connection A" SortExpression="CONNEC_A" />
                        <asp:BoundField DataField="CONNEC_B" HeaderText="Connection B" SortExpression="CONNEC_B" />
                        <asp:TemplateField HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                            <EditItemTemplate>
                                <asp:DropDownList ID="cboSC" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                    Width="114px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks" SortExpression="REMARKS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REMARKS") %>' Width="360px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <EmptyDataTemplate>
                        WPS Not Found!
                    </EmptyDataTemplate>
                    <FieldHeaderStyle Width="100px" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="wpsDataSource" runat="server" SelectMethod="GetDataByWPS_ID"
        TypeName="dsWeldingBTableAdapters.PIP_WPS_NOTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="WPS_NO1" Type="String" />
            <asp:Parameter Name="MATERIAL" Type="String" />
            <asp:Parameter Name="PROCESS" Type="String" />
            <asp:Parameter Name="PWHT" Type="String" />
            <asp:Parameter Name="SIZE_FROM" Type="Decimal" />
            <asp:Parameter Name="SIZE_TO" Type="Decimal" />
            <asp:Parameter Name="THK_FROM" Type="Decimal" />
            <asp:Parameter Name="THK_TO" Type="Decimal" />
            <asp:Parameter Name="PDF_DIR" Type="Object" />
            <asp:Parameter Name="CONNEC_A" Type="String" />
            <asp:Parameter Name="CONNEC_B" Type="String" />
            <asp:Parameter Name="PIPE_CLASS" Type="String" />
            <asp:Parameter Name="WPS_NO2" Type="String" />
            <asp:Parameter Name="WPS_NO3" Type="Object" />
            <asp:Parameter Name="REV" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="WPS_GROUP" Type="Object" />
            <asp:Parameter Name="MAT_GROUP" Type="Object" />
            <asp:Parameter Name="original_WPS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WPS_ID" QueryStringField="WPS_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DirObjsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DIR_ID, DIR_OBJ FROM DIR_OBJECTS WHERE (PROJECT_ID = :PROJECT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
