<%-- 
    Document   : edituser
    Created on : Sep 24, 2023, 10:21:39 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin edit user's profile</title>
        <style>
            input[type="submit"] {
                width: 40%;
                height: 50px;
                border: 1px solid;
                background: #F26F21;
                border-radius: 10px;
                font-size: 18px;
                color: white;
                font-weight: 700;
                cursor: pointer;
                outline: none;
            }

            input[type="submit"]:hover {
                border-color: #F26F21;
                transition: .5s;
            }
            
        </style>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>

        <script>
            function validateForm() {
                var userName = document.getElementById("user_name").value;
                var phone = document.getElementById("phone").value;
                //var submitBtn = document.getElementById("submitBtn");
                var statusN = false;
                var statusP = false;
                var status = false;


                //check username
                if (!/^[a-zA-Z\s]+$/.test(userName)) {
                    document.getElementById("userNameError").innerHTML = "Username contains only letters";
                    statusN = false;
                } else {
                    document.getElementById("userNameError").innerHTML = "";
                    statusN = true;
                }


                //check phone
                if (!/^\d{10,11}$/.test(phone)) {
                    document.getElementById("phoneError").innerHTML = "contain 10-11 numbers";
                    statusP = false;
                } else {
                    document.getElementById("phoneError").innerHTML = "";
                    statusP = true;
                }

                if (statusN && statusP) {
                    status = true;
                } else {
                    status = false;
                }

                return status;
            }
        </script>

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
                        <h1>Edit User Profile</h1>
                        <!--<div class="mb-3 mb-lg-4 text-danger"><b>${mess}</b></div>-->   
                        <!--<div class="mb-3 mb-lg-4 text-danger"><b>*Data field cannot be left blank</b></div>-->   

                        <c:if test="${not empty successMessage}">
                            <div id="successMessage" class="alert alert-success" role="alert">
                                ${successMessage}
                            </div>
                            <script>
                                setTimeout(function () {
                                    var successMessage = document.getElementById('successMessage');
                                    successMessage.style.display = 'none';
                                }, 4000); // 4000 milliseconds = 4 seconds
                            </script>
                        </c:if>


                        <div class="container mt-5" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form id="edit" action="edituseradmin" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="user_id" class="form-label">ID</label>
                                                <input value="${u.userId}" class="form-control" style="padding: .375rem .75rem; width: 95%;background-color: #F1F1F1;color:#B0B0B0" type="text" name="user_id" autofocus="" readonly>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Roll Number</label>
                                                <input value="${u.rollNumber}" class="form-control" style="padding: .375rem .75rem; width: 100%;background-color: #F1F1F1;color:#B0B0B0" type="text" name="rollNumber" autofocus="" readonly>
                                            </div>                                         
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Full Name</label>
                                            <input value="${u.userName}" class="form-control" type="text" id="user_name" name="user_name" class="form-control" required>
                                            <span style="color: red" id="userNameError" class="error-message position-absolute"></span>
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="newPassword" class="form-label">Password</label>
                                                <input value="${u.password}"class="form-control" style="padding: .375rem .75rem; width: 95%;background-color: #F1F1F1;color:#B0B0B0" type="password" name="password" autofocus="" readonly>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Email</label>
                                                <input value="${u.email}"class="form-control" style="padding: .375rem .75rem; width: 100%;background-color: #F1F1F1;color:#B0B0B0" id="email" type="text" name="email" autofocus="" readonly>
                                            </div>                                       
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: inline;">
                                                <div style="display:grid">
                                                    <label for="newPassword" class="form-label">Phone</label>
                                                    <input value="${u.phone}" class="form-control" style="padding: .375rem .75rem; width: 95%" type="text" id="phone" name="phone" autofocus="" required maxlength="11">
                                                </div>

                                                <span style="color: red" id="phoneError" class="error-message position-absolute"></span>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="role" class="form-label">Role</label>                                                   
                                                <input name="role" type="text" class="form-control" value="${role}" style="padding: .375rem .75rem; width: 100%;background-color: #F1F1F1;color:#B0B0B0" readonly="">
                                            </div>    
                                            <!--                                            <select name="role" id="role" style="width: 150px; margin-right: 50px" required>  
                                                                                            <option value="" selected disabled hidden>All roles</option>
                                                                                            <option value="Teacher">Teacher</option>
                                                                                            <option value="Student">Student</option>
                                                                                        </select>-->
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3">
                                                <label class="form-label">Status: </label><br>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="active" name="status" value="True" class="form-check-input" ${u.getStatus() == "Active" ? "checked" : ""}>
                                                    <label for="active" class="form-check-label">Active</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="deactive" name="status" value="False" class="form-check-input" ${u.getStatus() == "Deactive" ? "checked" : ""}>
                                                    <label for="deactive" class="form-check-label">Deactive</label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3">
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
                                        </div>

                                    </div>
                                </div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="UPDATE PROFILE">
                                    <a href="viewlistuser" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </body>
</html>
