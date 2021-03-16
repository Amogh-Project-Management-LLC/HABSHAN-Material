<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SCNDetail.aspx.cs" Inherits="Logistics_SCNDetail" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
          function handleSpace(event)
        {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13)
            {
                event.preventDefault();
                event.stopPropagation();
            }
        }
  </script>
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="90px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:DetailsView ID="itemDetails" runat="server" Height="50px" Width="625px" AutoGenerateRows="False" CellPadding="4" DataSourceID="itemsDataSource"  ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            
            <FieldHeaderStyle BackColor="#DEE8F5" />
            <Fields>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="SCN_NO" HeaderText="SCN NO" SortExpression="SCN_NO" />
                <asp:BoundField DataField="SHIP_NO" HeaderText="SHIP NO" SortExpression="SHIP_NO" />
                <asp:BoundField DataField="SCN_DATE" HeaderText="SCN DATE" DataFormatString="{0:dd-MMM-yyyy}" SortExpression="SCN_DATE" />
                <asp:BoundField DataField="SCN_COMMIT_DISP" HeaderText="SCN COMMIT DISP" SortExpression="SCN_COMMIT_DISP" />
                <asp:BoundField DataField="SCN_TO" HeaderText="SCN TO" SortExpression="SCN_TO" />
                <asp:BoundField DataField="ATTN_TO" HeaderText="ATTN" SortExpression="ATTN_TO" />
                <asp:BoundField DataField="SCN_CC" HeaderText="CC" SortExpression="SCN_CC" />
                <asp:BoundField DataField="SCN_REF_NO" HeaderText="REF NO" SortExpression="SCN_REF_NO" />
                <asp:BoundField DataField="SCN_FROM" HeaderText="SCN FROM" SortExpression="SCN_FROM" />
                <asp:BoundField DataField="SCN_PHONE1" HeaderText="PHONE1" SortExpression="SCN_PHONE1" />
                <asp:BoundField DataField="SCN_PHONE2" HeaderText="PHONE2" SortExpression="SCN_PHONE2" />
                <asp:BoundField DataField="SCN_FAX_NO" HeaderText="FAX_NO" SortExpression="SCN_FAX_NO" />
                <asp:BoundField DataField="SCN_PAGES" HeaderText="NO OF PAGES" SortExpression="SCN_PAGES" />
                <asp:BoundField DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySCN" TypeName="dsLogistics_ATableAdapters.VIEW_PRC_SCN_MASTERTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SCN_ID" QueryStringField="SCN_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

