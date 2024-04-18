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
            // Thực thi khi trang được chạy lần đầu
            if (!IsPostBack)
            {
                // Nếu id của phòng có thì sẽ thực thi - QueryString["roomId"] là nó lấy cái id của phòng từ cái địa chỉ trên web
                if (Request.QueryString["roomId"] != null)
                {
                    // Chuyển id phòng sang dạng int
                    int roomId = Convert.ToInt32(Request.QueryString["roomId"]);

                    // tạo biến roomData với kiểu là DataTable để truy vấn và đổ dữ liệu vào
                    DataTable roomData = GetRoom(roomId);

                    // Gán dữ liệu từ roomData vào Repeater bên HTML có id là roomRepeater
                    roomRepeater.DataSource = roomData;
                    roomRepeater.DataBind();

                }
                else
                {
                    // Handle the case where roomId is not provided in the URL
                }
            }
        }


        // Phương thức lấy thông tin của phòng
        private DataTable GetRoom(int roomId)
        {
            DataTable table = new DataTable();
            try
            {
                // Tạo kết nối
                clsDatabase.OpenConnection();

                // Tạo câu truy vấn 
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, R.Room_Image_Path, T.Type_Name, T.Type_Size, T.Type_Details, P.Room_Type_Price from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID INNER JOIN Price P on R.Type_ID = P.Type_ID where R.Room_ID = @RoomID;", clsDatabase.connection);

                // Tạo và gán dữ liệu cho tham số tên là @RoomID có dữ liệu là id của phòng cho câu truy vấn phía trên
                command.Parameters.AddWithValue("@RoomID", roomId);

                // Thực hiện truy vấn
                SqlDataAdapter adapter = new SqlDataAdapter(command);

                // Đóng kết nối
                clsDatabase.CloseConnection();

                // Đổ dữ liệu vào biến table được tạo ở đầu phương thức
                adapter.Fill(table);
            }
            catch (Exception)
            {
                // Nếu có lỗi thì tạo 1 script để thực thi code JavaScript thông báo lỗi lên màn hình
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Error occurs')</script>");
            }

            // Trả về table đã có dữ liệu
            return table;
        }


        // Đây là WebMethod - Là các phương thức/method có thể được gọi bên trình duyệt thông qua sử dụng AJAX
        // Method đặt phòng nhận tham số userID, roomID, detail, bookingDate, checkIn và checkOut để insert vào database
        [WebMethod]
        public static String HandlePlaceRoom(int userID, int roomId, string detail, string bookingDate, string checkIn, string checkOut)
        {
            try
            {
                // Kiểm tra xem có bị trùng ngày check in và checkout không nếu không thì thực hiện đoạn code ở trong
                if (CheckReservation(roomId, checkIn, checkOut) == "You can book")
                {
                    // Tạo kết nối
                    clsDatabase.OpenConnection();

                    // Tạo câu truy vấn insert vào bảng Reservation và lấy ra reservation id được tạo
                    string queryInsertReserve = "INSERT INTO Reservation (R_Details, R_Status, R_Booking_Date, User_ID) VALUES(@Detail, 0, @CheckIn, @UserID); SELECT SCOPE_IDENTITY();";

                    // Tạo câu lệnh truy vấn và truyền biến phía trên vào thay vì ghi trực tiếp SQL vào
                    SqlCommand insertReservationCommand = new SqlCommand(queryInsertReserve, clsDatabase.connection);

                    // Tạo các tham số và gán dữ liệu
                    insertReservationCommand.Parameters.AddWithValue("@Detail", detail);
                    insertReservationCommand.Parameters.AddWithValue("@CheckIn", checkIn);
                    insertReservationCommand.Parameters.AddWithValue("@UserID", userID);

                    // Thực hiện truy vấn và trả về giá trị cột đầu tiên của kết quả và chuyển sang dạng int
                    int reservationId = Convert.ToInt32(insertReservationCommand.ExecuteScalar());

                    // Tạo câu truy vấn insert vào bảng Booking_Details
                    string queryInsertBookingDetail = "INSERT INTO Booking_Details (Date_Checkin, Date_Checkout, R_ID, Room_ID) VALUES (@CheckIn, @CheckOut, @ReservationID, @RoomID);";

                    // Tạo lệnh truy vấn và truyền câu truy vấn vào
                    SqlCommand insertBookingDetailCommand = new SqlCommand(queryInsertBookingDetail, clsDatabase.connection);

                    // Tạo và gán tham số
                    insertBookingDetailCommand.Parameters.AddWithValue("@CheckIn", checkIn);
                    insertBookingDetailCommand.Parameters.AddWithValue("@CheckOut", checkOut);
                    insertBookingDetailCommand.Parameters.AddWithValue("@ReservationID", reservationId);
                    insertBookingDetailCommand.Parameters.AddWithValue("@RoomID", roomId);

                    // Thực hiện truy vấn mà không trả về giá trị
                    insertBookingDetailCommand.ExecuteNonQuery();

                    // Trả về string success
                    return "Success";
                }
                else
                {
                    // Nếu không đặt được thì trả về "Room has been booked"
                    return "Room has been booked";
                }
            }
            catch (Exception)
            {
                // Trả về lỗi
                return "Error";
            }
        }

        // Kiểm tra phòng có đặt được hay không
        [WebMethod]
        public static String CheckReservation(int roomId, string checkIn, string checkOut)
        {
            try
            {
                clsDatabase.OpenConnection();

                // Tạo lệnh truy vấn kiểm tra check in và check out có bị trùng với những đơn khác không
                string query = "SELECT COUNT(*) AS bookings_count FROM Booking_Details WHERE Room_ID = @RoomID AND (@CheckIn BETWEEN Date_Checkin AND Date_Checkout OR @CheckOut BETWEEN Date_Checkin AND Date_Checkout OR Date_Checkin BETWEEN @CheckIn AND @CheckOut);";
                SqlCommand command = new SqlCommand(query, clsDatabase.connection);
                command.Parameters.AddWithValue("@RoomID", roomId);
                command.Parameters.AddWithValue("@CheckIn", checkIn);
                command.Parameters.AddWithValue("@CheckOut", checkOut);

                // Trả về cột đầu tiên của kết quả
                int bookingsCount = (int)command.ExecuteScalar();
                clsDatabase.CloseConnection();
        
                // Nếu kết quả lớn hơn 0 nghĩa là có 1 hoặc nhiều đơn trùng ngày check in hoặc check out
                if (bookingsCount > 0)
                {
                    // Trả về thông báo phòng đã được đặt
                    return "Have been booked";
                }
                else
                {
                    // Trả về có thể đặt
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