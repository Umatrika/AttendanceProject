<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="adminPage.aspx.cs" Inherits="AttendanceProject.adminPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .floatRight { float: right; height:inherit;}
        .floatLeft { float: left; }
        .floatCenter { text-align: center; }
        .AddButton {
            color:white;
            font-family:Arial;
            font-size:25px;            
            width:inherit;
            border:solid;
            border-width:2px;
            border-radius:15px;
            padding-left:10px;
            padding-right:10px;
            padding-top:10px;
            padding-bottom:10px;
            background:maroon;            
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 400px;
            height: auto;
        }
        .row 
        {
            width:100%;
            margin: 0 auto;
        }
        .block 
        {
            width: 100px;
            display:inline-block;
            margin-left:30px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="headDiv">
        <div id="rightDiv" style="float:right; padding-right:10px;">
            <asp:Label ID="lblSignedUser" runat="server" Text="Signed in as Admin " Font-Names="calibri" Font-Size="11pt"></asp:Label>&nbsp;
            <asp:Button id="btnSignOut" runat="server" Text="Sign Out" OnClick="btnSignOut_Click"/>
        </div>
    </div>
    <div id="dashboardDiv" style="margin-left:150px; font-family:Calibri;">
        <h2>Welcome to Dashboard</h2>
    </div>
    <div id="sideDiv" style="padding-left:150px; padding-right:150px; height:430px;">
        <asp:Panel ID="SidePanel" runat="server" BorderStyle="Solid" BorderColor="Black" Width="8%" CssClass="floatLeft">
            <asp:ImageButton id="imgAccount" runat="server" ImageUrl="~/account1.jpg" Width="75px" Height="75px" ImageAlign="Middle"/>
            <asp:imageButton id="dashboard" runat="server" ImageUrl="~/dashboard.png"/>
            <asp:ImageButton id="imgCourse" runat="server" ImageUrl="~/courses.jpg" Width="75px" Height="75px"/>
            <asp:ImageButton id="imgCalander" runat="server" ImageUrl="~/calander.jpg" Width="75px" Height="75px"/>
            <asp:ImageButton id="imgInbox" runat="server" ImageUrl="~/inbox.jpg" Width="75px" Height="75px"/>
        </asp:Panel>
        <asp:Panel ID="pnlContent" runat="server" BorderStyle="Solid" BorderColor="yellow" width="88%" height="430px" CssClass="row">
        <div id="contentDiv" class="row">
            <div id="divAddStudent" class="block" runat="server" style="width:250px; height:250px; border:double; border-color: black;">
                <asp:Button id="btnAddStudent" runat="server" Text="Add Student" CssClass="AddButton"/>
                <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtender1" runat="server" popupcontrolId="Panel1" TargetControlID="btnAddStudent"
                    BackgroundCssClass="modalBackground">
                </ajaxControlToolkit:ModalPopupExtender>

                <asp:panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" style = "display:none">
                    <asp:Label ID="lblStudentInformation" runat="server" Text="Student Information" Font-Bold="True" Font-Size="14pt"></asp:Label><br /><br />
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell>First Name</asp:TableCell>
                            <asp:TableCell><asp:TextBox id="txtStudentFirstName" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Last Name</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentLastName" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Email</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentEmail" runat="server" TextMode="DateTime"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>DOB</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentDOB" runat="server" TextMode="DateTime"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Mobile No</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentMobileNumber" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Address</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentAddress" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>City</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentCity" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>State</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentState" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Zip</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentZip" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>                            
                        <asp:TableRow>
                            <asp:TableCell>Notes</asp:TableCell>
                            <asp:TableCell><asp:TextBox ID="txtStudentNotes" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow >
                            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Middle">
                                <asp:Button id="btnStudentSubmit" runat="server" Text="Submit" onclick="btnStudentSubmit_Click"/>
                                <asp:Button id="btnStudentCancel" runat="server" Text="Cancel"/>
                            </asp:TableCell>                            
                        </asp:TableRow>
                    </asp:Table>
                    <asp:Label ID="lblStudentErrorMessage" runat="server"></asp:Label>
                    <br /><br />
                </asp:panel>               
            </div>

            <div id="divAddInstructor" class="block" runat="server" style="width:250px; height:250px; border:double; border-color:red;">
                <asp:Button ID="btnAddInstructor" runat="server" Text="Add Instructor" CssClass="AddButton"/>
                <ajaxControlToolkit:ModalPopupExtender id="ajaxPopup" runat="server" popupcontrolId="pnlInstructorPopup" TargetControlID="btnAddInstructor"
                    cancelControlId="btnInstructorClose" BackgroundCssClass="modalBackground">
                </ajaxControlToolkit:ModalPopupExtender>

                <asp:panel ID="pnlInstructorPopup" runat="server" CssClass="modalPopup" align="center" style = "display:none">
                    <asp:Label ID="lblInstructorInformation" runat="server" Text="Instructor Information" Font-Bold="True" Font-Size="14pt"></asp:Label>
                    <br /><br />
                    <asp:Label ID="lblInstructorFirstName" runat="server" Text="First Name:"></asp:Label>
                    <asp:TextBox ID="txtInstructorFirstName" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblInstructorLastName" runat="server" Text="Last Name:"></asp:Label>
                    <asp:TextBox ID="txtInstructorLastName" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblInstructorEmail" runat="server" Text="Email:"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtInstructorEmail" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblInstructorPassword" runat="server" Text="Password"></asp:Label>&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtInstructorPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <br />
                    <br/>
                    <asp:Button id="btnInstructorSubmit" runat="server" Text="Submit" onclick="btnInstructorSubmit_Click"/>
                    <asp:Button id="btnInstructorClose" runat="server" Text="Close"/>    
                    <br />
                        <asp:Label id="lblInstructorErrorMessage" runat="server"></asp:Label>
                    <br /><br />           
                </asp:panel>
            </div>

            <div id="divAddCourse" class="block" runat="server" style="width:250px; height:250px; border:double; border-color:yellow;">
                <asp:Button id="btnAddCourse" runat="server" Text="Add Subject" CssClass="AddButton"/>
            </div>
        </div>
        </asp:Panel>
    </div>
</asp:Content>
