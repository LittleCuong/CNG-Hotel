using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using CNG_Hotel.Models;
using System.Data.SqlClient;

namespace CNG_Hotel.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            string name = Name.Text;
            string phone = Phone.Text;
            string password = Password.Text;
            string confirmPassword = ConfirmPassword.Text;

            if (password != confirmPassword)
            {
                
            } else
            {
                if (CheckUserPhone(phone) == "existed")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Phone number existed');</script>");
                }
                else
                {
                    if (CreateUser(name, phone, password))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Register successfully, please sign in!');</script>");
                        Response.Redirect("/Account/Login");

                    } else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Register failed, please try again later!');</script>");
                    }

                }
            }

        }

        private static String CheckUserPhone(string phone)
        {
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM Users WHERE User_Phone = @PhoneNumber", clsDatabase.connection);
                command.Parameters.AddWithValue("@PhoneNumber", phone);

                int count = (int)command.ExecuteScalar();
                if (count > 0)
                {
                    return "existed";
                } else
                {
                    return "not exist";
                }
            }
            catch (Exception)
            {
                return "Error";
            }
        }

        private bool CreateUser(string name, string phone, string password)
        {
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("Insert into Users values(@Name, @Phone, @Password, 2)", clsDatabase.connection);
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@Phone", phone);
                command.Parameters.AddWithValue("@Password", password);
                int rowsAffected = command.ExecuteNonQuery();
                return rowsAffected > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}