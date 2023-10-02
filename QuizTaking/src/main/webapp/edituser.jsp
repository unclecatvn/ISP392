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
                            <form action="edituseradmin" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="user_id" class="form-label">ID</label>
                                                <input value="${u.userId}" class="form-control" style="padding: .375rem .75rem; width: 95%;background-color: #F1F1F1;color:#B0B0B0" type="text" name="user_id" autofocus="" readonly>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Roll Number</label>
                                                <input value="${u.rollNumber}" class="form-control" style="padding: .375rem .75rem; width: 100%" type="text" name="rollNumber" autofocus="" required>
                                            </div>                                         
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Username</label>
                                            <input value="${u.userName}" class="form-control" type="text" id="password" name="user_name" class="form-control"  required>
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="newPassword" class="form-label">Password</label>
                                                <input value="${u.password}"class="form-control" style="padding: .375rem .75rem; width: 95%;background-color: #F1F1F1;color:#B0B0B0" type="password" name="password" autofocus="" readonly>
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Email</label>
                                                <input value="${u.email}"class="form-control" style="padding: .375rem .75rem; width: 100%" type="text" name="email" autofocus="" required>
                                            </div>                                       
                                        </div>
                                        <div class="center" style="display: flex;">
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="newPassword" class="form-label">Phone</label>
                                                <input value="${u.phone}" class="form-control" style="padding: .375rem .75rem; width: 95%" type="text" name="phone" autofocus="" required maxlength="11">
                                            </div>
                                            <div class="col-sm-6 col-md-5 col-lg-6 mb-3" style="display: grid;">
                                                <label for="confirmPassword" class="form-label">Role</label>
                                                <input value="${u.getRole(u.roleId)}" class="form-control" style="padding: .375rem .75rem; width: 100%" type="text" name="role" autofocus="">
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
