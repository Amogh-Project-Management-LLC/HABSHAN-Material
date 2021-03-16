<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="MaterialStatusView.aspx.cs" Inherits="Material_Catalog_View" Title="Material Status View" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>

                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
                        Filter="Contains" DataValueField="MAT_ID" Width="250px" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged" AutoPostBack="true"
                        CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Matcode" 
                        ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; text-align: right; padding: 2px;">
    </div>

    <div>

        <asp:DetailsView ID="EleDetailsView" runat="server" AllowPaging="True" AutoGenerateRows="False"
            DataKeyNames="MAT_ID" DataSourceID="sqldatasource" SkinID="DetailsViewSkin"
            OnModeChanging="DetailsView_ModeChanging" Width="600px">

            <Fields>
                <asp:CommandField ShowEditButton="True" ButtonType="Image"
                    CancelImageUrl="~/Images/icon-cancel.gif"
                    EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif"
                    UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="MAT CODE1" />
                <asp:BoundField DataField="MAT_CODE2" HeaderText="MAT CODE2" />
                <asp:BoundField DataField="MAT_CODE3" HeaderText="MAT CODE3" />
                <asp:BoundField DataField="MAT_CODE4" HeaderText="MAT CODE4" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="SIZE DESC" />
                <asp:BoundField DataField="SIZE1" HeaderText="SIZE1" />
                <asp:BoundField DataField="SIZE2" HeaderText="SIZE2" />
                <asp:BoundField DataField="WALL_THK" HeaderText="WALL THK" />
                <asp:BoundField DataField="THK1" HeaderText="THK1" />
                <asp:BoundField DataField="THK2" HeaderText="THK2" />
                <asp:BoundField DataField="UNIT_WEIGHT" HeaderText="UNIT WEIGHT" />
                <asp:TemplateField HeaderText="ITEM NAME">
                    <ItemTemplate>
                        <%#Eval("ITEM_NAM")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="comItem" runat="server"
                            DataSourceID="sqlitemSource" DataTextField="ITEM_NAM"
                            DataValueField="ITEM_ID" SelectedValue='<%# Bind("ITEM_ID") %>'>
                        </telerik:RadComboBox>

                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="UOM">
                    <ItemTemplate>
                        <%#Eval("UOM")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="comUom" runat="server"
                            DataSourceID="sqluomSource" DataTextField="UOM"
                            DataValueField="UNIT_ID" SelectedValue='<%# Bind("UNIT_ID") %>'>
                        </telerik:RadComboBox>

                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="CLASS" HeaderText="CLASS" />
                <asp:BoundField DataField="MAT_TYPE" HeaderText="MAT TYPE" />
                <asp:BoundField DataField="SHORT_DESCR" HeaderText="SHORT DESCR" />
                <asp:BoundField DataField="MAT_DESCR" HeaderText="MAT DESCR" />


            </Fields>
        </asp:DetailsView>

    </div>

    <asp:SqlDataSource ID="sqldatasource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PIP_MAT_STOCK.*,PIP_MAT_ITEM.ITEM_NAM,UOM_DESCR.UOM
                           FROM PIP_MAT_STOCK LEFT OUTER JOIN PIP_MAT_ITEM 
                          ON  PIP_MAT_STOCK.ITEM_ID=PIP_MAT_ITEM.ITEM_ID 
                       LEFT OUTER JOIN UOM_DESCR ON PIP_MAT_STOCK.UNIT_ID=UOM_DESCR.UNIT_ID
                         WHERE (MAT_ID = :MAT_ID)"
        DeleteCommand="DELETE FROM PIP_MAT_STOCK ON  WHERE (MAT_ID = :MAT_ID)"
        UpdateCommand="UPDATE PIP_MAT_STOCK  
                        SET  MAT_CODE1=:MAT_CODE1,MAT_CODE2=:MAT_CODE2,SIZE_DESC=:SIZE_DESC,SIZE1=:SIZE1,SIZE2=:SIZE2,WALL_THK=:WALL_THK,
                             THK1=:THK1,THK2=:THK2,UNIT_WEIGHT=:UNIT_WEIGHT,ITEM_ID=:ITEM_ID,UNIT_ID=:UNIT_ID,CLASS=:CLASS,MAT_TYPE=:MAT_TYPE,SHORT_DESCR=:SHORT_DESCR,MAT_DESCR=:MAT_DESCR,
                            MAT_CODE3=:MAT_CODE3,MAT_CODE4=:MAT_CODE4
                        WHERE (MAT_ID=:MAT_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_CODE1" Type="String" />
            <asp:Parameter Name="MAT_CODE2" Type="String" />
            <asp:Parameter Name="SIZE_DESC" Type="String" />
            <asp:Parameter Name="SIZE1" Type="String" />
            <asp:Parameter Name="SIZE2" Type="String" />
            <asp:Parameter Name="WALL_THK" Type="String" />
            <asp:Parameter Name="THK1" Type="String" />
            <asp:Parameter Name="THK2" Type="String" />
            <asp:Parameter Name="UNIT_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="UNIT_ID" Type="Decimal" />
            <asp:Parameter Name="CLASS" Type="String" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="SHORT_DESCR" Type="String" />
            <asp:Parameter Name="MAT_DESCR" Type="String" />
            <asp:Parameter Name="MAT_CODE3" Type="String" />
            <asp:Parameter Name="MAT_CODE4" Type="String" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlitemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ITEM_ID,ITEM_NAM FROM PIP_MAT_ITEM ORDER BY UPPER(ITEM_NAM)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqluomSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  UNIT_ID,UOM FROM UOM_DESCR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_CODE1,MAT_ID FROM PIP_MAT_STOCK"></asp:SqlDataSource>
</asp:Content>
