using System;
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
            string select_command = "SELECT Count(*) FROM [dbo].[Instructor] WHERE Email = @EmailId AND Password = @PasswordId";
            SqlCommand myCommand = new SqlCommand(select_command, myConnection);
            myCommand.Parameters.AddWithValue("@EmailId", email);
            myCommand.Parameters.AddWithValue("@PasswordId", password);
            Int32 return_status = (Int32)myCommand.ExecuteScalar();
            if (return_status > 0)
            {
                lblInstructorErrorMessage.Text = "Instructor Exists Already.";
                lblInstructorErrorMessage.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                string insert_command = "INSERT INTO [dbo].[Instructor] ([FirstName], [LastName],[Email],[Password]) values (@FirstName, @LastName, @Email, @Password)";
                SqlCommand insertCommand = new SqlCommand(insert_command, myConnection);
                //SqlCommand insertCommand = new SqlCommand("[dbo].[usp_RegisterInstructor]", myConnection);
                //insertCommand.CommandType = CommandType.StoredProcedure;
                insertCommand.Parameters.AddWithValue("@FirstName", firstName);
                insertCommand.Parameters.AddWithValue("@LastName", lastName);
                insertCommand.Parameters.AddWithValue("@Email", email);
                insertCommand.Parameters.AddWithValue("@Password", password);                
            }
            myConnection.Close();       
        }

        protected void btnStudentSubmit_Click(object sender, EventArgs e)
        {
            String firstName = txtStudentFirstName.Text;
            String lastName = txtStudentLastName.Text;
            String email = txtStudentEmail.Text;
            //DateTime DOB = DateTime.Parse(txtStudentDOB.Text);
            string mobile = txtStudentMobileNumber.Text; // check data type of mobile
            string address = txtStudentAddress.Text;
            string city = txtStudentCity.Text;
            string state = txtStudentState.Text;
            string zip = txtStudentZip.Text; // Check for data type
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
                string insert_command = "INSERT INTO [dbo].[Student]([FirstName],[LastName],[Email],[MobileNumber],[Adrress],[City],[State],[Zip],[Notes]) VALUES	(@FirstName,@LastName,@Email,@MobileNumber,@Adrress,@City,@State,@Zip,@Notes)";
                SqlCommand insertCommand = new SqlCommand(insert_command, myConnection);                
                insertCommand.Parameters.AddWithValue("@FirstName", firstName);
                insertCommand.Parameters.AddWithValue("@LastName", lastName);
                insertCommand.Parameters.AddWithValue("@Email", email);
                //insertCommand.Parameters.AddWithValue("@DOB", DOB);
                insertCommand.Parameters.AddWithValue("@MobileNumber", mobile);
                insertCommand.Parameters.AddWithValue("@Adrress", address);
                insertCommand.Parameters.AddWithValue("@City", city);
                insertCommand.Parameters.AddWithValue("@State", state);
                insertCommand.Parameters.AddWithValue("@Zip", zip);
                insertCommand.Parameters.AddWithValue("@Notes", note);
                int return_value = insertCommand.ExecuteNonQuery();
            }
            myConnection.Close();
        }
    }
}