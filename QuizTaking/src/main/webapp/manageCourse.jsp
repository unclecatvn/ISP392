<%-- 
    Document   : manageCourse
    Created on : Oct 1, 2023, 12:53:43 AM
    Author     : ADMIN
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Course</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/manageCourse.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>

        <div class="container-fluid">

            <div class="row">
                <div class="col-sm-4 px-0 d-none d-sm-block">
                    <%@include file="sidebar.jsp" %>
                    <c:if test="${sessionScope.user == null || sessionScope.user.roleId == 2 ||sessionScope.user.roleId == 3}">
                        <c:redirect url="home" />
                    </c:if>
                </div>             
                <div class="col-sm-8 px-0 d-none d-sm-block" style="margin-left: 300px;margin-top: 30px;">

                    <h1>Manage Course</h1>
                    <hr>

                    <div class="mt-4">
                        <h3>Insert</h3> 
                        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form action="insertCourse" method="post">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="courseName" class="form-label">Course Name</label>
                                            <input type="text" id="courseName" name="courseName" class="form-control"  onkeyup="checkCourseName()" required="">
                                            <p id="force">FORMAT: ISP391 || ISP391c || TRANS601 || TRANS601c</p>
                                            <p id="warning"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="courseDescription" class="form-label">Course Description</label>                               
                                            <input type="text" id="courseDescription" name="courseDescription" class="form-control" required="">                                                                 
                                        </div>
                                    </div>
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${message}</b></div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="INSERT COURSE" id="submitBtn" disabled="">
                                    <a href=""class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                </div>
                            </form>
                            <script>
                                function checkCourseName() {
                                    var courseName = document.getElementById("courseName").value.toUpperCase().trim();
                                    var submitBtn = document.getElementById("submitBtn");
                                    var regex = /^[A-Za-z]{3,5}[0-9]{3}[Cc]?$/;
                                    var requirementsMet = true;
                                    var listCourseName = [
                                <c:forEach var="c" items="${listCourse}">
                                        '${c.courseName.toUpperCase()}',
                                </c:forEach>
                                    ];
                                    if (listCourseName.includes(courseName)) {
                                        document.getElementById("warning").innerHTML = "This course already existed";
                                        document.getElementById("warning").style.color = "red";
                                        requirementsMet = false;
                                    } else {
                                        document.getElementById("warning").innerHTML = "";
                                    }

                                    if (regex.test(courseName)) {
                                        document.getElementById("force").style.color = "green";

                                    } else {
                                        document.getElementById("force").style.color = "gray";
                                        requirementsMet = false;
                                    }

                                    if (requirementsMet) {
                                        submitBtn.style.backgroundColor = "#F26F21"; // Màu cam
                                        submitBtn.disabled = false;
                                    } else {
                                        submitBtn.style.backgroundColor = "gray"; // Màu xám
                                        submitBtn.disabled = true;
                                    }

                                }
                            </script>
                        </div>
                    </div>

                    <div class="mt-4">
                        <h3>View Course</h3>
                        <p class="">${mess}</p>
                        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <table class="table table-striped" style="--bs-table-bg: #F8F5F5">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Course Name</th>
                                        <th scope="col">Course Description</th>
                                        <th scope="col">Modify</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${listCourse}">                                    
                                        <tr>
                                            <th scope="row">${c.courseId}</th>
                                            <td>${c.courseName}</td>
                                            <td>${c.courseDescription}</td>
                                            <td>
                                                <c:set var="allowDelete" value="false"></c:set>
                                                <c:forEach var="ct" items="${listCourseTaken}">
                                                    <c:if test="${ct.courseId eq c.courseId}">
                                                        <c:set var="allowDelete" value="true"></c:set>
                                                    </c:if>
                                                </c:forEach>
                                                <c:choose>
                                                    <c:when test="${allowDelete eq true}">
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#updateModal" data-course-id="${c.courseId}" onclick="showCourse(this);"><i class='bx bxs-edit'></i></a>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#updateModal" data-course-id="${c.courseId}" onclick="showCourse(this);"><i class='bx bxs-edit'></i></a>
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#deleteModal${c.courseId}" data-course-id="${c.courseId}"><i class='bx bx-trash'></i></a>
                                                        </c:otherwise>
                                                    </c:choose>


                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Edit-->
        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px;">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Update Course</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="updateCourse" method="post">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="courseName" class="form-label">Course Name</label>
                                        <input type="text" id="courseNameEdit" name="courseName" class="form-control" maxlength="30" onkeyup="checkCourseNameEdit()">
                                        <input type="text" id="courseNameCurrent" name="courseNameCurrent" class="form-control" maxlength="30" hidden="">
                                        <input type="text" id="courseId" name="courseId" class="form-control" hidden="">
                                        <p id="forceEdit">FORMAT: ISP391 || ISP391c || TRANS601 || TRANS601c</p>
                                        <p id="warningEdit"></p>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="courseDescription" class="form-label">Course Description</label>                               
                                        <input type="text" id="courseDescription" name="courseDescription" class="form-control">                                                                 
                                    </div>
                                </div>
                            </div>
                            <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                <input type="submit" value="UPDATE Course" id="submitBtne" disabled="">
                                <a href="" data-bs-dismiss="modal" aria-label="Close" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                            </div>
                            <script>
                                function checkCourseNameEdit() {
                                    var courseName = document.getElementById("courseNameEdit").value.toUpperCase().trim();
                                    var courseNameCurrent = document.getElementById("courseNameCurrent").value.toUpperCase().trim();
                                    var submitBtn = document.getElementById("submitBtne");
                                    var regex = /^[A-Za-z]{3,5}[0-9]{3}[Cc]?$/;
                                    var requirementsMet = true;
                                    var listCourseName = [
                                <c:forEach var="c" items="${listCourse}">
                                        '${c.courseName.toUpperCase()}',
                                </c:forEach>
                                    ];
                                    if (listCourseName.includes(courseName) && courseNameCurrent !== courseName) {
                                        document.getElementById("warningEdit").innerHTML = "This course already existed";
                                        document.getElementById("warningEdit").style.color = "red";
                                        requirementsMet = false;
                                    } else {
                                        document.getElementById("warningEdit").innerHTML = "";
                                    }

                                    if (regex.test(courseName)) {
                                        document.getElementById("forceEdit").style.color = "green";

                                    } else {
                                        document.getElementById("forceEdit").style.color = "gray";
                                        requirementsMet = false;
                                    }

                                    if (requirementsMet) {
                                        submitBtn.style.backgroundColor = "#F26F21"; // Màu cam
                                        submitBtn.disabled = false;
                                    } else {
                                        submitBtn.style.backgroundColor = "gray"; // Màu xám
                                        submitBtn.disabled = true;
                                    }

                                }
                            </script>
                        </form>

                    </div>

                </div>
            </div>
        </div>
        <script>
            function showCourse(link) {
                var courseId = link.getAttribute('data-course-id');
                var modal = $('#updateModal');
                // Xóa danh sách lớp hiện tại (nếu có)
                //                modal.find('#courseName').empty();
                //                modal.find('#courseDescription').empty();

                // Sử dụng AJAX để tải danh sách lớp từ servlet
                $.ajax({
                    type: 'GET',
                    url: 'updateCourse', // URL của servlet
                    data: {courseId: courseId},
                    dataType: 'json',
                    success: function (data) {
                        // Xử lý dữ liệu trả về từ servlet
                        var courseName = data.courseName;
                        var courseDescription = data.courseDescription;
                        var courseId = data.courseId;
                        // Add the class list HTML to the modal
                        modal.find('#courseNameEdit').val(courseName);
                        modal.find('#courseNameCurrent').val(courseName);
                        modal.find('#courseDescription').val(courseDescription);
                        modal.find('#courseId').val(courseId);
                        // Mở modal
                        modal.modal('show');
                    },
                    error: function (xhr, status, error) {
                        console.error('Error loading class data:', error);
                    }
                });
            }
        </script>


        <!-- Modal delete -->
        <c:forEach var="c" items="${listCourse}"> 
            <div class="modal fade" id="deleteModal${c.courseId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 500px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Course</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="deleteCourse" method="post">
                                <input type="text" id="courseId" name="courseId" class="form-control" value="${c.courseId}" hidden="">

                                Are you sure you want to delete this course?<br><!-- comment -->
                                ${c.courseId} - ${c.courseName} - ${c.courseDescription}<br><!-- comment -->
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
    </body>
</html>
