using System;
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
    public partial class loginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblErrorMessage.Text = "";
            Session["user"] = txtUserName.Text;
            if (txtUserName.Text == "admin" && txtPassword.Text == "123")
            {
                Response.Redirect("adminPage.aspx");
                lblErrorMessage.Text = "";
            }
            else
            {
                SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);                
                myConnection.Open();
                string login_command = "SELECT Count(*) FROM Instructor WHERE Email = @Email AND Password = @Password";
                
                SqlCommand myCommand = new SqlCommand(login_command, myConnection);
                myCommand.Parameters.AddWithValue("@Email", txtUserName.Text);
                myCommand.Parameters.AddWithValue("@Password", txtPassword.Text);                              
                Int32 return_status = (Int32)myCommand.ExecuteScalar();
                myConnection.Close();
                lblErrorMessage.Text = "";
                if (return_status == 1)
                {
                    Response.Redirect("instructorPage.aspx");
                }
                else
                {
                    lblErrorMessage.Text = "Incorrect User Name or Password";
                    lblErrorMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {

        }

        protected void btnNewUserSubmit_Click(object sender, EventArgs e)
        {
            string first_name = txtNewUserFirstName.Text;
            string last_name = txtNewUserLastName.Text;
            string email = txtNewUserEmail.Text;
            string password = txtNewUserPassword.Text;

            SqlConnection myConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["SqlDbConnectionString"].ConnectionString);
            myConnection.Open();
            string login_command = "SELECT Count(*) FROM [dbo].[Instructor] WHERE Email = @Email";
            SqlCommand myCommand = new SqlCommand(login_command, myConnection);
            myCommand.Parameters.AddWithValue("@Email", email);
            Int32 return_status = (Int32)myCommand.ExecuteScalar();
           // lblErrorMessage.Text = "Connection Opened" + return_status;
            myConnection.Close();
            lblErrorMessage.Text = "";
            if (return_status == 1) {
                lblErrorMessage.Text = "User Exists Already";
                lblErrorMessage.ForeColor = System.Drawing.Color.Red;                
            }             
            else
            {
                lblErrorMessage.Text = "Information Submitted to Admin for Approval";
                txtNewUserFirstName.Text = "";
                txtNewUserLastName.Text = "";
                txtNewUserEmail.Text = "";
                txtNewUserPassword.Text = "";
                //txtNewUserConfirmPassword.Text = "";               
            }
        }
    }
}