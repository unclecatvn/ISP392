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
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-4 px-0 d-none d-sm-block">
                    <%@include file="sidebar.jsp" %> 
                </div>             
                <div class="col-sm-8 px-0 d-none d-sm-block" style="margin-left: 300px;margin-top: 30px;">

                    <h1>Manage Course</h1>
                    <hr>

                    <div class="mt-4">
                        <h3>Insert</h3> 
                        <div class="container" style="background-color: #F8F5F5; padding: 20px; border-radius: 10px;">
                            <form action="userdetail" method="post" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="fullname" class="form-label">Course Name</label>
                                            <input type="text" id="fullname" name="fullname" class="form-control" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="rollnumber" class="form-label">Course Description</label>                               
                                            <input type="text" id="rollnumber" name="rollnumber" class="form-control">                                                                 
                                        </div>
                                    </div>
                                </div>
                                <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>*Successfully updated course</b></div>
                                <div class="" style="display:flex;justify-content: center;margin-top: 10px">
                                    <input type="submit" value="UPDATE PROFILE">
                                    <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="mt-4">
                        <h3>View Course</h3> 
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
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>ISP392</td>
                                        <td>Integrated System Project</td>
                                        <td><a type="button" data-bs-toggle="modal" data-bs-target="#updateModal"><i class='bx bxs-edit'></i></a>
                                            <a type="button" data-bs-toggle="modal" data-bs-target="#deleteModal"><i class='bx bx-trash'></i></a></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>ISP392</td>
                                        <td>Integrated System Project</td>
                                        <td><a type="button" data-bs-toggle="modal" data-bs-target="#updateModal"><i class='bx bxs-edit'></i></a>
                                            <a><i class='bx bx-trash'></i></a></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>ISP392</td>
                                        <td>Integrated System Project</td>
                                        <td><a type="button" data-bs-toggle="modal" data-bs-target="#updateModal"><i class='bx bxs-edit'></i></a>
                                            <a><i class='bx bx-trash'></i></a></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">4</th>
                                        <td>ISP392</td>
                                        <td>Integrated System Project</td>
                                        <td><a type="button" data-bs-toggle="modal" data-bs-target="#updateModal"><i class='bx bxs-edit'></i></a>
                                            <a><i class='bx bx-trash'></i></a></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">5</th>
                                        <td>ISP392</td>
                                        <td>Integrated System Project</td>
                                        <td><a type="button" data-bs-toggle="modal" data-bs-target="#updateModal"><i class='bx bxs-edit'></i></a>
                                            <a><i class='bx bx-trash'></i></a></td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>



        </div>

        <!-- Modal -->
        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-width: 750px;--bs-modal-margin: 5.75rem;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px;">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Update Course</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="userdetail" method="post" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="fullname" class="form-label">Course Name</label>
                                        <input type="text" id="fullname" name="fullname" class="form-control" maxlength="30">
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="rollnumber" class="form-label">Course Description</label>                               
                                        <input type="text" id="rollnumber" name="rollnumber" class="form-control">                                                                 
                                    </div>
                                </div>
                            </div>
                            <div class="d-block mx-4 mb-3 mb-lg-4  text-danger"><b>*Successfully updated course</b></div>

                            <div class="" style="display:flex;justify-content: center;margin-top: 10px;margin-bottom: 20px">
                                <input type="submit" value="UPDATE PROFILE">
                                <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal delete -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="--bs-modal-margin: 5.75rem;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 500px;">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Course</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete the course?
                    </div>
                    <div class="modal-footer">
                        <input type="submit" value="DELETE" style="height: 45px;">
                        <a href="home" class="link-underline link-underline-opacity-0" style="display: flex;align-items: center; color:#B0B0B0; margin-left: 15px">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
