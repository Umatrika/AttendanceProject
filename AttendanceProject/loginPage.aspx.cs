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
    public partial class loginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFileName=C:\USERS\UMA PHANI\DOCUMENTS\GITHUB\ATTENDANCEPROJECT\ATTENDANCEPROJECT\APP_DATA\DB_UC.MDF;Integrated Security=True;MultipleActiveResultSets=True";
            myConnection.Open();
            string login_command = "SELECT Count(*) FROM [dbo].[Instructor] WHERE Email = @Email AND Password = @Password";
            SqlCommand myCommand = new SqlCommand(login_command, myConnection);
            myCommand.Parameters.AddWithValue("@Email", txtUserName.Text);
            myCommand.Parameters.AddWithValue("@Password", txtPassword.Text);
            Int32 return_status = (Int32)myCommand.ExecuteScalar();
            lblErrorMessage.Text = "Connection Opened" + return_status;
            myConnection.Close();
            if (return_status == 1)
                Response.Redirect("instructorPage.aspx");
            else
            {
                lblErrorMessage.Text = "Check User Name or Password";
                lblErrorMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            //Response.Redirect("adminPage.aspx");
        }

        protected void btnInstructorSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void btnAdminSubmit_Click(object sender, EventArgs e)
        {
            if (txtAdminUserName.Text == "admin" && txtAdminPassword.Text == "123")
                Response.Redirect("AdminPage.aspx");
            else
            {
                lblAdminLoginError.Text = "Check Username or Password";
                lblAdminLoginError.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnNewUserSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}