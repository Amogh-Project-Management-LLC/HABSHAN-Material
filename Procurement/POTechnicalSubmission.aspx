<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POTechnicalSubmission.aspx.cs" Inherits="Procurement_POTechnicalSubmission" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add" Width="80px">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-new.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 3px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="True" PageSize="15">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="PO_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                        EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="15px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                                <ItemStyle Width="15px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PO_REVISION" ReadOnly="true" FilterControlAltText="Filter PO_REVISION column" HeaderText="PO REV" SortExpression="PO_REVISION" UniqueName="PO_REVISION">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="ITP_SUBMIT_DT" DataType="System.DateTime" FilterControlAltText="Filter ITP_SUBMIT_DT column" HeaderText="ITP SUBMIT DATE" SortExpression="ITP_SUBMIT_DT" UniqueName="ITP_SUBMIT_DT">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="ITP_SUBMIT_DT_DatePicker" DbSelectedDate='<%# Bind("ITP_SUBMIT_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="ITP_SUBMIT_DTLabel" runat="server" Text='<%# Eval("ITP_SUBMIT_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ITP_REVIEW_DT" DataType="System.DateTime" FilterControlAltText="Filter ITP_REVIEW_DT column" HeaderText="ITP REVIEW DATE" SortExpression="ITP_REVIEW_DT" UniqueName="ITP_REVIEW_DT">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="ITP_REVIEW_DatePicker" DbSelectedDate='<%# Bind("ITP_REVIEW_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>                                   
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="ITP_REVIEW_DTLabel" runat="server" Text='<%# Eval("ITP_REVIEW_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ITP_APPROVE_DT" DataType="System.DateTime" FilterControlAltText="Filter ITP_APPROVE_DT column" HeaderText="ITP APPROVE DATE" SortExpression="ITP_APPROVE_DT" UniqueName="ITP_APPROVE_DT">
                                <EditItemTemplate>
                                       <telerik:RadDatePicker runat="server" ID="ITP_APPROVE_DTTextBox" DbSelectedDate='<%# Bind("ITP_APPROVE_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>                                     
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="ITP_APPROVE_DTLabel" runat="server" Text='<%# Eval("ITP_APPROVE_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="DWG_SPEC_SUBMIT_DT" DataType="System.DateTime" FilterControlAltText="Filter DWG_SPEC_SUBMIT_DT column" HeaderText="DWG SPEC SUBMIT DATE" SortExpression="DWG_SPEC_SUBMIT_DT" UniqueName="DWG_SPEC_SUBMIT_DT">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="DWG_SPEC_SUBMIT_DTTextBox" DbSelectedDate='<%# Bind("DWG_SPEC_SUBMIT_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>                                    
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DWG_SPEC_SUBMIT_DTLabel" runat="server" Text='<%# Eval("DWG_SPEC_SUBMIT_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="DWG_SPEC_REVIEW_DT" DataType="System.DateTime" FilterControlAltText="Filter DWG_SPEC_REVIEW_DT column" HeaderText="DWG SPEC REVIEW DATE" SortExpression="DWG_SPEC_REVIEW_DT" UniqueName="DWG_SPEC_REVIEW_DT">
                                <EditItemTemplate>
                                     <telerik:RadDatePicker runat="server" ID="DWG_SPEC_REVIEW_DTTextBox" DbSelectedDate='<%# Bind("DWG_SPEC_REVIEW_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>                                     
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DWG_SPEC_REVIEW_DTLabel" runat="server" Text='<%# Eval("DWG_SPEC_REVIEW_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="DWG_SPEC_APPROVE_DT" DataType="System.DateTime" FilterControlAltText="Filter DWG_SPEC_APPROVE_DT column" HeaderText="DWG SPEC APPROVE DATE" SortExpression="DWG_SPEC_APPROVE_DT" UniqueName="DWG_SPEC_APPROVE_DT">
                                <EditItemTemplate>
                                     <telerik:RadDatePicker runat="server" ID="DWG_SPEC_APPROVE_DTTextBox" DbSelectedDate='<%# Bind("DWG_SPEC_APPROVE_DT") %>'
                                         Width="100px"></telerik:RadDatePicker>                                    
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DWG_SPEC_APPROVE_DTLabel" runat="server" Text='<%# Eval("DWG_SPEC_APPROVE_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CREATE_DATE" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                            </telerik:GridBoundColumn>

                        </Columns>

                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_ATableAdapters.VIEW_PO_TECHNICAL_SUBMISSIONTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_PO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ITP_SUBMIT_DT" Type="DateTime" />
            <asp:Parameter Name="ITP_REVIEW_DT" Type="DateTime" />
            <asp:Parameter Name="ITP_APPROVE_DT" Type="DateTime" />
            <asp:Parameter Name="DWG_SPEC_SUBMIT_DT" Type="DateTime" />
            <asp:Parameter Name="DWG_SPEC_REVIEW_DT" Type="DateTime" />
            <asp:Parameter Name="DWG_SPEC_APPROVE_DT" Type="DateTime" />
            <asp:Parameter Name="original_PO_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

