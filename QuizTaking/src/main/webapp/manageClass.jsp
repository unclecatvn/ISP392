<%-- 
    Document   : manageClass
    Created on : Oct 4, 2023, 12:57:49 AM
    Author     : HoaiNam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Class</title>
        <link rel="shortcut icon" type="image/png" href="./assets/img/favicon.png"/>
        <link rel="stylesheet" href="./css/manageClass.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>
        ${classId}
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-4 px-0 d-none d-sm-block">
                    <%@include file="sidebar.jsp" %> 
                </div>             
                <div class="col-sm-8 px-0 d-none d-sm-block" style="margin-left: 300px;margin-top: 30px;">

                    <h1>Manage Class</h1>
                    <hr>

                    <div class="mt-4">
                        <h3>Insert</h3> 
                        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form action="insertclass" method="post" onsubmit="return checkClass()">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="className" class="form-label">Class Name</label>
                                            <input type="text" id="className" name="className" class="form-control" maxlength="30" onkeyup="checkClass()" required="">
                                            <p id="force">FORMAT: IS1701 || SE1233 || IOT1233</p>
                                            <small id="warningN"></small>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="startDate" class="form-label">Start Date</label>                               
                                            <input type="date" id="startDate" name="startDate" class="form-control" required="">                                                                 
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="endDate" class="form-label">End Date</label>                               
                                            <input type="date" id="endDate" name="endDate" class="form-control" required="">
                                            <small id="warningD"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${mess}</b></div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="UPDATE CLASS" id="submitBtn" disabled="">
                                    <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        function checkClass() {
                            var className = document.getElementById("className").value;
                            var startDate = document.getElementById("startDate").value;
                            var endDate = document.getElementById("endDate").value;
                            var submitBtn = document.getElementById("submitBtn");
                            var regex = /^[A-Z]{2,4}[0-9]{3,5}?$/;
                            var requirementMetN = true;
                            var requirementMetD = true;
                            var listClassName = [
                        <c:forEach var="c" items="${listC}">
                                '${c.className}',
                        </c:forEach>
                            ];

                            var startDateField = document.getElementById("startDate");
                            var endDateField = document.getElementById("endDate");

                            // Thêm sự kiện onchange cho trường "startDate"
                            startDateField.addEventListener("change", function () {
                                validateDateRange(startDateField, endDateField);
                            });

                            // Thêm sự kiện onchange cho trường "endDate"
                            endDateField.addEventListener("change", function () {
                                validateDateRange(startDateField, endDateField);
                            });

                            // Hàm kiểm tra ngày
                            function validateDateRange(startField, endField) {
                                var startDateValue = startField.value;
                                var endDateValue = endField.value;
                                if (new Date(startDateValue) >= new Date(endDateValue)) {
                                    document.getElementById("warningD").innerHTML = "Start date must be before end date";
                                    document.getElementById("warningD").style.color = "red";
                                    requirementMetD = false;
                                } else {
                                    document.getElementById("warningD").innerHTML = "";
                                    requirementMetD = true; // Cập nhật lại requirementMetD nếu hợp lệ
                                }
                                // Kiểm tra yêu cầu khi thay đổi bất kỳ trường nào
                                if (requirementMetN && requirementMetD) {
                                    submitBtn.style.backgroundColor = "#F26F21"; // Màu cam
                                    submitBtn.disabled = false;
                                } else {
                                    submitBtn.style.backgroundColor = "gray"; // Màu xám
                                    submitBtn.disabled = true;
                                }
                            }

                            if (listClassName.includes(className)) {
                                document.getElementById("warningN").innerHTML = "This class name has already existed";
                                document.getElementById("warningN").style.color = "red";
                                requirementMetN = false;
                            } else {
                                document.getElementById("warningN").innerHTML = "";
                            }

                            if (regex.test(className)) {
                                document.getElementById("force").style.color = "green";
                            } else {
                                document.getElementById("force").style.color = "gray";
                                requirementMetN = false;
                            }
                        }

                    </script>

                    <div class="mt-4">
                        <h3>View Class</h3> 
                        <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>${deletemess}</b></div>
                        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <table class="table table-striped" style="--bs-table-bg: #F8F5F5">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Class Name</th>
                                        <th scope="col">Start Date</th>
                                        <th scope="col">End Date</th>
                                        <th scope="col">Modify</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${listC}">
                                        <tr>
                                            <th scope="row">${c.classId}</th>
                                            <td>${c.className}</td>
                                            <td>${c.startDate}</td>
                                            <td>${c.endDate}</td>
                                            <td>
                                                <c:set var="allowDelete" value="false"></c:set>
                                                <c:forEach var="ct" items="${listT}">
                                                    <c:if test="${ct.classId eq c.classId}">
                                                        <c:set var="allowDelete" value="true"></c:set>
                                                    </c:if>
                                                </c:forEach>
                                                <c:choose>
                                                    <c:when test="${allowDelete eq true}">
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#updateModal${c.classId}"><i class='bx bxs-edit'></i></a>
                                                        <a class="link-underline link-underline-opacity-0" type="button" data-bs-toggle="modal" data-bs-target="#insertModal${c.classId}">| Insert Course |</a>
                                                        <a class="link-underline link-underline-opacity-0" data-bs-toggle="modal" data-bs-target="#classView" data-course-id="${c.classId}" onclick="showClassList(this);">| List course</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#updateModal${c.classId}"><i class='bx bxs-edit'></i></a>
                                                        <a type="button" data-bs-toggle="modal" data-bs-target="#deleteModal${c.classId}" data-course-id="${c.classId}"><i class='bx bx-trash'></i></a>
                                                        <a class="link-underline link-underline-opacity-0" type="button" data-bs-toggle="modal" data-bs-target="#insertModal${c.classId}">| Insert Course |</a>
                                                        <a class="link-underline link-underline-opacity-0" data-bs-toggle="modal" data-bs-target="#classView" data-course-id="${c.classId}" onclick="showClassList(this);">| List course</a>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:set var="classId" value="${c.classId}" /> 
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
        <!-- Popup -->
        <div class="modal fade" id="classView" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header justify-content-center">
                        <h5 class="modal-title" id="exampleModalLabel">COURSE LIST</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <thead class="justify-content-center align-items-center">
                                <tr class="justify-content-center align-items-center">
                                    <th scope="col">Course Id</th>
                                    <th scope="col-md-2">Course Name</th>
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
                                                                var classId = link.getAttribute('data-course-id');
                                                                var modal = $('#classView');
                                                                // Xóa danh sách lớp hiện tại (nếu có)
                                                                modal.find('#classListBody').empty();
                                                                // Sử dụng AJAX để tải danh sách lớp từ servlet
                                                                $.ajax({
                                                                    type: 'get',
                                                                    url: 'listcourseofclass', // URL của servlet
                                                                    data: {classId: classId},
                                                                    dataType: 'json',
                                                                    success: function (data) {
                                                                        // Xử lý dữ liệu trả về từ servlet
                                                                        var classListHtml = '';
                                                                        data.forEach(function (cls) {
                                                                            classListHtml += '<tr>';
                                                                            classListHtml += '<th scope="row">' + cls.course.courseId + '</th>';
                                                                            classListHtml += '<th scope="row"><a href="assignuser?courseId=' + cls.course.courseId + '&classId=' + cls.classes.classId + '" >' + cls.course.courseName + '</a></th>';
//                                                                classListHtml += '<td><a href="courseDetail?classId=' + cls.classes.classId + '&courseId=' + cls.course.courseId + '">Go to Class</a></td>';

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

        <!--Delete Modal-->
        <c:forEach var="c" items="${listC}"> 
            <div class="modal fade" id="deleteModal${c.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 500px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Class</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="deleteclass" method="post">
                                <input type="text" id="classId" name="classId" class="form-control" value="${c.classId}" hidden="">

                                Are you sure you want to delete this course?<br><!-- comment -->
                                ${c.classId} - ${c.className}<br> 
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

        <!-- Edit Modal -->
        <c:forEach var="c" items="${listC}"> 
            <div class="modal fade" id="updateModal${c.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 700px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Update Class</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="updateclass" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <input type="text" value="${c.classId}" name="classId" hidden="">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="className" class="form-label">Class Name</label>
                                            <input type="text" id="className" name="className" class="form-control" value="${c.className}" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="startDate" class="form-label">Start Date</label>                               
                                            <input type="date" id="startDate" name="startDate" value="${c.startDate}" class="form-control">                                                                 
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="endDate" class="form-label">End Date</label>                               
                                            <input type="date" id="endDate" name="endDate" value="${c.endDate}" class="form-control">                                                                 
                                        </div>
                                    </div>
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>*Successfully updated course</b></div>

                                <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                    <input type="submit" value="UPDATE CLASS">
                                    <a class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Insert Course Modal -->
        <c:forEach var="c" items="${listC}"> 
            <div class="modal fade" id="insertModal${c.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 700px;">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Insert Course of Class: ${c.classId}. ${c.className}</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="insertcourseintoclass" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <input type="text" value="${c.classId}" name="classId" hidden="">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="className" class="form-label">Course</label>
                                            <select class="form-label form-control" name="course" id="teacher" style="width: 150px;margin-right: 50px;" required>
                                                <option class="form-label" value="" selected disabled hidden>All Course</option>
                                                <c:forEach items="${listCourse}" var="co">
                                                    <option class="form-label" value="${co.courseId}">${co.courseId}- ${co.courseName}</option>
                                                </c:forEach>
                                            </select> 
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="startDate" class="form-label">Student</label>                               
                                            <select class="form-label form-control" name="student" id="teacher" style="width: 150px;margin-right: 50px;" required>
                                                <option class="form-label" value="" selected disabled hidden>All Student</option>
                                                <c:forEach items="${listSt}" var="t">
                                                    <option class="form-label" value="${t.userId}">${t.userId}.${t.rollNumber} - ${t.userName}</option>
                                                </c:forEach>
                                            </select>                                                                     
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="endDate" class="form-label">Teacher</label>                               
                                            <select class="form-label form-control" name="teacher" id="teacher" style="width: 150px;margin-right: 50px;" required>
                                                <option class="form-label" value="" selected disabled hidden>All Teacher</option>
                                                <c:forEach items="${listTe}" var="t">
                                                    <option class="form-label" value="${t.userId}">${t.userId}.${t.rollNumber} - ${t.userName}</option>
                                                </c:forEach>
                                            </select>                                                                 
                                        </div>
                                    </div>
                                </div>

                                <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                    <input type="submit" value="INSERT">
                                    <a class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
    </body>
</html>
