<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword_code" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Change Your Password</title>
    <link rel="shortcut icon" type="image/x-icon" href="Images/favicon.ico" />

    <style type="text/css">
        /* HTML elements  */ h1, h2, h3, h4, h5, h6 {
            font-weight: normal;
            margin: 0;
            line-height: 1.1em;
            color: #000;
        }

        h1 {
            font-size: 2em;
            margin-bottom: .5em;
        }

        p, blockquote, ul, ol, dl, form, table, pre {
            line-height: inherit;
            margin: 0 0 1.5em 0;
        }

        blockquote, dd {
            padding: 0 0 0 2em;
        }

        pre, code, samp, kbd, var {
            font: 100% mono-space,monospace;
        }

        pre {
            overflow: auto;
        }

        abbr, acronym {
            text-transform: uppercase;
            border-bottom: 1px dotted #000;
            letter-spacing: 1px;
        }

            abbr[title], acronym[title] {
                cursor: help;
            }

        small {
            font-size: .9em;
        }

        sup, sub {
            font-size: .8em;
        }

        em, cite, q {
            font-style: italic;
        }

        img {
            border: none;
        }

        hr {
            display: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, caption {
            text-align: left;
        }

        form div {
            margin: .5em 0;
            clear: both;
        }

        label {
            display: block;
        }

        fieldset {
            margin: 0;
            padding: 0;
            border: none;
        }

        legend {
            font-weight: bold;
        }

        input[type="radio"], input[type="checkbox"], .radio, .checkbox {
            margin: 0 .25em 0 0;
        }
        /* //  HTML elements */ /* base */

        body, table, input, textarea, select, li, button {
            font: 1em "Lucida Sans Unicode", "Lucida Grande", sans-serif;
            line-height: 1.5em;
            color: #444;
        }

        body {
            font-size: 12px;
            /*background: #e5fffb;*/
            text-align: center;
        }
        /* // base */ /* login form */
        #login_logo {
            margin: 2em auto;
            border: 3px solid gainsboro;
            background-color: white;
            -moz-border-radius: 3px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-box-shadow: 0 0 10px #4e707c;
            -webkit-box-shadow: 0 0 10px #4e707c;
            box-shadow: 0 0 10px #4e707c;
            text-align: left;
            position: relative;
        }

        #login {
            margin: 5em auto;
            background: #fff;
            border: 8px solid #eee;
            width: 500px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-box-shadow: 0 0 10px #4e707c;
            -webkit-box-shadow: 0 0 10px #4e707c;
            box-shadow: 0 0 50px #4e707c;
            text-align: left;
            position: relative;
        }

            #login a, #login a:visited {
                color: #0283b2;
            }

                #login a:hover {
                    color: #111;
                }

            #login h1 {
                background: #0092c8;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                font-size: 14px;
                padding: 18px 23px;
                margin: 0 0 1.5em 0;
                border-bottom: 1px solid #007dab;
            }

            #login .register {
                position: absolute;
                float: left;
                margin: 0;
                line-height: 30px;
                top: -40px;
                right: 0;
                font-size: 11px;
            }

            #login p {
                margin: .5em 25px;
            }

            #login div {
                margin: .5em 25px;
                background: #eee;
                padding: 4px;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                text-align: right;
                position: relative;
            }

            #login label {
                float: left;
                line-height: 30px;
                padding-left: 10px;
            }

            #login .field {
                border: 1px solid #ccc;
                width: 280px;
                font-size: 12px;
                line-height: 1em;
                padding: 4px;
                -moz-box-shadow: inset 0 0 5px #ccc;
                -webkit-box-shadow: inset 0 0 5px #ccc;
                box-shadow: inset 0 0 5px #ccc;
            }

            #login div.submit {
                background: none;
                margin: 1em 25px;
                text-align: left;
            }

                #login div.submit label {
                    float: none;
                    display: inline;
                    font-size: 11px;
                }

            #login button {
                border: 0;
                padding: 0 30px;
                height: 30px;
                line-height: 30px;
                text-align: center;
                font-size: 12px;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                background: #0092c8;
                -moz-border-radius: 50px;
                -webkit-border-radius: 50px;
                border-radius: 50px;
                cursor: pointer;
            }

            #login .back {
                padding: 1em 0;
                border-top: 1px solid #eee;
                text-align: right;
                font-size: 11px;
            }

            #login .error {
                float: left;
                position: absolute;
                left: 95%;
                top: -5px;
                background: #890000;
                padding: 5px 10px;
                font-size: 11px;
                color: #fff;
                text-shadow: #500 0 1px 0;
                text-align: left;
                white-space: nowrap;
                border: 1px solid #500;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                -moz-box-shadow: 0 0 5px #700;
                -webkit-box-shadow: 0 0 5px #700;
                box-shadow: 0 0 5px #700;
            }

            #login .button1 {
                border: 0;
                padding: 0 30px;
                height: 30px;
                line-height: 30px;
                text-align: center;
                font-size: 12px;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                background: #0092c8;
                -moz-border-radius: 50px;
                -webkit-border-radius: 50px;
                border-radius: 50px;
                cursor: pointer;
            }

        .login_table {
            background: #CCF0FA;
            color: #000;
            text-shadow: #007dab 0 1px 0;
            font-size: 14px;
            padding: 18px 23px;
            margin: 0 0 1.5em 0;
            border-bottom: 1px solid #007dab;
        }
        /* //  login form */

        .BarIndicator {
            color: Red;
            background-color: Red;
        }

        .BarIndicatorYellow {
            color: Yellow;
            background-color: Yellow;
        }

        .BarIndicatorOrange {
            color: orange;
            background-color: orange;
        }

        .BarIndicatorGreen {
            color: Green;
            background-color: Green;
        }
    </style>

