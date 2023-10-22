<%-- 
    Document   : courseDetail
    Created on : Sep 20, 2023, 4:43:33 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QPS - QUIZ PRACTICE SYSTEMS</title>
        <link rel="stylesheet" href="./css/viewDetail.css" />
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
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
                        <div class="col-sm-8 col-md-5" style="display:grid;margin-top: 20px">
                            <h5>Course code: ${cd.course.courseName} </h5>
                            <h1>${cd.course.courseDescription}</h1>
                            <div class="card" style="width:700px;height: 500px">
                                <div style="padding: 1rem 1rem 0.1rem 1rem">
                                    <div style="display:flex;justify-content: space-between;">
                                        <h3 class="card-title">EXAM PRACTICE</h3>
                                        <c:if test="${sessionScope.user.roleId eq 2}">
                                            <a type="button" style="display:flex;align-items: center; margin-left: 10px; font-size: 17px; color:#F26F21; font-weight: 700;" data-bs-toggle="modal" data-bs-target="#newModal">
                                                <i class='bx bx-folder-plus'></i>
                                                <span style="margin-left: 5px">NEW QUIZ</span>
                                            </a>
                                        </c:if>
                                    </div>
                                    <p class="d-block mx-4 mb-3 mb-lg-4  text-danger" style="font-weight: 600;">${message}</p>
                                </div>
                                <div class="card-body" style="height:450px; overflow: auto;">
                                    <div class="col-md-12" style="display:grid; max-height: fit-content">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.roleId == 3}">                                                
                                                <c:forEach var="q" items="${quiz}">
                                                    <c:if test="${q.status eq true}"> 
                                                        <div class="card mb-3">
                                                            <div class="card-body" style="background-color: #F8F8F8;box-shadow: 2px 3px 3px #d6d6d6;">
                                                                <div style="display:flex;align-items: flex-start;justify-content: space-between;">
                                                                    <h5 class="card-title">${q.title}</h5>
                                                                    <div style="display: -webkit-box;">
                                                                        <i class='bx bx-calendar-week'></i>
                                                                        <p>${q.startDate} - ${q.endDate}</p>
                                                                    </div>

                                                                </div>
                                                                <div class="row" style="display:flex;justify-content: space-between;">
                                                                    <div class="col-md-10" style="width: 80%;">
                                                                        <p class="card-text">${q.description}</p>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <div class="btn-group" style="float: right;">
                                                                            <button class="btn btn-secondary btn-sm dropdown-toggle" style="background: #F26F21;--bs-btn-border-color:none;" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                                Action
                                                                            </button>
                                                                            <c:if test="${sessionScope.user.roleId eq 2}">
                                                                                <ul class="dropdown-menu">
                                                                                    <li><a class="dropdown-item" href="editQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">Edit</a></li>
                                                                                    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#deleteModal${q.quizId}" data-quiz-id="${q.quizId}">Delete</a></li>

                                                                                </ul>
                                                                            </c:if>
                                                                            <c:if test="${sessionScope.user.roleId eq 3}">
                                                                                <ul class="dropdown-menu">                                               
                                                                                    <li><a class="dropdown-item" href="viewQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">View history</a></li>
                                                                                    <li><a class="dropdown-item" href="viewQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">Do quiz</a></li>
                                                                                </ul>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="q" items="${quiz}">
                                                    <div class="card mb-3">
                                                        <div class="card-body" style="background-color: #F8F8F8;box-shadow: 2px 3px 3px #d6d6d6;">
                                                            <div style="display:flex;align-items: flex-start;justify-content: space-between;">
                                                                <h5 class="card-title">${q.title}</h5>
                                                                <div style="display: -webkit-box;">
                                                                    <i class='bx bx-calendar-week'></i>
                                                                    <p>${q.startDate} - ${q.endDate}</p>
                                                                </div>

                                                            </div>
                                                            <div class="row" style="display:flex;justify-content: space-between;">
                                                                <div class="col-md-10" style="width: 80%;">
                                                                    <p class="card-text">${q.description}</p>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <div class="btn-group" style="float: right;">
                                                                        <button class="btn btn-secondary btn-sm dropdown-toggle" style="background: #F26F21;--bs-btn-border-color:none;" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                            Action
                                                                        </button>
                                                                        <c:if test="${sessionScope.user.roleId eq 2}">
                                                                            <ul class="dropdown-menu">
                                                                                <li><a class="dropdown-item" href="editQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">Edit</a></li>
                                                                                <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#deleteModal${q.quizId}" data-quiz-id="${q.quizId}">Delete</a></li>

                                                                            </ul>
                                                                        </c:if>
                                                                        <c:if test="${sessionScope.user.roleId eq 3}">
                                                                            <ul class="dropdown-menu">                                               
                                                                                <li><a class="dropdown-item" href="viewQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">View history</a></li>
                                                                                <li><a class="dropdown-item" href="viewQuiz?classId=${q.classes.classId}&courseId=${q.course.courseId}&quizId=${q.quizId}">Do quiz</a></li>
                                                                            </ul>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-5" style="margin-left: auto;margin-top: 45px">
                            <div class="card" style="width:400px;position: sticky;top:0">
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
                                        <p class="card-text"><strong>End date:</strong> ${cd.classes.endDate}</p>
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

                <!-- Modal new quiz -->
                <div class="modal fade" id="newModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
                    <div class="modal-dialog">
                        <div class="modal-content" style="width: 700px;">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">New Quiz</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="insertQuiz" method="post">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="mb-3">
                                                <label for="title" class="form-label">Title</label>
                                                <input type="text" id="title" name="title" class="form-control" maxlength="10" required="">
                                                <input type="text"  name="courseId" class="form-control" value="${cd.course.courseId}" style="display:none">
                                                <input type="text"  name="classId" class="form-control" value="${cd.classes.classId}" style="display:none">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="attemptTime" class="form-label">Attempt Time</label>
                                                <input type="number" id="attemptTime" name="attemptTime" placeholder="Min 1" class="form-control" min="1" required="">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="description" class="form-label">Description</label>                               
                                            <input type="text" id="description" name="description" class="form-control" maxlength="30" required="">                                                                 
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="startDate" class="form-label">Start Date</label>
                                                <input type="datetime-local" id="startDate" name="startDate" class="form-control" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="endDate" class="form-label">End Date</label>                               
                                                <input type="datetime-local" id="endDate" name="endDate" class="form-control" min="startDate" required="">                                                                 
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3" style="display: grid;">
                                                <label for="attemptTime" class="form-label">Status</label>
                                                <div class="from-status" style="display:flex;">
                                                    <div class="form-check form-check-inline">
                                                        <input type="radio" id="deactive" name="status" value="0" class="form-check-input" required="">
                                                        <label for="deactive" class="form-check-label">Private</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input type="radio" id="active" name="status" value="1" class="form-check-input">
                                                        <label for="active" class="form-check-label">Public</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="duration" class="form-label">Duration</label>
                                                <div style="display:flex;">
                                                    <select class="form-select" aria-label="duration" id="durationUnit" name="durationUnit">
                                                        <option value="second">Second</option>
                                                        <option value="minutes">Minutes</option>
                                                    </select>
                                                    <input type="number" min="1" class="form-control" id="durationValue" name="durationValue" />
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                        <input type="submit" value="INSERT QUIZ">
                                        <a type="button" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px" data-bs-dismiss="modal">Cancel</a>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
                <script>
                    // Lấy tham chiếu đến các phần tử input
                    var startDateInput = document.getElementById('startDate');
                    var endDateInput = document.getElementById('endDate');

                    // Lấy ngày và giờ hiện tại
                    var currentDate = new Date();
                    currentDate.setUTCHours(currentDate.getUTCHours() + 7);
