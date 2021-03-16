<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="LoginPage" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Amogh Database Login Page</title>
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
            margin: 0em auto;
            border: 1px solid gainsboro;
            background-color: white;
            -moz-border-radius: 3px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-box-shadow: 0 0 10px #4e707c;
            -webkit-box-shadow: 0 0 10px #4e707c;
            box-shadow: 0 0 5px #4e707c;
            text-align: left;
            position: relative;
        }

        #login {
            margin: 4em auto;
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

        .login_table {
            background: #CCF0FA;
            color: #000;
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
        /* //  login form */
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

    <form id="login" method="post" runat="server">

        <table class="login_table">
            <tr>
                <td>
                    <img src="Images/Company_Logo/amogh.png" height="40" style="padding-left: 30px" />
                </td>
                <td style="text-align: left">
                    <%--<asp:Label ID="Label2" runat="server" Text="<%$Resources:PageLabels, LoginToDatabase %>"></asp:Label>   --%>
                    Log In &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>
        <%--  
        <h1>                 
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:PageLabels, LoginToDatabase %>"></asp:Label>            
        </h1>--%>

        <div>
            <asp:Label ID="lblProject" runat="server" Text="Project"></asp:Label>

            <asp:DropDownList ID="ProjectList" runat="server" Width="295px" AutoPostBack="True"
                DataSourceID="ProjectDataSource" DataTextField="PROJECT" DataValueField="PROJECT_ID"
                OnSelectedIndexChanged="ProjectList_SelectedIndexChanged" OnDataBound="ProjectList_DataBound"
                OnDataBinding="ProjectList_DataBinding" AppendDataBoundItems="true">
            </asp:DropDownList>
        </div>
        <div>
            <asp:Label ID="lblUserName" runat="server" Text="User Name"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" Width="290px"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" Width="290px" TextMode="Password"></asp:TextBox>
        </div>

        <div class="submit">
            <asp:Button ID="btnSubmit" runat="server" Text="Log in" CssClass="button1" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnForgetPwd" runat="server" Text="Reset Password" CssClass="button1"
                OnClick="btnForgetPwd_Click"/>

        </div>
        <div>
            <asp:Label ID="ErrMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
        <div>
            Copyright © 2018, 2022, AMOGH All rights reserved.
        </div>
    </form>
    <asp:SqlDataSource ID="ProjectDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        DataSourceMode="DataReader" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJECT_ID, JOB_CODE  || ' - ' || JOB_NAME AS PROJECT
FROM PROJECT_INFORMATION
ORDER BY JOB_CODE"></asp:SqlDataSource>
</body>
</html>
