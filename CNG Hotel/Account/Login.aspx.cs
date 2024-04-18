using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using CNG_Hotel.Models;
using System.Data.SqlClient;

namespace CNG_Hotel.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        }

        // Method log in
        protected void LogIn(object sender, EventArgs e)
        {
            // Lấy value của Number và Password truyền vào hàm check thông tin
            string phone = Number.Text;
            string password = Password.Text;
            IsValidUser(phone, password);
        }

        private void IsValidUser(string phoneNumber, string password)
        {
            try
            {
                clsDatabase.OpenConnection();
                string query = "SELECT User_ID, Role_ID FROM Users WHERE User_Phone = @PhoneNumber AND User_Pass = @Password";
                SqlCommand command = new SqlCommand(query, clsDatabase.connection);

                command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                command.Parameters.AddWithValue("@Password", password);

                // Đọc dữ liệu và truy vấn
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                 
                    // Lấy user id và user role từ kết quả  => Lấy kết quả dưới dạng số nguyên 32 bit
                    // lấy id ở cột đầu tiên trong kết quả
                    int userId = reader.GetInt32(0);

                    // lấy user role trong cột thứ 2
                    int userRole = reader.GetInt32(1);
               
                    // Gán cookie cho trình duyệt là user id để kiểm tra xem người dùng có đăng nhập hay chưa
                    HttpCookie userIdCookie = new HttpCookie("id", userId.ToString());
                    Response.Cookies.Add(userIdCookie);
                 
                    // Nếu user role = 1 => admin => dẫn đến trang admin
                    if (userRole == 1)
                    {
                        Response.Redirect("/Account/AdminPage.aspx");
                    }
                    // không thì chuyển sang trang chủ cho khách hàng
                    else if (userRole == 2)
                    {
                        Response.Redirect("/Default.aspx");
                    }
                }
                else
                {
                    // Account does not exist
                    System.Diagnostics.Debug.WriteLine("No account");
                }
            }
            catch (Exception)
            {
                FailureText.Text = "Failed to execute";
            }
        }
    }
}