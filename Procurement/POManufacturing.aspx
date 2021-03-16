<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POManufacturing.aspx.cs" Inherits="Procurement_POManufacturing" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnSubOrder" Text="Sub Order & Receipt"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnBoughtOut" Text="Bought Out Items" OnClick="btnBoughtOut_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAssembly" Text="Assembly"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnITPTesting" Text="ITP Testing" OnClick="btnITPTesting_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="RadButton3" Text="Hydro Test"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="RadButton4" Text="Performance Test"></telerik:RadButton>
    </div>
          
    <div style="margin-top:3px">
        <asp:UpdatePanel runat="server" ID="grdUpdatePanel">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="itemsDataSource" AllowPaging="true" PageSize="50" Height="330px" AllowFilteringByColumn="true"
                     OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">                   
                    <ClientSettings EnablePostBackOnRowClick="true">
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <mastertableview autogeneratecolumns="False" datasourceid="itemsDataSource" DataKeyNames="PO_ID">                        
                        <Columns>                           
                            <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" SortExpression="PO_NO" UniqueName="PO_NO"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_ORDER_RELEASE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter SUB_ORDER_RELEASE column" HeaderText="SUB_ORDER_RELEASE" SortExpression="SUB_ORDER_RELEASE" UniqueName="SUB_ORDER_RELEASE"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MAT_RCVD_DATE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter MAT_RCVD_DATE column" HeaderText="MAT_RCVD_DATE" SortExpression="MAT_RCVD_DATE" UniqueName="MAT_RCVD_DATE"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BOUGHT_OUT_INSP_DT" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter BOUGHT_OUT_INSP_DT column" HeaderText="BOUGHT_OUT_INSP_DT" SortExpression="BOUGHT_OUT_INSP_DT" UniqueName="BOUGHT_OUT_INSP_DT"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ASSEMBLY_PREP_DT_F" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter ASSEMBLY_PREP_DT_F column" HeaderText="ASSEMBLY_PREP_DT_F" SortExpression="ASSEMBLY_PREP_DT_F" UniqueName="ASSEMBLY_PREP_DT_F"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ASSEMBLY_PREP_DT_A" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter ASSEMBLY_PREP_DT_A column" HeaderText="ASSEMBLY_PREP_DT_A" SortExpression="ASSEMBLY_PREP_DT_A" UniqueName="ASSEMBLY_PREP_DT_A"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ITP_TESTING_CLR" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter ITP_TESTING_CLR column" HeaderText="ITP_TESTING_CLR" SortExpression="ITP_TESTING_CLR" UniqueName="ITP_TESTING_CLR"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HYDRO_TEST_CLR" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter HYDRO_TEST_CLR column" HeaderText="HYDRO_TEST_CLR" SortExpression="HYDRO_TEST_CLR" UniqueName="HYDRO_TEST_CLR" ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PERF_TEST_CLR" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter PERF_TEST_CLR column" HeaderText="PERF_TEST_CLR" SortExpression="PERF_TEST_CLR" UniqueName="PERF_TEST_CLR"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </mastertableview>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>        
    </div>     
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetData" TypeName="Procurement_ATableAdapters.VIEW_PO_ACTIVITYTableAdapter"></asp:ObjectDataSource>
</asp:Content>

