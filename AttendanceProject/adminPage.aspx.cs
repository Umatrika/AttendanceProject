using System;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
//using ClientScript.RegisterStartupScript;

namespace AttendanceProject
{
    public partial class adminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string admin_username;
                if (!string.IsNullOrEmpty(Session["user"] as string))
                {
                    admin_username = Session["user"].ToString();
                    if (admin_username != "admin")
                        Response.Redirect("loginPage.aspx");
                }
                else
                    Response.Redirect("loginPage.aspx");
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {

        }

        protected void addStudent_Click(object sender, ImageClickEventArgs e)
        {
            string queryString = "loginPage.aspx";
            string newWin = "window.open('" + queryString + "');";
            ClientScript.RegisterStartupScript(this.GetType(), "pop", newWin, true);
        }

        protected void addInstructor_Click(object sender, ImageClickEventArgs e)
        {
            
        }

        protected void btnInstructorSubmit_Click(object sender, EventArgs e)
        {
            //Store Instructor Information in Database.
            string firstName = txtInstructorFirstName.Text;
            string lastName = txtInstructorLastName.Text;
            string email = txtInstructorEmail.Text;
            string password = txtInstructorPassword.Text;   // check how to store it

            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            string select_command = "SELECT Count(*) FROM [dbo].[Instructor] WHERE Email = @EmailId";
            SqlCommand myCommand = new SqlCommand(select_command, myConnection);
            myCommand.Parameters.AddWithValue("@EmailId", email);
            Int32 return_status = (Int32)myCommand.ExecuteScalar();
            if (return_status > 0)
            {
                lblStudentErrorMessage.Text = "Instructor Exists Already.";
                //lblInstructorErrorMessage.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                string insert_intructor_str = "INSERT INTO [dbo].[Instructor] ([FirstName], [LastName],[Email],[Password]) values (@FirstName, @LastName, @Email, @Password)";
                SqlCommand insertInstructorCmd = new SqlCommand(insert_intructor_str, myConnection);
                insertInstructorCmd.Parameters.AddWithValue("@FirstName", firstName);
                insertInstructorCmd.Parameters.AddWithValue("@LastName", lastName);
                insertInstructorCmd.Parameters.AddWithValue("@Email", email);
                insertInstructorCmd.Parameters.AddWithValue("@Password", password);
                int return_value = insertInstructorCmd.ExecuteNonQuery();
                if (return_value > 0)
                {
                    lblStudentErrorMessage.Text = "Instructor Added Sucessfully";
                }
            }
            myConnection.Close();       
        }

        protected void btnStudentSubmit_Click(object sender, EventArgs e)
        {
            String firstName = txtStudentFirstName.Text;
            String lastName = txtStudentLastName.Text;
            String email = txtStudentEmail.Text;
            DateTime DOB = DateTime.ParseExact(txtStudentDOB.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            string mobile = txtStudentMobileNumber.Text;
            string address = txtStudentAddress.Text;
            string city = txtStudentCity.Text;
            string state = txtStudentState.Text;
            string zip = txtStudentZip.Text;
            string note = txtStudentNotes.Text;

            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            string select_command = "SELECT Count(*) FROM [dbo].[Student] WHERE Email = @Email";
            SqlCommand myCommand = new SqlCommand(select_command, myConnection);
            myCommand.Parameters.AddWithValue("@Email", email);
            Int32 return_status = (Int32)myCommand.ExecuteScalar();
            if (return_status > 0)
            {
                lblStudentErrorMessage.Text = "Student Exists Already.";
                lblStudentErrorMessage.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                string insert_student_str = "INSERT INTO [dbo].[Student]([FirstName],[LastName],[Email],[DOB],[MobileNumber],[Adrress],[City],[State],[Zip],[Notes]) VALUES	(@FirstName,@LastName,@Email,@dob, @MobileNumber,@Adrress,@City,@State,@Zip,@Notes)";
                SqlCommand insertCommandCmd = new SqlCommand(insert_student_str, myConnection);                
                insertCommandCmd.Parameters.AddWithValue("@FirstName", firstName);
                insertCommandCmd.Parameters.AddWithValue("@LastName", lastName);
                insertCommandCmd.Parameters.AddWithValue("@Email", email);
                insertCommandCmd.Parameters.AddWithValue("@dob", DOB);
                insertCommandCmd.Parameters.AddWithValue("@MobileNumber", mobile);
                insertCommandCmd.Parameters.AddWithValue("@Adrress", address);
                insertCommandCmd.Parameters.AddWithValue("@City", city);
                insertCommandCmd.Parameters.AddWithValue("@State", state);
                insertCommandCmd.Parameters.AddWithValue("@Zip", zip);
                insertCommandCmd.Parameters.AddWithValue("@Notes", note);
                int return_value = insertCommandCmd.ExecuteNonQuery();
                if (return_value > 0)
                {
                    lblStudentErrorMessage.Text = "Student Added Sucessfully";                    
                }
            }
            myConnection.Close();
        }

        protected void btnCourseSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}