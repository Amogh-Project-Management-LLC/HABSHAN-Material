<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UploadFileManager.aspx.cs" Inherits="Home_UploadFileManager" Title="Upload Files" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function OnClientFileOpen(oExplorer, args) {

            //get the extension of the opened item

            var fileExt = args.get_item().get_extension();

            if (fileExt && fileExt.toLowerCase() == "pdf") {

                //cancel the default behavior

                args.set_cancel(true);

                //open new RadWindow
                //var oWnd = radopen(args.get_item().get_path(), "RadWindow1");
                //oWnd.setSize(600, 400);

                //if you want to open the PDF file in a new browser window
                //you can use the following code

                window.open(args.get_item().get_path());

            }

        }
    </script>
    <telerik:RadFileExplorer ID="RadFileExplorer1" runat="server" Width="100%" EnableCreateNewFolder="false" Skin="Silk" OnClientFileOpen="OnClientFileOpen" EnableAsyncUpload="true"
        Configuration-MaxUploadFileSize="30720000" Configuration-AllowFileExtensionRename="false" OnItemCommand="RadFileExplorer1_ItemCommand"
        FilterTextBoxLabel="Find File" EnableFilteringOnEnterPressed="true" EnableFilterTextBox="true">
        <Configuration ViewPaths="~/Upload" UploadPaths="~/Upload" DeletePaths="~/Upload" />
    </telerik:RadFileExplorer>
</asp:Content>