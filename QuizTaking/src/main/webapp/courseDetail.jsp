<%-- 
    Document   : courseDetail
    Created on : Sep 20, 2023, 4:43:33 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QPS - QUIZ PRACTICE SYSTEMS</title>
        <link rel="stylesheet" href="./css/viewDetail.css" />
    </head>
    <body style="background-color: #F7F7F7">
        <%@include file="header.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
                integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
        crossorigin="anonymous"></script>
        <c:if test="${sessionScope.user == null}">
            <c:redirect url="home" />
        </c:if>
        <c:set var="allowAccess" value="false" /> 
        <c:forEach var="sp" items="${sp}">
            <c:if test="${sp.userId eq sessionScope.user.userId || sessionScope.user.roleId eq 2 || sessionScope.user.roleId eq 1}">
                <c:set var="allowAccess" value="true" /> 
            </c:if>
        </c:forEach>
        <c:choose>
            <c:when test="${allowAccess eq true}">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-md-5" style="display:grid;margin-left: right;margin-top: 20px">
                            <h5>Course code: ${cd.course.courseName} </h5>
                            <h1>${cd.course.courseDescription}</h1>
                            <div class="card" style="width:700px;height: 500px">
                                <div class="card-body">
                                    <h3 class="card-title">EXAM PRACTICE</h3>
                                    <div class="col-md-12" style="display:grid">
                                        <a>
                                            <span class='bx bxs-file-blank'></span>
                                            <span class="card-text" ><strong>Test 01</strong></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-5" style="margin-left: auto;margin-top: 45px">
                            <div class="card" style="width:400px">
                                <div class="card-body">
                                    <div class="row" style="padding-left: 10px;padding-right: 10px">
                                        <div class="container1 col-md-12">                                  
                                            <p class="card-text" style="margin-top: 15px">Class: <strong>${cd.classes.className}</strong></p>
                                            <p class="card-text">Number of students: <strong>${cd.totalStudent}</strong></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <h5 class="card-title">STUDENT INFORMATION</h5>
                                    <c:if test="${sessionScope.user.roleId eq 3}">
                                        <div class="col-md-12">
                                            <p class="card-text" style="margin-bottom: 5px"><strong>Student:</strong> ${sessionScope.user.userName} - ${sessionScope.user.rollNumber}</p>
                                            <p class="card-text" ><strong>Email:</strong> ${sessionScope.user.email}</p>
                                        </div>
                                    </c:if>
                                    <hr>
                                    <h5 class="card-title">TEACHER INFORMATION OF CLASS</h5>
                                    <div class="col-md-12">
                                        <p class="card-text" style="margin-bottom: 5px"><strong>Teacher:</strong> ${cd.teacher.userName}</p>
                                        <p class="card-text"><strong>Email:</strong> ${cd.teacher.email}</p>
                                    </div>
                                    <div class="row" style="margin-top: 20px">
                                        <div class="col-md-12" style="display:flex; justify-content: space-between;">
                                            <button type="button" class="button-fix btn btn-primary" >
                                                <span class="number">20</span>
                                                <span><strong>NUMBER OF EXAMS</strong></span></button>
                                            <button type="button" class="button-fix btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                                <span class="number">${cd.totalStudent}</span>
                                                <span><strong>NUMBER OF STUDENT</strong></span></button>                                    
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="date">
                                        <p class="card-text"><strong>Start date:</strong> ${cd.classes.startDate}</p>
                                        <p class="card-text"><strong>End date:</strong> ${cd.classes.endDate}(Class working)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--POPUP-->
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header justify-content-center">
                                <h5 class="modal-title" id="exampleModalLabel">STUDENT LIST</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Roll Number</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Gender</th>
                                            <th scope="col">Email</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sp" items="${sp}">
                                            <tr>
                                                <th scope="row">${sp.rollNumber}</th>
                                                <td>${sp.userName}</td>
                                                <td>${sp.gender == true ? 'Male' : 'Female'}</td>
                                                <td>${sp.email}</td>
                                            </tr>    
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>                   
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </c:when>
            <c:otherwise>
                <c:redirect url="home" />
            </c:otherwise>
        </c:choose>
    </body>
</html>
