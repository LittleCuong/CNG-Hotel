<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNG_Hotel._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <div class="image-container" style="height: 300px;">
        <img src="../image/new_background.jpg" style="object-fit: cover; width: 100%; height: 100%;"/>
        <h3 class="image-container--header">Welcome to CNG Hotel</h3>
    </div>
    <div class="container body-content">
        <div class="row" style="margin-top: 4px;">
        <div class="col-md-4 room-container">
            <div class="room-image--contain">
                <img src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
            </div>
            <div class="room-name--section">
                <div style="display: flex; flex-direction: column;">
                    <span id="roomName" runat="server" class="room-name"></span>
                    <span style="font-size: 12px;">Phòng đôi</span>
                </div>
                <button class="btn-custom room-order--btn">Đặt ngay</button>
            </div>
        </div>
        <div class="col-md-4 room-container">
            <div class="room-image--contain">
                <img src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
            </div>
            <div class="room-name--section">
                <div style="display: flex; flex-direction: column;">
                    <span class="room-name">The Chairman's Suite</span>
                    <span style="font-size: 12px;">Phòng đôi</span>
                </div>
                <button class="btn-custom room-order--btn">Đặt ngay</button>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
