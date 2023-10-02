<%-- 
    Document   : slidebar
    Created on : Sep 22, 2023, 4:36:51 PM
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
        <link rel="stylesheet" href="./css/sidebar.css"/>
    </head>
    <body>
        <c:if test="${sessionScope.user == null}">
            <c:redirect url="login-google" />
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <div class="sidebar">
                <div class="logo-details">
                    <span class="logo-name"><a href="home"><img src="./assets/img/logo.webp" alt="alt"/></a></span>

                </div>
                <ul class="nav-links">
                    <li class="menu active">
                        <a href="#" style="font-size: 30px;">
                            <i class='bx bx-menu' id="btn" style="font-size:20px"></i>
                        </a>
                    </li>

                    <li>
                        <a>
                            <i class='bx bxs-user-circle'></i>
                            <span class="link-name">${sessionScope.user.userName}</span>
                        </a>
                    </li>
                    <c:if test="${sessionScope.user.roleId == 1}">
                        <li>
                            <a href="home">
                                <i class='bx bxs-grid-alt'></i>
                                <span class="link-name">Dashboard</span>
                            </a>
                        </li> 
                    </c:if>
                    <c:if test ="${sessionScope.user.roleId == 3}">
                        <li>
                            <div class="icon-link">
                                <a href="#">
                                    <i class='bx bxs-user-account' ></i>
                                    <span class="link-name">User Setting</span>
                                </a>
                                <i class='bx bx-chevron-down'></i>
                            </div>
                            <ul class="sub-menu">
                                <li><a href="userdetail?email=${sessionScope.user.email}">View Profile</a></li>
                                <li><a href="changepassword">Change Password</a></li>
                            </ul>

                        </li>
                        
                        <li>
                            <div class="icon-link">
                                <a href="viewClass.jsp">
                                    <i class='bx bxs-school'></i>
                                    <span class="link-name">View Class</span>
                                </a>
                            </div>
                        </li>
                    </c:if>
                    <c:if test ="${sessionScope.user.roleId == 1}">
                        <li>
                            <div class="icon-link">
                                <a href="#">
                                    <i class='bx bxs-user-account' ></i>
                                    <span class="link-name">Admin Setting</span>
                                </a>
                                <i class='bx bx-chevron-down'></i>
                            </div>
                            <ul class="sub-menu">
                                <li><a href="userdetail?email=${sessionScope.user.email}">View Profile</a></li>
                                <li><a href="changepassword">Change Password</a></li>
                                <li><a href="viewlistuser">Manage Accounts</a></li>
                                <li><a href="url">Manage Class</a></li>
                                <li><a href="manageCourse.jsp">Manage Course</a></li>
                            </ul>
                        </li>
                    </c:if> 
                    <li>
                        <div class="logout">
                            <a class="logout btn btn-outline-success" href="logout">
                                <i class='bx bx-log-out' style="min-width: 30px;display: flex;justify-content: center" ></i>
                                <span class="link-name" style="padding-left:5px; padding-right: 5px;">Log out</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <script>
                let sidebar = document.querySelector(".sidebar");
                let closeBtn = document.querySelector("#btn");
                closeBtn.addEventListener("click", () => {
                    sidebar.classList.toggle("open");
                    menuBtnChange();//calling the function(optional)
                });
                function menuBtnChange() {
                    if (sidebar.classList.contains("open")) {
                        closeBtn.classList.replace("bx-menu", "bx-menu-alt-right");//replacing the iocns class
                    } else {
                        closeBtn.classList.replace("bx-menu-alt-right", "bx-menu");//replacing the iocns class
                    }
                }
            </script>
        </c:if>
    </body>
</html>
