using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CNG_Hotel.Account
{
    public partial class PlaceRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["roomId"] != null)
                {
                    int roomId = Convert.ToInt32(Request.QueryString["roomId"]);
                    DataTable roomData = GetRoom(roomId);
                    roomRepeater.DataSource = roomData;
                    roomRepeater.DataBind();

                }
                else
                {
                    // Handle the case where roomId is not provided in the URL
                }
            }
        }

        private DataTable GetRoom(int roomId)
        {
            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name, T.Type_Size, T.Type_Details, P.Room_Type_Price from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID INNER JOIN Price P on R.Type_ID = P.Type_ID where R.Room_ID = @RoomID;", clsDatabase.connection);
                command.Parameters.AddWithValue("@RoomID", roomId);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                clsDatabase.CloseConnection();
                adapter.Fill(table);
            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Error occurs')</script>");
            }
            return table;
        }

        [WebMethod]
        public static String HandlePlaceRoom(int userID, int roomId, string detail, string bookingDate, string checkIn, string checkOut)
        {
            try
            {
                if (CheckReservation(roomId, checkIn, checkOut) == "You can book")
                {
                    clsDatabase.OpenConnection();

                    string queryInsertReserve = "INSERT INTO Reservation (R_Details, R_Status, R_Booking_Date, User_ID) VALUES(@Detail, 0, @CheckIn, @UserID); SELECT SCOPE_IDENTITY();";
                    SqlCommand insertReservationCommand = new SqlCommand(queryInsertReserve, clsDatabase.connection);
                    insertReservationCommand.Parameters.AddWithValue("@Detail", detail);
                    insertReservationCommand.Parameters.AddWithValue("@CheckIn", checkIn);
                    insertReservationCommand.Parameters.AddWithValue("@UserID", userID);
                    int reservationId = Convert.ToInt32(insertReservationCommand.ExecuteScalar());

                    string queryInsertBookingDetail = "INSERT INTO Booking_Details (Date_Checkin, Date_Checkout, R_ID, Room_ID) VALUES (@CheckIn, @CheckOut, @ReservationID, @RoomID);";
                    SqlCommand insertBookingDetailCommand = new SqlCommand(queryInsertBookingDetail, clsDatabase.connection);
                    insertBookingDetailCommand.Parameters.AddWithValue("@CheckIn", checkIn);
                    insertBookingDetailCommand.Parameters.AddWithValue("@CheckOut", checkOut);
                    insertBookingDetailCommand.Parameters.AddWithValue("@ReservationID", reservationId);
                    insertBookingDetailCommand.Parameters.AddWithValue("@RoomID", roomId);
                    insertBookingDetailCommand.ExecuteNonQuery();

                    return "Success";
                }
                else
                {
                    return "Room has been booked";
                }
            }
            catch (Exception)
            {
                return "Error";
            }
        }

        [WebMethod]
        public static String CheckReservation(int roomId, string checkIn, string checkOut)
        {
            try
            {
                clsDatabase.OpenConnection();
                string query = "SELECT COUNT(*) AS bookings_count FROM Booking_Details WHERE Room_ID = @RoomID AND (@CheckIn BETWEEN Date_Checkin AND Date_Checkout OR @CheckOut BETWEEN Date_Checkin AND Date_Checkout OR Date_Checkin BETWEEN @CheckIn AND @CheckOut);";
                SqlCommand command = new SqlCommand(query, clsDatabase.connection);
                command.Parameters.AddWithValue("@RoomID", roomId);
                command.Parameters.AddWithValue("@CheckIn", checkIn);
                command.Parameters.AddWithValue("@CheckOut", checkOut);
                int bookingsCount = (int)command.ExecuteScalar();
                clsDatabase.CloseConnection();
        
                if (bookingsCount > 0)
                {
                    return "Have been booked";
                }
                else
                {
                    return "You can book";
                }
            }
            catch (Exception)
            {
                return "error";
            }
        }
    }
}