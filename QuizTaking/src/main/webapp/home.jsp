<%-- 
    Document   : index
    Created on : Sep 18, 2023, 12:16:02 AM
    Author     : HoaiNam
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>QPS - QUIZ PRACTICE SYSTEMS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/style.css" />
        <link rel="stylesheet" href="./css/dashboard.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>

    <body>
        <c:if test="${sessionScope.user==null}">
            <%@include file="header.jsp" %> 
            <section class="view" id="view">
                <div class="overlay" style="text-align: center;">
                    <a style=" font-size: 50px; font-family: Open Sans; font-weight: 700; word-wrap: break-word">QPS - Quiz
                        Practice Systems</a>
                    <hr>
                    <a style="font-size: 25px;font-family: Open Sans;word-wrap: break-word">Construct knowledge and personalize
                        the learning way to empower learners' full potential.</a>
                </div>
            </section>
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <c:choose>
                <c:when test="${sessionScope.user.roleId == 1}">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-4 px-0 d-none d-sm-block">
                                <%@include file="sidebar.jsp" %> 
                            </div>             
                            <div class="col-sm-8 px-0 d-none d-sm-block" style="margin-left: 300px;margin-top: 30px;">
                                <h1>Dashboard</h1>
                                <div class="container text-center">
                                    <div class="row align-items-end" style="border-radius: 10px; margin-top: 20px">
                                        <!--<div class="row">-->
                                        <div class="col-md-12" style="display:flex; justify-content: space-between;">
                                            <button type="button" class="button-fix btn btn-primary" >
                                                <span class="number"><strong>${totalStudent}</strong></span>
                                                <span>NUMBER OF STUDENT</span></button>
                                            <button type="button" class="button-fix btn btn-primary">
                                                <span class="number"><strong>${totalTeacher}</strong></span>
                                                <span>NUMBER OF TEACHER</span></button>
                                            <button type="button" class="button-fix btn btn-primary">
                                                <span class="number"><strong>${totalCourse}</strong></span>
                                                <span>NUMBER OF COURSE</span></button>
                                            <button type="button" class="button-fix btn btn-primary"">
                                                <span class="number"><strong>${totalClass}</strong></span>
                                                <span>NUMBER OF CLASS</span></button>
                                            <!--</div>-->
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <h3>View subject</h3> 
                                    <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                                        <table class="table table-striped" style="--bs-table-bg: #F8F5F5;">
                                            <thead>
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Subject Name</th>
                                                    <th scope="col">Description</th>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="l" items="${list}">
                                                    <tr>
                                                        <th scope="row">${l.courseId}</th>
                                                        <td>${l.courseName}</td>
                                                        <td>${l.courseDescription}</td>
                                                        <td><a class="link-underline link-underline-opacity-0" data-bs-toggle="modal" data-bs-target="#classView" data-course-id="${l.courseId}" onclick="showClassList(this);">View</a></td>
                                                        <c:set var="courseId" value="${l.courseId}" /> 
                                                    </tr>


                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- Popup -->
                                    <div class="modal fade" id="classView" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header justify-content-center">
                                                    <h5 class="modal-title" id="exampleModalLabel">CLASS LIST</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <table class="table">
                                                        <thead class="justify-content-center align-items-center">
                                                            <tr class="justify-content-center align-items-center">
                                                                <th scope="col">#</th>
                                                                <th scope="col-md-2">Class</th>
                                                                <th scope="col-md-2">Teacher</th>
                                                                <th scope="col-md-1">Total student</th>
                                                                <th scope="col-md-3">Date</th>
                                                                <th scope="col"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="classListBody">


                                                        </tbody>
                                                    </table>
                                                </div>                   
                                            </div>
                                        </div>
                                    </div>

                                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                                    <script>
                                                            function showClassList(link) {
                                                                var courseId = link.getAttribute('data-course-id');
                                                                var modal = $('#classView');

                                                                // Xóa danh sách lớp hiện tại (nếu có)
                                                                modal.find('#classListBody').empty();

                                                                // Sử dụng AJAX để tải danh sách lớp từ servlet
                                                                $.ajax({
                                                                    type: 'POST',
                                                                    url: 'home', // URL của servlet
                                                                    data: {courseId: courseId},
                                                                    dataType: 'json',
                                                                    success: function (data) {
                                                                        // Xử lý dữ liệu trả về từ servlet
                                                                        var classListHtml = '';
                                                                        data.forEach(function (cls) {
                                                                            classListHtml += '<tr>';
                                                                            classListHtml += '<th scope="row">' + cls.classes.classId + '</th>';
                                                                            classListHtml += '<td>' + cls.classes.className + '</td>';
                                                                            classListHtml += '<td>' + cls.teacher.userName + '</td>';
                                                                            classListHtml += '<td>' + cls.totalStudent + '</td>';
                                                                            classListHtml += '<td>' + cls.classes.startDate + ' - ' + cls.classes.endDate + '</td>';
                                                                            classListHtml += '<td><a href="courseDetail?classId=' + cls.classes.classId + '&courseId=' + cls.course.courseId + '">Go to Class</a></td>';

                                                                            classListHtml += '</tr>';
                                                                        });

                                                                        // Add the class list HTML to the modal
                                                                        modal.find('#classListBody').html(classListHtml);

                                                                        // Mở modal
                                                                        modal.modal('show');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.error('Error loading class data:', error);
                                                                    }
                                                                });
                                                            }
                                    </script>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="container-fluid">
                        <div class="row g-0">
                            <div class="col-sm-3 px-0">
                                <%@include file="sidebar.jsp" %> 
                            </div>             
                            <div class="col-sm-9 px-0" style="margin-top: 30px;">
                                <div class="row mb-2">
                                    <h1>All class and course</h1>
                                    <c:forEach var="l" items="${list}">                           
                                        <div class="col-md-4" style="width: 340px;margin-bottom: 10px;">
                                            <div class="card mx-0">
                                                <div class="card-body">
                                                    <h5 class="card-title" style="height: 50px"><b>${l.course.courseName} - ${l.course.courseDescription}</b></h5>
                                                    <p class="card-text">Class: ${l.classes.className}</p>
                                                    <p class="card-text">Teacher: ${l.teacher.userName}</p>
                                                    <p class="card-text">Number of students: ${l.totalStudent}</p>
                                                    <p class="card-text">
                                                        <fmt:formatDate pattern="dd-MM-yyyy" value="${l.classes.startDate}" var="startDate"/>   ${startDate}/
                                                        <fmt:formatDate pattern="dd-MM-yyyy" value="${l.classes.endDate}" var="endDate"/>${endDate}
                                                    </p>
                                                    <a class="link-underline link-underline-opacity-0" href="courseDetail?classId=${l.classes.classId}&courseId=${l.course.courseId}">Go to course</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div> 
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </body>
</html>