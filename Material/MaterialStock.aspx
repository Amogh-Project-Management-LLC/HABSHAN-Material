<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="MaterialStock.aspx.cs" Inherits="Isome_MaterialStock" Title="Material Catalog" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div style="background-color: gainsboro;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnSummary" runat="server" Text="Store Wise Status" Width="150" OnClick="btnSummary_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New Material" Width="110"></telerik:RadButton>
                </td>
                 <td  text-align: center;">
                 <telerik:RadButton ID="btnCatalogGrid" runat="server" Text="Material Status" OnClick="btnCatalogGrid_Click" Width="110"></telerik:RadButton>
                 </td>

                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtItemCode" runat="server" AutoPostBack="True" Width="200px"
                        EmptyMessage="Search" OnTextChanged="txtItemCode_TextChanged">
                    </telerik:RadTextBox>
                </td>
               

            </tr>
        </table>
    </div>


    <div>

        <table style="width: 100%">

            <tr>

                <td style="vertical-align: top; width: 355px;">
                    <%--<asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="MatListDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Height="420px" Width="350px"
                        OnDataBound="ListBox1_DataBound" AppendDataBoundItems="True" SelectionMode="Single" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:ListBox>--%>

                     <telerik:RadListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="MatListDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Height="420px" Width="350px"
                        OnDataBound="ListBox1_DataBound" AppendDataBoundItems="True" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged">
                        <Items>
                            <telerik:RadListBoxItem Selected="true" Value="-1" Text="(Select One)" />
                        </Items>

                    </telerik:RadListBox>
                </td>



                <td style="vertical-align: top">
                    <asp:UpdatePanel runat="server" ID="updatePanel1">
                        <ContentTemplate>
                            <asp:DetailsView ID="StockDetailsView" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                                DataSourceID="MatStockDataSource" Width="100%" DataKeyNames="MAT_ID" SkinID="DetailsViewSkin"
                                EnableViewState="False" OnDataBound="StockDetailsView_DataBound" OnModeChanging="StockDetailsView_ModeChanging">
                                <Fields>
                                    <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif"
                                        EditImageUrl="~/Images/icon-edit.gif" SelectImageUrl="~/Images/icon-select.gif"
                                        UpdateImageUrl="~/Images/icon-save.gif" />
                                    <asp:TemplateField HeaderText="Material Code1" SortExpression="MAT_CODE1">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMat1" runat="server" Text='<%# Bind("MAT_CODE1") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMat1" runat="server" Text='<%# Bind("MAT_CODE1") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tag No" SortExpression="MAT_CODE2">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMat2" runat="server" Text='<%# Bind("MAT_CODE2") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMat2" runat="server" Text='<%# Bind("MAT_CODE2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Mesc Code" SortExpression="MAT_CODE3">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMat3" runat="server" Text='<%# Bind("MAT_CODE3") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMat3" runat="server" Text='<%# Bind("MAT_CODE3") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                      <asp:TemplateField HeaderText="Mat Code" SortExpression="MAT_CODE4">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMat4" runat="server" Text='<%# Bind("MAT_CODE4") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMat4" runat="server" Text='<%# Bind("MAT_CODE4") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="GL Code" SortExpression="GL_CODE">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtGLCode" runat="server" Text='<%# Bind("GL_CODE") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label66" runat="server" Text='<%# Bind("GL_CODE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="SIZE_DESC" HeaderText="Size Desc" SortExpression="SIZE_DESC" />
                                    <asp:BoundField DataField="WALL_THK" HeaderText="Schedule/ Wall Thk" SortExpression="WALL_THK" />
                                    <asp:BoundField DataField="SIZE1" HeaderText="Size 1" SortExpression="SIZE1" />
                                    <asp:BoundField DataField="SIZE2" HeaderText="Size 3" SortExpression="SIZE2" />
                                    <asp:BoundField DataField="THK1" HeaderText="Sch1" SortExpression="THK1" />
                                    <asp:BoundField DataField="THK2" HeaderText="Sch2" SortExpression="THK2" />
                                    <asp:BoundField DataField="UNIT_WEIGHT" HeaderText="Unit Weight" SortExpression="UNIT_WEIGHT" />
                                    <asp:TemplateField HeaderText="Item Name" SortExpression="ITEM_NAM" >
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ItemDataSource"  AppendDataBoundItems="true"
                                                DataTextField="ITEM_NAM" DataValueField="ITEM_ID" SelectedValue='<%# Bind("ITEM_ID") %>'
                                                Width="128px">
                                                <asp:ListItem Text="Please select" Value="" />
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ITEM_NAM") %>'></asp:TextBox>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("ITEM_NAM") %>' Width="128px" ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="UOM" SortExpression="UOM">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="UomDataSource" AppendDataBoundItems="true"
                                                DataTextField="UOM" DataValueField="UNIT_ID" SelectedValue='<%# Bind("UNIT_ID") %>'
                                                Width="77px">
                                                 <asp:ListItem Text="Please select" Value="" />
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("UOM") %>' Width="77px"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Material Type" SortExpression="MAT_TYPE">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PT_CODE" HeaderText="Part Code" SortExpression="PT_CODE" />
                                    <asp:BoundField DataField="CLASS" HeaderText="Class/ Rating" SortExpression="CLASS" />
                                    <asp:BoundField DataField="SHORT_DESCR" HeaderText="Short Description" SortExpression="SHORT_DESCR" />
                                    <asp:TemplateField HeaderText="Long Description" SortExpression="MAT_DESCR">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MAT_DESCR") %>' Width="95%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("MAT_DESCR") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>

            </tr>
        </table>
    </div>



    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPOdepend" runat="server" Text="PO" Width="80" OnClick="btnPOdepend_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRecvd" runat="server" Text="MRV" Width="80" OnClick="btnRecvd_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMRIR" runat="server" Text="MRIR" Width="80" OnClick="btnMRIR_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnTrans" runat="server" Text="Transfer" Width="80" OnClick="btnTrans_Click"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnAddIssue" runat="server" Text="Add Issue" Width="80" OnClick="btnAddIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnHeatNos" runat="server" Text="Heat Nos" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>
                <%-- <td>
                    <telerik:RadButton ID="btnSplFabJC" runat="server" Text="Job Card" Width="110" OnClick="btnJC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJoints" runat="server" Text="Welding Joints" Width="110" OnClick="btnJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnInventoryAlloc" runat="server" Text="Inventory Alloc" Width="120" OnClick="btnInventoryAlloc_Click"></telerik:RadButton>
                </td>--%>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="MatStockDataSource" runat="server" SelectMethod="GetDataByMAT_ID"
        TypeName="dsMainTablesATableAdapters.PIP_MAT_STOCKTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListBox1" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_CODE1" Type="String" />
            <asp:Parameter Name="MAT_CODE2" Type="String" />
            <asp:Parameter Name="MAT_CODE3" Type="String" />
            <asp:Parameter Name="MAT_CODE4" Type="String" />
            <asp:Parameter Name="GL_CODE" Type="String" />
            <asp:Parameter Name="SIZE_DESC" Type="String" />
            <asp:Parameter Name="SIZE1" Type="String" />
            <asp:Parameter Name="SIZE2" Type="String" />
            <asp:Parameter Name="WALL_THK" Type="String" />
            <asp:Parameter Name="THK1" Type="String" />
            <asp:Parameter Name="THK2" Type="String" />
            <asp:Parameter Name="UNIT_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="UNIT_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="CLASS" Type="String" />
            <asp:Parameter Name="PT_CODE" Type="String" />
            <asp:Parameter Name="SHORT_DESCR" Type="String" />
            <asp:Parameter Name="MAT_DESCR" Type="String" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="UomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT UNIT_ID,UOM FROM UOM_DESCR ORDER BY UOM"></asp:SqlDataSource>
    <asp:ObjectDataSource ID="MatListDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsMainTablesATableAdapters.PIP_MAT_STOCKTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtItemCode" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="ItemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ITEM_ID, ITEM_NAM FROM PIP_MAT_ITEM ORDER BY ITEM_NAM"></asp:SqlDataSource>
</asp:Content>
