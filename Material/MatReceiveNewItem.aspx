<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveNewItem.aspx.cs" Inherits="Material_MatReceiveNewItem" Title="MRR - Add Items" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100" OnClick="btnBack_Click" CausesValidation="false">
                        <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="100" OnClick="btnSubmit_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import From IRN" Width="150" CausesValidation="false"
                         OnClick="btnImport_Click" Visible="false">
                        
                    </telerik:RadButton>
                </td>
                 <td>
                    <telerik:RadButton ID="btnExcelImport" runat="server" Text="Excel Import" Width="120" CausesValidation="false"
                         OnClick="btnExcelImport_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/excel.png" />
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnIRNImport" runat="server" Text="Import From IRN" Width="140px" CausesValidation="false"
                         OnClick="btnIRNImport_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
              <tr>
                <td style="width: 150px; background-color: whitesmoke">
                    <asp:Label ID="Label2" runat="server" Text="Search Material"></asp:Label>
                </td>
                <td style="height: 20px">
                  <%--  <telerik:RadTextBox ID="txtMatSearch" runat="server" Width="120px" AutoPostBack="true"
                         EmptyMessage="Search Material..."></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlMatList" runat="server" DataSourceID="sqlMatSource" DataTextField="PO_ITEM_TITLE" 
                        DataValueField="PO_ITEM_ID" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlMatList_SelectedIndexChanged"
                        OnDataBinding="ddlMatList_DataBinding" AutoPostBack="True" CausesValidation="False"></telerik:RadDropDownList>--%>

                    <telerik:RadComboBox ID="ddlMatList" runat="server" DataSourceID="sqlMatSource" DataTextField="PO_ITEM_TITLE" AllowCustomText="true" Filter="Contains" DataValueField="PO_ITEM_ID" Width="250px"
                        OnDataBinding="ddlMatList_DataBinding" OnSelectedIndexChanged="ddlMatList_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                     </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td  style="width: 150px; background-color: whitesmoke">
                     <asp:Label ID="Label9" runat="server" Text="IRN Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlIRN" runat="server" Width="250px" DataSourceID="IRNDataSource" DataValueField="IRN_ID" DataTextField="IRN_NO" OnDataBinding="ddlIRN_DataBinding" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlIRN_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false"></telerik:RadDropDownList>
                </td>
            </tr >
            <tr>
                <td style="width: 150px; background-color: whitesmoke">
                    <asp:Label ID="Label8" runat="server" Text="MR Item Number"></asp:Label>
                </td>
                <td style="height: 20px">
                    <telerik:RadTextBox ID="txtMrItem" runat="server" Width="60px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="mrItemValidator" runat="server" ControlToValidate="txtMrItem"
                        ErrorMessage="*" Width="12px" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
          
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="PO Item Number"></asp:Label>
                </td>
                <td style="height: 20px">
                    <telerik:RadTextBox ID="txtPoItem" runat="server" Width="60px" OnTextChanged="txtPoItem_TextChanged"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="itemNoValidator" runat="server" ControlToValidate="txtPoItem"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatCode" runat="server" AutoPostBack="True" OnTextChanged="txtMatCode_TextChanged"
                        Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label4" runat="server" Text="Material Description"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatDescr" runat="server" Enabled="false"
                        Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
               <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Cable Drum No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCableDrumNo" runat="server" AutoPostBack="True" Width="200px"></telerik:RadTextBox>                    
                </td>
            </tr>           
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Received Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="200px"></telerik:RadTextBox>
                    <telerik:RadLabel ID="lblbalqty" runat="server"></telerik:RadLabel>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>     
            
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label10" runat="server" Text="Pieces"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPieces" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>     

            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="matIdField" runat="server" />
    <asp:HiddenField ID="HiddenPOID" runat="server" />
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT PO_ITEM_ID, PO_ITEM_TITLE
                        FROM VIEW_ADAPTER_PO_DETAIL
                        WHERE  PO_ID = :PO_ID AND (PO_ID,PO_ITEM) IN (SELECT PO_ID,PO_ITEM FROM VIEW_IRN_BAL_TO_RECV WHERE IRN_ID IN (SELECT IRN_ID FROM PIP_MAT_RECEIVE_IRN WHERE MAT_RCV_ID = :MAT_RCV_ID))">
        <SelectParameters>          
            <asp:ControlParameter ControlID="HiddenPOID" DefaultValue="-1" Name="PO_ID" PropertyName="Value" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="IRNDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT IRN_NO,PIP_PO_IRN.IRN_ID 
                        FROM PIP_PO_IRN INNER JOIN
                        PIP_PO_IRN_DETAIL ON PIP_PO_IRN.IRN_ID=PIP_PO_IRN_DETAIL.IRN_ID
                        WHERE PIP_PO_IRN.IRN_ID IN (SELECT IRN_ID FROM PIP_MAT_RECEIVE_IRN WHERE MAT_RCV_ID = :MAT_RCV_ID) AND PIP_PO_IRN_DETAIL.MAT_ID=:MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID" />
            <asp:ControlParameter ControlID="hiddenMatID"  DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenMatID" runat="server" />
</asp:Content>