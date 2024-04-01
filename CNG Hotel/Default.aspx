<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNG_Hotel._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="row" style="margin-top: 4px;">
        <div class="col-md-4 room-container">
            <div class="room-image--contain">
                <img src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
            </div>
            <div class="room-name--section">
                <span class="room-name">Phòng The Chairman's Suite</span>
                <button class="btn btn-default room-order--btn">Đặt ngay</button>
            </div>
        </div>
        <div class="col-md-4 room-container">
            <div class="room-image--contain">
                <img src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
            </div>
            <div class="room-name--section">
                <span class="room-name">Phòng The Chairman's Suite</span>
                <button class="btn btn-default room-order--btn">Đặt ngay</button>
            </div>
        </div>
         <div class="col-md-4 room-container">
            <div class="room-image--contain">
                <img src="image/doubleroom.jpg" class="room-image" alt="Double room"/>
            </div>
            <div class="room-name--section">
                <span class="room-name">Phòng The Chairman's Suite</span>
                <button class="btn btn-default room-order--btn">Đặt ngay</button>
            </div>
        </div>
    </div>

</asp:Content>
