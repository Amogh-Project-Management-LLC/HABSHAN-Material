<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_JC.aspx.cs" Inherits="Material_MaterialStock_JC" Title="Material - Jobcard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <asp:GridView ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="WO_NAME" DataSourceID="jcDataSource" SkinID="GridViewSkin" PageSize="20" Width="800px">
            <Columns>
                <asp:BoundField DataField="WO_NAME" HeaderText="Job Card" SortExpression="WO_NAME">
                </asp:BoundField>
                <asp:BoundField DataField="ISSUE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Issued On" HtmlEncode="False" SortExpression="ISSUE_DATE">
                </asp:BoundField>
                <asp:BoundField DataField="REVISION" HeaderText="Revision" SortExpression="REVISION">
                </asp:BoundField>
                <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="jcDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT WO_NAME, ISSUE_DATE, REVISION, SUB_CON_NAME FROM VIEW_JC_MAT_SUMMARY WHERE (MAT_ID = :MAT_ID) AND (PROJ_ID = :PROJECT_ID) ORDER BY WO_NAME">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>