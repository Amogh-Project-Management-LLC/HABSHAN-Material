<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableSessionState="ReadOnly"
    CodeFile="ExportData2.aspx.cs" Inherits="Home_ExportData" Title="Export Data" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div_frame {
            width: 600px;
            padding: 5px;
            background-color: gainsboro;
            margin: 3px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
    <table style="width: 100%;">
        <tr>
            <td style="background-color: gainsboro;">

                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnPreview" runat="server" Text="Excel CSV" Width="90" OnClick="btnPreview_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnExportExcel" runat="server" Text="Zip" Width="80" OnClick="btnExportExcel_Click"></telerik:RadButton>
                        </td>

                        <td>
                            <asp:ImageButton ID="ImageButtonProcedure" runat="server" ImageUrl="~/Images/knob/Refresh.png" ToolTip="PIVOT REFRESH" OnClick="ImageButtonProcedure_Click" />
                        </td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <td>

                                    <asp:HyperLink ID="HyperLinkPreview" runat="server" ImageUrl="~/Images/icons/printer.png" Target="_blank"></asp:HyperLink>

                                </td>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td>
                
                        <table>
                            <tr class="div_frame">
                                <td></td>
                                <td>
                                    <div>
                                        <%--<telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="true" EmptyMessage="Search" Width="500" OnTextChanged="txtSearch_TextChanged"></telerik:RadTextBox>--%>
                                        <telerik:RadSearchBox RenderMode="Lightweight" runat="server" ID="txtSearch" OnSearch="txtSearch_Search"
                                            DataSourceID="SqlDataSource1" Width="300"
                                            MaxResultCount="10" EmptyMessage="Search"
                                            DataTextField="EXPT_TITLE" DataValueField="EXPT_ID">
                                            <DropDownSettings Height="400" Width="300">
                                            </DropDownSettings>
                                        </telerik:RadSearchBox>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <telerik:RadListBox ID="ExportCatList" runat="server" Height="450px" Width="200px"
                                        DataSourceID="sqlExportCat" DataTextField="CAT_NAME" DataValueField="CAT_ID" AutoPostBack="true">
                                    </telerik:RadListBox>
                                </td>
                                <td style="text-align: center">
                                    <telerik:RadListBox ID="ExportSubCatList" runat="server" Height="450px" Width="300px"
                                        DataSourceID="sqlExportSubCat" DataTextField="SUB_CAT_NAME" DataValueField="SUB_CAT_ID" AutoPostBack="true">
                                    </telerik:RadListBox>
                                </td>
                                <td style="text-align: left">
                                    <telerik:RadListBox ID="ExportsListBox1" runat="server" Height="450px" Width="600px" AutoPostBack="true" OnSelectedIndexChanged="ExportsListBox1_SelectedIndexChanged"
                                        DataSourceID="exportsDataSource" DataTextField="EXPT_TITLE" DataValueField="EXPT_ID">
                                    </telerik:RadListBox>
                                </td>
                            </tr>
                        </table>

                  
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="exportsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT EXPT_ID, EXPT_TITLE FROM VIEW_IPMS_SYS_EXPORT WHERE (EXPT_TITLE LIKE FNC_FILTER(:EXPT_TITLE))  AND CAT_ID = :CAT_ID AND SUB_CAT_ID = :SUB_CAT_ID "
        OnSelecting="exportsDataSource_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="EXPT_TITLE" PropertyName="Text" />
            <asp:ControlParameter ControlID="ExportCatList" DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ExportSubCatList" DefaultValue="-1" Name="SUB_CAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlExportSubCat" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM IPMS_SYS_EXPORT_SUB_CAT WHERE  SUB_CAT_ID IN (SELECT SUB_CAT_ID FROM IPMS_SYS_EXPORT WHERE CAT_ID= :CAT_ID) ORDER BY SUB_CAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ExportCatList" DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="OutPutDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:HiddenField ID="FileName_HiddenField" runat="server" />
    <asp:SqlDataSource ID="sqlExportCat" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM IPMS_SYS_EXPORT_CAT ORDER BY CAT_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT EXPT_ID, EXPT_TITLE FROM VIEW_IPMS_SYS_EXPORT"></asp:SqlDataSource>
</asp:Content>