//                                        currentDate.setSeconds(0); // Đặt giây bằng 0 để loại bỏ giây

                    // Cài đặt giá trị tối thiểu cho ngày bắt đầu là ngày và giờ hiện tại
                    startDateInput.min = currentDate.toISOString().slice(0, -8);

                    // Thêm sự kiện change cho ngày bắt đầu
                    startDateInput.addEventListener('change', function () {
                        // Cập nhật giá trị tối thiểu cho ngày kết thúc bằng ngày bắt đầu
//                        endDateInput.min = startDateInput.value;
                        var startDateValue = new Date(startDateInput.value);

                        // Tính toán ngày sau 1 ngày (24 giờ) của ngày bắt đầu
                        var endDateMin = new Date(startDateValue.getTime() + 24 * 60 * 60 * 1000); // 24 giờ * 60 phút * 60 giây * 1000 milliseconds/giây

                        // Cài đặt giá trị tối thiểu cho ngày và giờ kết thúc
                        endDateInput.min = endDateMin.toISOString().slice(0, -8);
                    });
                </script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <!-- Modal delete -->
                <c:forEach var="q" items="${quiz}">
                    <div class="modal fade" id="deleteModal${q.quizId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
                        <div class="modal-dialog">
                            <div class="modal-content" style="width: 500px;">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Quiz</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="deleteQuiz" method="post">
                                        <input type="text" id="courseId" name="courseId" class="form-control" value="${q.course.courseId}" hidden="" >
                                        <input type="text" id="classId" name="classId" class="form-control" value="${q.classes.classId}" hidden="" >
                                        <input type="text" id="quizId" name="quizId" class="form-control" value="${q.quizId}" hidden="">
                                        <!--<input type="text" id="totalQuestion" name="totalQuestion" class="form-control" value="" hidden="">-->

                                        Are you sure to delete this quiz?<br><!-- comment -->
                                        This action can not undo<br><!-- comment -->
                                        <div class="modal-footer">
                                            <input type="submit" value="DELETE" style="height: 45px;">
                                            <a href="" data-bs-dismiss="modal" aria-label="Close" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:redirect url="home" />
            </c:otherwise>
        </c:choose>
    </body>
</html>
