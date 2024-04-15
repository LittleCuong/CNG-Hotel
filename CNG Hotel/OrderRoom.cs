using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace CNG_Hotel
{
    public partial class OrderRoom : System.Web.UI.Page
    {
        [WebMethod]
        public static string OrderRoomMethod(int roomId)
        {
            // Perform order processing logic here
            // You can access the roomId parameter to determine which room was ordered
            // For example, you can update a database or perform any other necessary actions

            return "Room ordered successfully"; // Return a success message
        }
    }
}