using System;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Configuration;

namespace AttendanceProject
{
    public partial class instructorPage : System.Web.UI.Page
    {
        static int instructor_ID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string select_instructor = "Select Instructor_ID, FirstName from Instructor";
                SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
                myConnection.Open();
                SqlCommand select_instructor_cmd = new SqlCommand(select_instructor, myConnection);
                SqlDataReader rd_instructor = select_instructor_cmd.ExecuteReader();
                
                string select_student = "Select Student_ID, FirstName from Student Where Active='Y'";
                SqlCommand select_student_cmd = new SqlCommand(select_student, myConnection);
                SqlDataReader rd_student = select_student_cmd.ExecuteReader();
                ddlSelectStudent.DataSource = rd_student;
                ddlSelectStudent.DataBind();
                ddlSelectStudent.Items.Insert(0, new ListItem("Select All", "0"));

                string select_subject = "select Subject_ID, SubjectName from Subject Where Active='Y'";
                SqlCommand select_subject_cmd = new SqlCommand(select_subject, myConnection);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = select_subject_cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                ddlSelectSubject.DataSource = ds;
                ddlSelectSubject.DataBind();                

                ddlSelectCourse.DataSource = ds;
                ddlSelectCourse.DataBind();
                ddlSelectCourse.Items.Insert(0, new ListItem("All Subjects", "0"));

