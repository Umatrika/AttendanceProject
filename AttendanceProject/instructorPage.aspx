<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="instructorPage.aspx.cs" Inherits="AttendanceProject.instructorPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .grdView_HeaderStyle {
            color:white;                   
        }
        .floatRight { 
            float: right; 
            height:inherit;
        }
        .floatLeft { 
            float: right; 
            height:inherit;
            margin-left:100px;
            border:double;
            border-color:black;            
        }
        .AddAttendance {
            font-family:Arial;
            text-align:right;
            font-size:larger;
            font-weight:bold;            
        }
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
    <div id="headerDiv">
        <div id="courseDiv" style="float:left; padding-left:10px;">
            <asp:DropDownList ID="ddlSelectCourse" runat="server" Width="150" DataTextField="SubjectName" DataValueField="Subject_ID">                
            </asp:DropDownList>
            <asp:Button id="btnDropDropSelectOk" runat="server" Text="OK" OnClick="btnDropDropSelectOk_Click"/>
        </div>
        <div id="searchDiv" style="float:right;">
            <asp:TextBox ID="txtSearch" runat="server" TextMode="Search" Text="Search Student"></asp:TextBox>
            <asp:Button id="btnLogOut" runat="server" Text="Sign Out" OnClick="btnLogOut_Click"/>
        </div>        
    </div>
    
    <div id="AttendenceDiv" style="height:450px; font-family:Arial;">

        <div id="showAttendenceDiv" align="center" style="margin-top:50px; font-family:Arial;">
            <asp:Button id="btnAddNewRecord" runat="server" Text="Add New Record" onclick="btnAddNewRecord_Click"/>
                   
            <ajaxControlToolkit:ModalPopupExtender id="ModalPopupExtenderRegister" runat="server" popupcontrolId="pnlAddAttendence" TargetControlID="btnAddNewRecord"
                cancelControlId="btnAttendenceCancel" BackgroundCssClass="modalBackground" >
            </ajaxControlToolkit:ModalPopupExtender>
            
            <asp:Panel ID="pnlAddAttendence" runat="server" CssClass="modalPopup" align="center" style = "display:none">
                <asp:Label ID="lblAddAttendence" runat="server" Text="Add New Attendance" CssClass="AddAttendance"></asp:Label>
                <br /><br />
                <asp:Table ID="addAttendence" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>Select Subject</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlSelectSubject" runat="server" Width="175" DataTextField="SubjectName" DataValueField="Subject_ID">                
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Select Date</></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtSelectDate" runat="server" TextMode="DateTime" ></asp:TextBox>
                                <ajaxControlToolkit:CalendarExtender id="cal" TargetControlID="txtSelectDate" Format="MM/dd/yyyy" runat="server"/>
                                <asp:RequiredFieldValidator ID="selectDateValidator" runat="server" ErrorMessage="*"
                                    controlToValidate="txtSelectDate" ValidationGroup="newRecord" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Select Student</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlSelectStudent" runat="server" Width="175" DataTextField="FirstName" DataValueField="Student_ID">
                            </asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Select Hours</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtHours" runat="server" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="hourValidator" runat="server" ErrorMessage="*"
                                    controlToValidate="txtHours" ValidationGroup="newRecord" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" Type="Integer" 
                                    MinimumValue="0" MaximumValue="4" ControlToValidate="txtHours" 
                                    ErrorMessage="Invalid Range" ForeColor="Red" ValidationGroup="newRecord"/>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>
                            <asp:Button id="btnAttendanceSubmit" runat="server" ValidationGroup="newRecord" Text="Submit" onclick="btnAttendanceSubmit_Click"/>
                            <asp:Button id="btnAttendenceCancel" runat="server" Text="Cancel"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br />
                <asp:Label ID="lblStatusMessage" runat="server"></asp:Label>
                <br />
            </asp:Panel>

            <asp:Button id="btnShowAllRecord" runat="server" Text="Show All" OnClick="btnShowAllRecord_Click"/>
            <asp:Button id="btnShowFiveFewest" runat="server" Text="Show Bottom 5" onclick="btnShowFiveFewest_Click"/>
            <asp:Button id="btnShowFiveMost" runat="server" Text="Show Top 5" OnClick="btnShowFiveMost_Click"/>
            <asp:Button id="btnDeleteRecord" runat="server" Text="Delete Record" OnClick="btnDeleteRecord_Click"/>
            <br />
            <asp:GridView ID ="GridviewAttendance" runat="server" allowpaging="True" CellPadding="4" BackColor="white" BorderWidth="1px" 
            ForeColor="black" BorderColor="#3366CC" AutoGenerateColumns="false" HeaderStyle-CssClass="grdView_HeaderStyle"
            PageSize="10" OnPageIndexChanging="GridviewAttendance_PageIndexChanging"
            OnRowCancelingEdit="gdview_RowCancelingEdit" OnRowDeleting="gdview_RowDeleting"
            OnRowEditing="gdview_RowEditing" OnRowUpdating="gdview_RowUpdating" HorizontalAlign="Center" RowStyle-Wrap="false">
                            
            <PagerStyle ForeColor="white" HorizontalAlign="Left" BackColor="maroon"></PagerStyle>
            <HeaderStyle Font-Bold="True" BackColor="maroon"></HeaderStyle>
                    
            <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                            <asp:CheckBox id="chkBoxAttendence" runat="server"/>
                        </ItemTemplate>
                        <EditItemTemplate>                        
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>      
             
                    <asp:TemplateField HeaderText="First Name">
                        <ItemTemplate>
                            <%# Eval("FirstName")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtStudent" text='<%# Bind("FirstName") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                
                    <asp:TemplateField HeaderText="Last Name">
                        <ItemTemplate>
                            <%# Eval("LastName")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtStudent" text='<%# Bind("LastName") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>            
                                                                 
                    <asp:TemplateField HeaderText="Hours">
                        <ItemTemplate>
                            <%# Eval("Hours")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtSubjectName" text='<%# Bind("Hours") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <%# Eval("AttendanceDT")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%"  runat="server" ID="txtDate" text='<%# Bind("AttendanceDT") %>' />
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>  
            
                    <asp:CommandField ButtonType="Button" ShowEditButton="true" ShowCancelButton="true"/>                            
                </Columns>   
            </asp:GridView>            
        </div>
    </div>
</asp:Content>
