<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="instructorPage.aspx.cs" Inherits="AttendanceProject.instructorPage" %>
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="headerDiv">
        <div id="courseDiv" style="float:left; padding-left:10px;">
            <asp:DropDownList ID="ddlSelectCourse" runat="server" Width="150" DataTextField="SubjectName" DataValueField="Subject_ID">                
            </asp:DropDownList>
            <asp:Button id="btnDropDropSelectOk" runat="server" Text="OK" OnClick="btnDropDropSelectOk_Click"/>
        </div>
        <div id="searchDiv" style="float:right; padding-right:30px;">
            <asp:TextBox ID="txtSearch" runat="server" TextMode="Search" Text="Search Student"></asp:TextBox>
        </div>
    </div>
    
    <div id="AttendenceDiv" style="height:450px;">
        <div id="addAttendenceDiv" style="float:left;">
            <asp:Panel ID="pnlAddAttendence" runat="server" CssClass="floatLeft">
                <asp:Label ID="lblAddAttendence" runat="server" Text="Add New Attendance" CssClass="AddAttendance"></asp:Label>
                <br /><br />
                <asp:Table ID="addAttendence" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>Select Instructor</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlSelectInstructor" runat="server" Width="175" DataTextField="FirstName" DataValueField="Instructor_ID">                                
                                <asp:ListItem Text="Select All" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Select Date</></asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="txtSelectDate" runat="server" TextMode="DateTime"></asp:TextBox></asp:TableCell>
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
                        <asp:TableCell><asp:TextBox ID="txtHours" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>
                            <asp:Button id="btnAttendanceSubmit" runat="server" Text="Submit" onclick="btnAttendanceSubmit_Click"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br />
                <asp:Label ID="lblStatusMessage" runat="server"></asp:Label>
                <br />
            </asp:Panel>            
            <br />
        </div>

        <div id="showAttendenceDiv" align="center" style="margin-top:50px; font-family:Arial; text-align:center;">
            <asp:GridView ID ="GridviewAttendance" runat="server" allowpaging="True" CellPadding="4" BackColor="white" BorderWidth="1px" 
            ForeColor="black" BorderColor="#3366CC" AutoGenerateColumns="false" HeaderStyle-CssClass="grdView_HeaderStyle"
            PageSize="8" OnPageIndexChanging="GridviewAttendance_PageIndexChanging"
            OnRowCancelingEdit="gdview_RowCancelingEdit" OnRowDeleting="gdview_RowDeleting"
            OnRowEditing="gdview_RowEditing" OnRowUpdating="gdview_RowUpdating" HorizontalAlign="Center">
                            
            <PagerStyle ForeColor="#003399" HorizontalAlign="Left" BackColor="maroon"></PagerStyle>
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
             
                    <asp:TemplateField HeaderText="Student">
                        <ItemTemplate>
                            <%# Eval("Student_ID")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtStudent" text='<%# Bind("Student_ID") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                
                    <asp:TemplateField HeaderText="Instructor">
                        <ItemTemplate>
                            <%# Eval("Instructor_ID")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtStudent" text='<%# Bind("Instructor_ID") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>            
                                                                 
                    <asp:TemplateField HeaderText="Subject">
                        <ItemTemplate>
                            <%# Eval("AttendanceDT")%>    
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%" runat="server" ID="txtSubjectName" text='<%# Bind("AttendanceDT") %>'/>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <%# Eval("Hours")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox width="100%"  runat="server" ID="txtDate" text='<%# Bind("Hours") %>' />
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>  
            
                    <asp:CommandField ButtonType="Button" ShowEditButton="true" ShowCancelButton="true"/>                            
                </Columns>   
            </asp:GridView>
            <asp:Button id="btnDeleteRecord" runat="server" Text="Delete Record" OnClick="btnDeleteRecord_Click"/>
        </div>
    </div>
</asp:Content>
