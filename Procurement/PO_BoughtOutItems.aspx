<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PO_BoughtOutItems.aspx.cs" Inherits="Procurement_PO_BoughtOutItems" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">   
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add Inspection Detail">
            <Icon PrimaryIconUrl="../Images/New-Icons/Document-New.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnUpload" Text="Upload">
            <Icon PrimaryIconUrl="../Images/New-Icons/Document-New.png" />
        </telerik:RadButton>
    </div>
    
    <div style="margin-top:3px">
        <asp:UpdatePanel runat="server" ID="UpdatePanelGrid">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
                     OnItemCommand="RadGrid1_ItemCommand">
                    <groupingsettings collapsealltooltip="Collapse all groups" />
                    <mastertableview autogeneratecolumns="False" datasourceid="itemsDataSource" AllowAutomaticDeletes="true" 
                         EditMode="InPlace">
                        <Columns>                            
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ItemStyle-Width="15px"></telerik:GridButtonColumn>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="15px"/>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="INSP_TYPE_DESC" ReadOnly="true" FilterControlAltText="Filter INSP_TYPE_DESC column" HeaderText="INSPECTION TYPE" SortExpression="INSP_TYPE_DESC" UniqueName="INSP_TYPE_DESC">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INSP_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter INSP_DATE column" HeaderText="INSP DATE" SortExpression="INSP_DATE" UniqueName="INSP_DATE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INSP_REP_NO" FilterControlAltText="Filter INSP_REP_NO column" HeaderText="INSP REPORT NO" SortExpression="INSP_REP_NO" UniqueName="INSP_REP_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INSP_RESULT" FilterControlAltText="Filter INSP_RESULT column" HeaderText="RESULT" SortExpression="INSP_RESULT" UniqueName="INSP_RESULT">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INSP_REMARKS" FilterControlAltText="Filter INSP_REMARKS column" HeaderText="REMARKS" SortExpression="INSP_REMARKS" UniqueName="INSP_REMARKS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CREATE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CREATE_BY_USER" FilterControlAltText="Filter CREATE_BY_USER column" HeaderText="CREATE BY" SortExpression="CREATE_BY_USER" UniqueName="CREATE_BY_USER">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UPDATE_BY_USER" FilterControlAltText="Filter UPDATE_BY_USER column" HeaderText="UPDATE BY" SortExpression="UPDATE_BY_USER" UniqueName="UPDATE_BY_USER">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UPDATE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter UPDATE_DATE column" HeaderText="UPDATE_DATE" SortExpression="UPDATE_DATE" UniqueName="UPDATE_DATE">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </mastertableview>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_ATableAdapters.VIEW_PO_BOUGHT_OUT_INSPTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_INSP_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PO_ID" SessionField="PO_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="INSP_DATE" Type="DateTime" />
            <asp:Parameter Name="INSP_REP_NO" Type="String" />
            <asp:Parameter Name="INSP_RESULT" Type="String" />
            <asp:Parameter Name="INSP_REMARKS" Type="String" />
            <asp:Parameter Name="UPDATE_DATE" Type="DateTime" />
            <asp:Parameter Name="UPDATE_BY" Type="Decimal" />
            <asp:Parameter Name="original_INSP_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

