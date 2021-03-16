<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Joints.aspx.cs" Inherits="HeatNo_HeatNo_Joints" Title="Material - Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 3px;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="jointsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="JointsDataSource" Width="100%" AllowPaging="True" OnDataBound="jointsGridView_DataBound"
            PageSize="20">
            <Columns>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isome" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool No" SortExpression="SPOOL" />
                <asp:BoundField DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                <asp:BoundField DataField="JNT_REV_CODE" HeaderText="Rev-Code" SortExpression="JNT_REV_CODE" />
                <asp:BoundField DataField="CAT_NAME" HeaderText="SF" SortExpression="CAT_NAME" />
                <asp:BoundField DataField="JOINT_TYPE" HeaderText="Type" SortExpression="JOINT_TYPE" />
                <asp:BoundField DataField="JOINT_SIZE_DEC" HeaderText="Size" SortExpression="JOINT_SIZE_DEC" />
                <asp:BoundField DataField="ITEM_CODE1" HeaderText="Item 1" SortExpression="ITEM_CODE1" />
                <asp:BoundField DataField="ITEM_CODE2" HeaderText="Item 2" SortExpression="ITEM_CODE2" />
                <asp:BoundField DataField="FITUP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Fitup Date"
                    HtmlEncode="False" SortExpression="FITUP_DATE" />
                <asp:BoundField DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date"
                    HtmlEncode="False" SortExpression="WELD_DATE" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="JointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOB_CODE, ISO_TITLE1, WO_NAME,
SHEET, SPOOL,
MAT_TYPE, MAT_CLASS, JOINT_NO, CAT_NAME, JNT_REV_CODE, JOINT_TYPE, JOINT_SIZE_DEC, JOINT_THK, SCHEDULE, HEAT_NO1, HEAT_NO2,
FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, WPS_NO, TW_FLG, NDE_SW, PROG_SW, ITEM_CODE1, ITEM_CODE2
FROM VIEW_TOTAL_JOINTS
WHERE (PROJ_ID = :PROJECT_ID)
AND ((MAT_ID1 = :MAT_ID) OR (MAT_ID2 = :MAT_ID))
ORDER BY   ISO_TITLE1, JOINT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>