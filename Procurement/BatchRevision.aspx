<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="BatchRevision.aspx.cs" Inherits="BatchRevision" Title="Revision" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%">
            <tr>
                <td>
                  <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right; padding: 2px;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; text-align: right; padding: 2px;">
    </div>

    <div>
        <asp:DetailsView ID="revisionDetailsView" runat="server" AllowPaging="True" AutoGenerateRows="False"
            DataKeyNames="REV_ID" DataSourceID="RevDataSource" SkinID="DetailsViewSkin"
            OnModeChanging="revisionDetailsView_ModeChanging" Width="600px" OnDataBound="revisionDetailsView_DataBound"
            OnPageIndexChanged="revisionDetailsView_PageIndexChanged">
            <EmptyDataTemplate>
                No Revision[s] Found!
            </EmptyDataTemplate>
            <Fields>
                <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif"
                    EditImageUrl="~/Images/icon-edit.gif" SelectImageUrl="~/Images/icon-select.gif"
                    UpdateImageUrl="~/Images/icon-save.gif" />
                <asp:BoundField DataField="PO_NO" HeaderText="PO No" SortExpression="PO_NO" ReadOnly="true" />
                <asp:BoundField DataField="BATCH_NO" HeaderText="BATCH No" SortExpression="BATCH_NO" ReadOnly="true" />
                <asp:BoundField DataField="REV_NO" HeaderText="Revision" SortExpression="REV_NO" ReadOnly="true" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="BATCH_CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="Batch Create Date" HtmlEncode="False" SortExpression="BATCH_CREATE_DATE" ReadOnly="true" />

                <asp:BoundField DataField="BATCH_CREATED_BY" HeaderText="Batch Create By" SortExpression="BATCH_CREATED_BY" ReadOnly="true" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="BATCH_REV_CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="Rev Create Date" HtmlEncode="False" SortExpression="BATCH_REV_CREATE_DATE" ReadOnly="true" />

                <asp:BoundField DataField="BATCH_REV_CREATED_BY" HeaderText="Rev Create By" SortExpression="BATCH_REV_CREATED_BY" ReadOnly="true" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="BATCH_REV_CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="Rev Create Date" HtmlEncode="False" SortExpression="BATCH_REV_CREATE_DATE" ReadOnly="true" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="PIM_INITIAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="PIM INITIAL" HtmlEncode="False" SortExpression="PIM_INITIAL" ReadOnly="true" Visible="false"/>

                <asp:BoundField ApplyFormatInEditMode="True" DataField="PIM_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="PIM FORECAST" HtmlEncode="False" SortExpression="PIM_FORECAST" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="PIM_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="PIM ACTUAL" HtmlEncode="False" SortExpression="PIM_ACTUAL" InsertVisible="False" />

                <asp:BoundField ApplyFormatInEditMode="True" DataField="MANF_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="MANUFACTURING BASE_PLAN" HtmlEncode="False" SortExpression="MANF_BASE_PLAN" InsertVisible="False" ReadOnly="true" Visible="false"/>
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="MANF_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="MANUFACTURING FORECAST" HtmlEncode="False" SortExpression="MANF_FORECAST" InsertVisible="False" ReadOnly="true" Visible="false"/>
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="MANF_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="MANUFACTURING ACTUAL" HtmlEncode="False" SortExpression="MANF_ACTUAL" InsertVisible="False" ReadOnly="true" Visible="false"/>

                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="FAT_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="FAT BASE PLAN" HtmlEncode="False" SortExpression="FAT_BASE_PLAN" InsertVisible="False" ReadOnly="true" Visible="false"/>
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="FAT_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="FAT FORECAST" HtmlEncode="False" SortExpression="FAT_FORECAST" InsertVisible="False" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="FAT_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="FAT ACTUAL" HtmlEncode="False" SortExpression="FAT_ACTUAL" InsertVisible="False" />

                    <asp:BoundField ApplyFormatInEditMode="True" DataField="DELIVERY_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="DELIVERY BASE PLAN" HtmlEncode="False" SortExpression="DELIVERY_BASE_PLAN" InsertVisible="False" ReadOnly="true" Visible="false" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="DELIVERY_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="DELIVERY SITE FORECAST" HtmlEncode="False" SortExpression="DELIVERY_FORECAST" InsertVisible="False" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="DELIVERY_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="DELIVERY SITE ACTUAL" HtmlEncode="False" SortExpression="DELIVERY_ACTUAL" InsertVisible="False" />

