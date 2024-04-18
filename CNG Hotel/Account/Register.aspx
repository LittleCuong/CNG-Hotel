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
                    <div class="register-container" style="display: flex; flex-direction: column; height: 100%; padding: 30px 25px; box-shadow: 0 5px 30px rgba(80, 57, 24, 0.15); border-radius: 8px;">                     
                        <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <div class="input-container">
                                <asp:Label runat="server" AssociatedControlID="Name" CssClass="col-md-12 control-label">User name</asp:Label>
                                <div class="col-md-12">
                                    <asp:TextBox runat="server" ID="Name" CssClass="form-control input-custom" TextMode="SingleLine" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Name"
                                        CssClass="text-danger" ErrorMessage="The user name field is required." />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-container">
                                <asp:Label runat="server" AssociatedControlID="Phone" CssClass="col-md-12 control-label">Phone Number</asp:Label>
                                <div class="col-md-12">
                                    <asp:TextBox runat="server" ID="Phone" CssClass="form-control input-custom" TextMode="Phone" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Phone"
                                        CssClass="text-danger" ErrorMessage="The phone number field is required." />
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
                                    <asp:CompareValidator ID="ComparePassword" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="Password do not match!" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: 12px;">
                            <div class="col-md-12">
                                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="default-btn" style="width: 100%"/>
                            </div>
                        </div>
                    </div>                               
                </section>
            </div>
        </div>
    </div>

    <script>


    </script>
</asp:Content>
