<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"   
    CodeFile="AutoSendExpeditorsEmails.aspx.cs" Inherits="Expeditors_Emails" Title="Send Expeditors Emails" EnableSessionState="ReadOnly" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

      
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
   
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table>
            <tr>
                <td>
                    <asp:ImageButton ID="ImageButtonProcedure" runat="server" ImageUrl="~/Images/knob/Refresh.png" ToolTip="Batch Status" OnClick="ImageButtonProcedure_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click" Width="100px" ></telerik:RadButton>
                </td>
            
                
            </tr>
        </table>
       
    </div>
    <div>
    

        <asp:SqlDataSource ID="MailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT distinct USER_NAME  FROM VIEW_BATCH_EMAIL GROUP BY USER_NAME 
                       ORDER BY Count(*)"></asp:SqlDataSource>
    </div>
</asp:Content>
