using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AttendanceProject
{
    public partial class instructorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string select_instructor = "Select Instructor_ID, FirstName from Instructor";
                SqlConnection myConnection = new SqlConnection();
                myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
                myConnection.Open();
                SqlCommand select_instructor_cmd = new SqlCommand(select_instructor, myConnection);
                SqlDataReader rd_instructor = select_instructor_cmd.ExecuteReader();
                ddlSelectInstructor.DataSource = rd_instructor;
                ddlSelectInstructor.DataBind();
                
                string select_student = "Select Student_ID, FirstName from Student";
                SqlCommand select_student_cmd = new SqlCommand(select_student, myConnection);
                SqlDataReader rd_student = select_student_cmd.ExecuteReader();
                ddlSelectStudent.DataSource = rd_student;
                ddlSelectStudent.DataBind();
                ddlSelectStudent.Items.Insert(0, new ListItem("Select All", "0"));

                string select_subject = "select Subject_ID, SubjectName from Subject";
                SqlCommand select_subject_cmd = new SqlCommand(select_subject, myConnection);
                SqlDataReader rd_subject = select_subject_cmd.ExecuteReader();
                ddlSelectCourse.DataSource = rd_subject;
                ddlSelectCourse.DataBind();
                ddlSelectCourse.Items.Insert(0, new ListItem("Select All", "0"));

                myConnection.Close();
            }            
        }

        protected void btnDropDropSelectOk_Click(object sender, EventArgs e)
        {
            ShowStudentAttendance();
        }

        protected void ShowStudentAttendance()
        {
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            SqlCommand select = new SqlCommand("SELECT * from attendance", myConnection);
            DataSet ds = new DataSet();
            SqlDataAdapter sdp = new SqlDataAdapter(select);
            sdp.Fill(ds);

            GridviewAttendance.DataSource = ds.Tables[0];
            GridviewAttendance.DataBind();
            myConnection.Close();
        }

        protected void gdview_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridviewAttendance.EditIndex = -1;
            ShowStudentAttendance();
        }

        protected void gdview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        { }

        protected void gdview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridviewAttendance.EditIndex = -1;
        }

        protected void gdview_RowEditing(object sender, GridViewEditEventArgs e)
        {
        
        }

        protected void btnAttendanceSubmit_Click(object sender, EventArgs e)
        {
            int instructor_id = int.Parse(ddlSelectInstructor.SelectedValue);
            int student_id = int.Parse(ddlSelectStudent.SelectedValue);
            int subject_id = int.Parse(ddlSelectCourse.SelectedValue);
            int hours = int.Parse(txtHours.Text);
            //DateTime attendanceDate = DateTime.Parse(txtSelectDate.Text);

            string insert_attendance = "Insert into [dbo].[Attendance](Instructor_ID, Student_ID, Subject_ID, Hours) VALUES (@instructorId, @studentId, @subjectID, @hour)";                
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            SqlCommand insertCommand = new SqlCommand(insert_attendance, myConnection);            
            insertCommand.Parameters.AddWithValue("@instructorId", instructor_id);
            insertCommand.Parameters.AddWithValue("@studentId", student_id);
            insertCommand.Parameters.AddWithValue("@subjectID", subject_id);
            insertCommand.Parameters.AddWithValue("@hour", hours);
            //insertCommand.Parameters.AddWithValue("@attendanceDate", attendanceDate);
            int return_val = insertCommand.ExecuteNonQuery();
            if (return_val > 0)
            {
                lblStatusMessage.Text = "Attendance Added Sucessfully";
                ddlSelectInstructor.SelectedIndex = -1;
                ddlSelectStudent.SelectedIndex = -1;
            }
        }

        protected void btnDeleteRecord_Click(object sender, EventArgs e)
        {

        }

        protected void GridviewAttendance_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }
    }
}