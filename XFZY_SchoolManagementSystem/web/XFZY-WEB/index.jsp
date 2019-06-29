<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("currentUser") == null)
    {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentRole = session.getAttribute("currentRole").toString();
%>

<!DOCTYPE html>
<html>
<head>
    <base href="./">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="XFZY教学管理系统 - 主页">
    <meta name="author" content="Snow admin@xuefeng.space">
    <meta name="keyword" content="Snow XFZY School Management 教学管理">
    <title>XFZY教学管理系统 - 主页</title>
    <!-- Icons-->
    <link rel="icon" type="image/ico" href="./img/favicon.ico" sizes="any" />
    <link href="vendors/@coreui/icons/css/coreui-icons.min.css" rel="stylesheet">
    <link href="vendors/flag-icon-css/css/flag-icon.min.css" rel="stylesheet">
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application-->
    <link href="css/style.css" rel="stylesheet">
    <link href="vendors/pace-progress/css/pace.min.css" rel="stylesheet">
    <!-- My custom styles-->
    <link href="css/snow_custom.css" rel="stylesheet">
    <style>
        .snow-welcome-text {
            font-family: "-apple-system", BlinkMacSystemFont, "Yu Gothic Medium", "游ゴシック Medium", YuGothic, "游ゴシック体", "Noto Sans Japanese", "ヒラギノ角ゴ Pro W3", "メイリオ", "Hiragino Kaku Gothic ProN", "MS PGothic", Osaka, "sans-serif" !important;
        }
    </style>
</head>

<body class="app header-fixed sidebar-fixed aside-menu-fixed sidebar-lg-show">
<header class="app-header navbar">
    <button class="navbar-toggler sidebar-toggler d-lg-none mr-auto" type="button" data-toggle="sidebar-show">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#">
        <img class="navbar-brand-full" src="img/brand/hunnu_logo_rectangle.gif" width="136.35" height="30" alt="HUNNU Logo">
        <img class="navbar-brand-minimized" src="img/brand/hunnu_logo_rectangle.gif" width="" height="30" alt="HUNNU Logo">
    </a>
    <button class="navbar-toggler sidebar-toggler d-md-down-none" type="button" data-toggle="sidebar-lg-show">
        <span class="navbar-toggler-icon"></span>
    </button>
    <ul class="nav navbar-nav d-md-down-none">
        <li class="ml-3 nav-item px-3">
            <a class="nav-link" href="index.jsp">首页</a>
        </li>
        <li class="nav-item px-3">
            <a class="nav-link" href="#">设置</a>
        </li>
    </ul>
    <ul class="mr-3 nav navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                <img class="img-avatar" src="img/avatars/snow_avatar_50_50.png" alt="admin@xuefeng.space">
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <div class="dropdown-header text-center">
                    <strong>Hi, ${currentUser} !</strong>
                </div>
                <a id="personalInfoButton" class="dropdown-item" href="user_personal_info.jsp">
                    <i class="fa fa-user"></i> 个人信息
                </a>
                <a id="logoutButton" class="dropdown-item" href="logout">
                    <i class="fa fa-lock"></i> 登出
                </a>
            </div>
        </li>
    </ul>
</header>

<div class="app-body">
    <div class="sidebar">
        <nav class="sidebar-nav">
            <ul class="nav">
                <%--                <c:if test="${sessionScope.currentRole == 'admin'}">--%>
                <% if(currentRole.equals("admin")) { %>
                <li class="nav-title">管理员</li>
                <li class="nav-item">
                    <a class="nav-link" href="admin_staff_management.jsp">
                        <i class="nav-icon fa fa-users"></i> 教职工管理
                    </a>
                </li>
                <% } %>

                <% if(currentRole.equals("teacher") || currentRole.equals("admin")) { %>
                <li class="nav-title">教师端</li>
                <li class="nav-item">
                    <a class="nav-link" href="teacher_course_management.jsp">
                        <i class="nav-icon fa fa-book"></i> 课程管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="teacher_class_management.jsp">
                        <i class="nav-icon fa fa-institution"></i> 班级管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="teacher_student_management.jsp">
                        <i class="nav-icon fa fa-child"></i> 学生管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="teacher_fill_score.jsp">
                        <i class="nav-icon fa fa-tachometer"></i> 成绩录入</a>
                </li>
                <% } %>

                <% if(currentRole.equals("student") || currentRole.equals("admin")) { %>
                <li class="nav-title">学生端</li>
                <li class="nav-item">
                    <a class="nav-link" href="student_select_course.jsp">
                        <i class="nav-icon fa fa-crosshairs"></i> 选课</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="student_my_courses.jsp">
                        <i class="nav-icon fa fa-book"></i> 我的课程</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="student_my_score.jsp">
                        <i class="nav-icon fa fa-tachometer"></i> 我的成绩</a>
                </li>
                <% } %>

            </ul>
        </nav>
        <button class="sidebar-minimizer brand-minimizer" type="button"></button>
    </div>
    <main class="main">
        <!-- Breadcrumb-->
        <div class="container-fluid mt-4">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="jumbotron">
                            <h1 class="display-3">Welcome!</h1>
                            <p class="lead snow-welcome-text">欢迎使用XFZY教学管理系统<br>XFZYきょういくかんりシステムへようこそ〜</p>
                            <hr class="my-4">
                            <p>站点由雪峰云强力驱动，已平稳运行<span id="snow-site-since"></span>(●'◡'●)ﾉ</p>

                            <div id="snowAccordion" data-children=".item">
                                <div class="item">
                                    <p class="lead">
                                        <a class="collapsed" data-toggle="collapse" data-parent="#snowAccordion" href="#snowMoreInfoAccordion" aria-expanded="false" aria-controls="snowMoreInfoAccordion" href="#">More <i class="fa fa-angle-down"></i> </a>
                                    </p>
                                    <div class="collapse" id="snowMoreInfoAccordion" role="tabpanel" style="">
                                        <ul class="">
                                            <li>Project Repo: <a target="_blank" href="https://github.com/penguin806/XFZY_SchoolManagementSystem">https://github.com/penguin806/XFZY_SchoolManagementSystem</a> (遵循GPLv3开源协议)</li>
                                            <li>Developer:
                                                <ul>
                                                    <li>湖师大信工院 2016级 李学锋</li>
                                                    <li>湖师大信工院 2016级 张玥</li>
                                                </ul>
                                            </li>
                                            <li>友链:
                                                <ul>
                                                    <li><a target="_blank" href="http://www.hunnu.edu.cn/">湖南师范大学</a></li>
                                                    <li><a target="_blank" href="http://lib.hunnu.edu.cn/">湖南师范大学图书馆</a></li>
                                                    <li><a target="_blank" href="http://www.xuefeng.space/"><s>Xuefeng's Blog</s> 年久失修_(:з」∠)_</a></li>
                                                    <li><a target="_blank" href="https://clientarea.gigsgigscloud.com/?affid=1620">GigsGigsCloud</a></li>
                                                    <li><a target="_blank" href="https://m.do.co/c/ea07d8436bcf">DigitalOcean</a></li>
                                                    <li><a target="_blank" href="https://s.click.taobao.com/t?e=m%3D2%26s%3DF0RSFhWgw6IcQipKwQzePCperVdZeJviEViQ0P1Vf2kguMN8XjClAjaYaRFNAfk8%2FoG8TVwdWCOQX07RK3CGycCFqUaxOL4%2FHavnNbDqUQK8p0JVbL%2Bb8BVF%2BG%2F2LD3qKIUZKvQyk4%2FkxFiXT%2FI5kZuVJ2zJE2c0p3fRQ0ORdflbmmsujxxDvKiBJVMc%2BOMFCM7aOFaXltYhhQs2DjqgEA%3D%3D">阿里云</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                        <p class="mb-3">使用过程中如果遇到问题，请<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=806361380&site=qq&menu=yes">联系管理员</a>。
                                        <br>E-mail: <a target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=GWl2dXhraXx3fmxwd1l-dmF0eHB1N3p2dA" style="text-decoration:none;">admin@xuefeng.space</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<footer class="app-footer">
    <!--<div class="row">-->
    <div class="col-lg-6 col-md-12 text-center text-lg-left p-0">
        <a href="https://github.com/penguin806/XFZY_SchoolManagementSystem">XFZY教学管理系统</a>
        <span> Copyright &copy; 2019 湖师大信工院 李学锋 张玥.</span>
    </div>
    <div class="col-lg-6 d-none d-lg-block text-right p-0">
        <span>前端框架</span>
        <a href="https://coreui.io">CoreUI</a>
        <span>基于Angular & Bootstrap 4</span>
    </div>
    <!--</div>-->
</footer>
<!-- CoreUI and necessary plugins-->
<script src="vendors/jquery/js/jquery.min.js"></script>
<script src="vendors/popper.js/js/popper.min.js"></script>
<script src="vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="vendors/pace-progress/js/pace.min.js"></script>
<script src="vendors/perfect-scrollbar/js/perfect-scrollbar.min.js"></script>
<script src="vendors/@coreui/coreui/js/coreui.min.js"></script>
<!-- Plugins and scripts required by this view-->
<script src="vendors/chart.js/js/Chart.min.js"></script>
<script src="vendors/@coreui/coreui-plugin-chartjs-custom-tooltips/js/custom-tooltips.min.js"></script>
<script src="js/main.js"></script>
<script src="js/snow_custom.js"></script>
<script>
    $(document).ready(
        function () {
            show_date_time();
        }
    );
</script>
</body>
</html>
