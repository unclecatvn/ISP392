<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/userprofile.css"/>
        <script>
            function validatePassword() {
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var submitBtn = document.getElementById("submitBtn");

                var passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,16}$/; // REGEX

                var requirementsMet = true; // Biến để kiểm tra xem tất cả các yêu cầu có được đáp ứng

                // Kiểm tra yêu cầu: Dài từ 8 đến 16 ký tự
                if (password.length < 8 || password.length > 16) {

                    document.getElementById("requirementLength").style.color = "gray";

                    requirementsMet = false;
                } else {
                    document.getElementById("requirementLength").style.color = "green";
                }

                // Kiểm tra yêu cầu: Ít nhất 1 chữ cái viết hoa
                if (!/[A-Z]/.test(password)) {
                    document.getElementById("requirementUpperCase").style.color = "gray";

                    requirementsMet = false;
                } else {
                    document.getElementById("requirementUpperCase").style.color = "green";
                }

                // Kiểm tra yêu cầu: Ít nhất 1 chữ số
                if (!/\d/.test(password)) {
                    document.getElementById("requirementNumber").style.color = "gray";
                    requirementsMet = false;
                } else {
                    document.getElementById("requirementNumber").style.color = "green";
                }

                // Kiểm tra yêu cầu: password và confirmPassword khớp nhau
                if (password !== confirmPassword) {
                    document.getElementById("errorMessage").innerHTML = "Password and Confirm password do not match.";
                    document.getElementById("errorMessage").style.color = "red";
                    requirementsMet = false;
                } else {
                    document.getElementById("errorMessage").innerHTML = "";
                    
                }

                // Cập nhật màu nền của nút "CONFIRM"
                if (!requirementsMet) {
                    submitBtn.style.backgroundColor = "gray"; // Màu xám
                    submitBtn.disabled = true;
                } else {
                    submitBtn.style.backgroundColor = "#F26F21"; // Màu cam
                    submitBtn.disabled = false;
                }
            }
        </script>
    </head>
    <body id="body">
        <c:if test="${sessionScope.user == null}">
            <c:redirect url="login-google" />
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-4 px-0 d-none d-sm-block">
                        <%@include file="sidebar.jsp" %> 
                    </div>             
                    <div class="col-sm-8 px-0 d-none d-sm-block" style="margin-left: 300px;margin-top: 30px;">
                        <h1>Change Password</h1>
                        <p>Choose a new password.</p>
                        <div class="mb-3 mb-lg-4 text-danger"><b>${mess}</b></div>   


                        <div class="container mt-5" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form action="changepassword" method="post">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3" style="display: grid;">
                                            <label for="oldPassword" class="form-label">Password</label>
                                            <input class="form-control" style="padding: .375rem .75rem;" type="password" name="oldPassword" autofocus="" required>
                                            <input style="padding: .375rem .75rem;" type="hidden" name="Email" value="${sessionScope.user.email}">
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="newPassword" class="form-label">New Password</label>
                                                <input class="form-control" style="padding: .375rem .75rem; width: 95%;height: 40px;" type="password" name="newPassword" id="password" onkeyup="validatePassword()" required>
                                                <div style="margin-top: 5px;">
                                                    <small class="form-text" id="requirementLength">8-16 character</small><br><!-- comment -->
                                                    <small class="form-text" id="requirementUpperCase">At least 1 Uppercase</small><br><!-- comment -->
                                                    <small class="form-text" id="requirementNumber">At least 1 digit</small><br><!-- comment --> 
                                                </div>

                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                                <input class="form-control" style="padding: .375rem .75rem; width: 100%;height: 40px;margin-bottom: 75px;" type="password" name="confirmPassword" id="confirmPassword" onkeyup="validatePassword()" required>
                                                <div class="text-danger" style=""><b id="errorMessage"></b></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="CHANGE PASSWORD" id="submitBtn" disabled="">
                                    <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                    <!--<button type="button" onclick='window.location.href = "home"'>Back</button>-->
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </body>
</html>