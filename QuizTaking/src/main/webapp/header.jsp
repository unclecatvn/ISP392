<%-- 
    Document   : home
    Created on : Sep 18, 2023, 12:16:54 AM
    Author     : HoaiNam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link rel="stylesheet" href="./css/header.css" />
        <style>
            .dropdown-toggle::after{
                display:none;
            }
        </style>
    </head>
    <body style="background-color: #F7F7F7">
        <header class="header">
            <!-- Đây là navbar -->
            <nav class="navbar" style="background-color: white;">
                <div class="container-fluid" style="height: 50px;padding-left: 30px; padding-right: 30px;">
                    <a href="home"><img class="logo" style="height: 45px;" src="./assets/img/logo.webp"></a>
                    <div class="sub-menu-wrap" id="userDropdown">
                        <div class="usermenu">
                            <c:choose>
                                <c:when test="${sessionScope.user!=null}">
                                    <div class="dropdown-center">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="background-color: white;border: none;color: black;font-size:20px;display:flex;align-items: center;">
                                            <span class="bx bxs-user-circle" style="font-size: 35px; margin-right: 5px"></span>
                                            <span><strong>${sessionScope.user.userName}</strong></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <c:if test ="${sessionScope.user.roleId == 1}">
                                                <li><a class="dropdown-item" href="home">
                                                        <span class="bx bx-user"></span>
                                                        <span>Dashboard</span></a></li>
                                                    </c:if>
                                            <c:if test ="${sessionScope.user.roleId != 1}">
                                                <li><a class="dropdown-item" href="userdetail?email=${sessionScope.user.email}">
                                                        <span class="bx bx-user"></span>
                                                        <span>User Setting</span></a></li>
                                            </c:if>
                                            <li><a class="dropdown-item" href="logout">
                                                    <span class="bx bx-log-out"></span>
                                                    <span>Log out</span></a></li>
                                        </ul>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="login">
                                        <a class="bx bx-world link-underline link-underline-opacity-0" style="color: black;"> </a>
                                        YOU ARE NOT LOGGED IN.
                                        <a class="font-weight-bold link-underline link-underline-opacity-0" href="login-google"
                                           style="font-weight: bold; color: black;">(LOG IN)</a>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </body>
</html>
