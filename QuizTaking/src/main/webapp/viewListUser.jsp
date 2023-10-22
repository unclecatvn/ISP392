<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View List User</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <!-- Include Bootstrap CSS -->
        <link rel="stylesheet" href="./css/viewListUser.css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body style="margin-left: 280px;">
        <c:if test="${sessionScope.user == null}">
            <c:redirect url="login-google" />
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <%@include file="sidebar.jsp" %>
            <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;width: 1200px;position: sticky;top: 0;z-index: 999;">
                <form action="searchuser" method="post">
                    <div style="display:flex;justify-content: center;">
                        <select class="form-label form-control" name="status" id="status" style="width: 150px;margin-right: 50px;" required>  
                            <option class="form-label" value="" selected disabled hidden>All status</option>
                            <option value=true>Active</option>
                            <option value=false>Deactive</option>
                        </select>

                        <select class="form-label form-control" name="role" id="role" style="width: 150px; margin-right: 50px" required>  
                            <option value="" selected disabled hidden>All roles</option>
                            <option value="2">Teacher</option>
                            <option value="3">Student</option>
                        </select>


                        <input class="form-label form-control" style="width: 350px; margin-right: 50px" type="search" id="search" name="search" placeholder="Search by name" value="${nameS}" style="margin-right: 50px">

                        <input type="submit" value="Submit" style="margin-right: 30px">
                        <a href="viewlistuser" class="link-underline link-underline-opacity-0" style="color: black;display:flex;align-items: center;">Cancel search</a>
                    </div>
                    <div>
                        <a href="createuserprofile.jsp" class="link-underline link-underline-opacity-0" style="color:#F26F21;font-weight: 600;">Create new user profile</a>
                    </div>
                </form>                            
            </div>




            <div class="container mt-4">
                <table class="table table-bordered">
                    <thead class="thead">
                        <tr>
                            <th>ID</th>
                            <th>Roll Number</th>
                            <th>Username</th>
                            <th>Gender</th>                   
                            <th>Phone</th>
                            <th>Role</th>                    
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listS}" var="x" varStatus="status">
                            <tr>                
                                <td>${x.userId}</td>
                                <td>${x.rollNumber}</td>
                                <td>${x.userName}</td>
                                <td>${x.getGender()}</td>
                                <td>${x.phone}</td>
                                <td>${x.getRole(x.roleId)}</td>
                                <td>${x.getStatus()}</td>
                                <td>

                                    <!-- block button -->  


                                    <c:set var="allowDelete" value="false"></c:set> <!-- Set allowDelete to false initially -->

                                    <c:if test="${x.roleId eq 2}">
                                        <c:forEach var="ut" items="${listST}">
                                            <c:if test="${x.userId eq ut.userId}">
                                                <c:set var="allowDelete" value="true"></c:set>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${x.roleId eq 3}">
                                        <c:forEach var="us" items="${listSS}">
                                            <c:if test="${x.userId eq us.userId}">
                                                <c:set var="allowDelete" value="true"></c:set>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <!-- Always render the edit button -->
                                    <a href="edituseradmin?id=${x.userId}" class="btn btn-sm btn-primary">Edit</a>

                                    <!-- Render the delete button conditionally based on allowDelete -->
                                    <c:if test="${allowDelete eq false}">
                                        <button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#exampleModal" onclick="showDeleteModal(${x.userId})">
                                            Delete
                                        </button>
                                    </c:if>



                                    <!-- Delete Confirmation Modal -->
                                    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Delete Confirmation</h5>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure you want to delete this User?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="button" class="btn btn-danger" onclick="deleteUser()">Delete</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

    <script>
                                                        var patientIdToDelete = null;

                                                        function showDeleteModal(userId) {
                                                            userIdToDelete = userId;
                                                            $('#deleteModal').modal('show');
                                                        }

                                                        function deleteUser() {
                                                            if (userIdToDelete) {
                                                                window.location.href = 'deleteuser?id=' + userIdToDelete;
                                                            }
                                                        }
    </script>
</html>
