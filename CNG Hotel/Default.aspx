<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNG_Hotel._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--<div class="image-container" style="height: 400px; background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../image/beach_background.jpg); background-position: center;">--%>
        <%--<img src="../image/beach_background.jpg" style="object-fit: cover; width: 100%; height: 100%; object-position: center; "/>--%>
        <%--<h3 class="image-container--header">Welcome to CNG Hotel</h3>--%>
    <%--</div>--%>
    <div class="container body-content">
        <h3 class="room-name--header">Phòng đơn</h3>
        <div class="row" style="margin-top: 4px;">
            <asp:Repeater ID="singleRoomRepeater" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 custom-container">
                        <div class="room-container">
                            <div class="room-image--contain">
                                <img id="roomImage" src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
                            </div>
                            <div class="room-name--section">
                                <div style="display: flex; flex-direction: column;">
                                    <span id="roomName" runat="server" class="room-name">
                                        <asp:Label Text='<%# Eval("Room_Name") %>' runat="server" />
                                    </span>
                                    <span id="roomType" style="font-size: 12px;">
                                        <i style="margin: 0 2px 0 0px;" class="fa-solid fa-bed"></i>
                                        <asp:Label Text='<%# Eval("Type_Name")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-users"></i>
                                        <asp:Label Text='<%# Eval("Type_Size")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-couch"></i>
                                        <asp:Label Text='<%# Eval("Type_Details")%>' runat="server" />
                                    </span>
                                </div>
                                <button class="room-order--btn">Đặt ngay</button>
                            </div>
                        </div>
                    </div>               
                </ItemTemplate>
            </asp:Repeater>          
        </div>
        <h3 class="room-name--header">Phòng đôi</h3>
        <div class="row" style="margin-top: 4px;">
            <asp:Repeater ID="doubleRoomRepeater" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 custom-container">
                        <div class="room-container">
                            <div class="room-image--contain">
                                <img id="roomImage" src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
                            </div>
                            <div class="room-name--section">
                                  <div style="display: flex; flex-direction: column;">
                                    <span id="roomName" runat="server" class="room-name">
                                        <asp:Label Text='<%# Eval("Room_Name") %>' runat="server" />
                                    </span>
                                    <span id="roomType" style="font-size: 12px;">
                                        <i style="margin: 0 2px 0 0px;" class="fa-solid fa-bed"></i>
                                        <asp:Label Text='<%# Eval("Type_Name")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-users"></i>
                                        <asp:Label Text='<%# Eval("Type_Size")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-couch"></i>
                                        <asp:Label Text='<%# Eval("Type_Details")%>' runat="server" />
                                    </span>
                                </div>
                                <button class="room-order--btn">Đặt ngay</button>
                            </div>
                        </div>
                    </div>               
                </ItemTemplate>
            </asp:Repeater>          
        </div>
        <h3 class="room-name--header">Phòng hạng sang</h3>
        <div class="row" style="margin-top: 4px;">
            <asp:Repeater ID="suiteRoomRepeater" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 custom-container">
                        <div class="room-container">
                            <div class="room-image--contain">
                                <img id="roomImage" src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
                            </div>
                            <div class="room-name--section">
                                  <div style="display: flex; flex-direction: column;">
                                    <span id="roomName" runat="server" class="room-name">
                                        <asp:Label Text='<%# Eval("Room_Name") %>' runat="server" />
                                    </span>
                                    <span id="roomType" style="font-size: 12px;">
                                        <i style="margin: 0 2px 0 0px;" class="fa-solid fa-bed"></i>
                                        <asp:Label Text='<%# Eval("Type_Name")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-users"></i>
                                        <asp:Label Text='<%# Eval("Type_Size")%>' runat="server" />
                                        <i style="margin: 0 2px 0 20px;" class="fa-solid fa-couch"></i>
                                        <asp:Label Text='<%# Eval("Type_Details")%>' runat="server" />
                                    </span>
                                </div>
                                <button class="room-order--btn">Book now</button>
                            </div>
                        </div>
                    </div>               
                </ItemTemplate>
            </asp:Repeater>          
        </div>
    </div>
</asp:Content>
