<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_MatRegist.aspx.cs" Inherits="Erection_Additional_Mat_Regist"
    Title="Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <table style="width: 100%">
        <tr>
            <td style="background-color: gainsboro">
                <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="Button1_Click" CausesValidation="false"></telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                       <tr>
                        <td style="width: 100px; background-color: whitesmoke">Discipline</td>
                        <td>
                            <telerik:RadDropDownList ID="ddScope" runat="server" DataSourceID="Scope_SqlDataSource" DataTextField="DISCIPLINE" 
                                DataValueField="DISCIPLINE_ID" Width="250px" AppendDataBoundItems="true" OnDataBinding="ddScope_DataBinding">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label9" runat="server" Text="Issue Type"></asp:Label>
                        </td>
                        <td>
                          <telerik:RadDropDownList ID="ddlIssueType" runat="server" DataSourceID="mivTypeDataSource" DataTextField="ISSUE_TYPE" DataValueField="TYPE_ID" Width="250px   "
                              OnDataBinding="ddlIssueType_DataBinding" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlIssueType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">                              
                          </telerik:RadDropDownList>
                        </td>
                    </tr>
                        <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Subcon"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                                Width="250px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" OnDataBinding="cboSubcon_DataBinding"
                                CausesValidation="false">                                
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                      <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Refer Subcon"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="RadDropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="RefSubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="250px" AutoPostBack="True" OnDataBinding="RadDropDownList1_DataBinding"
                                CausesValidation="false">                                
                            </telerik:RadDropDownList>
                           
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label6" runat="server" Text="From Store"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="250px" OnDataBinding="cboStore_DataBinding" AutoPostBack="false">                                
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cboStore"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label10" runat="server" Text="Area"></asp:Label>
                        </td>
                        <td>
                          <%--<telerik:RadDropDownList ID="ddlArea" runat="server" DataSourceID="AreaDataSource" DataTextField="AREA_L2" DataValueField="AREA_L2" Enabled="false" 
                              OnSelectedIndexChanged="ddlArea_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false" OnDataBinding="ddlArea_DataBinding" AppendDataBoundItems="true">                              
                          </telerik:RadDropDownList>--%>
                               <telerik:RadComboBox ID="ddlArea" runat="server" Width="200px" AllowCustomText="True" DataSourceID="AreaDataSource" DataTextField="AREA_L2"
                                DataValueField="AREA_L2" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged" CausesValidation="false" >
                            </telerik:RadComboBox>
                        </td>

                    </tr>
                      <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label11" runat="server" Text="Job Card"></asp:Label>
                        </td>
                        <td>
                          <telerik:RadDropDownList ID="ddlJC" runat="server" DataSourceID="JCDataSource" DataTextField="WO_NAME" DataValueField="WO_NAME" Enabled="false"
                              OnSelectedIndexChanged="ddlJC_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false" OnDataBinding="ddlJC_DataBinding" AppendDataBoundItems="true">                              
                          </telerik:RadDropDownList>
                        </td>
                    </tr>
                      <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label12" runat="server" Text="Site Job Card"></asp:Label>
                        </td>
                        <td>
                          <telerik:RadDropDownList ID="ddlSiteJC" runat="server" DataSourceID="SiteJCDataSource" DataTextField="ISSUE_NO" DataValueField="ISSUE_NO" Enabled="false"
                              OnSelectedIndexChanged="ddlSiteJC_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false" OnDataBinding="ddlSiteJC_DataBinding" AppendDataBoundItems="true">                              
                          </telerik:RadDropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label1" runat="server" Text="Issue Number"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueNo" runat="server" Width="250px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIssueNo"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                 
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label2" runat="server" Text="Issued Date"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label8" runat="server" Text="Reference No"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRefNo" runat="server" Width="250px" Enabled="false">
                             
                            </telerik:RadTextBox>      
                               <asp:RequiredFieldValidator ID="txtRefNoRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtRefNo" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label3" runat="server" Text="Issued by"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueby" runat="server" Width="140px" ReadOnly="true"></telerik:RadTextBox>
                           
                        </td>
                    </tr>
                
                   <%-- <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Category"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboCategory" runat="server" DataSourceID="catDataSource" DataTextField="CATEGORY"
                                DataValueField="CAT_ID" Width="250px" AppendDataBoundItems="True" OnDataBinding="cboCategory_DataBinding">                               
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cboCategory"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>--%>
                   
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: gainsboro">
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="RefSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM REF_SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF &#13;&#10;WHERE (PROJECT_ID = :PROJECT_ID)&#13;&#10;AND (SC_ID = :SC_ID)&#13;&#10;ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CATEGORY" FROM "PIP_MAT_ISSUE_ADD_CAT"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="Scope_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DISCIPLINE_ID, DISCIPLINE FROM DISCIPLINE_DEF ORDER BY DISCIPLINE'>
    </asp:SqlDataSource>
         <asp:SqlDataSource ID="mivTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT TYPE_ID,ISSUE_TYPE FROM PIP_MIV_ISSUE_TYPE ">            
        </asp:SqlDataSource>
     <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT DISTINCT AREA_L2 FROM VIEW_IPMS_AREA 
         UNION SELECT SUB_AREA FROM MATERIAL_SUB_AREA ORDER BY AREA_L2">
                        <%--UNION  
                        SELECT DISTINCT AREA_L2,SUBCON_SHOP AS SUBCON_FIELD FROM VIEW_IPMS_AREA WHERE SUBCON_SHOP=:SUBCON_FIELD"--%> 
         <%--<SelectParameters>
             <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SUBCON_FIELD" PropertyName="SelectedValue" />
         </SelectParameters>--%>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="JCDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT DISTINCT WO_NAME FROM VIEW_ADAPTER_FAB_JC WHERE SUB_CON_ID=:SUBCON_ID"> 
         <SelectParameters>
             <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SUBCON_ID" PropertyName="SelectedValue" />
         </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="SiteJCDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT DISTINCT ISSUE_NO FROM VIEW_LOOSE_ISSUE_JC WHERE SC_ID=:SUBCON_FIELD"> 
         <SelectParameters>
             <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SUBCON_FIELD" PropertyName="SelectedValue" />
         </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>