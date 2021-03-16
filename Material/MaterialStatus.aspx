<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStatus.aspx.cs" Inherits="Material_MaterialStock" Title="Material Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= poGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
             var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            
            var divFooter = document.getElementById("footerDiv").clientHeight
            
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width - 15+ "px";
           
            grid.repaint();
        }
    </script>
    <div style="background-color: gainsboro;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <telerik:RadGrid ID="poGridView" runat="server" AutoGenerateColumns="False" DataSourceID="matDataSource"
            AllowPaging="True" DataKeyNames="MAT_ID" PageSize="50" SkinID="GridViewSkin">
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <Columns>
                    <telerik:GridBoundColumn DataField="MAT_CODE" HeaderText="MAT CODE" SortExpression="MAT_CODE">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAME" HeaderText="ITEM NAME" SortExpression="ITEM_NAME">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_DESCRIPTION" HeaderText="MAT DESCRIPTION" SortExpression="ITEM_DESCRIPTION">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUM_PO_QTY" HeaderText="PO QTY" SortExpression="PO_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUM_RELEASE_QTY" HeaderText="IRN RELEASE QTY" SortExpression="RELEASE_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="SUM_RECV_QTY" HeaderText="MRR RECV QTY" SortExpression="RECV_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="SUM_MRIR_ACPT_QTY" HeaderText="MRIR ACPT QTY" SortExpression="ACPT_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="SUM_MAT_REQ_QTY" HeaderText="MR REQ QTY" SortExpression="REQ_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="SUM_TRANSF_QTY" HeaderText="TRANSF QTY" SortExpression="TRANSF_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="SUM_TRANS_RECV_QTY" HeaderText=" MAT RCV QTY" SortExpression="RCV_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="SUM_MIV_REQ_QTY" HeaderText=" MIV REQ QTY" SortExpression="REQ_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="SUM_MIV_ISSUE_QTY" HeaderText=" MIV ISSUE QTY" SortExpression="ISSUE_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BALANCE" HeaderText="BALANCE QTY" SortExpression="BALANCE">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                   

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="matDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM view_po_wise_mat_status WHERE (MAT_ID = :MAT_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
