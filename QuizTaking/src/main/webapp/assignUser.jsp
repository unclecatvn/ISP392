<%-- 
    Document   : assignUser
    Created on : Oct 8, 2023, 7:52:34 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Class Manager</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/assignUser.css"/>
    </head>
    <body>
        <%@include file="sidebar.jsp" %>
        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;width: 1200px;position: sticky;top: 0;z-index: 999; margin-right: 50px;">
            <form action="assignuser" method="post" style="display:flex;">
                <label style='margin-right: 20px;'>List of teacher: </label>
                <select class="form-label form-control" name="teacher" id="teacher" style="width: 150px;margin-right: 50px;" required>
                    <option class="form-label" value="" selected disabled hidden>All Teacher</option>
                    <c:forEach items="${listT}" var="t">
                        <option class="form-label" value="${t.userId}">${t.userId}.${t.rollNumber} - ${t.userName}</option>
                    </c:forEach>
                </select>
                <input value="${classId}" hidden="" name="classId">
                <input value="${courseId}" hidden="" name="courseId">
                <input type="submit" value="Assign teacher">
            </form>

            <div>${teacherInfo.userName} - ${teacherInfo.email} - ${teacherInfo.phone}</div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add student</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="assignstudent" method="post" onsubmit="return checkStudent()">
                            <label for="student">List of student: </label>
                            <select class="form-label form-control" name="student" id="student" style="width: 150px;margin-right: 50px;" required>
                                <option class="form-label" value="" selected disabled hidden>All Student</option>
                                <c:forEach items="${listS}" var="s">
                                    <option class="form-label" value="${s.userId}">${s.userId}.${s.rollNumber} - ${s.userName}</option>
                                </c:forEach>
                            </select>
                            <p id="warning"></p>
                            <input value="${classId}" hidden="" name="classId">
                            <input value="${courseId}" hidden="" name="courseId">
                            <input class='assign-student' type="submit" value="Assign student">
                        </form>
                    </div>
                </div>
            </div>
            <script>
                function checkStudent() {
                    var studentId = document.getElementById("student").value;
                    var requirementMet = true;
                    var listStudent = [
                <c:forEach items="${list}" var="s">
                        '${s.student.userId}',
                </c:forEach>
                    ];
                    var listStudentSC = [
                <c:forEach items="${listSC}" var="sc">
                        '${sc.student.userId}',
                </c:forEach>
                    ];
                    if (listStudent.includes(studentId)) {
                        document.getElementById("warning").innerHTML = "This student has already in this class";
                        document.getElementById("warning").style.color = "red";
                        requirementMet = false;
                    } else if(listStudentSC.includes(studentId)){
                        document.getElementById("warning").innerHTML = "This student has already anticipated in this course";
                        document.getElementById("warning").style.color = "red";
                        requirementMet = false;
                    }else {
                        document.getElementById("warning").innerHTML = "";
                    }

                    return requirementMet;
                }
            </script>
        </div>


        <div class="container mt-4" style="margin-right: -100px">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                Add student
            </button>
            <table class="table table-bordered" style="width: 1100px;">
                <thead class="thead">
                    <tr>
                        <th>ID</th>
                        <th>Roll Number</th>
                        <th>Email</th>
                        <th>Username</th>                    
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="x" varStatus="status">
                        <tr>                
                            <td>${x.student.userId}</td>
                            <td>${x.student.rollNumber}</td>
                            <td>${x.student.email}</td>
                            <td>${x.student.userName}</td>
                        </tr>
                    </c:forEach>
            </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
