<%-- 
    Document   : doQuiz
    Created on : Oct 11, 2023, 10:08:09 AM
    Author     : HoaiNam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Do Quiz</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/viewQuiz.css"/>
        <script>
            var quizDurationInSeconds = ${quiz.duration};
            function updateCountdownTimer(hours, minutes, seconds) {
                var timerElement = document.getElementById("countdownTimer");
                timerElement.textContent = "Time remaining: " + hours + "h " + minutes + "m " + seconds + "s";
            }

            function countdown(seconds, callback) {
                var totalSeconds = seconds;
                var timer = setInterval(function () {
                    var hours = Math.floor(totalSeconds / 3600);
                    var remainingSeconds = totalSeconds % 3600;
                    var minutes = Math.floor(remainingSeconds / 60);
                    var seconds = remainingSeconds % 60;

                    updateCountdownTimer(hours, minutes, seconds);

                    if (totalSeconds <= 0) {
                        clearInterval(timer);
                        if (typeof callback === 'function') {
                            // Thay đổi hành vi ấn nút "Finish attempt"
                            var finishButton = document.getElementById("finishButton");
                            if (finishButton) {
                                finishButton.click();
                            }
                        }
                    }
                    totalSeconds--;
                    var remainingMinutes = Math.ceil(totalSeconds / 60);
                    document.getElementById("finishTimeInput").value = ${quiz.duration} - seconds; // Chuyển đổi thời gian còn lại thành giây
                }, 1000);
            }

            
            countdown(quizDurationInSeconds, function () {
                // Hành vi khi hết thời gian
                var finishButton = document.getElementById("finishButton");
                if (finishButton) {
                    finishButton.click();
                }
            });
        </script>

        <script>
            // Lưu trạng thái ban đầu của trang
            const initialState = {page: "doQuiz?classId=${classId}&courseId=${courseId}&quizId=${quizId}"}; // Đường dẫn ban đầu


            window.onpopstate = function (event) {
                // Kiểm tra xem người dùng đã quay lại
                if (event.state && event.state.page === "home") {
                    // Chuyển họ về trang chính (home page)
                    window.location.href = "home";
                }
            };


            history.replaceState(initialState, null, window.location.href);


            const homeState = {page: "home"};
            history.pushState(homeState, null, "home");
        </script>


    </head>
    <body style="background-color: #F7F7F7">
        <c:if test="${sessionScope.attemptId == null}">
            <c:redirect url="home" />
        </c:if>
        <c:if test="${sessionScope.attemptId != null}">
            <%@include file="header.jsp" %>
            <!-- Info Box -->
            <!--            <div class="info_box">
                            <div class="info-title"><span>Some Rules of this Quiz</span></div>
                            <div class="info-list">
                                <div class="info">1. You will have only <span>15 seconds</span> per each question.</div>
                                <div class="info">2. Once you select your answer, it can't be undone.</div>
                                <div class="info">3. You can't select any option once time goes off.</div>
                                <div class="info">4. You can't exit from the Quiz while you're playing.</div>
                                <div class="info">5. You'll get points on the basis of your correct answers.</div>
                            </div>
                            <div class="buttons">
                                <button class="quit">Exit Quiz</button>
                                <button class="restart">Continue</button>
                            </div>
                        </div>-->
            <div class="container1 mt-4">
                <div class="row"  style="margin-left: 100px; margin-right: 100px;">
                    <a href="" style="margin-bottom: 10px;">
                        <h3>
                            Home/Class/...../...../.......
                        </h3>
                    </a>
                    <div class="col-md-8">
                        <form action="submitQuiz" method="post" id="submitQuiz">
                            <c:forEach var="listQ" items="${listQuestion}" varStatus="questionNumber">
                                <div class="question mb-4" id="${questionNumber.index + 1}">
                                    <!-- Quiz Box -->
                                    <div class="quiz_box">
                                        <section>
                                            <div class="que_text" style="padding-bottom: 10px;">
                                                <h4><b>Question ${questionNumber.index + 1}:</b>
                                                    <span style="font-size: 18px;">${listQ.name}
                                                        <c:if test="${listQ.type == false}">
                                                            <small style="color: grey">(Single choice): ${listQ.correctAnswer}</small>
                                                        </c:if>
                                                        <c:if test="${listQ.type == true}">
                                                            <small style="color: grey">(Multiple choice): ${listQ.correctAnswer}</small>
                                                        </c:if>
                                                    </span>
                                                </h4>
                                            </div>
                                            <input type="text" name="questionId${questionNumber.index + 1}" value="${listQ.questionId}" hidden="">
                                            <input type="text" name="totalQuestion" value="${quiz.totalQuestion}" hidden="">
                                            <input type="text" name="quizId" value="${quiz.quizId}" hidden="">
                                            <input type="text" name="classId" value="${quiz.classes.classId}" hidden="">
                                            <input type="text" name="courseId" value="${quiz.course.courseId}" hidden="">
                                            <input type="text" name="correctAnswer${questionNumber.index + 1}" value="${listQ.correctAnswer}" hidden="">
                                            <div class="option container">
                                                <c:set var="answerNumber" value="0" scope="page"></c:set>
                                                <c:forEach var="listA" items="${listAnswer}">
                                                    <c:if test="${listA.question.questionId == listQ.questionId}">
                                                        <c:set var="answerNumber" value="${answerNumber + 1}" scope="page"></c:set>
                                                            <div class="option_list">                                                          
                                                                <div class="input-group" style="flex-wrap: unset;">
                                                                    <div class="input-group-text">
                                                                        <input class="form-check-input mt-0" type="checkbox" data-question="${questionNumber.index + 1}" data-max-checked="${listQ.correctAnswer}" value="${listA.answerId}" name="answerQues${questionNumber.index + 1}" onchange="limitCheckboxes(this)">

                                                                </div>                             
                                                                <input type="text" class="button-fix btn btn-primary" value="${Character.toString(answerNumber + 64)}. ${listA.answer}" readonly="">
                                                            </div>
                                                        </div>

                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </c:forEach>
                            <input type="text" name="finishTime" id="finishTimeInput" hidden="">
                        </form>
                        <script>
                            function limitCheckboxes(checkbox) {
                                var questionNumber = checkbox.getAttribute('data-question'); // Lấy số câu hỏi
                                var maxChecked = parseInt(checkbox.getAttribute('data-max-checked')); // Số checkbox tối đa được chọn

                                var checkedCheckboxes = document.querySelectorAll('input[type=checkbox][data-question="' + questionNumber + '"]:checked');

                                if (checkedCheckboxes.length > maxChecked) {
                                    // Nếu số checkbox được chọn vượt quá giới hạn, hủy chọn checkbox cuối cùng
                                    checkbox.checked = false;
                                }
                            }
                        </script>
                    </div>
                    <div class="quizNavigationCol col-md-4">
                        <div class="mb-3">
                            <div class="header-quiz">
                                <div class="title" style="margin-top: 8px;">
                                    <h4><b>${quiz.title}</b></h4>
                                </div>
                                <div class="time" id="countdownTimer"></div>
                            </div>
                            <hr>
                            <div class="quizNavigation">Quiz navigation
                                <p>${sessionScope.attemptQuiz.attemptId}</p>
                                <div class="quizShow">
                                    <c:forEach var="i" begin="1" end="${quiz.totalQuestion}">                                    
                                        <a href="#${i}" type="button" class="quizNavigationShow btn btn-outline-secondary">${i}</a>
                                    </c:forEach>
                                </div>
                            </div>
                            <!--<input type="submit" value="Finish attempt" form="submitQuiz">-->
                            <a type="button" href="" data-bs-toggle="modal" data-bs-target="#submitModal" >Finish attempt</a>

                        </div>
                    </div>
                </div>
            </div>
            <!--Popup ask user-->
            <div class="modal fade" id="submitModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 500px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Quiz</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure want to submit quiz.
                            This action can not undo

                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Finish attempt" form="submitQuiz" id="finishButton">
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </body>
</html>
