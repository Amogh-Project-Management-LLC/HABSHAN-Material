<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialReuse.aspx.cs" Inherits="Material_MaterialReuse" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnAdd" Text="Create Request" Width="120px"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnMaterial" Text="Material" Width="120px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnPreview" Text="Preview" Width="120px" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:5px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid DataSourceID="MatReuse_GridView" ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" 
              CellSpacing="0" GridLines="None" AllowAutomaticDeletes="True" 
              AllowAutomaticUpdates="True" OnItemDataBound="RadGrid1_ItemDataBound" OnPreRender="RadGrid1_PreRender">            
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>

            <MasterTableView DataSourceID="MatReuse_GridView" AutoGenerateColumns="False" DataKeyNames="MRN_ID" EditMode="InPlace">              
                <Columns>

                    <%-- GRID VIEW EDIT COLUMN --%>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <%-- GRID VIEW COLUMN END --%>
                    <%-- GRID VIEW DELETE COLUMN --%>
                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                    </telerik:GridButtonColumn>
                    <%-- GRID VIEW DELETE COLUMN END --%>

                    <telerik:GridBoundColumn DataField="MRN_NO" FilterControlAltText="Filter MRN_NO column" HeaderText="MRN NUMBER" SortExpression="MRN_NO" UniqueName="MRN_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <ItemStyle Width="160px" />
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="MRN_DATE" DataType="System.DateTime" FilterControlAltText="Filter MRN_DATE column" HeaderText="MRN DATE" SortExpression="MRN_DATE" UniqueName="MRN_DATE" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                        <ItemStyle HorizontalAlign="Right" />
                        <ItemStyle Width="80px" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="MRN_BY" FilterControlAltText="Filter MRN_BY column" HeaderText="MRN BY" SortExpression="MRN_BY" UniqueName="MRN_BY" ReadOnly="True" AllowFiltering="False">
                        <ItemStyle Width="80px" />
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="TO STORE" SortExpression="STORE_NAME" UniqueName="STORE_NAME" AllowFiltering="False">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                Width="120px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Width="80" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
          
    </div>
    <asp:ObjectDataSource ID="MatReuse_GridView" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_ADP_MAT_REUSETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MRN_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MRN_NO" Type="String" />
            <asp:Parameter Name="MRN_DATE" Type="DateTime" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_MRN_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="FilterValue" runat="server" />
</asp:Content>

