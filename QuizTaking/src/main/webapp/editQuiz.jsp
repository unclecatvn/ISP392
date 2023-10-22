<%-- 
    Document   : editQuiz
    Created on : Oct 5, 2023, 1:23:54 AM
    Author     : HoaiNam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Quiz</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/doQuiz.css"/>
    </head>
    <body style="background-color: #F7F7F7">
        <c:if test="${sessionScope.user == null}">
            <c:redirect url="login-google" />
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <%@include file="header.jsp" %>
            <div class="container-fluid" style="margin-top: 30px">
                <div class="row">
                    <div class="col-sm-6 px-0 d-none d-sm-block">
                        <div class="" style="margin-left: 45px;">
                            <h4><a href="">Home / Quiz</a></h4>
                        </div>
                        <div class="container" style="background-color: white; padding: 25px; border-radius: 10px;margin-left: 45px;max-width: 700px;">

                            <h2>Quiz Information</h2>
                            <hr>
                            <form action="editQuiz" method="post">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="title" class="form-label">Title</label>
                                            <input type="text" id="title" name="title" class="form-control" maxlength="30" value="${q.title}" required="">
                                            <input type="text" id="quizId" name="quizId" class="form-control" maxlength="30" value="${q.quizId}" required="" hidden="">
                                            <input type="text" id="quizId" name="classId" class="form-control" maxlength="30" value="${q.classes.classId}" required="" hidden="">
                                            <input type="text" id="quizId" name="courseId" class="form-control" maxlength="30" value="${q.course.courseId}" required="" hidden="">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="attemptTime" class="form-label">Attempt Time</label>
                                            <input type="number" min="1"  id="attemptTime" name="attemptTime" class="form-control" maxlength="30" value="${q.attemptTime}" required="">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>                               
                                        <input type="text" id="description" name="description" class="form-control" value="${q.description}" required="">                                                                 
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="startDate" class="form-label">Start Date</label>
                                            <input type="datetime-local" id="startDate" name="startDate" class="form-control" maxlength="30" value="${q.startDate}" required="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="endDate" class="form-label">End Date</label>                               
                                            <input type="datetime-local" id="endDate" name="endDate" class="form-control" value="${q.endDate}" required="">                                                       
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3" style="display: grid;">
                                            <label for="attemptTime" class="form-label">Status</label>
                                            <div class="from-status" style="display:flex;">
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="deactive" name="status" value="0" class="form-check-input" ${q.status == false ? "checked" : ""} required="">
                                                    <label for="deactive" class="form-check-label">Private</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="active" name="status" value="1" class="form-check-input" ${q.status == true ? "checked" : ""} required="">
                                                    <label for="active" class="form-check-label">Public</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="duration" class="form-label">Duration</label>
                                            <div style="display:flex;">
                                                <select class="form-select" aria-label="duration" id="durationUnit" name="durationUnit" required="">
                                                    <option value="second" ${q.duration == second ? "selected" : ""}>Second</option>
                                                    <option value="minutes" ${q.duration == minutes ? "selected" : ""}>Minutes</option>
                                                </select>
                                                <input type="number" min="1" placeholder="Min 1" class="form-control" id="durationValue" name="durationValue" value="${q.duration}" />
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${mess}</b></div>

                                <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                    <input type="submit" value="UPDATE QUIZ">
                                </div>
                            </form>
                            <script>
                                // Lấy tham chiếu đến các phần tử input
                                var startDateInput = document.getElementById('startDate');
                                var endDateInput = document.getElementById('endDate');

                                function convertToVietnamTime(date) {
                                    var vietnamTime = new Date(date);
                                    vietnamTime.setHours(vietnamTime.getHours() + 7);
                                    return vietnamTime;
                                }

                                // Lấy ngày và giờ hiện tại
                                var currentDate = convertToVietnamTime(new Date());

