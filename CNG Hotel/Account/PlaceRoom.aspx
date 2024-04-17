<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlaceRoom.aspx.cs" Inherits="CNG_Hotel.Account.PlaceRoom" Async="True" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:Repeater ID="roomRepeater" runat="server">
       <ItemTemplate>
        <div style="height: 350px; background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../image/beach_background.jpg); background-position: bottom;">
            <div style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center; padding: 20px 0; ">
                <span style="width: 400px; margin: 0; text-align: center; font-size: 45px; color: #fff;"></span>
            </div>
        </div>
        <div class="container" style="height: 600px;">
           <div class="row" style="padding-top: 30px; height: 100%">
               <div class="col-md-8" style="height: 100%; display: flex; flex-direction: column">
                   <h3 style="font-size: 24px;"><asp:Label Font-Size="XX-Large" Text='<%# Eval("Room_Name")%>' runat="server" /></h3>
                   <span id="roomType" style="font-size: 12px;">
                       <i style="margin: 0 2px 0 0px;" class="fa-solid fa-bed"></i>
                       <asp:Label Text='<%# Eval("Type_Name")%>' runat="server" />
                       <i style="margin: 0 2px 0 20px;" class="fa-solid fa-users"></i>
                       <asp:Label Text='<%# Eval("Type_Size")%>' runat="server" />
                       <i style="margin: 0 2px 0 20px;" class="fa-solid fa-couch"></i>
                       <asp:Label Text='<%# Eval("Type_Details")%>' runat="server" />
                   </span>
                   <div style="margin-top: 20px">
                       <span style="font-size: 20px;">
                           Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
                       </span>
                       <span style="display: block; margin-top: 20px; font-size: 20px;">
                           Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. 
                       </span>
                   </div>
               </div>
               <div class="col-md-4" style="display: flex; flex-direction: column; height: 100%; padding: 30px 25px; box-shadow: 0 5px 30px rgba(80, 57, 24, 0.15); border-radius: 8px;">
                   <div style="display: flex; justify-content: space-between; align-items: center;">
                    <h3>RESERVE: </h3>
                    <span style="width: 100%; display: block; padding-top: 20px; font-size: 16px; text-align: end">From <p style="display: inline-block; margin: 0;">$<asp:Label ID="roomTypePriceLabel" ClientIDMode="Static" Font-Bold="true" Text='<%#Eval("Room_Type_Price")%>' runat="server" /></p>/night</span>  
                   </div>
                   <div class="">
                       <div class="reservation-input--container">
                            <label style="font-size: 18px; font-weight: lighter" for="checkin">Check In</label>
                            <input class="reservation-input date-input" type="date" id="checkin" name="checkin">
                       </div>
                       <div class="reservation-input--container">
                            <label style="font-size: 18px; font-weight: lighter" for="checkin">Check Out</label>
                            <input class="reservation-input date-input" type="date" id="checkout" name="checkout">
                       </div>
                       <div class="reservation-input--container">
                            <label style="font-size: 18px; font-weight: lighter" for="detail">Trips for</label>
                            <input class="reservation-input date-input" style="width: 124px; text-align: center;" type="text" id="detail" name="detal" value="Vacation">
                       </div>
                       <div class="reservation-input--container">
                            <label style="font-size: 18px; font-weight: lighter" for="checkin">Days</label>
                            <input class="reservation-input days-input" disabled type="number" id="days" name="days">
                       </div>
                       <div class="cost-container">                          
                            <h3 style="margin: 10px 0 0 0;">TOTAL COST: </h3>
                            <span id="cost" style="margin-top: 10px; font-weight: 600; font-size: 20px;"></span>
                       </div>
                       <div style="display: flex; flex-direction: column; margin-top: 10px">
                           <div class="default-btn check-reserve--btn" style="position: relative; display: flex; justify-content: center; text-align: center;" >
                                <input onClick='<%#"handleCheckReservation(" + Eval("Room_ID") + ")"%>' type="button" style="position: absolute; left: 0; width: 100%; height: 100%; background-color: transparent; border: none; outline: none;" value="Check Reservation"/>
                           </div>
                           <div class="default-btn" style="position: relative; display: flex; justify-content: center; text-align: center;" >
                                <input onClick='<%#"handleOrderRoom(" + Eval("Room_ID") + ")"%>' type="button" style="position: absolute; left: 0; width: 100%; height: 100%; background-color: transparent; border: none; outline: none; color: #fff;" value="Book Your Stay Now"/>
                           </div>
                           <%--<asp:Button runat="server" CssClass="default-btn" Text="Book Your Stay Now" OnClientClick='<%# "handleOrderRoom(" + Eval("Room_ID") + "); return false;" %>' CommandArgument='<%# Eval("Room_ID")%>' />--%>
                       </div>
                   </div>
               </div>
           </div>
        </div>
       </ItemTemplate>
    </asp:Repeater>  
    <script>
        
          var checkIn = document.getElementById("checkin")
          var checkOut = document.getElementById("checkout")
          var days = document.getElementById("days")
          var cost = document.getElementById("cost")

          var roomTypePriceLabel = document.getElementById("roomTypePriceLabel");


          var today = new Date();

          var dd = String(today.getDate()).padStart(2, '0');
          var mm = String(today.getMonth() + 1).padStart(2, '0');
          var yyyy = today.getFullYear();

          var currentDate = yyyy + '-' + mm + '-' + dd;
      
          var defaultCheckoutDate = String(today.getDate() + 1).padStart(2, '0');

          // Set the value of the input element
          checkIn.value = currentDate;
          checkIn.min = currentDate;

          checkOut.value = yyyy + '-' + mm + '-' + defaultCheckoutDate;
          days.value = 1
        

          cost.textContent = '$' + document.getElementById("roomTypePriceLabel").textContent * 1

          checkIn.addEventListener("change", function () {
              var checkinDate = new Date(this.value);
              checkinDate.setDate(checkinDate.getDate() + 1); // Add one day

              var checkin_dd = String(checkinDate.getDate()).padStart(2, '0');
              var checkin_mm = String(checkinDate.getMonth() + 1).padStart(2, '0');
              var checkin_yyyy = checkinDate.getFullYear();

              var minCheckoutDate = checkin_yyyy + '-' + checkin_mm + '-' + checkin_dd;

              checkOut.min = minCheckoutDate;
       
              if (checkOut.value < minCheckoutDate) {
                  checkOut.value = minCheckoutDate;
                  days.value = 1;
                  cost.innerHTML = '$' + roomTypePriceLabel.textContent * 1
              } else {
                  var checkinDate = new Date(checkIn.value);
                  var checkoutDate = new Date(checkOut.value);

                  var differenceInTime = checkoutDate.getTime() - checkinDate.getTime();

                  var differenceInDays = differenceInTime / (1000 * 3600 * 24);

                  days.value = differenceInDays;
                  cost.innerHTML = '$' + roomTypePriceLabel.textContent * differenceInDays
                }

           });

          checkOut.addEventListener("change", function () {
              var checkinDate = new Date(checkIn.value);
              var checkoutDate = new Date(checkOut.value);
        
              var differenceInTime = checkoutDate.getTime() - checkinDate.getTime();
        
              var differenceInDays = differenceInTime / (1000 * 3600 * 24);

              days.value = differenceInDays;
              cost.innerHTML ='$'+ roomTypePriceLabel.textContent * differenceInDays
          });

          function handleCheckReservation(id) {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("PlaceRoom.aspx/CheckReservation") %>',
                data: JSON.stringify({roomId: id, checkIn: checkIn.value, checkOut: checkOut.value }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d === "Have been booked") {
                        alert("Room not available. Please choose a new check in and check out day")
                    } else if (response.d === "You can book") {
                        alert("You can book now!");
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error occurs!")
                    console.error("Error ordering room: " + error);
                }
            })
          }
       
          function handleOrderRoom(id) {
              let name = "id" + "=";
              let decodedCookie = decodeURIComponent(document.cookie);
              let ca = decodedCookie.split(';');
    
              let userID = 0;

              for(let i = 0; i <ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') {
                  c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    userID = c.substring(name.length, c.length)
                }
              }

              detail = document.getElementById("detail")

              $.ajax({
                    type: "POST",
                    url: '<%= ResolveUrl("PlaceRoom.aspx/HandlePlaceRoom") %>',
                    data: JSON.stringify({ userID: userID, roomId: id, detail: detail.value, bookingDate: currentDate, checkIn: checkIn.value, checkOut: checkOut.value }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d === "Success") {
                            alert("Place room successfully")
                        } else if (response.d === "Room has been booked") {
                            alert("Room not available. Please choose a new check in and check out day")
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error ordering room: " + error);
                    }
                });
           }

        function getCookie(cname) {
          
         }

        

    </script>
</asp:Content>
