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
            if (!IsPostBack)
            {
                // Fetch data from the database
                DataTable roomData = getRoom();
                DataTable doubleRoomData = getDoubleRoom();
                DataTable suiteRoomData = getSuiteRoom();

                // Bind single room
                singleRoomRepeater.DataSource = roomData;
                singleRoomRepeater.DataBind();

                // Bind double room
                doubleRoomRepeater.DataSource = doubleRoomData;
                doubleRoomRepeater.DataBind();

                // Bind suite room
                suiteRoomRepeater.DataSource = suiteRoomData;
                suiteRoomRepeater.DataBind();
            }
        }

        private DataTable getRoom()
        {

            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'single';", clsDatabase.connection);
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

        private DataTable getDoubleRoom()
        {
            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'double';", clsDatabase.connection);
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

        private DataTable getSuiteRoom()
        {
            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name, T.Type_Size, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'suite';", clsDatabase.connection);
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

        protected void btnOrderRoom_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (User.Identity.IsAuthenticated)
            {
                int roomId = Convert.ToInt32(btn.CommandArgument);
                // If logged in, open a modal to confirm the order
                ClientScript.RegisterStartupScript(this.GetType(), "confirmModal", "<script>openConfirmModal('" + roomId + "');</script>");
            }
            else
            {
                // If not logged in, display an alert to log in
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "<script>alert('Please log in to place an order.');</script>");
            }                
        }


            [WebMethod]
            public static string OrderRoomMethod(int roomId)
            {
                return "Room ordered successfully";
            }
        

    }
}