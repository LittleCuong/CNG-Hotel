<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CNG_Hotel.Account.Login" Async="true" %>
<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="container body-content">
        <div class="row">
        <div class="col-md-12">
            <h2 style="font-size: 22px; text-align: center; font-weight: 400;">Sign in to CNG Hotel</h2>
            <section id="loginForm" class="login-section">
                <div class="login-container">
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
                        <div class="col-md-12 remember-container">
                            <div class="checkbox" style="display: flex; align-items: center; margin: 0;">
                                <asp:CheckBox runat="server" ID="RememberMe" style="padding-bottom: 4px;"/>
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12" style="display: flex; justify-content: center;">
                            <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn-custom login-btn" />
                        </div>
                    </div>
                </div>
                <p style="display: block; margin-top: 6px;">
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                <p>
                    <%-- Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    --%>
                </p>
            </section>
        </div>
    </div>

    </div>
</asp:Content>
