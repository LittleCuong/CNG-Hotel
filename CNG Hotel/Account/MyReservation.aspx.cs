using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CNG_Hotel.Account
{


    public partial class MyReservation : System.Web.UI.Page
    {
        HttpCookie propertyIdCookie = HttpContext.Current.Request.Cookies["id"];
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve property ID from cookie
                
                if (propertyIdCookie != null)
                {
                    int propertyId;
                    if (int.TryParse(propertyIdCookie.Value, out propertyId))
                    {
                        // Call the method to fetch reservations by property ID
                        GetReservations(propertyId);
                    }
                    else
                    {
                        // Property ID in cookie is not a valid integer
                        // Handle this case as needed
                    }
                }
            }
        }

        private void GetReservations(int id)
        {
            DataTable dt = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                string query = @"
                    SELECT 
                        R.R_ID AS R_ID,
                        R.R_Details AS R_Details,                      
                        R.R_Booking_Date AS R_Booking_Date,
                        Ro.Room_Name AS Room_Name,
                        BD.Date_Checkin AS Date_Checkin,
                        BD.Date_Checkout AS Date_Checkout
                    FROM 
                        Reservation AS R
                    JOIN 
                        Booking_Details AS BD ON R.R_ID = BD.R_ID
                    JOIN 
                        Room AS Ro ON BD.Room_ID = Ro.Room_ID
                    WHERE 
                        R.User_ID = @UserId";

                    SqlCommand command = new SqlCommand(query, clsDatabase.connection);
                    command.Parameters.AddWithValue("@UserId", id);

                    clsDatabase.CloseConnection();

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dt);
                    ReservationGridView.DataSource = dt;
                    ReservationGridView.DataBind();
            }
            catch (Exception)
            {
                //result.ForeColor = System.Drawing.Color.Red;
                //result.Text = ex.Message;
            }
        }

        protected void frmSinhVien_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int propertyId;
            string reservationId = ReservationGridView.DataKeys[e.RowIndex].Value.ToString();
            string sqlDelete = "DELETE FROM Reservation WHERE R_ID ='" + reservationId + "';";
            try
            {
                clsDatabase.OpenConnection();
                using (SqlCommand comSqlDelete = new SqlCommand(sqlDelete, clsDatabase.connection))
                {
                    int check = comSqlDelete.ExecuteNonQuery();
     
                    if (check > 0)
                    {

                        if (int.TryParse(propertyIdCookie.Value, out propertyId))
                        {
                            // Call the method to fetch reservations by property ID
                            GetReservations(propertyId);
                        }
                    }
                    else
                    {
           
                    }
                }
                clsDatabase.CloseConnection();
            }
            catch (Exception)
            {

            }

            if (int.TryParse(propertyIdCookie.Value, out propertyId))
            {
                // Call the method to fetch reservations by property ID
                GetReservations(propertyId);
            }
        }

        protected void frmSinhVien_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //MyReservation.PageIndex = e.NewPageIndex;
            //loadData();
        }

        protected void ReservationGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }



}