<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestRegister.aspx.cs" Inherits="Material_MaterialRequestRegister" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">        
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%">
                            <tr>
                                 <td style="width: 140px; background-color: Gainsboro">
                                    Area:
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="RadAreaDDL"  runat="server" Width="200px" DataSourceID="areaDataSource" DataTextField="AREA_L3" DataValueField="AREA_L3" AutoPostBack="true" CausesValidation="false"></telerik:RadDropDownList>
                                    
                                </td>
                            </tr>
                             <tr>
                                 <td style="width: 140px; background-color: Gainsboro">
                                  Sub Area:
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="RadSubAreaDDL"  runat="server" Width="200px" DataSourceID="subAreaDataSource" DataTextField="AREA_L2" DataValueField="AREA_L2" AutoPostBack="true"></telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="RadSubAreaDDL"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <%--  <tr>
                                 <td style="width: 140px; background-color: Gainsboro">
                                  Sub Area:
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="ddlRequestType"  runat="server" Width="200px" DataSourceID="RequestTypeDataSource" DataTextField="MR_TYPE" DataValueField="MR_TYPE_ID" AutoPostBack="true"></telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRequestType" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Request Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtRequestNo" runat="server" Width="200px"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="reqNoValidator" runat="server" ControlToValidate="txtRequestNo"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Request Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="txtReqDate" runat="server" Width="200px"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="ReqDateValidator" runat="server" ControlToValidate="txtReqDate"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Discipline:
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="ddDiscipline" runat="server" DataSourceID="disciplineDataSource"
                                        DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" Width="200px" Font-Names="Calibri">
                                    </telerik:RadDropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Request From:
                                </td>
                                <td>                                  
                                     <telerik:RadDropDownList ID="ddlReqFrom" runat="server" AppendDataBoundItems="True" Width="200px" DataSourceID="sqlStoreListSource" DataTextField="STORE_NAME" DataValueField="STORE_ID" OnDataBinding="ddlReqFrom_DataBinding" OnSelectedIndexChanged="ddlReqFrom_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false"></telerik:RadDropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Request To:
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="ddlStoreList" runat="server" AppendDataBoundItems="True" Width="200px" DataSourceID="sqlStoreListSource" DataTextField="STORE_NAME" DataValueField="STORE_ID" OnDataBinding="ddlStoreList_DataBinding"></telerik:RadDropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: Gainsboro">
                                    Remarks:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="455px"></telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>                        
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="75px" OnClick="btnSubmit_Click" />
                        </td>
                        <td style="width: 100px" align="center">
                            <asp:UpdateProgress ID="UpdateProgress3" runat="server" DisplayAfter="10">
                                <ProgressTemplate>
                                    <img src="../Images/circle-ball.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="disciplineDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE_ID, DISCIPLINE FROM DISCIPLINE_DEF ORDER BY DISCIPLINE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreListSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="areaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT distinct area_l3 from amg_piping.ipms_area WHERE (PROJECT_ID = :PROJECT_ID)  
                        UNION SELECT AREA  FROM MATERIAL_SUB_AREA ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="subAreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
         SelectCommand="SELECT DISTINCT AREA_L2 from AMG_PIPING.IPMS_AREA WHERE (PROJECT_ID = :PROJECT_ID) and (AREA_L3=:AREA_L3)
                        UNION SELECT SUB_AREA  FROM MATERIAL_SUB_AREA WHERE (AREA=:AREA_L3)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter DefaultValue="-1" Name="AREA_L3" ControlID="RadAreaDDL" PropertyName="SELECTEDVALUE"/>
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="RequestTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MR_TYPE,MR_TYPE_ID FROM MATERIAL_REQUEST_TYPE">
    </asp:SqlDataSource>
</asp:Content>

