<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="adminPage.aspx.cs" Inherits="AttendanceProject.adminPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .floatRight 
        { 
            float: right;
            height:inherit;
        }
        .floatLeft 
        { 
            float: left; 
            height:inherit;           
        }
        .floatCenter { 
            text-align: center;
        }
        .AddCourse {
            font-family:Arial;
            text-align:right;
            font-size:larger;
            font-weight:bold;            
        }
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
            font-family:Arial;
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
        .inlineBlock 
        { 
            display: inline-block; 
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="headDiv" align="center">        
        <div id="rightDiv" style="float:right; padding-right:10px;">
            <asp:Button id="btnSignOut" runat="server" Text="Sign Out" OnClick="btnSignOut_Click"/>
        </div>
        <div>
            <asp:Label ID="lblStudentErrorMessage" runat="server" Font-Bold="True" Font-Size="15"></asp:Label>
        </div>
       <div id="dashboardDiv" style="font-family:arial;">
            <h2>Welcome to Dashboard Board</h2>
        </div>
    </div>

    <div id="contentDiv1" align="center">
        <asp:Panel id="pnlAddStudent" runat="server" CssClass="inlineBlock">
            <div id="divAddStudent" class="block" runat="server" style="width:250px; height:250px; border:double; border-color: black;">
                <asp:Button id="btnAddStudent" runat="server" Text="Add Student" CssClass="AddButton"/>
                <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtender1" runat="server" popupcontrolId="Panel1" TargetControlID="btnAddStudent"
                    BackgroundCssClass="modalBackground">
                </ajaxControlToolkit:ModalPopupExtender>

                <asp:panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" style = "display:none"><br />
                    <asp:Label ID="lblStudentInformation" runat="server" Text="Add Student Information" Font-Bold="True" Font-Size="14pt"></asp:Label><br /><br />
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell>First Name</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox id="txtStudentFirstName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentFirstNameValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentFirstName" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="lastNameValidator" runat="server" 
                                     ControlToValidate="txtStudentFirstName" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Last Name</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentLastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentLastNameValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentLastName" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="studentLastNameValidation" runat="server" 
                                    ControlToValidate="txtStudentLastName" ValidationGroup="studentAdd" ForeColor="Red"
                                ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Email</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentEmailValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentEmail" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="studentEmailValidation" runat="server" 
                                    ControlToValidate="txtStudentEmail" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                                    Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>DOB</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentDOB" runat="server" TextMode="DateTime"></asp:TextBox>
                                <ajaxControlToolkit:CalendarExtender id="cal" TargetControlID="txtStudentDOB" Format="MM/dd/yyyy" runat="server"/>
                                <asp:RequiredFieldValidator ID="txtStudentDOBValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentDOB" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Mobile No</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentMobileNumber" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentMobileNumberValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentMobileNumber" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="StudentMobileValidation" runat="server" ErrorMessage="Invalid" 
                                    ControlToValidate="txtStudentMobileNumber" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression= "^(\(?[0-9]{3}\)?)?\-?[0-9]{3}\-?[0-9]{4}$"></asp:RegularExpressionValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Address</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentAddress" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentAddressValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentAddress" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>City</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentCity" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentCityValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentCity" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="studentCityCalidation" runat="server" 
                                     ControlToValidate="txtStudentCity" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>State</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentState" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentStateValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentState" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="studentStateValidation" runat="server" 
                                     ControlToValidate="txtStudentState" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Zip</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentZip" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtStudentZipValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtStudentZip" ValidationGroup="studentAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="studentZipValidation" runat="server" 
                                     ControlToValidate="txtStudentZip" ValidationGroup="studentAdd" ForeColor="Red"
                                    ValidationExpression="\d{5}-?(\d{4})?$" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>                            
                        <asp:TableRow>
                            <asp:TableCell>Notes</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtStudentNotes" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow >
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell VerticalAlign="Middle">
                                <asp:Button id="btnStudentSubmit" runat="server" Text="Submit" onclick="btnStudentSubmit_Click" ValidationGroup="studentAdd"/>
                                <asp:Button id="btnStudentCancel" runat="server" Text="Cancel"/>
                            </asp:TableCell>                            
                        </asp:TableRow>
                    </asp:Table>                    
                    <br /><br />
                </asp:panel>               
            </div>
        </asp:Panel>
        <asp:Panel id="Panel2" runat="server" CssClass="inlineBlock">
            <div id="divAddInstructor" class="block" runat="server" style="width:250px; height:250px; border:double; border-color:black;">
                <asp:Button ID="btnAddInstructor" runat="server" Text="Add Instructor" CssClass="AddButton"/>
                <ajaxControlToolkit:ModalPopupExtender id="ajaxPopup" runat="server" popupcontrolId="pnlInstructorPopup" TargetControlID="btnAddInstructor"
                    cancelControlId="btnInstructorCancel" BackgroundCssClass="modalBackground">
                </ajaxControlToolkit:ModalPopupExtender>

                <asp:panel ID="pnlInstructorPopup" runat="server" CssClass="modalPopup" align="center" style = "display:none">
                    <asp:Label ID="lblAddInstructor" runat="server" Text="Add New Instructor" CssClass="AddCourse"></asp:Label>
                    <br /><br />
                    <asp:Table ID="tblAddInstructor" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>First Name</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtInstructorFirstName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="instructorFirstNameValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtInstructorFirstName" ValidationGroup="instructorAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="firstNameValidator" runat="server" 
                                    ControlToValidate="txtInstructorFirstName" ValidationGroup="instructorAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" /> 
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Last Name</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtInstructorLastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="instructorLastNameValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtInstructorLastName" ValidationGroup="instructorAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="lastNameValdator" runat="server" 
                                    ControlToValidate="txtInstructorLastName" ValidationGroup="instructorAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Email</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtInstructorEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="instructorEmailValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtInstructorEmail" ValidationGroup="instructorAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="emailValidator" runat="server" 
                                    ControlToValidate="txtInstructorEmail" ValidationGroup="Popup" ForeColor="Red"
                                    ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                                    Text="Invalid" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Password</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtInstructorPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="instructorPasswordValidator" runat="server" ErrorMessage="*"
                                     controlToValidate="txtInstructorPassword" ValidationGroup="instructorAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell>
                                <asp:Button id="btnInstructorSubmit" runat="server" Text="Submit" onclick="btnInstructorSubmit_Click" ValidationGroup="instructorAdd"/>
                                <asp:Button ID="btnInstructorCancel" runat="server" Text="Cancel"/>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table> 
                    <br /><br />   
                </asp:panel>
            </div>
        </asp:Panel>
        <asp:Panel id="Panel3" runat="server" CssClass="inlineBlock">
            <div id="divAddCourse" class="block" runat="server" style="width:250px; height:250px; border:double; border-color:black;">
                <asp:Button id="btnAddCourse" runat="server" Text="Add Subject" CssClass="AddButton"/>
                <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtender2" runat="server" popupcontrolId="pnlAddCoursePopup" TargetControlID="btnAddCourse"
                    cancelControlId="btnCourseCancel" BackgroundCssClass="modalBackground">
                </ajaxControlToolkit:ModalPopupExtender>

                <asp:panel ID="pnlAddCoursePopup" runat="server" CssClass="modalPopup" align="center" style = "display:none">
                <asp:Label ID="lblAddCourse" runat="server" Text="Add New Course" CssClass="AddCourse"></asp:Label>
                    <br /><br />
                <asp:Table ID="tblAddCourse" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>Subject Name</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtSubjectName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtSubjectNameValidaor" runat="server" ErrorMessage="*"
                                     controlToValidate="txtSubjectName" ValidationGroup="CourseAdd" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="SubjectNameValidator" runat="server" 
                                    ControlToValidate="txtSubjectName" ValidationGroup="CourseAdd" ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z0-9\s]{1,50}$" Text="Invalid" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Department Name</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlSelectCourse" runat="server" Width="175">
                                <asp:ListItem Text="Arts" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Business" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Computer" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Finance" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Medical" Value="4"></asp:ListItem>
                            </asp:DropDownList>                            
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Description</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="txtCourseDescription" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>
                            <asp:Button id="btnCourseSubmit" runat="server" Text="Submit" onclick="btnCourseSubmit_Click" ValidationGroup="CourseAdd"/>
                            <asp:Button id="btnCourseCancel" runat="server" Text="Cancel"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br /><br />
                </asp:panel>
            </div>
         </asp:Panel>       
    </div>
</asp:Content>
