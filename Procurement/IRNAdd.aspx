<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IRNAdd.aspx.cs" Inherits="Procurement_IRNAdd" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" Text="Back" Width="80px" ID="btnBack" OnClick="Unnamed_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" Text="Save" Width="80px" ID="btnSave" OnClick="btnSave_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <style type="text/css">
        .Heading {
            width: 140px;
            background-color: whitesmoke;
        }
    </style>
    <div style="margin-top: 3px">
        <table>
            <tr>
                <td style="text-align: right; vertical-align: top">
                    <table style="text-align: left; vertical-align: top">
                        <tr>
                            <td class="Heading">RFI Number</td>
                            <td>
                                <telerik:RadComboBox ID="ddlRFINo" runat="server" DataSourceID="RFIDataSource" DataTextField="RFI_NO" AllowCustomText="true" Filter="Contains" DataValueField="RFI_ID" Width="250px"
                                    CheckBoxes="true" EnableCheckAllItemsCheckBox="true" OnDataBinding="ddlRFINo_DataBinding" OnSelectedIndexChanged="ddlRFINo_SelectedIndexChanged1" AutoPostBack="true">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">IRN Number</td>
                            <td>
                                <telerik:RadTextBox ID="txtIRNNumber" runat="server" Width="250px" Enabled="true"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">IRN Date</td>
                            <td>
                                <telerik:RadDatePicker ID="txtIRNCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="250px"></telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">IRN Rev</td>
                            <td>
                                <telerik:RadTextBox ID="txtRev" runat="server" Width="250px"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">PO Number</td>
                            <td>
                               <telerik:RadComboBox ID="ddlPO" runat="server" DataSourceID="PODataSource" DataTextField="PO_NO" AllowCustomText="true"
                                   Filter="Contains" DataValueField="PO_ID" Width="250px"
                                   OnSelectedIndexChanged="ddlPO_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                </telerik:RadComboBox>
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">VO Number</td>
                            <td>
                                <telerik:RadDropDownList ID="ddlVO" runat="server" Width="250px"  AppendDataBoundItems="true" OnDataBinding="ddlVO_DataBinding"
                                    DataSourceID="sqlVODataSource" DataTextField="REV_NAME" DataValueField="REV_NAME" OnSelectedIndexChanged="ddlVO_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <%--   <tr>
                            <td class="Heading">Inspection Report No</td>
                            <td>
                                <telerik:RadTextBox ID="txtIRNReportNO" runat="server" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>--%>
                        <%--  <tr>
                            <td class="Heading">Inspection Report Date</td>
                            <td>
                                <telerik:RadDatePicker ID="txtIRNReportDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px"></telerik:RadDatePicker>
                            </td>
                        </tr>--%>
                        <tr>
                            <td class="Heading">Vendor Code</td>
                            <td>
                                <telerik:RadDropDownList ID="ddlVendor" runat="server" Enabled="false"
                                    DataSourceID="VendorDataSource" DataTextField="VENDOR_NAME" DataValueField="VENDOR_ID" Width="250px">
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">Vendor Type</td>
                            <td>
                                <telerik:RadDropDownList ID="vendorType" runat="server">
                                    <Items>
                                        <telerik:DropDownListItem Text="Vendor/Supplier" Value="Vendor/Supplier" />
                                        <telerik:DropDownListItem Text="Subcontractor" Value="Subcontractor" />
                                        <telerik:DropDownListItem Text="All" Value="All" />
                                    </Items>
                                </telerik:RadDropDownList>
                                <%--  <telerik:RadCheckBoxList ID="vendorType" runat="server" AutoPostBack="false" Direction="Horizontal">
                                    <Items>
                                        <telerik:ButtonListItem Text="Vendor/Supplier" Value="vendor" />
                                        <telerik:ButtonListItem Text="Sub-Contractor" Value="subcon" />
                                    </Items>
                                </telerik:RadCheckBoxList>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">Venodr Report</td>
                            <td>
                                <telerik:RadRadioButtonList ID="vendorReport" runat="server" AutoPostBack="false" Direction="Horizontal">
                                    <Items>
                                        <telerik:ButtonListItem Text="Yes" Value="Y" />
                                        <telerik:ButtonListItem Text="No" Value="N" />
                                    </Items>
                                </telerik:RadRadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">PO Status</td>
                            <td>
                                <telerik:RadRadioButtonList ID="poStatus" runat="server" AutoPostBack="false" Direction="Horizontal">
                                    <Items>
                                        <telerik:ButtonListItem Text="Complete" Value="Complete" />
                                        <telerik:ButtonListItem Text="Incomplete" Value="Incomplete" />
                                    </Items>
                                </telerik:RadRadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="Heading">Major IRN Reports</td>
                            <td>
                                <%-- <telerik:RadAutoCompleteBox ID="RADreportID" runat="server" DropDownHeight="10" AllowCustomEntry="true" InputType="Text" DataSourceID="TextDataSource" DataTextField="text" DataValueField="text" Width="200px">
                                </telerik:RadAutoCompleteBox>--%>
                                <telerik:RadComboBox runat="server" ID="MajorIReports" DataSourceID="MajorReportTypeDataSource" DataValueField="irn_report_type_id" DataTextField="IRN_REPORT" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="250px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                        <tr>
                            <%-- <td class="Heading">PO Number</td>--%>
                            <td>
                                <telerik:RadComboBox ID="cboPONO" runat="server" Width="250px" CheckBoxes="true" AllowCustomText="true" Visible="false"
                                    Filter="Contains" EnableCheckAllItemsCheckBox="true" DataSourceID="PODataSource" DataTextField="PO_NO" DataValueField="PO_ID">
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                          <tr>
                            <td class="Heading">PO Contact Name</td>
                            <td>
                                <telerik:RadTextBox ID="txtPOContact" runat="server" Width="200px" ></telerik:RadTextBox>
                            </td>
                        </tr>
                        
                          <tr>
                            <td class="Heading">PO Contact Email</td>
                            <td>
                                <telerik:RadTextBox ID="txtPOEmail" runat="server" Width="200px" ></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td class="Heading">PO Contact Phone</td>
                            <td>
                                <telerik:RadTextBox ID="txtPOPhone" runat="server" Width="200px" ></telerik:RadTextBox>
                            </td>
                        </tr>

                          <tr>
                            <td class="Heading">Vendor Contact Name</td>
                            <td>
                                <telerik:RadTextBox ID="txtVendorContactName" runat="server" Width="200px" ></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td class="Heading">Vendor Contact No</td>
                            <td>
                                <telerik:RadTextBox ID="txtVendorPhone" runat="server" Width="200px" ></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td class="Heading">Prepared By</td>
                            <td>
                                <telerik:RadTextBox ID="txtPreparedBy" runat="server" Width="200px" Text="LI CHONGQUAN"></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td class="Heading">Reviewed By</td>
                            <td>
                                <telerik:RadTextBox ID="txtReviewedBy" runat="server" Width="200px" Text="NAVNEET"></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td class="Heading">Approved By</td>
                            <td>
                                <telerik:RadTextBox ID="txtApprovedBy" runat="server" Width="200px" Text="SAVAD"></telerik:RadTextBox>
                            </td>
                        </tr>
                          <tr>
                            <td class="Heading">Distribution</td>
                            <td>
                                <telerik:RadCheckBox ID="chkDClient" runat="server" Text="Client" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadCheckBox ID="chkDSupp" runat="server" Text="Supplier/Vendor" AutoPostBack="false" ></telerik:RadCheckBox><br />
                                <telerik:RadCheckBox ID="chkDSubSup" runat="server" Text="Subsupplier" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadCheckBox ID="chkDSubcon" runat="server" Text="Subcontractor" AutoPostBack="false"></telerik:RadCheckBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="Heading">Remarks</td>
                            <td>
                                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px" TextMode="MultiLine"></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="text-align: right; vertical-align: top">
                    <table style="text-align: left; vertical-align: top">

                        <tr>
                            <td style="text-align: right" class="Heading">
                                <telerik:RadLabel ID="lableRep" Text="Inspection Reports   1" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <asp:Table ID="myTable" runat="server" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>Report</asp:TableCell>
                                        <asp:TableCell>Date</asp:TableCell>
                                        <asp:TableCell>Browse</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <telerik:RadTextBox ID="txtRep1" runat="server"></telerik:RadTextBox>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <telerik:RadDatePicker ID="txtRepDate1" runat="server"></telerik:RadDatePicker>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <%--<input type="file" id="txtFileUpload1" multiple="multiple" name="myfile" runat="server" size="100" />--%>
                                            <asp:FileUpload ID="txtFileUpload1" runat="server" AllowMultiple="true" />
                                          
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </td>

                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <telerik:RadLabel ID="RadLabel1" Text="2" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <asp:Table ID="Table1" runat="server" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <telerik:RadTextBox ID="txtRep2" runat="server"></telerik:RadTextBox>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <telerik:RadDatePicker ID="txtRepDate2" runat="server"></telerik:RadDatePicker>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:FileUpload ID="txtFileUpload2" runat="server" AllowMultiple="true" />
                                            <%--<input type="file" id="txtFileUpload2" multiple="multiple" name="myfile" runat="server" size="100" />--%>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <telerik:RadLabel ID="RadLabel2" Text="3" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <asp:Table ID="Table2" runat="server" Width="100%">

                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <telerik:RadTextBox ID="txtRep3" runat="server"></telerik:RadTextBox>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <telerik:RadDatePicker ID="txtRepDate3" runat="server"></telerik:RadDatePicker>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:FileUpload ID="txtFileUpload3" runat="server" AllowMultiple="true" />
                                            <%--<input type="file" id="txtFileUpload3" multiple="multiple" name="myfile" runat="server" size="100" />--%>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <telerik:RadLabel ID="RadLabel3" Text="4" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <asp:Table ID="Table3" runat="server" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <telerik:RadTextBox ID="txtRep4" runat="server"></telerik:RadTextBox>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <telerik:RadDatePicker ID="txtRepDate4" runat="server"></telerik:RadDatePicker>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:FileUpload ID="txtFileUpload4" runat="server" AllowMultiple="true" />
                                            <%-- <input type="file" id="txtFileUpload4" multiple="multiple" name="myfile" runat="server" size="100" />--%>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <telerik:RadLabel ID="RadLabel5" Text="5" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <asp:Table ID="Table4" runat="server" Width="100%">

                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <telerik:RadTextBox ID="txtRep5" runat="server"></telerik:RadTextBox>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <telerik:RadDatePicker ID="txtRepDate5" runat="server"></telerik:RadDatePicker>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:FileUpload ID="txtFileUpload5" runat="server" AllowMultiple="true" />
                                            <%--<input type="file" id="txtFileUpload5" multiple="multiple" name="myfile" runat="server" size="100" />--%>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </td>
                        </tr>

                        <tr>
                            <td class="Heading">Inspection Result</td>
                            <td>
                                <telerik:RadDropDownList ID="ddlInspResult" runat="server" Width="200px">
                                    <Items>
                                        <telerik:DropDownListItem Text="(Select)" Value="" />
                                        <telerik:DropDownListItem Text="Accepted" Value="Accepted" />
                                        <telerik:DropDownListItem Text="Accepted With Condition" Value="Accepted With Condition" />
                                        <telerik:DropDownListItem Text="Reject" Value="Reject" />

                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <tr>

                            <td>
                                <telerik:RadTextBox ID="txtinspResult" runat="server" Rows="5" Width="500px" TextMode="MultiLine" Visible="false"></telerik:RadTextBox>
                            </td>
                            <td>

                                <telerik:RadCheckBox ID="chk1" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb1" runat="server" value="1" Height="23px" Text="Material is released for further fabrication. Supplier to request further inspection upon completion of items as listed above."></telerik:RadLabel>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadCheckBox ID="chk2" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb2" runat="server" value="2" Height="23px" Text="Material rejected previously on a Non-confirmity notice,is release for action as checked"></telerik:RadLabel>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadCheckBox ID="chk3" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb3" Height="23px" runat="server" value="3" Text="Material is released per purchase order specification for delivery to : CPECC"></telerik:RadLabel>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadCheckBox ID="chk4" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb4" Height="23px" runat="server" value="4" Text="Material is released without inspection,as instructed, for delivery to: "></telerik:RadLabel>
                                <telerik:RadTextBox ID="txtchk4" runat="server"></telerik:RadTextBox>
                            </td>

                        </tr>
                        <tr>
                            <td></td>
                            <td style="align-content: center">
                                <telerik:RadCheckBox ID="chk5" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb5" runat="server" value="5" Text="NCR outstanding on items released" Height="23px"></telerik:RadLabel>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadCheckBox ID="chk6" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadLabel ID="lb6" runat="server" value="6" Text="Random Inspection" Height="23px"></telerik:RadLabel>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                 <telerik:RadCheckBox ID="chk7" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                 <telerik:RadTextBox ID="txtchk7" runat="server" Width="300px"></telerik:RadTextBox>
                                <%--<telerik:RadCheckBox ID="chk7" runat="server" AutoPostBack="false"></telerik:RadCheckBox>
                                <telerik:RadTextBox ID="txtchk7" runat="server" Width="300px"></telerik:RadTextBox>

                                  <telerik:RadAutoCompleteBox ID="txtchk7" runat="server" DropDownHeight="10" AllowCustomEntry="true" InputType="Text" DataSourceID="TextDataSource" DataTextField="text" DataValueField="text" Width="300px">
                                </telerik:RadAutoCompleteBox>--%>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="TextDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT null as text from dual"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>

    <asp:SqlDataSource ID="VendorDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VENDOR_NAME,VENDOR_ID FROM VENDOR_MASTER"></asp:SqlDataSource>

    <asp:SqlDataSource ID="RFIDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT RFI_ID,RFI_REPORT_NO AS RFI_NO FROM PIP_PO_INSP_REQUEST"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MajorReportTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT irn_report_type_id,irn_report FROM PIP_PO_IRN_MAJOR_REPORT_TYPE"></asp:SqlDataSource>

      <asp:SqlDataSource ID="sqlVODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
          SelectCommand="SELECT DISTINCT REV_NAME FROM PIP_PO_VARIATION WHERE PO_ID=:PO_ID">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddlPO" Name="PO_ID" DefaultValue="-1" PropertyName="SelectedValue" />
          </SelectParameters>
      </asp:SqlDataSource>
</asp:Content>

