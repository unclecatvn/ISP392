<%-- 
    Document   : viewQuiz
    Created on : Oct 18, 2023, 9:27:32 PM
    Author     : HoaiNam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Quiz</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/editQuiz.css"/>
    </head>
    <body style="background-color: #F7F7F7">
        <%@include file="header.jsp" %>
        <div class="container1 mt-4">
            <div class="row"  style="margin-left: 100px; margin-right: 100px;">
                <a href="" style="margin-bottom: 10px;">
                    <h3>
                        Home/Class/...../...../.......
                    </h3>
                </a>
                <div class="quizNavigationCol col-md-12">
                    <div class="mb-3" style="margin-left: 20px;margin-right: 20px;">
                        <div class="header-quiz">
                            <div class="title">
                                <h2><b>${quiz.title}</b></h2>
                            </div>
                        </div>
                        <div style="text-align: center;">
                            <p>Time limit: ${quiz.duration} mins</p>
                            <p>Max attempt: ${quiz.attemptTime} times</p>
                        </div>
                        <div style="table-score">
                            <h5>Summary of your previous attempts</h5>
                            <table class="table table-striped">
                                <thead class="table-dark" style="--bs-table-bg: #F26F21;--bs-table-border-color:#F26F21">
                                    <tr>
                                        <th scope="col">Attempt</th>
                                        <th scope="col">Total time</th>
                                        <th scope="col">Marks</th>
                                        <th scope="col">Review</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="listA" items="${listAttempt}" varStatus="number">
                                        <tr>
                                            <th scope="row">${number.index + 1}</th>
                                            <td>${listA.finishTime}</td>
                                            <td>${listA.score}</td>
                                            <td><a href="">Review</a></td>
                                        </tr> 
                                    </c:forEach>
                                </tbody>
                            </table>
                            <p class="d-block mx-4 mb-3  text-danger">Highest grade: 10.00 / 10.00.</p>
                            <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                <form action="viewQuiz" method="POST" id="doQuiz">
                                    <input type="text" name="classId" value="${classId}" hidden="">
                                    <input type="text" name="enrollId" value="${enrollId}" hidden="">
                                    <input type="text" name="courseId" value="${courseId}" hidden="">
                                    <input type="text" name="quizId" value="${quizId}" hidden="">
                                </form>
                                <input type="submit" value="DO QUIZ" form="doQuiz">
                                <br><!-- comment -->
                                
                            </div>
                                <p style="color: red; text-align: center">${mess}</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
