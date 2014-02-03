<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login - Faculty Portal</title>
     <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet"/>

    <!-- Add custom CSS here -->
    <link href="css/sb-admin.css" rel="stylesheet"/>
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"/>
</head>
<body>
    <form id="form1" runat="server">
      <div class="login center text-center"> 
           <img src="images/TSULOGO.png" class="loginlogo" />
           <h4>Tarlac State University</h4>
          <h5><small>Sign in with your Faculty Portal Account</small></h5>
    </div>
        <%--<div class="login well center logpadtop">--%>

             <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/default.aspx" CssClass="login well center logpadtop">
            <LayoutTemplate>

            <div class="row text-center padup">
                <asp:TextBox ID="UserName" runat="server" placeholder="Username" CssClass ="logcontrols"></asp:TextBox>
                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
            </div>
            <div class="row text-center">
                <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Password" CssClass ="logcontrols"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
            </div>
            <div class="row  text-center center ">
                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></div>
            <div class="row logcontrols center logpadtop">
                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" CssClass="btn btn-primary col-sm-12" /></div>
            <div class ="row logpadtop">
                <div class="padleft"><a> Need help? </a></div></div>
                <div class="paddown"></div>
            </LayoutTemplate>
            </asp:Login>
        <div class="text-center">
            <a> Create an account </a>

        </div>
      <%--  </div>--%>

       <%-- <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/default.aspx">
            <LayoutTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2">Log In</td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color:Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:Login>
    </div>--%>
    </form>
</body>
</html>