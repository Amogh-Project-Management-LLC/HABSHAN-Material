<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="IrnItems.aspx.cs" Inherits=" Mrr_Irn_items" Title="Mrr Irn Items" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>

                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <div id="HeaderDiv">
                        <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                    </div>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Visible="false" Text="Save" Width="80px" OnClick="btnSave_Click" />
                </td>


            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; text-align: right; padding: 2px;">
    </div>

    <table runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 180px; background-color: gainsboro">MAT RCV NO

            </td>
            <td style="width: 248px">

                <telerik:RadComboBox ID="RadMatRcvNo" runat="server" DataSourceID="MrrDataSource" DataTextField="MAT_RCV_NO" AllowCustomText="true"
                    Filter="Contains" DataValueField="MAT_RCV_ID" Width="250px" AutoPostBack="true" CausesValidation="false">
                </telerik:RadComboBox>
            </td>

            <td style="width: 180px; background-color: gainsboro">IRN NO

            </td>
            <td>
                <telerik:RadComboBox ID="RadIrnNo" runat="server" DataSourceID="IrnDataSource" DataTextField="IRN_NO" AllowCustomText="true"
                    AppendDataBoundItems="true" Filter="Contains" DataValueField="IRN_ID" Width="250px" AutoPostBack="true" CausesValidation="false">
                </telerik:RadComboBox>
            </td>
        </tr>
    </table>


    <div>
        <telerik:RadGrid ID="MrrGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CssClass="DataWebControlStyle" DataKeyNames="UNIQ_ID" DataSourceID="MrrViewDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            PageSize="50" AllowSorting="true"
            PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)" OnItemDataBound="OnItemDataBoundHandler" OnItemCommand="MrrGridView_ItemCommand">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings EnablePostBackOnRowClick="true">
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="MrrViewDataSource" DataKeyNames="UNIQ_ID" AutoGenerateColumns="False" PageSize="50"
                AllowFilteringByColumn="true" EditMode="InPlace"
                AllowMultiColumnSorting="true" ClientDataKeyNames="UNIQ_ID" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow" UniqueName="DeleteCommandColumn"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="UNIQ_ID" HeaderText="UNIQ ID" SortExpression="UNIQ_ID" ReadOnly="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MAT RCV NO"
                        SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="IRN_NO" HeaderText="IRN NUMBER"
                        SortExpression="IRN_NO">
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="250px" DataSourceID="IrnDataSource"
                                DataTextField="IRN_NO" DataValueField="IRN_ID" EnableLoadOnDemand="True" DropDownAutoWidth="Enabled"
                                AppendDataBoundItems="true" AllowCustomText="true" Filter="Contains" OnSelectedIndexChanged="OnSelectedIndexChangedHandler"
                                AutoPostBack="true" CausesValidation="false">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="IRN_NOLabel" runat="server" Text='<%# Eval("IRN_NO") %>'></asp:Label>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>

    </div>

    <asp:SqlDataSource ID="MrrViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PIP_MAT_RECEIVE_IRN.*,PIP_MAT_RECEIVE.MAT_RCV_NO,PIP_PO_IRN.IRN_NO FROM PIP_MAT_RECEIVE_IRN 
                         LEFT OUTER JOIN PIP_MAT_RECEIVE
                         ON  PIP_MAT_RECEIVE_IRN.MAT_RCV_ID=PIP_MAT_RECEIVE.MAT_RCV_ID 
                        LEFT OUTER JOIN PIP_PO_IRN ON PIP_MAT_RECEIVE_IRN.IRN_ID=PIP_PO_IRN.IRN_ID
                        WHERE (PIP_MAT_RECEIVE_IRN.MAT_RCV_ID = :MAT_RCV_ID)"
        DeleteCommand="DELETE FROM PIP_MAT_RECEIVE_IRN  WHERE (UNIQ_ID = :UNIQ_ID)"
        UpdateCommand="UPDATE PIP_MAT_RECEIVE_IRN  
                        SET IRN_ID=:IRN_ID WHERE UNIQ_ID=:UNIQ_ID"
        InsertCommand="INSERT INTO PIP_MAT_RECEIVE_IRN (MAT_RCV_ID,IRN_ID) VALUES(:MAT_RCV_ID,:IRN_ID)">

        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID" Type="Decimal" />
        </SelectParameters>

        <UpdateParameters>
            <%--<asp:Parameter Name="IRN_ID" Type="Decimal" />--%>
            <asp:SessionParameter SessionField="IRN_ID" Name="IRN_ID" Type="Int32" />
            <asp:Parameter Name="UNIQ_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UNIQ_ID" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter Name="MAT_RCV_ID" ControlID="RadMatRcvNo" Type="Decimal" />
            <asp:ControlParameter Name="IRN_ID" ControlID="RadIrnNo" Type="Decimal" />
        </InsertParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="IrnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT  IRN_ID, IRN_NO   FROM PIP_PO_IRN WHERE PROJECT_ID = :PROJECT_ID ORDER BY IRN_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MrrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_RCV_ID, MAT_RCV_NO   FROM PIP_MAT_RECEIVE WHERE PROJECT_ID = :PROJECT_ID ORDER BY MAT_RCV_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
