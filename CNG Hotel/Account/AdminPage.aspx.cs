using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace CNG_Hotel.Account
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dataBind();
            }
        }


        private DataTable dataBind()
        {
            DataTable dataTable = new DataTable();

            string sql = @"
                SELECT 
                      r.R_ID AS R_ID,
                      u.User_Name AS 'User_name',
                      u.User_Phone AS 'User_phone',
                      r.R_Booking_Date AS 'Booking_date',
                      bd.Date_Checkin AS 'Date_checkin',
                      bd.Date_Checkout AS 'Date_checkout',
                      room.Room_Name AS 'Room_name',
                      case 
	                    WHEN r.R_Status = 1
                                   THEN 'Paid'
                                   ELSE 'Unpaid'
                           END AS 'Status',
                      t.Type_Name AS 'Room_type',
                      (SELECT SUM(p.Room_Type_Price) 
                       FROM Price p
                       WHERE p.Type_ID = t.Type_ID
                         AND p.Effective_Date <= bd.Date_Checkin) * DATEDIFF(DAY, bd.Date_Checkin, bd.Date_Checkout) AS 'Total_price'
                    FROM Reservation r
                    INNER JOIN Users u ON r.User_ID = u.User_ID
                    INNER JOIN Booking_Details bd ON r.R_ID = bd.R_ID
                    INNER JOIN Room room ON bd.Room_ID = room.Room_ID
                    INNER JOIN Type t ON room.Type_ID = t.Type_ID
                    ORDER BY r.R_Status;
            ";
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, clsDatabase.connection);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dataTable);
                reservationsGridView.DataSource = dataTable;
                reservationsGridView.DataBind();
                return dataTable;
            }
            catch (Exception)
            {
            }
            return dataTable;
        }

        protected void reservationsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                if (status == "Paid")
                {
                    e.Row.Enabled = false;
                    e.Row.BackColor = System.Drawing.Color.LightGray;
                }
            }
        }

        protected void reservationsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ConfirmPayment")
            {
                string index = e.CommandArgument.ToString();
                string reservationId = reservationsGridView.DataKeys[int.Parse(index)].Value.ToString();

                try
                {
                    clsDatabase.OpenConnection();
                    string updateQuery = "UPDATE Reservation SET R_Status = '1' WHERE R_ID = @reservationId";
                    SqlCommand updateCommand = new SqlCommand(updateQuery, clsDatabase.connection);
                    updateCommand.Parameters.AddWithValue("@reservationId", reservationId);
                    updateCommand.ExecuteNonQuery();
                    showPopup("Xác nhận đã thanh toán thành công!", "success");

                    dataBind();
                    clsDatabase.CloseConnection();
                }
                catch (SqlException)
                {
                    //result.Text = "Error updating reservation: " + ex.Message;
                }

            }

        }

        protected void showPopup(string message, string type)
        {
            string script = $@"<script type='text/javascript'>
                        alert('{message}');
                      </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchPhone = txtSearchPhone.Text.Trim();

            if (!string.IsNullOrEmpty(searchPhone))
            {
                DataTable filteredData = FilterData(searchPhone);

                reservationsGridView.DataSource = filteredData;
                reservationsGridView.DataBind();
            }
            else
            {
                showPopup("Vui lòng nhập số điện thoại", "error");
                dataBind();
            }
        }

        private DataTable FilterData(string searchPhone)
        {
            DataTable dataTable = dataBind();

            DataView filteredView = new DataView(dataTable);
            filteredView.RowFilter = $"User_phone LIKE '%{searchPhone}%'";

            return filteredView.ToTable();
        }


        protected void reservationsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            reservationsGridView.PageIndex = e.NewPageIndex;
            dataBind();
        }
    }
}