<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="loginPage.aspx.cs" Inherits="AttendanceProject.loginPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .modalPopup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 500px;
            height: auto;
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="btnAdminDiv" style="float:right;">
        <asp:Button id="btnAdmin" runat="server" Text="Admin" OnClick="btnAdmin_Click"/>
        <ajaxControlToolkit:ModalPopupExtender id="ajaxPopup" runat="server" popupcontrolId="pnlAdminLoginPopup" TargetControlID="btnAdmin"
            cancelControlId="btnAdminClose" BackgroundCssClass="modalBackground">
        </ajaxControlToolkit:ModalPopupExtender>
        <asp:panel ID="pnlAdminLoginPopup" runat="server" CssClass="modalPopup" align="center" style = "display:none">
            <asp:Label ID="lblAdminLogin" runat="server" Text="Admin Login" Font-Bold="True" Font-Size="14pt"></asp:Label>
            <br /><br />
            <asp:Label ID="lblAdminUserName" runat="server" Text="First Name:"></asp:Label>
            <asp:TextBox ID="txtAdminUserName" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lblAdminPassword" runat="server" Text="Last Name:"></asp:Label>
            <asp:TextBox ID="txtAdminPassword" runat="server"></asp:TextBox>
            <br />
            <br/>
            <asp:Button id="btnAdminSubmit" runat="server" Text="Login" onclick="btnAdminSubmit_Click"/>
            <asp:Button id="btnAdminClose" runat="server" Text="Cancel"/>    
            <br /><br />
            <asp:Label ID="lblAdminLoginError" runat="server"></asp:Label>
            <br />         
        </asp:panel>
    </div>
    <div id="div_login" align="center" style="margin: 20px 400px 0px 400px ; border:double">
        <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblUserName" runat="server" Text="User Name:"></asp:Label>
        <asp:TextBox ID="txtUserName" runat="server" BorderWidth="1"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>&nbsp;&nbsp;
        <asp:Textbox ID="txtPassword" runat="server" BorderWidth="1" TextMode="Password"></asp:Textbox>
        <br />
        <br />
        <asp:Button id="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>
        <br />
        <br />
        <asp:HyperLink ID="lnkRegister" runat="server" Text="Register A New User" ForeColor="#6600FF" NavigateUrl="~/RegisterPage.aspx"></asp:HyperLink>
        <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtenderRegister" runat="server" popupcontrolId="pnlRegisterNewUser" TargetControlID="lnkRegister"
            cancelControlId="btnNewUserRegisterCancel" BackgroundCssClass="modalBackground">
        </ajaxControlToolkit:ModalPopupExtender>
        <asp:panel ID="pnlRegisterNewUser" runat="server" CssClass="modalPopup" align="center" style = "display:none">
            <asp:Label ID="lblRegisterNewUser" runat="server" Text="New User" Font-Bold="True" Font-Size="14pt"></asp:Label>
            <br /><br />
            <asp:Label ID="lblNewUserFirstName" runat="server" Text="First Name:"></asp:Label> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserFirstName" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lblNewUserLastName" runat="server" Text="Last Name:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserLastName" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lblNewUserEmail" runat="server" Text="Email:"></asp:Label>
            &nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserEmail" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lblNewUserPassword" runat="server" Text="Password:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserPassword" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lblNewUserConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
            <asp:TextBox ID="txtNewUserConfirmPassword" runat="server"></asp:TextBox>
            <br /><br />
            <br />
            <br/>
            <asp:Button id="btnNewUserSubmit" runat="server" Text="Login" onclick="btnNewUserSubmit_Click"/>
            <asp:Button id="btnNewUserRegisterCancel" runat="server" Text="Cancel"/>    
            <br /><br />
            <asp:Label ID="lblNewUserErrorMessage" runat="server"></asp:Label>
            <br />         
        </asp:panel>
    </div>
</asp:Content>
