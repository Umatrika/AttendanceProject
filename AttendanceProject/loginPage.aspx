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
            font-family:Arial;
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
            cancelControlId="btnAdminOk" BackgroundCssClass="modalBackground">
        </ajaxControlToolkit:ModalPopupExtender>

        <asp:panel ID="pnlAdminLoginPopup" runat="server" CssClass="modalPopup" align="center" style = "display:none">
            <asp:Label ID="lblAdminLogin" runat="server" Text="Admin Login" Font-Bold="True" Font-Size="14pt" Font-Underline="True"></asp:Label>
            <br /><br />
            <asp:Label ID="lblAdminMessage" runat="server" Text="Please Login with Admin Credentials"></asp:Label>
            <br /><br />
            <asp:Button id="btnAdminOk" runat="server" Text="OK" />    
            <br /><br />
        
        </asp:panel>
    </div>
    <div id="div_login" align="center" style="margin: 20px 400px 0px 400px ; border:double">
        <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblUserName" runat="server" Text="User Name:"></asp:Label>
        <asp:TextBox ID="txtUserName" runat="server" BorderWidth="1" ValidationGroup="login"></asp:TextBox>
            <asp:RequiredFieldValidator ID="userNameValidator" runat="server" ErrorMessage="*"
                controlToValidate="txtUserName" ValidationGroup="login" ForeColor="Red">
             </asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>&nbsp;&nbsp;
        <asp:Textbox ID="txtPassword" runat="server" BorderWidth="1" TextMode="Password" ValidationGroup="login"></asp:Textbox>
            <asp:RequiredFieldValidator ID="passwordValidator" runat="server" ErrorMessage="*"
                controlToValidate="txtPassword" ValidationGroup="login" ForeColor="Red">
             </asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button id="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" ValidationGroup="login"/>
        <br />
        <br />
        <asp:HyperLink ID="lnkRegister" runat="server" Text="Register A New User" ForeColor="#6600FF" NavigateUrl="~/RegisterPage.aspx"></asp:HyperLink>
        <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtenderRegister" runat="server" popupcontrolId="pnlRegisterNewUser" TargetControlID="lnkRegister"
            cancelControlId="btnNewUserRegisterCancel" BackgroundCssClass="modalBackground" >
        </ajaxControlToolkit:ModalPopupExtender>
        <asp:panel ID="pnlRegisterNewUser" runat="server" CssClass="modalPopup" align="center" style = "display:none">
            <br />
            <asp:Label ID="lblRegisterNewUser" runat="server" Text="New User" Font-Bold="True" Font-Size="14pt"></asp:Label>
            <br /><br />
            <asp:Label ID="lblNewUserFirstName" runat="server" Text="First Name:"></asp:Label> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserFirstName" runat="server" ValidationGroup="Popup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewUserFirstNameValidator" runat="server" ErrorMessage="*"
                    controlToValidate="txtNewUserFirstName" ValidationGroup="Popup" ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="firstNameValidator" runat="server" 
                    ControlToValidate="txtNewUserFirstName" ValidationGroup="Popup" ForeColor="Red"
                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                    Text="Invalid" /> 
            <br /><br />
            <asp:Label ID="lblNewUserLastName" runat="server" Text="Last Name:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserLastName" runat="server" ValidationGroup="Popup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewUserLastNameValidator" runat="server" ErrorMessage="*"
                    controlToValidate="txtNewUserLastName" ValidationGroup="Popup" ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="lastNameValidator" runat="server" 
                    ControlToValidate="txtNewUserLastName" ValidationGroup="Popup" ForeColor="Red"
                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                    Text="Invalid" />
            <br /><br />
            <asp:Label ID="lblNewUserEmail" runat="server" Text="Email:"></asp:Label>
            &nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserEmail" runat="server" ValidationGroup="Popup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewUserEmailValidator" runat="server" ErrorMessage="*"
                    controlToValidate="txtNewUserEmail" ValidationGroup="Popup" ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="emailValidator" runat="server" 
                    ControlToValidate="txtNewUserEmail" ValidationGroup="Popup" ForeColor="Red"
                    ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                    Text="Invalid" />
            <br /><br />
            <asp:Label ID="lblNewUserPassword" runat="server" Text="Password:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNewUserPassword" runat="server" ValidationGroup="Popup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewUserPasswordValidator" runat="server" ErrorMessage="*"
                    controlToValidate="txtNewUserPassword" ValidationGroup="Popup" ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regVal" runat="server" 
                    ControlToValidate="txtNewUserPassword" ValidationGroup="Popup" ForeColor="Red"
                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                    Text="Invalid" />
            <br /><br />

            <br/>
            <asp:Button id="btnNewUserSubmit" runat="server" Text="Login" onclick="btnNewUserSubmit_Click" ValidationGroup="Popup"/>
            <asp:Button id="btnNewUserRegisterCancel" runat="server" Text="Cancel"/>    
            <br /><br />
            <asp:Label ID="lblNewUserErrorMessage" runat="server"></asp:Label>
            <br />         
        </asp:panel>
    </div>
</asp:Content>
