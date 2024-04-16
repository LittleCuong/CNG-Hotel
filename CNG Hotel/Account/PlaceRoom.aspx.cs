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
    }
}