<%-- 
    Document   : login
    Created on : Sep 19, 2023, 9:54:51 PM
    Author     : HoaiNam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="./css/style.css" />
        <link rel="stylesheet" href="./css/login.css" />

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

                        <!--                        <div class="px-5 ms-xl-4">
                                                    <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;margin:250px "></i>
                                                    <span class="h1 fw-bold mb-0">Logo</span>
                                                </div>-->

                        <!--<div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">-->
                        <a href="home"><img src="./assets/img/logo.webp" alt="alt" style="width: 200px;margin-left: 230px;padding-top: 50px;" ></a>
                        <h2 style="margin-left:120px; margin-right:100px; margin-top: 30px;font-size: 35px;">QPS - Quiz Practice Systems</h2>
                        <div class="align-items-center px-5" style="margin-left:100px; margin-right:100px; margin-top: 20px">

                            <div class="center">
                                <c:set var="cookie" value="${pageContext.request.cookies}"/>
                                <form action="login-google" method="post">
                                    <div class="txt_field">
                                        <input type="text" name="Username" autofocus="" value="${cookie.cuser.value}" required>
                                        <span></span>
                                        <label>Email</label>
                                    </div>

                                    <div class="txt_field">
                                        <input type="password" name="password" value="${cookie.cpass.value}" autofocus="" required>
                                        <span></span>
                                        <label>Password</label>
                                    </div>

                                    <!-- Checkbox -->
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" ${(cookie.crem!=null?'checked':'')} name="rem" value="ON" id="form1Example3" checked />
                                        <label class="form-check-label" for="form1Example3"> Remember me </label>
                                    </div>
                                    <a href="forgotPassword" class="forgotpassword link-underline link-underline-opacity-0" onclick="doforgetPass()">Forgot Password?</a>
                                    <div class="text-danger" style="display:flex;justify-content: center;margin-top:10px;margin-bottom:10px"><b>${mess}</b></div>
                                    <input type="submit" value="Login">
                                </form>
                                <form action="login-google" method="post">
                                    <div class="login-google">
                                        <span style="display: flex;justify-content: space-around;margin-top: 20px; margin-bottom: 10px">Log in using your account on:</span>
                                        <a class="login-google-button link-underline link-underline-opacity-0" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/QuizPractice/login-google&response_type=code
                                           &client_id=17343589046-105nt6idiu9esmhfthjkun5jdrlvafcv.apps.googleusercontent.com&approval_prompt=force">
                                            <span style="margin-right: 5px"><img style="height: 35px" src="./assets/img/google.svg" alt="alt"/></span>
                                            <span>FPT.EDU.VN</span></a>
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