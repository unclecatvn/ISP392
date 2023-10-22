<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
                integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
        crossorigin="anonymous"></script>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="./css/forgotpassword.css"/>
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


            function updateCountdownTimer(seconds) {
                var timerElement = document.getElementById("countdownTimer");
                timerElement.textContent = "Time remaining: " + seconds + "s";
            }

// Hàm đếm ngược
            function countdown(seconds, callback) {
                var timer = setInterval(function () {
                    seconds--;
                    updateCountdownTimer(seconds); // Cập nhật thời gian đếm ngược trên trang
                    if (seconds == 0) {
                        clearInterval(timer); // Dừng đếm ngược khi hết thời gian
                        if (typeof callback === 'function') {
                            callback(); // Gọi hàm callback sau khi đếm ngược kết thúc
                        }
                    }
                }, 1000); // Mỗi 1 giây
            }

// Gọi hàm countdown với thời gian là 60 giây và hành động callback sau khi kết thúc
            countdown(60, function () {
                window.location.href = "forgotPassword";
                // Thêm mã để chuyển hướng về trang login ở đây (sử dụng window.location.href = ...)
            });
        </script>
    </head>
    <body>
        <c:if test="${sessionScope.email == null}">
            <c:redirect url="home"></c:redirect>
        </c:if>
        <section class="forgotpassword">
            <div class="form-box-login">
                <div class="center justify-content-center align-items-center" style="height: auto">
                    <h1 class="justify-content-center">
                        <span class="h1-reset">Reset Password</span>                       
                    </h1>
                    <form action="changePasswordForgot" method="post">
                        <!--<form>-->
                        <div class="txt_field">
                            <p style="color: black;font-size: 20px;font-weight: 500">Email</p>
                            <input type="email" class="form-control" aria-label="Email" aria-describedby="basic-addon1" name="email" readonly="" value="${sessionScope.email}">
                            <p style="color: black;font-size: 20px;font-weight: 500">New password</p>
                            <input type="password" class="form-control" name="password" id="password" onkeyup="validatePassword()">
                            <small class="form-text" id="requirementLength">8-16 character</small><br><!-- comment -->
                            <small class="form-text" id="requirementUpperCase">At least 1 Uppercase</small><br><!-- comment -->
                            <small class="form-text" id="requirementNumber">At least 1 digit</small><br><!-- comment -->     
                            <p style="color: black;font-size: 20px;font-weight: 500">Confirm new password</p>
                            <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" onkeyup="validatePassword()">
                        </div>
                        <div class="d-block text-danger" style="margin-top:10px;margin-bottom:10px" id="countdownTimer">Time remaining: 60s</div>
                        <div class="d-block text-danger" style="margin-top:10px;margin-bottom:10px"><b>${mess}</b></div>
                        <div class="d-block text-danger" style="margin-top:10px;margin-bottom:10px"><b id="errorMessage"></b></div>
                        <input type="submit" value="CONFIRM" id="submitBtn" disabled="">

                        <a class="link-underline link-underline-opacity-0" href="login-google" style="display:flex; color: black; justify-content: center; align-items: center;margin-top:10px;">
                            <span><i class='bx bx-right-arrow-alt' style="display: flex;justify-content: center;align-items: center;"></i></span>
                            <span>Cancel</span></a>
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>
