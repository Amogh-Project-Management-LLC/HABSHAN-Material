<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PresDetailAdd - Copy.aspx.cs" Inherits="Preservation_PresDetailAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <div>
        <table>            
            <%--<tr>
                <td style="width: 150px; background-color: #EBF5F7">Store</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSCList" runat="server" DataSourceID="sqlStoreList" DataTextField="STORE_NAME" DataValueField="STORE_ID" AppendDataBoundItems="True" AutoPostBack="True" 
                        OnDataBinding="ddlSCList_DataBinding1"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Substore</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSubStore" runat="server" DataSourceID="sqlSubStoreList" DataTextField="STORE_L1"
                        Width="250px" DataValueField="SUBSTORE_ID" AppendDataBoundItems="True" AutoPostBack="True" OnDataBinding="ddlMirList_DataBinding" OnSelectedIndexChanged="ddlMirList_SelectedIndexChanged">
                    </telerik:RadDropDownList>
                </td>
            </tr>--%>
            <tr>
                
                     <td style="width: 150px; background-color: #EBF5F7">MRIR No</td>
                <td>
                    <telerik:RadDropDownList ID="ddlMRIRNo" runat="server" DataSourceID="MRIRDataSource" DataTextField="MIR_NO"
                        Width="250px" DataValueField="MIR_ID" AppendDataBoundItems="True" AutoPostBack="True" >
                    </telerik:RadDropDownList>
                </td>
                
            </tr>
              <tr>
                
                     <td style="width: 150px; background-color: #EBF5F7">Preservation Code</td>
                <td>
                    <telerik:RadDropDownList ID="ddlPreservCode" runat="server" DataSourceID="PresvCodeDataSource" DataTextField="PRESERV_CODE"
                        Width="250px" DataValueField="PRESERV_CODE_ID" AppendDataBoundItems="True" AutoPostBack="True" >
                    </telerik:RadDropDownList>
                </td>
                
            </tr>
          <%--  <tr>
                <td style="width: 150px; background-color: #EBF5F7">Material Code 1</td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtAutoMatCode" runat="server" DataSourceID="sqlMatCodeSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" DropDownHeight="250px" EmptyMessage="Start Type to Search" AutoPostBack="True" OnEntryAdded="txtAutoMatCode_EntryAdded"></telerik:RadAutoCompleteBox>
                </td>
            </tr>--%>
            
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Quantity</td>
                <td>
                    <telerik:RadTextBox ID="txtQuantity" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Report Number</td>
                <td>
                    <telerik:RadTextBox ID="txtReportNo" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Inspection By</td>
                <td>
                    <telerik:RadTextBox ID="txtInspBy" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7">Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: #EBF5F7"></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel"></telerik:RadButton>
                </td>
            </tr>

        </table>        
      <%--  <asp:SqlDataSource ID="sqlMatCodeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1 
FROM VIEW_ITEM_REP_A 
WHERE PROJECT_ID = :PROJECT_ID AND SUB_CON_ID IN (SELECT SC_ID FROM STORES_DEF WHERE STORE_ID = :STORE_ID)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="ddlSCList" DefaultValue="-1" Name="STORE_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>   --%>
        <asp:SqlDataSource ID="sqlStoreList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>
       <%-- <asp:SqlDataSource ID="sqlSubStoreList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUBSTORE_ID, STORE_L1 FROM STORES_SUB WHERE (STORE_ID = :STORE_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSCList" DefaultValue="-1" Name="STORE_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
        <asp:HiddenField ID="hiddenMatID" runat="server" />
        <asp:SqlDataSource ID="MRIRDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_ID, MIR_NO FROM PRC_MAT_INSP">
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="PresvCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRESERV_CODE_ID, PRESERV_CODE FROM PRESERV_CODE_MASTER">
        </asp:SqlDataSource>
    </div>
</asp:Content>

