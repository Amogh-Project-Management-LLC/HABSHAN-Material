<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PODetailTracking.aspx.cs" Inherits="Procurement_PODetailTracking" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="90px" OnClick="btnBack_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:DetailsView ID="itemDetails" runat="server" Height="50px" Width="625px" AutoGenerateRows="False" CellPadding="4" DataSourceID="itemDataSource" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5"/>
            <Fields>
                <asp:BoundField DataField="PO_ITEM_NO" HeaderText="PO_ITEM_NO" SortExpression="PO_ITEM_NO" />
                <asp:BoundField DataField="SPLIT_ID" HeaderText="SPLIT_ID" SortExpression="SPLIT_ID" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="MAT_DESCR" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" />
                <asp:BoundField DataField="ORD_QTY" HeaderText="ORD_QTY" SortExpression="ORD_QTY" />
                <asp:BoundField DataField="SPLIT_QTY" HeaderText="SPLIT_QTY" SortExpression="SPLIT_QTY" />
                <asp:BoundField DataField="SPLIT_EXTRA_QTY" HeaderText="SPLIT_EXTRA_QTY" SortExpression="SPLIT_EXTRA_QTY" />
                <asp:BoundField DataField="CDD" HeaderText="CDD" SortExpression="CDD" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="IRN_NO" HeaderText="IRN_NO" SortExpression="IRN_NO" />
                <asp:BoundField DataField="IRN_ISSUE_DT" HeaderText="IRN_ISSUE_DT" SortExpression="IRN_ISSUE_DT" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="IRN_REPORT_NO" HeaderText="IRN_REPORT_NO" SortExpression="IRN_REPORT_NO" />
                <asp:BoundField DataField="IRN_REMARKS" HeaderText="IRN_REMARKS" SortExpression="IRN_REMARKS" />
                <asp:BoundField DataField="SRN_NO" HeaderText="SRN_NO" SortExpression="SRN_NO" />
                <asp:BoundField DataField="SRN_DATE" HeaderText="SRN_DATE" SortExpression="SRN_DATE" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="DEL_POINT" HeaderText="DEL_POINT" SortExpression="DEL_POINT" />
                <asp:BoundField DataField="SRN_QTY" HeaderText="SRN_QTY" SortExpression="SRN_QTY" />
                <asp:BoundField DataField="INSP_DT_F" HeaderText="INSP_DT_F" SortExpression="INSP_DT_F" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="INSP_DT_A" HeaderText="INSP_DT_A" SortExpression="INSP_DT_A" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="DEL_EXWORKS_DT_F" HeaderText="DEL_EXWORKS_DT_F" SortExpression="DEL_EXWORKS_DT_F" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="DEL_EXWORKS_DT_A" HeaderText="DEL_EXWORKS_DT_A" SortExpression="DEL_EXWORKS_DT_A" DataFormatString="{0:dd-MMM-yyyy}"/>               
                <asp:BoundField DataField="SCN_NO" HeaderText="SCN_NO" SortExpression="SCN_NO" />
                <asp:BoundField DataField="SN_DT" HeaderText="SN_DT" SortExpression="SN_DT" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="SHIP_NO" HeaderText="SHIP_NO" SortExpression="SHIP_NO" />
                <asp:BoundField DataField="SHIPPED_QTY" HeaderText="SHIPPED_QTY" SortExpression="SHIPPED_QTY" />
                <asp:BoundField DataField="SHIP_DISP_DT_F" HeaderText="SHIP_DISP_DT_F" SortExpression="SHIP_DISP_DT_F" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="SHIP_DISP_DT_A" HeaderText="SHIP_DISP_DT_A" SortExpression="SHIP_DISP_DT_A" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="SHIP_SITE_ARR_DT_F" HeaderText="SHIP_SITE_ARR_DT_F" SortExpression="SHIP_SITE_ARR_DT_F" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="SHIP_SITE_ARR_DT_A" HeaderText="SHIP_SITE_ARR_DT_A" SortExpression="SHIP_SITE_ARR_DT_A" DataFormatString="{0:dd-MMM-yyyy}"/>
                <asp:BoundField DataField="QTY_UNDER_SHIPMENT" HeaderText="QTY_UNDER_SHIPMENT" SortExpression="QTY_UNDER_SHIPMENT" />
                <asp:BoundField DataField="BALANCE_QTY_TO_RELEASE" HeaderText="BALANCE_QTY_TO_RELEASE" SortExpression="BALANCE_QTY_TO_RELEASE" />
                <asp:BoundField DataField="REPORT_PROGRESS_FLAG" HeaderText="REPORT_PROGRESS_FLAG" SortExpression="REPORT_PROGRESS_FLAG" />
                <asp:BoundField DataField="ROS_DT" HeaderText="ROS_DT" SortExpression="ROS_DT" />
                <asp:BoundField DataField="ETA_DATE" HeaderText="ETA_DATE" SortExpression="ETA_DATE" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </div>
    <asp:ObjectDataSource ID="itemDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByItem" TypeName="Procurement_BTableAdapters.VIEW_PO_SPLIT_DETAILTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SPLIT_ITEM_ID" QueryStringField="id" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

