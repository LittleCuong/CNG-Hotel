<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="CNG_Hotel.Account.AdminPage" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
        <div class="container" style="padding-top: 20px; padding-bottom: 20px; box-shadow: 0 5px 30px rgba(80, 57, 24, 0.15); border-radius: 8px;">
            <h1 style="margin-top: 12px; text-align: center">Reservation</h1>
            <div style="padding: 15px 0;">
                <div class="search-input--container">
                    <asp:TextBox CssClass="input-search" ID="txtSearchPhone" runat="server" Width="150px" placeHolder="Enter phone number"></asp:TextBox>
                    <asp:Button ID="btnSearch" CssClass="default-btn search-btn" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>         
            </div>
            <br />
            <asp:GridView ID="reservationsGridView" runat="server" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Vertical" AllowSorting="True" Width="100%"
                PageSize="5" AllowPaging="true"
                OnPageIndexChanging="reservationsGridView_PageIndexChanging"
                OnRowDataBound="reservationsGridView_RowDataBound"
                OnRowCommand="reservationsGridView_RowCommand" DataKeyNames="R_ID">
                <AlternatingRowStyle BackColor="#53624E" />
                <Columns>
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Booking_date" HeaderText="Booking date" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="User_name" HeaderText="Customer name" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="User_phone" HeaderText="Phone number" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Date_checkin" HeaderText="Check in" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Date_checkout" HeaderText="Check out" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Room_name" HeaderText="Room" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Status" HeaderText="Status" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Room_type" HeaderText="Room type" />
                    <asp:BoundField ItemStyle-CssClass="header-reservation" DataField="Total_price" HeaderText="Total" DataFormatString="{}" />
                    <asp:TemplateField HeaderText="Confirm">
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" Text="Booking Confimation" CommandName="ConfirmPayment" CommandArgument="<%#Container.DataItemIndex%>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#53624E" CssClass="header-reservation" Font-Bold="False" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle CssClass="row-reservation" BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
        </div>

</asp:Content>