</head>
<body>

    <div id="login_logo">
        <table style="width: 100%;">
            <tr>
                <td style="text-align: left">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Company_Logo/Adnoc.png" Height="100px" />
                </td>
                <td style="text-align: right">
                    <asp:Image runat="server" ID="LoginHeaderImage" ImageUrl="~/Images/Company_Logo/cpecc_logo.png" Height="80px" />
                </td>

            </tr>
        </table>
    </div>

    <form id="login" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnableScriptCombine="true" OutputCompression="AutoDetect">
        </telerik:RadScriptManager>
        <table class="login_table">
            <tr>
                <td>
                    <img src="Images/Company_Logo/amogh.png" height="40" style="padding-left: 30px" />
                </td>
                <td style="text-align: left">Reset Password &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>
        <div id="divExpire" runat="server" visible="false">
            <asp:Label ID="ExpiredLabel" runat="server" ForeColor="Red" Text="This link has been expired"></asp:Label>
        </div>
        <div id="divpwd1" runat="server" visible="false">
            <asp:Label ID="lblPwd" runat="server" Text="Enter New Password:"></asp:Label>
            <asp:TextBox ID="txt_pwd" runat="server" TextMode="Password" Width="290px" CausesValidation="false"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txt_pwd" ErrorMessage="!" ForeColor="Red"></asp:RequiredFieldValidator>
            <cc1:PasswordStrength runat="server" ID="PasswordStrength1" TargetControlID="txt_pwd"
                StrengthStyles="BarIndicator;BarIndicatorYellow;BarIndicatorOrange;BarIndicatorGreen"
                TextStrengthDescriptions="Poor;Weak;Average;Good" BarIndicatorCssClass="BarIndicator"
                BarBorderCssClass="BarBorder">
            </cc1:PasswordStrength>
        </div>
        <div id="divpwd2" runat="server" visible="false">
            <asp:Label ID="lblRetypePwd" runat="server" Text="Retype Password:"></asp:Label>
            <asp:TextBox ID="txt_retype_pwd" runat="server" TextMode="Password" Width="290px" CausesValidation="false"></asp:TextBox>
            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="txt_retype_pwd" ErrorMessage="!" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server"
                ControlToCompare="txt_pwd" ControlToValidate="txt_retype_pwd"
                ErrorMessage="Enter Same Password" ForeColor="Red"></asp:CompareValidator>
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txt_retype_pwd"
                ErrorMessage="Minimum Password Length is 5"
                ValidationExpression="[^ ]{5,}" ForeColor="Red"></asp:RegularExpressionValidator>
        </div>
        <div class="submit">

            <asp:Button ID="btn_change_pwd" runat="server" OnClick="btn_change_pwd_Click" Text="Change Password" CssClass="button1" Visible="false" />
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Log in Page" CssClass="button1" CausesValidation="false" Visible="false" />
        </div>


        <div>
            <asp:Label ID="lbl_msg" runat="server"></asp:Label>

        </div>
    </form>

</body>
</html>
