using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.Hosting;
using System.Web.SessionState;

/// <summary>
/// Summary description for Global
/// </summary>
public partial class Global : System.Web.HttpApplication
{
    //public static UsersCollection Users = new UsersCollection();

    void Application_Start(object sender, EventArgs e)
    {
        Application.Add("userCount", 0);
        UsersCollection users = new UsersCollection();
        Application.Add("Users", users);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        //Create Session Folder
        string FolderName = HostingEnvironment.ApplicationPhysicalPath + @"SessionData\" + Session.SessionID.ToString();
        Directory.CreateDirectory(FolderName);

        int userCount = int.Parse(Application.Get("userCount").ToString());
        userCount++;

        Application.Set("userCount", userCount);

        Session.Add("lang", "en");

        Session.Add("STOCK_TYPE", "");
        Session.Add("ACCOUNT_PIC_URL", "");

        //Credentials
        Session.Add("PROJECT_ID", -1);
        Session.Add("PROJECT", "");
        Session.Add("JOB_CODE", "");
        Session.Add("PJ_CODE", "");
        Session.Add("HV_SCOPE", "N");
        Session.Add("USER_NAME", "");
        Session.Add("CONNECT_AS", 0);
        Session.Add("CONNECT", "");

        //Material Stock form variables
        Session.Add("STK_MAT_CODE", "");
        Session.Add("STK_LIST_INDEX", "");

        //Material Form Variables
        Session.Add("popUp_MIR_ID", "");
        Session.Add("popUp_MIR_ITEM_ID", "");
        //Heat No Index form variables
        Session.Add("HN_FILTER", "");
        Session.Add("HN_INDEX", "");
        Session.Add("TC_FILTER", "");
        Session.Add("TC_PG_INDEX", "");
        Session.Add("ITEM_CODE_POPUP_FILTER", "");
        Session.Add("WPS_POPUP_FILTER", "");
        //NDE Status variables
        Session.Add("NDE_STATUS_ISOME", "~");
        Session.Add("NDE_STATUS_REQ", "~");
        Session.Add("NDE_STATUS_REP", "~");
        Session.Add("NDE_STATUS_TYPE", "-1");
        Session.Add("NDE_STATUS_SPL", "~");
        //NDE Request
        Session.Add("NDE_REQ_FILTER", "");
        //NDE
        Session.Add("NDE_AUTO_DATE", DateTime.Now.ToString("dd-MMM-yyyy"));
        Session.Add("NDE_AUTO_REP", "");
        //Spool Status
        Session.Add("SPL_STATUS_FILTER", "");
        Session.Add("WPS_FILTER", "");
        Session.Add("SPL_TRANS_FILTER", "");
        //Job card
        Session.Add("JC_FILTER", "");
        Session.Add("JC_MIV_FILTER", "");
        Session.Add("MRIR_FILTER", "");
        Session.Add("ADD_MIV_FILTER", "");
        //New Revision
        Session.Add("NEW_REV_REV", "0");
        Session.Add("NEW_REV_SCR", "0");
        Session.Add("NEW_REV_FCR", "0");
        Session.Add("NEW_REV_DATE", "");
        Session.Add("NEW_REV_LOT", "");
        //drawing transmittal
        Session.Add("DWG_TRANS_FILTER", "");
        //test package
        Session.Add("TPK_FILTER", "");
        //Pipe Remains
        Session.Add("REM_FILTER", "");
        
    }

    void Session_End(object sender, EventArgs e)
    {
        int userCount = int.Parse(Application.Get("userCount").ToString());
        userCount--;
        Application.Set("userCount", userCount);

        string FolderName = HostingEnvironment.ApplicationPhysicalPath + @"SessionData\" + Session.SessionID.ToString();
        Directory.Delete(FolderName);

        var session = sender as HttpSessionState;
        var users = Application.Get("Users") as UsersCollection;
        users.Remove(session.SessionID);
        Application.Set("Users", users); // update it
    }

    
}