<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CNG_Hotel.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
   
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

     <div class="container body-content">
        <div class="row">
            <div class="col-md-12">   
                <h2 style="font-size: 22px; text-align: center; font-weight: 400;">Sign up to CNG Hotel</h2>
                <section class="register-section">
                    <div class="register-container">                     
                        <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <div class="input-container">
                                <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-12 control-label">Email</asp:Label>
                                <div class="col-md-12">
                                    <asp:TextBox runat="server" ID="Email" CssClass="form-control input-custom" TextMode="Email" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                        CssClass="text-danger" ErrorMessage="The email field is required." />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-container">
                                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-12 control-label">Password</asp:Label>
                                <div class="col-md-12">
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control input-custom" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                        CssClass="text-danger" ErrorMessage="The password field is required." />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-container">
                                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-12 control-label">Confirm password</asp:Label>
                                <div class="col-md-12">
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control input-custom" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn-custom login-btn" />
                            </div>
                        </div>
                    </div>                               
                </section>
            </div>
        </div>
    </div>
</asp:Content>
