using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using System;

public class BasePage : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        if (!string.IsNullOrEmpty(Request.QueryString["lang"]))
        {
            HttpContext.Current.Session["lang"] = Request.QueryString["lang"];
        }

        string lang = HttpContext.Current.Session["lang"].ToString();

        string culture = string.Empty;
        
        if (lang.ToLower().Contains("en") || string.IsNullOrEmpty(culture))
        {
            culture = "en-US";
        }
        if (lang.ToLower().Contains("vi"))
        {
            culture = "vi-VN";
        }
        if (lang.ToLower().Contains("ja"))
        {
            culture = "ja-JP";
        }
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);

        base.InitializeCulture();
    }
}
