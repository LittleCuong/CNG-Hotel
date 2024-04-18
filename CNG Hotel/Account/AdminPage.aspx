<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="CNG_Hotel.Account.AdminPage" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
   <div>
            <h1 style="display: flex; justify-content: center; align-content: center; width: 100%;">Danh Sách Đặt Phòng</h1>
            <div style="padding: 0 0 15px 25px;">
                <asp:TextBox ID="txtSearchPhone" runat="server" Width="150px" placeHolder="Nhập số điện thoại"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Tìm Kiếm" OnClick="btnSearch_Click" />
            </div>
            <br />
            <asp:GridView ID="reservationsGridView" runat="server" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Vertical" AllowSorting="True" Width="100%"
                PageSize="5" AllowPaging="true"
                OnPageIndexChanging="reservationsGridView_PageIndexChanging"
                OnRowDataBound="reservationsGridView_RowDataBound"
                OnRowCommand="reservationsGridView_RowCommand" DataKeyNames="R_ID">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Booking_date" HeaderText="Ngày tạo đơn" />
                    <asp:BoundField DataField="User_name" HeaderText="Tên khách hàng" />
                    <asp:BoundField DataField="User_phone" HeaderText="Số điện thoại" />
                    <asp:BoundField DataField="Date_checkin" HeaderText="Ngày nhận phòng" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Date_checkout" HeaderText="Ngày trả phòng" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Room_name" HeaderText="Phòng" />
                    <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
                    <asp:BoundField DataField="Room_type" HeaderText="Loại phòng" />
                    <asp:BoundField DataField="Total_price" HeaderText="Tổng tiền" DataFormatString="{0:.000 VND}" />
                    <asp:TemplateField HeaderText="Xác Nhận">
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" Text="Xác Nhận Thanh Toán" CommandName="ConfirmPayment" CommandArgument="<%#Container.DataItemIndex%>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
        </div>

</asp:Content>

