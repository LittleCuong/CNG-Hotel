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
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            // ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            // OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            string phone = Number.Text;
            string password = Password.Text;
            IsValidUser(phone, password);
            //if (IsValid)
            //{
            //    // Validate the user password
            //    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            //    var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

            //    // This doen't count login failures towards account lockout
            //    // To enable password failures to trigger lockout, change to shouldLockout: true
            //    var result = signinManager.PasswordSignIn(Number.Text, Password.Text, RememberMe.Checked, shouldLockout: false);

            //    switch (result)
            //    {
            //        case SignInStatus.Success:
            //            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            //            break;
            //        case SignInStatus.LockedOut:
            //            Response.Redirect("/Account/Lockout");
            //            break;
            //        case SignInStatus.RequiresVerification:
            //            Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}", 
            //                                            Request.QueryString["ReturnUrl"],
            //                                            RememberMe.Checked),
            //                              true);
            //            break;
            //        case SignInStatus.Failure:
            //        default:
            //            FailureText.Text = "Invalid login attempt";
            //            ErrorMessage.Visible = true;
            //            break;
            //    }
            //}
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

                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                 
                    int userId = reader.GetInt32(0);
                    int userRole = reader.GetInt32(1);
               
                    HttpCookie userIdCookie = new HttpCookie("id", userId.ToString());
                    Response.Cookies.Add(userIdCookie);
                 
                    if (userRole == 1)
                    {                    
                        System.Diagnostics.Debug.WriteLine("Login admin");
                    }
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