<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableSessionState="ReadOnly"
    CodeFile="ExportData.aspx.cs" Inherits="Home_ExportData" Title="Export Data" %>

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
                             <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:HyperLink ID="HyperLinkPreview" runat="server" ImageUrl="~/Images/icons/printer.png" Target="_blank"></asp:HyperLink>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="div_frame">
                            <telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="true" EmptyMessage="Search" Width="500" OnTextChanged="txtSearch_TextChanged"></telerik:RadTextBox>
                        </div>
                        <div class="div_frame" style="text-align:left">
                            <telerik:RadListBox ID="ExportsListBox1" runat="server" Height="450px" Width="600px"  OnSelectedIndexChanged="ExportsListBox1_SelectedIndexChanged"
                                DataSourceID="exportsDataSource" DataTextField="EXPT_TITLE" DataValueField="EXPT_ID" AutoPostBack="true">
                            </telerik:RadListBox>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="exportsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT EXPT_ID, EXPT_TITLE
  FROM VIEW_IPMS_SYS_EXPORT
 WHERE VISIBLE_FLAG = 'Y'
   AND (EXPT_TITLE LIKE FNC_FILTER(:EXPT_TITLE))
 ORDER BY EXPT_TITLE"
        OnSelecting="exportsDataSource_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="EXPT_TITLE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="OutPutDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:HiddenField ID="FileName_HiddenField" runat="server" />
</asp:Content>