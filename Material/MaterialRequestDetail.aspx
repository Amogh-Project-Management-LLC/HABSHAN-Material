<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestDetail.aspx.cs" Inherits="Material_MaterialRequestDetail" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">       
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DetailsView ID="itemsDetailsView" runat="server" Width="600px" AutoGenerateRows="False"
                            CssClass="DataWebControlStyle" DataSourceID="itemsDataSource" DataKeyNames="MAT_REQ_ID,MR_ITEM_NO"
                            OnModeChanging="itemsDetailsView_ModeChanging" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <Fields>
                                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                                <asp:BoundField DataField="MR_ITEM_NO" HeaderText="MR Item No" SortExpression="MR_ITEM_NO" />
                                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size Desc" SortExpression="SIZE_DESC"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="ITEM_NAM" HeaderText="Material Type" SortExpression="ITEM_NAM"
                                    ReadOnly="true" />                                
                                <asp:BoundField DataField="MAT_DESCR" HeaderText="Material Desc" SortExpression="MAT_DESCR"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                                <asp:BoundField DataField="REQ_QTY" HeaderText="Requested Qty" SortExpression="REQ_QTY" />
                                <asp:BoundField DataField="ISSUED_QTY" HeaderText="Issued Qty" SortExpression="ISSUED_QTY" />
                                <asp:BoundField DataField="RQRD_DATE" HeaderText="Required Date" SortExpression="RQRD_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="RQRD_LOCATION" HeaderText="Required at Location" SortExpression="RQRD_LOCATION" />
                                <asp:BoundField DataField="ETA_DATE" HeaderText="ETA Date" SortExpression="ETA_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="ATA_DATE" HeaderText="ATA Date" SortExpression="ATA_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Fields>
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle CssClass="HeaderStyle" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle CssClass="AlternatingRowStyle" BackColor="White" />
                            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                            <EditRowStyle BackColor="#2461BF" />
                            <EmptyDataTemplate>
                                Invalid Index!
                            </EmptyDataTemplate>
                            <FieldHeaderStyle Width="165px" BackColor="#DEE8F5" Font-Bold="True" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                        </asp:DetailsView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataByMR_ITEM_NO" TypeName="dsMaterialCTableAdapters.VIEW_MATERIAL_REQUEST_DTTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="MR_ITEM_NO" Type="Decimal" />
            <asp:Parameter Name="REQ_QTY" Type="Decimal" />
            <asp:Parameter Name="ISSUED_QTY" Type="Decimal" />
            <asp:Parameter Name="RQRD_DATE" Type="DateTime" />
            <asp:Parameter Name="RQRD_LOCATION" Type="String" />
            <asp:Parameter Name="ETA_DATE" Type="DateTime" />
            <asp:Parameter Name="ATA_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MR_ITEM_NO" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_REQ_ID" QueryStringField="MAT_REQ_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MR_ITEM_NO" QueryStringField="MR_ITEM_NO" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

