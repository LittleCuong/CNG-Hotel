using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
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
        private void test()
        {
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select * from Room;", clsDatabase.connection);
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    // Loop through the data
                    while (reader.Read())
                    {
                        // Retrieve values from the reader
                        System.Diagnostics.Debug.WriteLine("Room: " + reader["Room_Name"]);
                    }
                }
            }
            catch (Exception)
            {
                System.Diagnostics.Debug.WriteLine("Get data failed");
            }
        }

        private DataTable getRoom()
        {

            DataTable table = new DataTable();
            try
            {
                clsDatabase.OpenConnection();
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name, T.Type_Details from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'single';", clsDatabase.connection);
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
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'double';", clsDatabase.connection);
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
                SqlCommand command = new SqlCommand("select R.Room_ID, R.Room_Name, R.Room_Status, T.Type_Name from Room R INNER JOIN Type T ON R.Type_ID = T.Type_ID where T.Type_Name = 'suite';", clsDatabase.connection);
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