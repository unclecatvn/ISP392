<%-- 
    Document   : home
    Created on : Sep 18, 2023, 12:16:54 AM
    Author     : HoaiNam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header class="header">
        <!-- Đây là navbar -->
        <nav class="navbar" style="background-color: white;">
            <div class="container-fluid" style="height: 50px;padding-left: 20px; padding-right: 20px;">
                <img class="logo" style="height: 50px;" src="./assets/img/logo.png">
                <div class="usermenu">

                    <span class="login">
                        <a class="bx bx-world link-underline link-underline-opacity-0" style="color: black;"> </a>
                        YOU ARE NOT LOGGED IN.
                        <a class="font-weight-bold link-underline link-underline-opacity-0" href="/login.jsp"
                            style="font-weight: bold; color: black;">(LOG IN)</a>
                    </span>
                </div>
            </div>
        </nav>
    </header>
    </body>
</html>
