<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="loginPage.aspx.cs" Inherits="AttendanceProject.loginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="div_login" align="center" style="margin: 20px 400px 0px 400px ; border:double">
        <br />




        <br />
        <asp:Label ID="lblUserName" runat="server" Text="User Name"></asp:Label>
        <asp:TextBox ID="txtUserName" runat="server" BorderWidth="1"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
        <asp:Textbox ID="txtPassword" runat="server" BorderWidth="1" TextMode="Password"></asp:Textbox>
        <br />
        <br />
        <asp:Button id="btnLogin" runat="server" Text="Login"/>
        <br />


        <br />
        <asp:HyperLink ID="lnkRegister" runat="server" Text="Register A New User" ForeColor="#6600FF" NavigateUrl="~/RegisterPage.aspx"></asp:HyperLink>
    </div>
</asp:Content>