//                                console.log(Date);
                                // Cài đặt giá trị tối thiểu cho ngày bắt đầu là ngày và giờ hiện tại
                                var startDateValue = new Date("${q.startDate}"); // Lấy giá trị start date từ dữ liệu

                                // Kiểm tra nếu ngày bắt đầu lớn hơn ngày hiện tại, thì cài đặt giá trị tối thiểu là ngày hiện tại
                                if (startDateValue > currentDate) {
                                    startDateInput.min = currentDate.toISOString().slice(0, -8);
                                } else {
                                    startDateInput.min = startDateValue.toISOString().slice(0, -8);
                                }

                                // Thêm sự kiện change cho ngày bắt đầu
                                startDateInput.addEventListener('change', function () {
                                    // Cài đặt giá trị tối thiểu cho ngày kết thúc là ngày bắt đầu
                                    endDateInput.min = startDateInput.value;
                                });

                                // Thêm sự kiện change cho ngày kết thúc
                                endDateInput.addEventListener('change', function () {
                                    // Lấy giá trị của ngày bắt đầu và ngày kết thúc
                                    var startDateValue = new Date(startDateInput.value);
                                    var endDateValue = new Date(endDateInput.value);

                                    // Kiểm tra nếu ngày kết thúc nhỏ hơn ngày bắt đầu, thì đặt ngày kết thúc bằng ngày bắt đầu
                                    if (endDateValue < startDateValue) {
                                        endDateInput.value = startDateInput.value;
                                    }
                                });

                            </script>
                        </div>

                    </div>  
                    <div class="col-sm-6 px-0 d-none d-sm-block">
                        <div class="container" style="background-color: white; padding: 25px; border-radius: 10px;margin-right: 45px;width: 700px; height: 580px;">
                            <div class="title-question" style="display:flex; justify-content: space-between;align-items: center;">
                                <h2>Question
                                    <span>
                                        <button type="button" class="btn btn-danger" >${totalQuestion}</button>
                                    </span></h2>
                                <div>
                                    <button type="button" class="button-banking btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal" > Import Banking/Excel</button>
                                    <button type="button" class="button-fix btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal" > Add Question</button>
                                </div>
                            </div>
                            <p style="color: red">${in}</p>
                            <hr>
                            <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;height:430px; overflow: auto;">
                                <!--Question-->

                                <c:forEach var="listQ" items="${questionList}" varStatus="question">
                                    <li class="showQuestion">
                                        <div class="showQuestionTitle">
                                            <div class="titleQuestion" style="width: 150px;">
                                                <a style="margin-left: 10px;">

                                                    <span class="link-name">Question ${question.index + 1}</span>

                                                </a>
                                                <!--<button type="button" class="btn" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" disabled>5đ</button>-->
                                            </div>
                                            <div class="actionQuestion">
                                                <a href="#" type="button" class="link-underline link-underline-opacity-0 btn btn-light" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem;" data-bs-toggle="modal" data-bs-target="#editModal">Edit</a>
                                                <a href="#" type="button" data-bs-toggle="modal" data-bs-target="#deleteModal${listQ.questionId}" data-course-id="${listQ.questionId}" class="link-underline link-underline-opacity-0 btn btn-light" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem;">Delete</a> 
                                            </div>                                
                                            <i class='bx bx-chevron-down dropdown-icon' style="margin-right: 10px;"></i>
                                        </div>
                                        <ul class="sub-menu">
                                            <div class="sub-menuQuestion col-md-12">
                                                <p style="margin-bottom: 5px;" class="link-name"><b>${listQ.name}</b></p>
                                                        <c:set var="answerIndex" value="0" scope="page" />
                                                        <c:forEach var="listA" items="${answerList}" varStatus="answerList" >
                                                            <c:if test="${listA.question.questionId == listQ.questionId}">
                                                                <c:set var="answerIndex" value="${answerIndex + 1}" scope="page" />
                                                                <c:if test="${listA.answerCheck == true}">
                                                            <p style="color: red"><b>${Character.toString(answerIndex + 64)}. ${listA.answer}</b></p> 
                                                        </c:if>
                                                        <c:if test="${listA.answerCheck == false}">
                                                            <p>${Character.toString(answerIndex + 64)}. ${listA.answer}</p> 
                                                        </c:if>

                                                    </c:if>


                                                </c:forEach>

                                                <p style="color: green">EXPLAIN:
                                                    <c:set var="previousExplain" value="" />
                                                    <c:forEach var="listA" items="${answerList}" varStatus="answerStatus">
                                                        <c:if test="${listA.question.questionId == listQ.questionId}">
                                                            <c:if test="${not empty listA.explain and !listA.explain.equals(previousExplain)}">
                                                                <span style="color: green">${listA.explain}</span>
                                                                <c:set var="previousExplain" value="${listA.explain}" />
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>

                                                </p>
                                            </div>
                                        </ul>
                                    </li>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </div>
            </div>                                   


            <!-- Modal insert Question -->
            <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 700px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Add Question</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="insertQuestion" method="post">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="question" class="form-label">Question</label>
                                            <input type="text" name="quizId" value="${q.quizId}" hidden="">
                                            <input type="text" name="classId" value="${q.classes.classId}" hidden="">
                                            <input type="text" name="courseId" value="${q.course.courseId}" hidden="">
                                            <textarea id="question" name="question" placeholder="Please enter your question" class="form-control" aria-label="With textarea" required=""></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <div style="display: inline-flex;align-items: center; margin-bottom: 10px;">
                                                <label for="answersQuestion" class="form-label">Answers</label>   
                                                <select style="margin-left:10px;" id="questionType" class="form-select form-select-sm" aria-label="Small select example" name="questionType">
                                                    <option selected value="Select insert question">Select insert question</option>
                                                    <option value="False">Single Choice</option>
                                                    <option value="True">Multiple Choice</option>
                                                </select>
                                                <button style="margin-left:5px;" id="addAnswerButton" class="btn btn-primary" type="button">Insert</button>
                                                <button style="margin-left:5px;" id="deleteAnswerButton" class="btn btn-primary" type="button">Delete</button>

                                            </div>

                                        </div>
                                    </div>
                                    <p>
                                        <span>
                                            Total Answer: <input type="text" id="answerCount" name="answerCount" value="${answerCount}" readonly style="width: 100px">
                                            Correct Answer: <input type="text" id="checkboxCount" name="checkboxCount" value="${checkboxCount}" readonly style="width: 100px">
                                        </span>
                                    </p>                                    
                                    <div id="answerContainer" class="answerContainer">

                                        <!-- Các input answers sẽ được thêm vào đây -->
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <textarea id="Explain" name="explain" class="explain form-control" placeholder="Explain your answer" style="display: none;"></textarea>
                                        </div>

                                    </div>

                                    <!-- Thêm select cho option 2 -->
                                    <!--<div >-->
                                    <select class="form-select form-select-sm" aria-label="Small select example" id="multipleChoiceOptions" style="display: none;">
                                        <option value="1">0%</option>
                                        <option value="2">10%</option>
                                        <option value="3">20%</option>
                                        <option value="4">25%</option>
                                        <option value="5">30%</option>
                                        <option value="6">33%</option>
                                        <option value="8">50%</option>
                                    </select>
                                    <!--</div>-->
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger">
                                    <b id="messAnswer"></b>
                                </div>

                                <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                    <input type="submit" value="ADD QUESTION" id="addQuestionButton">
                                    <a type="button" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>

            <c:forEach var="ListQ" items="${questionList}"> 
                <div class="modal fade" id="deleteModal${ListQ.questionId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
                    <div class="modal-dialog">
                        <div class="modal-content" style="width: 500px;">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Course</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="deleteQuestion" method="post">
                                    <input type="text" id="questionId" name="questionId" class="form-control" value="${ListQ.questionId}" hidden=""> 
                                    <input type="text" name="quizId" value="${q.quizId}" hidden="">
                                    <input type="text" name="classId" value="${q.classes.classId}" hidden="">
                                    <input type="text" name="courseId" value="${q.course.courseId}" hidden="">
                                    Are you sure you want to delete this question?<br><!-- comment -->
                                    ${ListQ.questionId}
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

            <!-- Modal edit Question -->
            <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 700px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Edit Question</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="editQuestion" method="post">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="question" class="form-label">Question</label>
                                            <input type="text" name="quizId" value="${q.quizId}" hidden="">
                                            <input type="text" name="classId" value="${q.classes.classId}" hidden="">
                                            <input type="text" name="courseId" value="${q.course.courseId}" hidden="">
                                            <textarea id="questionEdit" name="questionEdit" placeholder="Please enter your question" class="form-control" aria-label="With textarea" required=""></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <div style="display: inline-flex;align-items: center; margin-bottom: 10px;">
                                                <label for="answersQuestionEdit" class="form-label">Answers</label>   
                                                <select style="margin-left:10px;" id="questionTypeEdit" class="form-select form-select-sm" aria-label="Small select example" name="questionTypeEdit">
                                                    <option selected value="Select insert question">Select insert question</option>
                                                    <option value="False">Single Choice</option>
                                                    <option value="True">Multiple Choice</option>
                                                </select>
                                                <button style="margin-left:5px;" id="addAnswerButtonEdit" class="btn btn-primary" type="button">Insert</button>
                                                <button style="margin-left:5px;" id="deleteAnswerButtonEdit" class="btn btn-primary" type="button">Delete</button>

                                            </div>

                                        </div>
                                    </div>
                                    <p>
                                        <span>
                                            Total Answer: <input type="text" id="answerCountEdit" name="answerCountEdit" value="${answerCount}" readonly style="width: 100px">
                                            Correct Answer: <input type="text" id="checkboxCountEdit" name="checkboxCountEdit" value="${checkboxCount}" readonly style="width: 100px">
                                        </span>
                                    </p>                                    
                                    <div id="answerContainerEdit" class="answerContainer">

                                        <!-- Các input answers sẽ được thêm vào đây -->
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <textarea id="Explain" name="explainEdit" class="explain form-control" placeholder="Explain your answer" style="display: none;"></textarea>
                                        </div>

                                    </div>

                                    <!-- Thêm select cho option 2 -->
                                    <!--<div >-->
                                    <select class="form-select form-select-sm" aria-label="Small select example" id="multipleChoiceOptions" style="display: none;">
                                        <option value="1">0%</option>
                                        <option value="2">10%</option>
                                        <option value="3">20%</option>
                                        <option value="4">25%</option>
                                        <option value="5">30%</option>
                                        <option value="6">33%</option>
                                        <option value="8">50%</option>
                                    </select>
                                    <!--</div>-->
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger">
                                    <b id="messAnswer"></b>
                                </div>

                                <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                    <input type="submit" value="ADD QUESTION" id="addQuestionButtonEdit">
                                    <a type="button" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            <script src="js/editQuiz.js"></script>
            <script src="js/editQuestion.js"></script>
        </c:if>

    </body>
</html>
