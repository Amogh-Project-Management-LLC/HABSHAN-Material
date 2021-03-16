<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" Title="Admin" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .dutton_div {
            width: 220px;
            padding: 5px;
            background-color: whitesmoke;
            margin: 3px;
            border-radius: 5px;
        }

        .tbl_header {
            width: 220px;
            padding: 5px;
            background-color: gainsboro;
            margin: 3px;
            border-radius: 5px;
            vertical-align: central;
            text-align: center;
            font-size: larger;
        }
    </style>
    <table style="width: 100%">
        <tr>
            <td class="tbl_header" style="width: 230px; " runat="server" visible="false">Imports</td>

            <td class="tbl_header" style="width: 230px" runat="server" visible="false">Updates</td>
            <td class="tbl_header" style="width: 230px">Misc</td>
            <td class="tbl_header" style="width: 230px">Settings</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 230px; vertical-align: top; " runat="server" visible="false">
                <div class="dutton_div">
                    <telerik:RadButton ID="btnImportCccMTO" runat="server" Text="Import CCC MTO" Width="200px" OnClick="btnImportCccMTO_Click">
                    </telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton ID="btnImportMRR" runat="server" Text="Import MRR" Width="200px" OnClick="btnImportMRR_Click">
                    </telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportCmsAvl" runat="server" Text="Import CMS Material Avl." Width="200px" OnClick="btnImportCmsAvl_Click">
                    </telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportBarCodeFitupWelding" runat="server" Text="Import Bar-Code Text Data" Width="200px"
                        OnClick="btnImportBarCodeFitupWelding_Click">
                    </telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportFieldDWR" runat="server" Text="Import Field DWR" Width="200px" OnClick="btnImportFieldDWR_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportIsoList" runat="server" Text="Import Iso List" Width="200px" OnClick="btnImportIsoList_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportSuppMTO" runat="server" Text="Import Support MTO" Width="200px" OnClick="btnImportSuppMTO_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnImportMSR" runat="server" Text="Import MSR" Width="200px" OnClick="btnImportMSR_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton ID="btnImportPO" runat="server" Text="Import PO" Width="200px" OnClick="btnImportPO_Click" ></telerik:RadButton>
                </div>
            </td>

            <td style="width: 230px; vertical-align: top" runat="server" visible="false">
                <div class="dutton_div">
                    <telerik:RadButton ID="btnUpdateAll" runat="server" Text="Update" Width="200px" OnClick="btnUpdateAll_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnUpdatePipeSupp" runat="server" Text="Update Pipe Support" Width="200px" OnClick="btnUpdateSuppMTO_Click" Style="top: 0px; left: 0px"></telerik:RadButton>
                </div>
            </td>
            <td style="width: 230px; vertical-align: top">
                <div class="dutton_div">
                    <telerik:RadButton ID="btnDelSessionData" runat="server" Text="Delete Session Log"
                        Width="200px" OnClick="btnDelSessionData_Click" Skin="Sunset">
                    </telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton ID="btnUsers" runat="server" Text="User Accounts" Width="200px" OnClick="btnUsers_Click"></telerik:RadButton>
                </div>
                <div class="dutton_div">
                    <telerik:RadButton ID="btnCollectSpoolgenPDF" Enabled="false" runat="server" Text="Collect Spoolgen PDFs" Width="200px" OnClick="btnCollectSpoolgenPDF_Click"></telerik:RadButton>
                </div>

                <div class="dutton_div">
                    <telerik:RadButton Enabled="false" ID="btnExportData" runat="server" Text="Export Data for CMS" Width="200px" OnClick="btnExportData_Click"></telerik:RadButton>
                </div>

                <div class="dutton_div">
                    <telerik:RadButton ID="btnAllocation" runat="server" Enabled="false" Text="Material Allocation" Width="200px" OnClick="btnAllocation_Click" Skin="Sunset"></telerik:RadButton>
                </div>
            </td>
            <td style="width: 230px; vertical-align: top">
                <div class="dutton_div">
                    <telerik:RadButton ID="btnSetPriority" runat="server" Text="Set Priority"
                        Width="200px" OnClick="btnSetPriority_Click" >
                    </telerik:RadButton>
                </div>
            </td>
            <td style="vertical-align: top; text-align: right;">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/new/admin-home-logo.png" ImageAlign="Right" />
            </td>
        </tr>
    </table>
</asp:Content>