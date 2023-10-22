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
        <title>Admin create user's profile</title>
        <link rel="stylesheet" href="./css/createuserprofile.css"/>
        <link rel="stylesheet" href="css/style.css">
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>

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

            .error-message {
                color: red;
                font-size: 12px;
                margin-top: 5px;
                left: 0;
                bottom: -20px;
            }

        </style>

        <script>
            function validateForm() {
                var rollNumber = document.create.rollNumber.value;
                var userName = document.create.user_name.value;
                //var password = document.create.password.value;
                var email = document.create.email.value;
                var phone = document.create.phone.value;
                //var submitBtn = document.getElementById("submitBtn");
                var statusR = false;
                var statusN = false;
                var statusE = false;
                var statusP = false;
                var status = false;

                //check roll number
                if (!/^(HE|HF)\d{6}$/.test(rollNumber)) {
                    document.getElementById("rollNumberError").innerHTML = "Roll number must start with HE or HF and 6 digits";
                    statusR = false;
                } else {
                    document.getElementById("rollNumberError").innerHTML = "";
                    statusR = true;
                }

                //check username
                if (!/^[a-zA-Z\s]+$/.test(userName)) {
                    document.getElementById("userNameError").innerHTML = "Username contains only letters";
                    statusN = false;
                } else {
                    document.getElementById("userNameError").innerHTML = "";
                    statusN = true;
                }

                //check password
//                if(!/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/.test(password)){
//                    document.getElementById("passwordError").innerHTML = "At least 1 uppercase, 1 lowercase, 1 special character, 1 number, length > 8 characters";
//                    status = false;
//                }else{
//                    document.getElementById("passwordError").innerHTML = "";
//                    status = true;
//                }

                //check email
                if (!/^[a-zA-Z0-9._%+-]+@(gmail\.com|fpt\.edu\.vn|fe\.edu\.vn)$/.test(email)) {
                    document.getElementById("emailError").innerHTML = "must end with @fpt.edu.vn or @gmail.com or @fe.edu.vn";
                    statusE = false;
                } else {
                    document.getElementById("emailError").innerHTML = "";
                    statusE = true;
                }

                //check phone
                if (!/^\d{10,11}$/.test(phone)) {
                    document.getElementById("phoneError").innerHTML = "contain 10-11 numbers";
                    statusP = false;
                } else {
                    document.getElementById("phoneError").innerHTML = "";
                    statusP = true;
                }

                if (statusR && statusN && statusE && statusP) {
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
                        <h1>Create User Profile</h1>

                        <div class="container mt-5" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form id="create" name="create" action="createprofileadmin" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="center" style="display: flex;">

                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Roll Number</label>
                                                <div class="position-relative">
                                                    <input id="rollNumber" value="${u.rollNumber}" class="form-control" style="padding: .375rem .75rem; width: 95%" type="text" name="rollNumber" autofocus="" required maxlength="8">
                                                    <span id="rollNumberError" class="error-message position-absolute"></span>
                                                    <div class="d-block text-danger" style="margin-top:10px;margin-bottom:10px"><b>${messR}</b></div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="email" class="form-label">Full Name</label>
                                                <div class="position-relative">
                                                    <input id="user_name" value="${u.userName}" class="form-control" type="text" id="password" name="user_name" class="form-control"  required minlength="4">
                                                    <span id="userNameError" class="error-message position-absolute"></span>
                                                </div> 
                                            </div> 
                                        </div>
                                        <div class="mb-3" style="display: grid;">
                                            <label for="confirmPassword" class="form-label">Email</label>
                                            <div class="position-relative">
                                                <input id="email" value="${u.email}"class="form-control" style="padding: .375rem .75rem; width: 100%" type="text" name="email" autofocus="" required>
                                                <span id="emailError" class="error-message position-absolute"></span>
                                                <div class="d-block text-danger" style="margin-top:10px;margin-bottom:10px"><b>${messE}</b></div>
                                            </div>
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="phone" class="form-label">Phone</label>
                                                <div class="position-relative">
                                                    <input id="phone" value="${u.phone}" class="form-control" style="padding: .375rem .75rem; width: 95%" type="text" name="phone" autofocus="" required minlength="10" maxlength="11">
                                                    <span id="phoneError" class="error-message position-absolute"></span>
                                                </div>
                                            </div>
                                            <select name="role" id="role" class="form-control col-sm-6 col-md-5 col-lg-6 mb-3" style="padding: .375rem .75rem; height: 50%;margin-top: 30px;width: 50%;" required>  
                                                <option value="" selected disabled hidden>All roles</option>
                                                <option value="2">Teacher</option>
                                                <option value="3">Student</option>
                                            </select>
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3">
                                                <label class="form-label">Status: </label><br>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="active" name="status" value="True" class="form-check-input" ${u.getStatus() == "Active" ? "checked" : ""} required>
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
                                                    <input type="radio" id="male" name="gender" value="True" class="form-check-input" ${u.getGender() == "Male" ? "checked" : ""} required>
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
                                    <input type="submit" value="UPDATE PROFILE" onsubmit="validateForm()" id="submitBtn">
                                    <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <script src="js/validateUser.js"></script>
    </body>
</html>
