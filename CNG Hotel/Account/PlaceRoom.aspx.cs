using System;
using System.Collections.Generic;
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
                    // Now you have the roomId, you can use it to fetch data
                  
                }
                else
                {
                    // Handle the case where roomId is not provided in the URL
                }
            }
        }
    }
}