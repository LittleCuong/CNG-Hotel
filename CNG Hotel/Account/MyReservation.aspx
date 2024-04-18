<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyReservation.aspx.cs" Inherits="CNG_Hotel.Account.MyReservation"  Async="True"%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div style="height: 300px; background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('../image/background.jpg'); background-position: center; background-size: cover;">
       <div style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center; padding: 20px 0; ">
          <span style="width: 400px; margin: 0; text-align: center; font-size: 45px; color: #fff;">My Reservation</span>
       </div>
    </div>
    <div>
    <div class="container">
       <asp:GridView CssClass="table-class" ID="ReservationGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="R_ID"
                Width="100%"
                Height="400px"
                OnRowDeleting="frmSinhVien_RowDeleting"
                
                PageSize="5"
                AllowPaging="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="ReservationGridView_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EditRowStyle BackColor="#999999"></EditRowStyle>

                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                <HeaderStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <Columns>

                    <asp:BoundField ItemStyle-Width="15%" DataField="R_ID" HeaderText="Reservation ID" HeaderStyle-CssClass="header-column" SortExpression="ReservationID" ReadOnly="True" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle Width="10%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField ItemStyle-Width="30%" DataField="R_Details" HeaderStyle-CssClass="header-column" HeaderText="Reservation Details" SortExpression="ReservationDetails" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle Width="30%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField ItemStyle-Width="20%" DataField="R_Booking_Date" HeaderText="Booking Date" HeaderStyle-CssClass="header-column" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField ItemStyle-Width="20%" DataField="Room_Name" HeaderText="Room Name" HeaderStyle-CssClass="header-column" SortExpression="RoomName" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField ItemStyle-Width="15%" DataField="Date_Checkin" HeaderText="Check In" HeaderStyle-CssClass="header-column" SortExpression="CheckIn" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField ItemStyle-Width="15%" DataField="Date_Checkout" HeaderText="Check Out" HeaderStyle-CssClass="header-column" SortExpression="CheckOut" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                    </asp:BoundField>

                    <asp:TemplateField ItemStyle-Width="20%">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Cancel Reservation" CssClass="default-btn"  CommandName="Delete" CommandArgument="<%#Container.DataItemIndex%>" CausesValidation="False" OnClientClick="return confirm('Do you want to cancel?');" />
                        </ItemTemplate>
       
                        <ItemStyle Width="30%"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>
                <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
            </asp:GridView>

    </div>

    <script>

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

