<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CNG_Hotel.Account.Login" Async="true" %>
<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="container body-content">
        <div class="row">
        <div class="col-md-12">
            <h2 style="font-size: 22px; text-align: center; font-weight: 400;">Sign in to CNG Hotel</h2>
            <section id="loginForm" class="login-section">
                <div class="login-container" style="display: flex; flex-direction: column; height: 100%; padding: 30px 25px; box-shadow: 0 5px 30px rgba(80, 57, 24, 0.15); border-radius: 8px;">
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <div class="input-container">
                            <asp:Label runat="server" AssociatedControlID="Number" CssClass="col-md-12 control-label">Phone number</asp:Label>
                            <div class="col-md-12">
                                <asp:TextBox runat="server" ID="Number" CssClass="form-control input-custom" TextMode="Phone"/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Number"
                                    CssClass="text-danger" ErrorMessage="The phone number field is required." />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-container">
                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-12 control-label">Password</asp:Label>
                            <div class="col-md-12">
                                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control input-custom" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12" style="display: flex; justify-content: center;">
                            <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="default-btn" style="width: 100%"/>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    </div>
</asp:Content>
