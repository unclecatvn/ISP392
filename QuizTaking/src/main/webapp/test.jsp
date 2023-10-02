<%-- 
    Document   : test
    Created on : Sep 19, 2023, 11:18:39 PM
    Author     : HoaiNam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://accounts.google.com/gsi/client" async></script>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    </head>
    <style>
        /* sidebar section */
        /* sidebar is altered from CodingLab tutorial as per need */
        /* https://www.youtube.com/watch?v=wEfaoAa99XY&ab_channel=CodingLab */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .sidebar{
            position: fixed;
            left: 0;
            top: 0;
            height: 100%;
            width: 78px;
            background: #11101D;
            padding: 6px 14px;
            z-index: 99;
            transition: all 0.5s ease;
            font-family: "Poppins" , sans-serif;
        }

        .sidebar.open{
            width: 250px;
        }

        .sidebar .logo-details{
            height: 60px;
            display: flex;
            align-items: center;
            position: relative;
        }

        .sidebar .logo-details .icon{
            opacity: 0;
            transition: all 0.5s ease;
        }

        .sidebar .logo-details .logo_name{
            color: #fff;
            font-size: 20px;
            font-weight: 600;
            opacity: 0;
            transition: all 0.5s ease;
        }

        .sidebar.open .logo-details .icon,
        .sidebar.open .logo-details .logo_name{
            opacity: 1;
        }

        .sidebar .logo-details #btn{
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            font-size: 22px;
            transition: all 0.4s ease;
            font-size: 23px;
            text-align: center;
            cursor: pointer;
            transition: all 0.5s ease;
        }

        .sidebar.open .logo-details #btn{
            text-align: right;
        }

        .sidebar i{
            color: #fff;
            height: 60px;
            min-width: 50px;
            font-size: 28px;
            text-align: center;
            line-height: 60px;
        }

        .sidebar .nav-list{
            margin-top: 20px;
            height: 100%;
        }

        .sidebar li{
            position: relative;
            margin: 8px 0;
            list-style: none;
        }

        .sidebar li .tooltip{
            position: absolute;
            top: -20px;
            left: calc(100% + 15px);
            z-index: 3;
            background: #fff;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 400;
            opacity: 0;
            white-space: nowrap;
            pointer-events: none;
            transition: 0s;
        }

        .sidebar li:hover .tooltip{
            opacity: 1;
            pointer-events: auto;
            transition: all 0.4s ease;
            top: 50%;
            transform: translateY(-50%);
        }

        .sidebar.open li .tooltip{
            display: none;
        }

        .sidebar input{
            font-size: 15px;
            color: #FFF;
            font-weight: 400;
            outline: none;
            height: 50px;
            width: 100%;
            width: 50px;
            border: none;
            border-radius: 12px;
            transition: all 0.5s ease;
            background: #1d1b31;
        }

        .sidebar.open input{
            padding: 0 20px 0 50px;
            width: 100%;
        }

        .sidebar .bx-search{
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            font-size: 22px;
            background: #1d1b31;
            color: #FFF;
        }

        .sidebar.open .bx-search:hover{
            background: #1d1b31;
            color: #FFF;
        }

        .sidebar .bx-search:hover{
            background: #FFF;
            color: #11101d;
        }

        .sidebar li a{
            display: flex;
            height: 100%;
            width: 100%;
            border-radius: 12px;
            align-items: center;
            text-decoration: none;
            transition: all 0.4s ease;
            background: #11101D;
        }

        .sidebar li a:hover{
            background: #FFF;
        }

        .sidebar li a .links_name{
            color: #fff;
            font-size: 15px;
            font-weight: 400;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: 0.4s;
        }

        .sidebar.open li a .links_name{
            opacity: 1;
            pointer-events: auto;
        }

        .sidebar li a:hover .links_name,
        .sidebar li a:hover i{
            transition: all 0.5s ease;
            color: #11101D;
        }

        .sidebar li i{
            height: 50px;
            line-height: 50px;
            font-size: 18px;
            border-radius: 12px;
        }

        .sidebar li.profile{
            position: fixed;
            height: 60px;
            width: 78px;
            left: 0;
            bottom: -8px;
            padding: 10px 14px;
            background: #1d1b31;
            transition: all 0.5s ease;
            overflow: hidden;
        }

        .sidebar.open li.profile{
            width: 250px;
        }

        .sidebar li .profile-details{
            display: flex;
            align-items: center;
            flex-wrap: nowrap;
        }

        .sidebar li img{
            height: 45px;
            width: 45px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 10px;
        }

        .sidebar li.profile .name,
        .sidebar li.profile .job{
            font-size: 13px;
            font-weight: 400;
            color: #fff;
            white-space: nowrap;
        }

        .sidebar li.profile .job{
            font-size: 9px;
        }

        .sidebar .profile #info{
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            background: #1d1b31;
            width: 100%;
            height: 60px;
            line-height: 60px;
            border-radius: 0px;
            transition: all 0.5s ease;
        }

        .sidebar.open .profile #info{
            width: 50px;
            background: none;
        }

        /* set sidebar settings for required sections */
        .main-content-section{
            position: relative;
            background: #E4E9F7;
            min-height: 100vh;
            top: 0;
            left: 78px;
            width: calc(100% - 78px);
            transition: all 0.5s ease;
            z-index: 2;
            justify-content: center;
            align-items: center;
        }

        .sidebar.open ~ .main-content-section{
            left: 250px;
            width: calc(100% - 250px);
        }

        .main-content-section .text{
            display: inline-block;
            color: #11101d;
            font-size: 25px;
            font-weight: 500;
            margin: 18px
        }

        @media (max-width: 420px) {
            .sidebar li .tooltip{
                display: none;
            }
        }
    </style>
    <body>
        <!-- >>> begin sidebar <<<  -->
        <div class="sidebar">
            <div class="logo-details">
                <i class='bx bx-code-alt icon'></i>
                <div class="logo_name kanit-font">dP's Website</div>
                <i class='bx bx-menu' id="btn"></i>
            </div>

            <ul class="nav-list">
                <li>
                    <a href="home.html">
                        <i class='bx bx-home-alt'></i>
                        <span class="links_name">Home</span>
                    </a>
                    <span class="tooltip">Home</span>
                </li>
                <li>
                    <a href="timeline.html">
                        <i class='bx bxs-institution'></i>
                        <span class="links_name">Education & Work</span>
                    </a>
                    <span class="tooltip">Education & Work</span>
                </li>
                <li>
                    <a href="projects.html">
                        <i class='bx bxs-spreadsheet'></i>
                        <span class="links_name">Projects</span>
                    </a>
                    <span class="tooltip">Projects</span>
                </li>
                <!-- <li>
                  <a href="photography.html">
                    <i class='bx bxs-image'></i>
                    <span class="links_name">Photography</span>
                  </a>
                  <span class="tooltip">Photography</span>
                </li> -->

                <!-- end section of sidebar -->
                <li class="profile">
                    <div class="profile-details">
                        <img src="assets/images/face.jpg" alt="profileImg">
                        <div class="name_job">
                            <div class="name kanit-font"><b>Debmalya Pramanik</b></div>
                            <div class="job">Data Science & Analyst</div>
                        </div>
                    </div>
                    <i class='bx bx-info-circle' id="info"></i>
                </li>
                <li>
                    <a href="contacts.html">
                        <i class='bx bxs-envelope'></i>
                        <span class="links_name">Contact Us</span>
                    </a>
                    <span class="tooltip">Contact Us</span>
                </li>
            </ul>
        </div>
        <script>
            let sidebar = document.querySelector(".sidebar");
            let closeBtn = document.querySelector("#btn");
            closeBtn.addEventListener("click", () => {
                sidebar.classList.toggle("open");
                menuBtnChange();//calling the function(optional)
            });
            function menuBtnChange() {
                if (sidebar.classList.contains("open")) {
                    closeBtn.classList.replace("bx-menu", "bx-menu-alt-right");//replacing the iocns class
                } else {
                    closeBtn.classList.replace("bx-menu-alt-right", "bx-menu");//replacing the iocns class
                }
            }
        </script>
    </body>
</html>
