using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CNG_Hotel
{
    public class clsDatabase
    {
        public static SqlConnection connection;

        public static bool OpenConnection()
        {
            try
            {
                connection = new SqlConnection("Server=CuongNguyen;Database=Hotel;uid=mylogin;pwd=mylogin");
                connection.Open();
                System.Diagnostics.Debug.WriteLine("Connected successfully");
            }
            catch (Exception)
            {
                System.Diagnostics.Debug.WriteLine("Connected failed");
                return false;
            }
            return true;
        }

        public static bool CloseConnection()
        {
            try
            {
                connection.Close();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }
    }
}