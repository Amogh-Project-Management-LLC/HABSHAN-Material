using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_NotificationBox : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MessagePanel.Visible = false;
    }
    public void show_success(string Message)
    {
        MessagePanel.CssClass = "success";
        MsgLabel.Text = Message;
        MessagePanel.Visible = true;
    }
    public void show_info(string Message)
    {
        MessagePanel.CssClass = "info";
        MsgLabel.Text = Message;
        MessagePanel.Visible = true;
    }
    public void show_error(string Message)
    {
        if (Message.ToLower().Contains("unique constraint"))
        {
            Message = "Duplicate entries no allowed!";
        }
        MessagePanel.CssClass = "error";
        MsgLabel.Text = Message;
        MessagePanel.Visible = true;
    }
}