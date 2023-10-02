<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/userprofile.css"/>
    </head>
    <body>
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
                        <h1>Profile Setting</h1>
                        <p>Manage your personal information.</p>
                        <c:if test="${not empty successMessage}">
                            <div id="successMessage" class="alert alert-success" role="alert" style="width:300px">
                                ${successMessage}
                            </div>
                            <script>
                                console.log(successMessage);
                                setTimeout(function () {
                                    console.log('Inside setTimeout');
                                    var successMessage = document.getElementById('successMessage');
                                    successMessage.style.display = 'none';
                                }, 4000);

                            </script>
    <!--                        <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${mess}</b></div>   -->
                        </c:if>


                        <div class="container mt-5" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form action="userdetail" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="fullname" class="form-label">Full Name</label>
                                            <input value="${u.userName}" type="text" id="fullname" name="fullname" class="form-control" maxlength="30">
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input value="${u.email}" type="email" id="email" name="email" class="form-control" style="background-color: #F1F1F1;color:#B0B0B0"readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">Phone</label>
                                            <input value="${u.phone}" type="text" id="phone" name="phone" class="form-control" maxlength="11">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Gender</label><br>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="male" name="gender" value="True" class="form-check-input" ${u.getGender() == "Male" ? "checked" : ""}>
                                                <label for="male" class="form-check-label">Male</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="female" name="gender" value="False" class="form-check-input" ${u.getGender() == "Female" ? "checked" : ""}>
                                                <label for="female" class="form-check-label">Female</label>
                                            </div>
                                        </div>
                                        <div class="mb-3" style="margin-top:25px">
                                            <label for="rollnumber" class="form-label">Roll Number</label>                               
                                            <input value="${u.rollNumber}" type="text" id="rollnumber" name="rollnumber" class="form-control" style="background-color: #F1F1F1;color:#B0B0B0" readonly>                                                                 
                                        </div>
                                        <div class="mb-3">
                                            <label for="role" class="form-label">Role</label>
                                            <input value="${role}" type="text" id="role" name="role" class="form-control" style="background-color: #F1F1F1;color:#B0B0B0" readonly>                                                                    
                                        </div>
                                    </div>
                                </div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="UPDATE PROFILE">
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