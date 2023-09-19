<%-- Document : login Created on : Sep 18, 2023, 12:50:17 AM Author : HoaiNam --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
              crossorigin="anonymous">
        <!-- box-icon -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <!--Css đáp vô đây-->
        <link rel="stylesheet" href="./assets/css/style.css" />
        <link rel="stylesheet" href="./assets/css/login.css" />

        <style>

        </style>
    </head>

    <body>
        <section class="login">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-sm-6 px-0 d-none d-sm-block">
                        <img src="./assets/img/login.png"
                             alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
                    </div>
                    <div class="form-box-login col-sm-6 text-black">

                        <div class="px-5 ms-xl-4">
                            <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;margin:250px "></i>
                            <span class="h1 fw-bold mb-0">Logo</span>
                        </div>

                        <!--<div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">-->
                        <div class="d-flex align-items-center px-5" style="margin:100px">

                            <div class="center">
                                <h1>QPS - Quiz Practice Systems</h1>
                                <form action="Login" method="post">
                                    <div class="txt_field">
                                        <input type="text" name="Username" autofocus="" required>
                                        <span></span>
                                        <label>Username</label>
                                    </div>

                                    <div class="txt_field">
                                        <input type="password" name="password" autofocus="" required>
                                        <span></span>
                                        <label>Password</label>
                                    </div>

                                    <div class="pass" onclick="doforgetPass()">Forgot Password?</div>
                                    <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${mess}</b></div>
                                    <input type="submit" value="Login">
                                </form>
                                <form action="signup" method="post">
                                    <div class="signup_link">
                                        Chưa phải là thành viên <a href="signup">Đăng ký</a>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </section>
    </body>

</html>