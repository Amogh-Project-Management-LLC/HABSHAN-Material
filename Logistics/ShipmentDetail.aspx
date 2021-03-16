<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShipmentDetail.aspx.cs" Inherits="Logistics_ShipmentDetail" %>
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
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:DetailsView ID="itemDetailsView" runat="server" Height="50px" Width="750px" AutoGenerateRows="False" CellPadding="4" DataSourceID="itemsDataSource" ForeColor="#333333" GridLines="None" >
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />            
            <FieldHeaderStyle BackColor="#DEE8F5" />
            <Fields>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif" ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="SHIP_NO" HeaderText="SHIP NO" SortExpression="SHIP_NO" />
                <asp:BoundField DataField="SHIP_CR_DT" HeaderText="SHIP CREATE DATE" SortExpression="SHIP_CR_DT" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_REF_NO" HeaderText="SHIP REF NO" SortExpression="SHIP_REF_NO" />
                <asp:BoundField DataField="SHIP_DOC_REF_NO" HeaderText="SHIP DOC REF NO" SortExpression="SHIP_DOC_REF_NO" />
                <asp:BoundField DataField="SHIP_DOCS_REMARKS" HeaderText="SHIP DOCS REMARKS" SortExpression="SHIP_DOCS_REMARKS" />
                <asp:BoundField DataField="MTRL_READ_DT" HeaderText="MATERIAL READY DATE" SortExpression="MTRL_READ_DT" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="FROM_PORT_NAME" HeaderText="FROM PORT" SortExpression="FROM_PORT_NAME" />
                <asp:BoundField DataField="TO_PORT_NAME" HeaderText="TO PORT" SortExpression="TO_PORT_NAME" />
                <asp:BoundField DataField="TRANSP_TYPE" HeaderText="TRANSPORT TYPE" SortExpression="TRANSP_TYPE" />
                <asp:BoundField DataField="SHIP_COMMIT_DISP" HeaderText="SHIP DISPATCHED (Y/N)" SortExpression="SHIP_COMMIT_DISP" />
                <asp:BoundField DataField="SHIP_CONSIGNOR_NAME" HeaderText="CONSIGNOR NAME" SortExpression="SHIP_CONSIGNOR_NAME" />
                <asp:BoundField DataField="SHIP_REMARKS" HeaderText="SHIP REMARKS" SortExpression="SHIP_REMARKS" />
                <asp:BoundField DataField="SHIP_DISP_DT_F" HeaderText="SHIP DISPATCH DT (FORECAST)" SortExpression="SHIP_DISP_DT_F" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_DISP_DT_A" HeaderText="SHIP DISPATCH DT (ACTUAL)" SortExpression="SHIP_DISP_DT_A" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_CSTM_CL_DT_F" HeaderText="CUSTOM CLEAR DATE (FORECAST)" SortExpression="SHIP_CSTM_CL_DT_F" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_CSTM_CL_DT_A" HeaderText="CUSTOM CLEAR DATE (ACTUAL)" SortExpression="SHIP_CSTM_CL_DT_A" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_ARR_DT_F" HeaderText="SHIP PORT ARRIVE DATE (FORECAST)" SortExpression="SHIP_ARR_DT_F" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_ARR_DT_A" HeaderText="SHIP PORT ARRIVE DATE (ACTUAL)" SortExpression="SHIP_ARR_DT_A" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_COMMIT_RCPT" HeaderText="SHIP RECEIVED (Y/N)" SortExpression="SHIP_COMMIT_RCPT" />
                <asp:BoundField DataField="SHIP_SITE_REMARKS" HeaderText="SHIP SITE REMARKS" SortExpression="SHIP_SITE_REMARKS" />
                <asp:BoundField DataField="SHIP_DUTY_EXEM_RCVD" HeaderText="SHIP DUTY EXEM RCVD" SortExpression="SHIP_DUTY_EXEM_RCVD" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_SITE_ARR_DT_A" HeaderText="SHIP SITE ARR DT (ACTUAL)" SortExpression="SHIP_SITE_ARR_DT_A" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="SHIP_SITE_ARR_DT_F" HeaderText="SHIP SITE ARR DT (FORECAST)" SortExpression="SHIP_SITE_ARR_DT_F" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="CARGO_TYPE_DESC" HeaderText="CARGO TYPE" SortExpression="CARGO_TYPE_DESC" />
                <asp:BoundField DataField="SHIP_NET_WT" HeaderText="SHIP NET WEIGHT (KGS)" SortExpression="SHIP_NET_WT" />
                <asp:BoundField DataField="SHIP_DUTY_EXCEMPTION" HeaderText="SHIP DUTY EXCEMPTION" SortExpression="SHIP_DUTY_EXCEMPTION" />
                <asp:BoundField DataField="SHIP_CONTRACT" HeaderText="SHIP CONTRACT" SortExpression="SHIP_CONTRACT" />
                <asp:BoundField DataField="FREIGHT_INVOICE_NO" HeaderText="FREIGHT INVOICE NO" SortExpression="FREIGHT_INVOICE_NO" />
                <asp:BoundField DataField="FREIGHT_COST" HeaderText="FREIGHT COST" SortExpression="FREIGHT_COST" />
                <asp:BoundField DataField="CSTM_CL_START_DT" HeaderText="CUSTOM CLR START DATE" SortExpression="CSTM_CL_START_DT" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="CREATE_BY" HeaderText="CREATE BY" SortExpression="CREATE_BY" />

            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySHIP_ID" TypeName="dsLogistics_ATableAdapters.VIEW_PRC_SHIP_MASTERTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SHIP_ID" QueryStringField="SHIP_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