                myConnection.Close();
                ShowStudentAttendance();
            }            
        }

        protected void btnDropDropSelectOk_Click(object sender, EventArgs e)
        {
            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();
            //string select_string = "select A.Attendance_ID, A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME, A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND INSTRUCTOR_ID=@instructor_id AND Subject_ID=@subjectId";
            string select_string = "select * from (select A.Attendance_ID,A.Instructor_ID, A.STUDENT_ID, A.SUBJECT_ID, A.HOURS, A.AttendanceDT, B.FirstName,B.LastName from dbo.attendance A LEFT JOIN DBO.Student B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID WHERE D.ACTIVE='Y' AND c.Instructor_ID=@instructor_id AND c.Subject_ID=@subjectId";
            //string select_All_string = "select A.Attendance_ID, A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME, A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND INSTRUCTOR_ID=@instructor_id";
            string select_All_string = "select * from (select A.Attendance_ID,A.Instructor_ID, A.STUDENT_ID, A.SUBJECT_ID, A.HOURS, A.AttendanceDT, B.FirstName,B.LastName from dbo.attendance A LEFT JOIN DBO.Student B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID WHERE D.ACTIVE='Y' AND c.Instructor_ID=@instructor_id";
            Int32 ddlSelectedValue = Convert.ToInt32(ddlSelectCourse.SelectedValue);
            SqlCommand select;
            if(ddlSelectedValue == 0)
                select = new SqlCommand(select_All_string, myConnection);
            else
                select = new SqlCommand(select_string, myConnection);
            select.Parameters.AddWithValue("@instructor_id", instructor_ID);
            select.Parameters.AddWithValue("@subjectId", ddlSelectedValue);
            
            DataSet ds = new DataSet();
            SqlDataAdapter sdp = new SqlDataAdapter(select);
            sdp.Fill(ds);

            GridviewAttendance.DataSource = ds.Tables[0];
            GridviewAttendance.DataBind();
            //GridviewAttendance.EditIndex = 1;
            myConnection.Close();            
        }

        protected void ShowStudentAttendance()
        {
            string instructor_email; 
            if (!string.IsNullOrEmpty(Session["user"] as string)) 
            {
                instructor_email = Session["user"].ToString();
                SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
                myConnection.Open();

                string instructor_id_cmd = "select top 1 Instructor_ID from Instructor where Email = @instructor_email";
                SqlCommand login_username_cmd = new SqlCommand(instructor_id_cmd, myConnection);
                login_username_cmd.Parameters.AddWithValue("@instructor_email", instructor_email);
                SqlDataReader reader = login_username_cmd.ExecuteReader();
                reader.Read();
                int instructor_id = Convert.ToInt32(reader["Instructor_ID"]);
                instructor_ID = instructor_id;

                //string select_string = "select A.Attendance_ID, A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME, A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND A.ACTIVE='Y' AND INSTRUCTOR_ID=@instructor_id order by A.Attendance_ID desc";
                string select_string = "select * from (select A.Attendance_ID,A.Instructor_ID, A.STUDENT_ID, A.SUBJECT_ID, A.HOURS, A.AttendanceDT, B.FirstName,B.LastName from dbo.attendance A LEFT JOIN DBO.Student B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID WHERE D.ACTIVE='Y' AND c.Instructor_ID=@instructor_id";
                SqlCommand select = new SqlCommand(select_string, myConnection);
                select.Parameters.AddWithValue("@instructor_id", instructor_id);
                DataSet ds = new DataSet();
                SqlDataAdapter sdp = new SqlDataAdapter(select);
                sdp.Fill(ds);

                GridviewAttendance.DataSource = ds.Tables[0];
                GridviewAttendance.DataBind();
                myConnection.Close();
            }
            else
            {
                Response.Redirect("loginPage.aspx");
            }
        }

        protected void gdview_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridviewAttendance.EditIndex = -1;
            ShowStudentAttendance();
        }

        protected void gdview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = GridviewAttendance.Rows[e.RowIndex];
            
            Label lblFirstNameStr = row.FindControl("lblFirstName") as Label;
            Label lblLastNameStr = row.FindControl("lblLastName") as Label;
            Label lblHoursStr = row.FindControl("lblHours") as Label;
            Label lblDateStr = row.FindControl("lblDate") as Label;
            Label lblAttendanceId = row.FindControl("lblAttendanceID") as Label;

            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();
            string selectStudentId = "select top 1 Student_ID from Student Where FirstName=@firstName AND LastName=@lastName";
            SqlCommand SelectStudentIdCmd = new SqlCommand(selectStudentId, myConnection);
            SelectStudentIdCmd.Parameters.AddWithValue("@firstName", lblFirstNameStr.Text);
            SelectStudentIdCmd.Parameters.AddWithValue("@lastName", lblLastNameStr.Text);
            SqlDataReader reader = SelectStudentIdCmd.ExecuteReader();
            reader.Read();
            int student_id = Convert.ToInt32(reader["Student_ID"]);
            
            string delete_attendance = "update attendance set Active='N' where Attendance_ID=@attendanceID";
            SqlCommand deleteCommand = new SqlCommand(delete_attendance, myConnection);
            deleteCommand.Parameters.AddWithValue("@attendanceID", lblAttendanceId.Text);
            int return_val = deleteCommand.ExecuteNonQuery();
            myConnection.Close();
            if (return_val > 0)
            {
                ddlSelectSubject.SelectedIndex = -1;
                ddlSelectStudent.SelectedIndex = -1;
                ShowStudentAttendance();
            }           
        }

        protected void gdview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridviewAttendance.Rows[e.RowIndex];
            TextBox newUserName = (TextBox)row.FindControl("txtFirstName");
            TextBox newLastName = (TextBox)row.FindControl("txtLastName");
            TextBox newHours = (TextBox)row.FindControl("txtHours");
            TextBox newDate = (TextBox)row.FindControl("txtDate");
            TextBox lblId = (TextBox)row.FindControl("txtAttendanceId");

            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();
            string updateStr = "Update Attendance SET Hours=@newHours, AttendanceDT=@newAttendance Where Attendance_ID=@newAttId";
            SqlCommand updateCmd = new SqlCommand(updateStr, myConnection);
            updateCmd.Parameters.AddWithValue("@newHours", newHours.Text);
            updateCmd.Parameters.AddWithValue("@newAttendance", newDate.Text);
            updateCmd.Parameters.AddWithValue("newAttId", lblId.Text);            
            int return_val = updateCmd.ExecuteNonQuery();
            myConnection.Close();
            if (return_val > 0)
            {
                ddlSelectSubject.SelectedIndex = -1;
                ddlSelectStudent.SelectedIndex = -1;
                GridviewAttendance.EditIndex = -1;
                ShowStudentAttendance();
            }
        }

        protected void gdview_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridviewAttendance.EditIndex = e.NewEditIndex;
            //ShowStudentAttendance();
        }

        protected void btnAttendanceSubmit_Click(object sender, EventArgs e)
        {
            int instructor_id = instructor_ID;
            int student_id = int.Parse(ddlSelectStudent.SelectedValue);
            int subject_id = int.Parse(ddlSelectSubject.SelectedValue);
            int hours = int.Parse(txtHours.Text);
            DateTime attendanceDate = DateTime.ParseExact(txtSelectDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            string insert_attendance = "Insert into [dbo].[Attendance](Instructor_ID, Student_ID, Subject_ID, Hours, AttendanceDT) VALUES (@instructorId, @studentId, @subjectID, @hour, @attendanceDate)";
            string insert_subject_student = "Insert into Subject_Student(Subject_ID, Student_ID, RegisterDT) VALUES (@subjectID, @studentId, @attendanceDate)";

            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();
            SqlCommand insertCommand = new SqlCommand(insert_attendance, myConnection);
            SqlCommand insertSubjStudentCmd = new SqlCommand(insert_subject_student, myConnection);
            insertCommand.Parameters.AddWithValue("@instructorId", instructor_id);
            insertCommand.Parameters.AddWithValue("@studentId", student_id);
            insertCommand.Parameters.AddWithValue("@subjectID", subject_id);
            insertCommand.Parameters.AddWithValue("@hour", hours);
            insertCommand.Parameters.AddWithValue("@attendanceDate", attendanceDate);
            insertSubjStudentCmd.Parameters.AddWithValue("@subjectID", subject_id);
            insertSubjStudentCmd.Parameters.AddWithValue("@studentId", student_id);
            insertSubjStudentCmd.Parameters.AddWithValue("@attendanceDate", attendanceDate);
            int return_val = insertCommand.ExecuteNonQuery();
            if (return_val > 0)
            {
                ddlSelectSubject.SelectedIndex = -1;
                ddlSelectStudent.SelectedIndex = -1;
            }
            insertSubjStudentCmd.ExecuteNonQuery();
            myConnection.Close();
            txtHours.Text = "";
            txtSelectDate.Text = "";
            ShowStudentAttendance();
        }

        protected void GridviewAttendance_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            
            ShowStudentAttendance();
            GridviewAttendance.PageIndex = e.NewPageIndex;
            GridviewAttendance.DataBind();
        }

        protected void btnShowFiveFewest_Click(object sender, EventArgs e)
        {
            //string select_top_five_str = "select TOP 5 * from (select a.instructor_id, a.student_id, a.subject_id, b.FirstName,b.LastName,a.TotalHours from (select instructor_id, student_id, subject_id, SUM(hours) AS 'TotalHours' from dbo.attendance group by instructor_id, student_id, subject_id ) A LEFT JOIN DBO.STUDENT B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID where c.Instructor_ID =@instructor_id ORDER BY C.TotalHours";
            string select_top_five_str = "select TOP 5 * from (select '-' as AttendanceDT, '-' as Attendance_ID, a.instructor_id, a.student_id, a.subject_id, b.FirstName,b.LastName,a.Hours from (select instructor_id, student_id, subject_id, SUM(hours) AS 'Hours' from dbo.attendance group by instructor_id, student_id, subject_id ) A LEFT JOIN DBO.STUDENT B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID where c.Instructor_ID =@instructor_id ORDER BY C.Hours";
            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();

            SqlCommand select_top_cmd = new SqlCommand(select_top_five_str, myConnection);
            select_top_cmd.Parameters.AddWithValue("@instructor_id", instructor_ID);
            DataSet ds = new DataSet();
            SqlDataAdapter sdp = new SqlDataAdapter(select_top_cmd);
            sdp.Fill(ds);
            GridviewAttendance.DataSource = ds.Tables[0];
            GridviewAttendance.DataBind();
            myConnection.Close();
        }

        protected void btnShowFiveMost_Click(object sender, EventArgs e)
        {
            //string select_top_five_str = "select TOP 5 * from (select a.instructor_id, a.student_id, a.subject_id, b.FirstName,b.LastName,a.TotalHours from (select instructor_id, student_id, subject_id, SUM(hours) AS 'TotalHours' from dbo.attendance group by instructor_id, student_id, subject_id ) A LEFT JOIN DBO.STUDENT B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID where c.Instructor_ID=@instructor_id ORDER BY C.TotalHours desc";
            string select_top_five_str = "select TOP 5 * from (select '-' as AttendanceDT, '-' as Attendance_ID, a.instructor_id, a.student_id, a.subject_id, b.FirstName,b.LastName,a.Hours from (select instructor_id, student_id, subject_id, SUM(hours) AS 'Hours' from dbo.attendance group by instructor_id, student_id, subject_id ) A LEFT JOIN DBO.STUDENT B ON A.STUDENT_ID=B.STUDENT_ID WHERE B.ACTIVE='Y') C LEFT JOIN DBO.SUBJECT D ON C.SUBJECT_ID=D.SUBJECT_ID where c.Instructor_ID =@instructor_id ORDER BY C.Hours DESC";
            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();

            SqlCommand select_top_cmd = new SqlCommand(select_top_five_str, myConnection);
            select_top_cmd.Parameters.AddWithValue("@instructor_id", instructor_ID);
            DataSet ds = new DataSet();
            SqlDataAdapter sdp = new SqlDataAdapter(select_top_cmd);
            sdp.Fill(ds);
            GridviewAttendance.DataSource = ds.Tables[0];
            GridviewAttendance.DataBind();
            myConnection.Close();
        }

        protected void btnShowAllRecord_Click(object sender, EventArgs e)
        {
            ShowStudentAttendance();            
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session["user"] = "";
            Response.Redirect("loginPage.aspx");
        }
    }
}