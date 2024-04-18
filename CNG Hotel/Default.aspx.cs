using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CNG_Hotel
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu trang web được tải lần đầu tiên sẽ thực hiện 
            if (!IsPostBack)
            {
                //  Khai báo các biến chứa dữ liệu thuộc dạng DataTable và thực hiện các method tương ứng
                // để lấy dữ liệu cho phòng đơn, đôi và suite
                DataTable roomData = getRoom();
                DataTable doubleRoomData = getDoubleRoom();
                DataTable suiteRoomData = getSuiteRoom();

                // Gán dữ liệu qua bên HTML //

                // Gán dữ liệu phòng đơn cho phần <asp>Repeater có id là singleRoomRepeater
                singleRoomRepeater.DataSource = roomData;
                singleRoomRepeater.DataBind();

                // Gán dữ liệu phòng đơn cho phần <asp>Repeater có id là doubleRoomRepeater
                doubleRoomRepeater.DataSource = doubleRoomData;
                doubleRoomRepeater.DataBind();

                // Gán dữ liệu phòng đơn cho phần <asp>Repeater có id là suiteRoomRepeater
                suiteRoomRepeater.DataSource = suiteRoomData;
                suiteRoomRepeater.DataBind();
            }
        }

        // Lấy dữ liệu các phòng đơn
        private DataTable getRoom()
        {
            // Tạo biến table với kiểu DataTable
            DataTable table = new DataTable();

            // Sử dụng try - catch để fetch dữ liệu và xử lý các lỗi ngoại lệ
            try
            {
                // tạo kết nối thông qua phương thức OpenConnection của lớp clsDatabase
                clsDatabase.OpenConnection();

                // Tạo lệnh truy vấn qua SqlCommand
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, R.Room_Image_Path, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'single';", clsDatabase.connection);

                // Thực thi truy vấn
                SqlDataAdapter adapter = new SqlDataAdapter(command);

                // Đóng kết nối database
                clsDatabase.CloseConnection();

                // Gán dữ liệu đã thực thi vào biến table ở trên
                adapter.Fill(table);
            }
            catch (Exception)
            {
                // Nếu có lỗi thì hiển thị lỗi trong console của Visual Code
                System.Diagnostics.Debug.WriteLine("Get data failed");
            }
            
            // Trả kết quả là biến table đã được đổ dữ liệu
            return table;
        }


        // Tương tự
        private DataTable getDoubleRoom()
        {
            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, R.Room_Image_Path, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'double';", clsDatabase.connection);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                clsDatabase.CloseConnection();
                adapter.Fill(table);
            }
            catch (Exception)
            {
                System.Diagnostics.Debug.WriteLine("Get data failed");
            }
            return table;
        }

        // Tương tự
        private DataTable getSuiteRoom()
        {
            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, R.Room_Image_Path, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'suite';", clsDatabase.connection);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                clsDatabase.CloseConnection();
                adapter.Fill(table);
            }
            catch (Exception)
            {
                System.Diagnostics.Debug.WriteLine("Get data failed");
            }
            return table;
        }
    }
}