<%--                  <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_EXWORKS_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Width="150px"
                    HeaderText="RECEIVED EX-WORKS BASE PLAN" HtmlEncode="False" SortExpression="RCVD_EXWORKS_BASE_PLAN" InsertVisible="False" Visible="false" />--%>
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_EXWORKS_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED EX-WORKS FORECAST" HtmlEncode="False" SortExpression="RCVD_EXWORKS_FORECAST" InsertVisible="False" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_EXWORKS_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED EX-WORKS ACTUAL" HtmlEncode="False" SortExpression="RCVD_EXWORKS_ACTUAL" InsertVisible="False" />

<%--                  <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_PORT_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED PORT BASE PLAN" HtmlEncode="False" SortExpression="RCVD_PORT_BASE_PLAN" InsertVisible="False" Visible="false"/>
                --%>
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_PORT_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED PORT FORECAST" HtmlEncode="False" SortExpression="RCVD_PORT_FORECAST" InsertVisible="False" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_PORT_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED PORT ACTUAL" HtmlEncode="False" SortExpression="RCVD_PORT_ACTUAL" InsertVisible="False" />

<%--                  <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_SITE_BASE_PLAN" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED SITE BASE PLAN" HtmlEncode="False" SortExpression="RCVD_SITE_BASE_PLAN" InsertVisible="False" Visible="false"/>
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_SITE_FORECAST" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED SITE FORECAST" HtmlEncode="False" SortExpression="RCVD_SITE_FORECAST" InsertVisible="False" Visible="false" />
                
                <asp:BoundField ApplyFormatInEditMode="True" DataField="RCVD_SITE_ACTUAL" DataFormatString="{0:dd-MMM-yyyy}"
                    HeaderText="RECEIVED SITE ACTUAL" HtmlEncode="False" SortExpression="RCVD_SITE_ACTUAL" InsertVisible="False" Visible="false" />--%>

               <asp:BoundField DataField="REV_REMARKS" HeaderText="REVISION REMARKS" SortExpression="REV_REMARKS"  />
              <%--  <asp:TemplateField HeaderText="REVISION REMARKS" SortExpression="REV_REMARKS" >
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REV_REMARKS") %>' Width="98%"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("REV_REMARKS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Fields>
        </asp:DetailsView>
    </div>
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="80" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="80" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="RevDataSource" runat="server" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_BATCH_REV_ADAPTERTableAdapter"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="BATCH_ID" QueryStringField="BATCH_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_REV_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PIM_FORECAST" Type="DateTime" />
            <asp:Parameter Name="PIM_ACTUAL" Type="DateTime" />
            <asp:Parameter Name="FAT_FORECAST" Type="DateTime" />
            <asp:Parameter Name="FAT_ACTUAL" Type="DateTime" />
            <asp:Parameter Name="DELIVERY_FORECAST" Type="DateTime" />
            <asp:Parameter Name="DELIVERY_ACTUAL" Type="DateTime" />
            <asp:Parameter Name="RCVD_EXWORKS_FORECAST" Type="DateTime" />
            <asp:Parameter Name="RCVD_EXWORKS_ACTUAL" Type="DateTime" />
            <asp:Parameter Name="RCVD_PORT_FORECAST" Type="DateTime" />
            <asp:Parameter Name="RCVD_PORT_ACTUAL" Type="DateTime" />
            <asp:Parameter Name="REV_REMARKS" Type="String" />
            <asp:Parameter Name="original_REV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
   <%-- <asp:SqlDataSource ID="markerDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MARKER_ID, UPPER(MARKER_NAME) AS MARKER_NAME FROM DWG_MARKER WHERE PROJECT_ID = :PROJECT_ID ORDER BY MARKER_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sguserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SG_USER_ID, UPPER(USER_NAME) AS USER_NAME FROM SG_USERS WHERE PROJECT_ID = :PROJECT_ID ORDER BY USER_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="statusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STATUS_ID, STATUS_CODE FROM ISOME_STATUS ORDER BY ISOME_STATUS.STATUS_CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sgtypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIP_SG_TYPE.SG_TYPE, PIP_SG_TYPE.DESCR FROM PIP_SG_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DIR_ID, DIR_OBJ FROM DIR_OBJECTS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY DIR_OBJ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sqlBackCheck" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT upper(USER_NAME) as USER_NAME
FROM USERS
ORDER BY USER_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHoldType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM HOLD_REQUEST_TYPE ORDER BY TYPE_NAME"></asp:SqlDataSource>
    --%>
    <asp:HiddenField ID="YesNoStatusHiddenField" runat="server" />
</asp:Content>
