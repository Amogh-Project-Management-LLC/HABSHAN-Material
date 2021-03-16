<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatRequisition2.aspx.cs" Inherits="Procurement_MatRequisition" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <style type="text/css">
      /*.rgDataDiv {
            min-height: 700px !important;
            overflow:scroll;
        }*/
      /*div.RadGrid .rgDataDiv {
        overflow-y: scroll!important;*/
    }
    </style>
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid=$find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        //      alert(height);
          //  RadGrid1.style.height = height + "px";
            //  RadGrid1.repaint();
            grid.get_element().style.height = (height)-210 + "px";
            //grid.get_element().style.rgDataDiv= (height) + "px";
            grid.repaint();
           
          
        }
    </script>
<telerik:RadGrid ID="RadGrid1" 	runat="server" 	DataSourceID="XmlDataSource1"  	AllowPaging="true" 
    PageSize="40"	Width="100%"  	 	style="border:0;outline:none">
	<MasterTableView TableLayout="Fixed" />
	<ClientSettings EnableRowHoverStyle="true">
		<Selecting AllowRowSelect="true" />
		<Scrolling AllowScroll="true" UseStaticHeaders="true" />
	</ClientSettings>
	<PagerStyle Mode="NextPrevAndNumeric" />
</telerik:RadGrid>

<asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/datasource.xml" />
</asp:Content>