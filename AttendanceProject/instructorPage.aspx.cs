using System;
using System.Globalization;
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
        static int instructor_ID;
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
                //ddlSelectInstructor.DataSource = rd_instructor;
                //ddlSelectInstructor.DataBind();
                
                string select_student = "Select Student_ID, FirstName from Student";
                SqlCommand select_student_cmd = new SqlCommand(select_student, myConnection);
                SqlDataReader rd_student = select_student_cmd.ExecuteReader();
                ddlSelectStudent.DataSource = rd_student;
                ddlSelectStudent.DataBind();
                ddlSelectStudent.Items.Insert(0, new ListItem("Select All", "0"));

                string select_subject = "select Subject_ID, SubjectName from Subject";
                SqlCommand select_subject_cmd = new SqlCommand(select_subject, myConnection);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = select_subject_cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                ddlSelectSubject.DataSource = ds;
                ddlSelectSubject.DataBind();

                ddlSelectCourse.DataSource = ds;
                ddlSelectCourse.DataBind();

                myConnection.Close();
                ShowStudentAttendance();
            }            
        }

        protected void btnDropDropSelectOk_Click(object sender, EventArgs e)
        {
            ShowStudentAttendance();
        }

        protected void ShowStudentAttendance()
        {
            string instructor_email; 
            if (!string.IsNullOrEmpty(Session["user"] as string)) 
            {
                instructor_email = Session["user"].ToString();
                SqlConnection myConnection = new SqlConnection();
                myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
                myConnection.Open();

                string instructor_id_cmd = "select top 1 Instructor_ID from Instructor where Email = @instructor_email";
                SqlCommand login_username_cmd = new SqlCommand(instructor_id_cmd, myConnection);
                login_username_cmd.Parameters.AddWithValue("@instructor_email", instructor_email);
                SqlDataReader reader = login_username_cmd.ExecuteReader();
                reader.Read();
                int instructor_id = Convert.ToInt32(reader["Instructor_ID"]);
                instructor_ID = instructor_id;

                string select_string = "select A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME, A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND INSTRUCTOR_ID=@instructor_id";
                //SqlCommand select = new SqlCommand("SELECT * from attendance", myConnection);
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
            int instructor_id = instructor_ID;
            int student_id = int.Parse(ddlSelectStudent.SelectedValue);
            int subject_id = int.Parse(ddlSelectSubject.SelectedValue);
            int hours = int.Parse(txtHours.Text);
            //DateTime attendanceDate = DateTime.Parse(txtSelectDate.Text);
            //booking.bookingDate = DateTime.ParseExact(datepicker.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            DateTime attendanceDate = DateTime.ParseExact(txtSelectDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);            
            string insert_attendance = "Insert into [dbo].[Attendance](Instructor_ID, Student_ID, Subject_ID, Hours) VALUES (@instructorId, @studentId, @subjectID, @hour)";                
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            SqlCommand insertCommand = new SqlCommand(insert_attendance, myConnection);            
            insertCommand.Parameters.AddWithValue("@instructorId", instructor_id);
            insertCommand.Parameters.AddWithValue("@studentId", student_id);
            insertCommand.Parameters.AddWithValue("@subjectID", subject_id);
            insertCommand.Parameters.AddWithValue("@hour", hours);
            insertCommand.Parameters.AddWithValue("@attendanceDate", attendanceDate);
            int return_val = insertCommand.ExecuteNonQuery();
            if (return_val > 0)
            {
                lblStatusMessage.Text = "Attendance Added Sucessfully";
                ddlSelectSubject.SelectedIndex = -1;
                ddlSelectStudent.SelectedIndex = -1;
            }
            ShowStudentAttendance();
        }

        protected void btnDeleteRecord_Click(object sender, EventArgs e)
        {

        }

        protected void GridviewAttendance_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void btnAddNewRecord_Click(object sender, EventArgs e)
        {


        }

        protected void btnShow_Click(object sender, EventArgs e)
        {

        }

        protected void btnShowFiveFewest_Click(object sender, EventArgs e)
        {
            string select_top_five_str = " select top 5 A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME,A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND INSTRUCTOR_ID='2' order by Hours desc";
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
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
            string select_top_five_str = " select top 5 A.Subject_ID, A.INSTRUCTOR_ID, A.STUDENT_ID, B.FIRSTNAME,B.LASTNAME,A.HOURS, A.AttendanceDT from attendance a LEFT JOIN STUDENT B ON A.Student_ID=B.Student_ID WHERE B.ACTIVE='Y' AND INSTRUCTOR_ID='2' order by Hours";
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
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