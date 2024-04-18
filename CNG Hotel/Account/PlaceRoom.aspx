<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlaceRoom.aspx.cs" Inherits="CNG_Hotel.Account.PlaceRoom" Async="True" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:Repeater ID="roomRepeater" runat="server">
       <ItemTemplate>
        <div style="height: 550px; background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('../image<%# Eval("Room_Image_Path") %>'); background-position: center; background-size: cover;">
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
                       </div>
                   </div>
               </div>
           </div>
        </div>
       </ItemTemplate>
    </asp:Repeater>  
    <script>
        
          // Lấy ra các HTMl tag có id tương ứng
          var checkIn = document.getElementById("checkin")
          var checkOut = document.getElementById("checkout")
          var days = document.getElementById("days")
          var cost = document.getElementById("cost")

          var roomTypePriceLabel = document.getElementById("roomTypePriceLabel");
          
          // Tạo ngày hiện tại
          var today = new Date();

          // Dòng này lấy ngày hiện tại từ đối tượng Date (today.getDate()) và chuyển đổi nó thành chuỗi 
          // (String()). .padStart(2, '0') đảm bảo rằng chuỗi có ít nhất 2 ký tự, 
          // nếu không, thêm ký tự '0' vào phía trước để đảm bảo độ dài là 2 ký tự.
          var dd = String(today.getDate()).padStart(2, '0');

          // Dòng này tương tự nhưng sẽ lấy tháng. Vì getMonth() lấy index là từ 0 tới 11 nên + thêm 1
          var mm = String(today.getMonth() + 1).padStart(2, '0');

          // Lấy năm từ cái biến today
          var yyyy = today.getFullYear();

          // Ghép lại thành 1 chuỗi là ngày hiện tại
          var currentDate = yyyy + '-' + mm + '-' + dd;
      
          // Ngày check out mặt định sẽ là ngày tiếp theo của check in nên today.getDate() + 1. 
          var defaultCheckoutDate = String(today.getDate() + 1).padStart(2, '0');

          // Set ngày check in mặc định là hôm nay
          checkIn.value = currentDate;
          // ngày check in tối thiểu là ngày hôm nay không thể là quá khứ nên set min value là hiện tại
          checkIn.min = currentDate;

          // Ngày check out là ngày hiện tại + 1 => gán biến defaultCheckoutDate ở trên vào
          checkOut.value = yyyy + '-' + mm + '-' + defaultCheckoutDate;
          // Khoảng cách từ check in tới check out ban đầu là 1 ngày
          days.value = 1
        
          // Giá phòng ban đầu là 1 => lấy html có id là cost và gán giá trị là giá phòng nhân 1
          cost.textContent = '$' + document.getElementById("roomTypePriceLabel").textContent * 1

          // Nếu ngày check in thay đổi thì sẽ chạy đoạn này
          checkIn.addEventListener("change", function () {
              var checkinDate = new Date(this.value);

              checkinDate.setDate(checkinDate.getDate() + 1); // Add one day

              var checkin_dd = String(checkinDate.getDate()).padStart(2, '0');
              var checkin_mm = String(checkinDate.getMonth() + 1).padStart(2, '0');
              var checkin_yyyy = checkinDate.getFullYear();

              // Ngày check out tối thiểu là ngày check in + 1 nên tạo chuỗi này
              var minCheckoutDate = checkin_yyyy + '-' + checkin_mm + '-' + checkin_dd;

              // gán giá trị tối thiểu cho check out là biến ở trên
              checkOut.min = minCheckoutDate;
       
              // Nếu mà người dùng cố tính chọn ngày check out nhỏ hơn check out min thì set 2 cái = nhau => check in check out cách 1 ngày
              // giá phòng sẽ nhân 1
              if (checkOut.value < minCheckoutDate) {
                  checkOut.value = minCheckoutDate;
                  days.value = 1;
                  cost.innerHTML = '$' + roomTypePriceLabel.textContent * 1
              } else {
                  // Nếu không thì sẽ tạo biến checkinDate với giá trị là ngày được chọn
                  var checkinDate = new Date(checkIn.value);
                  var checkoutDate = new Date(checkOut.value);

                  // Lấy thời gian 2 ngày in out trừ nhau ra được khoảng cách = mili giây
                  var differenceInTime = checkoutDate.getTime() - checkinDate.getTime();

                  // chia sự khác biệt thời gian tính bằng mili giây cho số mili giây trong một ngày, tức là 1000 mili giây * 3600 giây * 24 giờ
                  var differenceInDays = differenceInTime / (1000 * 3600 * 24);

                  // Set giá trị cho số ngày = biến differenceInDays
                  days.value = differenceInDays;
                  
                  // Giá phòng = giá ban đầu * số ngày
                  cost.innerHTML = '$' + roomTypePriceLabel.textContent * differenceInDays
                }

           });


          // Nếu người dùng chọn ngày check out sẽ chạy đoạn này
          checkOut.addEventListener("change", function () {
              var checkinDate = new Date(checkIn.value);
              var checkoutDate = new Date(checkOut.value);
        
              var differenceInTime = checkoutDate.getTime() - checkinDate.getTime();
        
              var differenceInDays = differenceInTime / (1000 * 3600 * 24);

              days.value = differenceInDays;
              cost.innerHTML ='$'+ roomTypePriceLabel.textContent * differenceInDays
          });

    
          //    Hàm kiểm tra có đặt được hay không bằng cách gửi 1 http request với dạng POST
          //    về Server. Ở đây là gửi về hàm CheckReservation thuộc lớp PlaceRoom
          //    data gửi với dạng JSON
          function handleCheckReservation(id) {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("PlaceRoom.aspx/CheckReservation") %>',
                // gửi room id, check in, check out qua server
                data: JSON.stringify({roomId: id, checkIn: checkIn.value, checkOut: checkOut.value }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Nếu server phản hồi Have been booked thì thông báo đã được đặt
                    if (response.d === "Have been booked") {
                        alert("Room not available. Please choose a new check in and check out day")
                    // Không thì hiển thị có thể đặt
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


          // Hàm đặt phòng
          function handleOrderRoom(id) {
              
              var checkinDate = new Date(checkIn.value);
              var checkoutDate = new Date(checkOut.value);
        
              var differenceInTime = checkoutDate.getTime() - checkinDate.getTime();
        
              var differenceInDays = differenceInTime / (1000 * 3600 * 24);

              // Lấy giá trị của một cookie có tên là "id" trong trình duyệt
              // gán vào biến name
              let name = "id" + "=";

              // lấy tất cả cookie => giải mã => gán vào decodedCookie
              let decodedCookie = decodeURIComponent(document.cookie);

              // chia chuỗi decodedCookie thành một mảng các chuỗi con bằng cách tách chúng bằng dấu chấm phẩy (;). Mỗi phần tử trong mảng này sẽ là một chuỗi đại diện cho một cookie.
              let ca = decodedCookie.split(';');
               
              // Mặc định cho user id = 0
              let userID = 0;

              // Lặp qua chuỗi cookie
              for(let i = 0; i <ca.length; i++) {
                // Gán phần tử thứ i của mảng ca vào biến c
                let c = ca[i];
                // Bỏ khoảng trắng
                while (c.charAt(0) == ' ') {
                  c = c.substring(1);
                }

                // kiểm tra cookie
                if (c.indexOf(name) == 0) {
                    // nếu có thì gán vào biến userID
                    userID = c.substring(name.length, c.length)

                    detail = document.getElementById("detail")
                    // Gọi AJAX truyền dữ liệu qua phương thức HandlePlaceRoom để đặt phòng
                    $.ajax({
                            type: "POST",
                            url: '<%= ResolveUrl("PlaceRoom.aspx/HandlePlaceRoom") %>',
                            data: JSON.stringify({ userID: userID, roomId: id, detail: detail.value, bookingDate: currentDate, checkIn: checkIn.value, checkOut: checkOut.value, total: roomTypePriceLabel.textContent * differenceInDays}),
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
                } else {
                    // Không có thì nghĩa là chưa đăng nhập nên thông báo yêu cầu đăng nhập
                    alert("You must sign in first!")
                }
              }
           }
    </script>
</asp:Content>
