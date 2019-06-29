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
    <meta name="description" content="XFZY教学管理系统">
    <meta name="author" content="Snow admin@xuefeng.space">
    <meta name="keyword" content="Snow XFZY School Management 教学管理">
    <title>XFZY教学管理系统 - 个人信息</title>
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
                        <div class="card">
                            <div class="card-header">
                                <i class="fa fa-user-circle"></i> 个人信息
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div id="currentUserInfoContainer" class="col-12 mx-auto">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_userName">用户名</label>
                                                    <input class="form-control" id="edit_userName" type="text" placeholder="" disabled="">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_userPassword">密码</label>
                                                    <input class="form-control" id="edit_userPassword" type="password" placeholder="xxxxxxxxxxxxxx">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_userRealname">姓名</label>
                                                    <input class="form-control" id="edit_userRealname" type="text" placeholder="鹿目圆">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_userEmail">E-mail</label>
                                                    <input class="form-control" id="edit_userEmail" type="text" placeholder="example@xuefeng.space">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="select_user_Info_userinfo_Sex">性别</label>
                                                    <select class="form-control" id="select_user_Info_userinfo_Sex">
                                                        <option value="男">男</option>
                                                        <option value="女">女</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_user_Info_userinfo_Idcard_number">身份证号</label>
                                                    <input class="form-control" id="edit_user_Info_userinfo_Idcard_number" type="text" placeholder="431126000000000000">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_user_Info_userinfo_Department">院系</label>
                                                    <input class="form-control" id="edit_user_Info_userinfo_Department" type="text" disabled="">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_user_Info_userinfo_Class">班级</label>
                                                    <input class="form-control" id="edit_user_Info_userinfo_Class" type="text" disabled="">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_user_Info_userinfo_Home_address">家庭地址</label>
                                                    <input class="form-control" id="edit_user_Info_userinfo_Home_address" type="text" placeholder="桃子湖">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="edit_user_Info_userinfo_Train_station">火车站</label>
                                                    <input class="form-control" id="edit_user_Info_userinfo_Train_station" type="text" placeholder="永州">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <button id="uploadCurrentUserInfoButton" class="btn btn-outline-success btn-lg btn-block" type="button">
                                                    <i class="fa fa-save"></i>
                                                    保存
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.row-->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="uploadCurrentUserInfoToServerSuccessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                            <div class="modal-dialog modal-success" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">XFZY教学管理系统</h4>
                                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>更新个人资料成功！</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-success" type="button" data-dismiss="modal">好嘞</button>
                                    </div>
                                </div>
                                <!-- /.modal-content-->
                            </div>
                            <!-- /.modal-dialog-->
                        </div>
                    </div>
                    <!-- /.col-->
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
<%--<script src="vendors/jquery/js/jquery.min.js"></script>--%>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.min.js"></script>
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
            function uploadCurrentUserInfoToBackend() {
                var currentUserId = "";
                var currentUserRole ="";
                currentUserId = ${currentUserId};
                currentUserRole = '${currentRole}';
                if(currentUserId.length === 0 || isNaN(currentUserId) ||
                    !(currentUserRole === 'admin' || currentUserRole === 'teacher' || currentUserRole === 'student') )
                {
                    alert("登录状态异常, 请重新登录!");
                    return;
                }

                var userToUpdateObject = {};
                userToUpdateObject.userId = currentUserId;
                userToUpdateObject.userName = $('#currentUserInfoContainer #edit_userName').val();
                userToUpdateObject.userPassword = $('#currentUserInfoContainer #edit_userPassword').val();
                userToUpdateObject.userRealname = $('#currentUserInfoContainer #edit_userRealname').val();
                userToUpdateObject.userEmail = $('#currentUserInfoContainer #edit_userEmail').val();
                userToUpdateObject.userRole = currentUserRole;
                userToUpdateObject.userRemarks = $('#currentUserInfoContainer #edit_userRemarks').val();
                userToUpdateObject.user_Info = { };

                userToUpdateObject.user_Info.userinfo_Sex = $('#currentUserInfoContainer #select_user_Info_userinfo_Sex').val();
                userToUpdateObject.user_Info.userinfo_Idcard_number = $('#currentUserInfoContainer #edit_user_Info_userinfo_Idcard_number').val();
                userToUpdateObject.user_Info.userinfo_Department = $('#currentUserInfoContainer #edit_user_Info_userinfo_Department').val();
                userToUpdateObject.user_Info.userinfo_Class = $('#currentUserInfoContainer #edit_user_Info_userinfo_Class').val();
                userToUpdateObject.user_Info.userinfo_Home_address = $('#currentUserInfoContainer #edit_user_Info_userinfo_Home_address').val();
                userToUpdateObject.user_Info.userinfo_Train_station = $('#currentUserInfoContainer #edit_user_Info_userinfo_Train_station').val();

                if(userToUpdateObject.userName.length === 0)
                {
                    $('#currentUserInfoContainer #edit_userName').addClass("is-invalid");
                    return;
                }
                else if(userToUpdateObject.userPassword.length === 0)
                {
                    $('#currentUserInfoContainer #edit_userPassword').addClass("is-invalid");
                    return;
                }
                else if (userToUpdateObject.userRealname.length === 0)
                {
                    $('#currentUserInfoContainer #edit_userRealname').addClass("is-invalid");
                    return;
                }
                else if(userToUpdateObject.userEmail.length === 0)
                {
                    $('#currentUserInfoContainer #edit_userEmail').addClass("is-invalid");
                    return;
                }

                $.post('updateUser',
                    {
                        userToUpdate: JSON.stringify(userToUpdateObject)
                    },
                    function (data, status) {
                        console.log('uploadCurrentUserInfoToBackend() :' + data);
                        $('#currentUserInfoContainer #edit_userName').removeClass("is-invalid");
                        $('#currentUserInfoContainer #edit_userPassword').removeClass("is-invalid");
                        $('#currentUserInfoContainer #edit_userRealname').removeClass("is-invalid");
                        $('#currentUserInfoContainer #edit_userEmail').removeClass("is-invalid");
                        $('#uploadCurrentUserInfoToServerSuccessModal').modal('toggle');
                    }
                );
            }

            $('#currentUserInfoContainer #uploadCurrentUserInfoButton').on('click', function () {
                    uploadCurrentUserInfoToBackend();
                }
            );

            function loadCurrentUserInfoFromBackend() {
                var currentUserId = "";
                currentUserId = ${currentUserId};
                if(currentUserId.length === 0 || isNaN(currentUserId))
                {
                    alert("登录状态异常, 请重新登录!");
                    return;
                }

                console.log('POST: queryUser + userId', currentUserId);
                $.post('queryUser',
                    {
                        userId: currentUserId
                    },
                    function(userDetailResult, status){
                        console.log('POST: queryUser + userId:' + currentUserId, status);
                        console.log(userDetailResult);
                        $('#currentUserInfoContainer #edit_userName').val(userDetailResult.userName);
                        $('#currentUserInfoContainer #edit_userPassword').val(userDetailResult.userPassword);
                        $('#currentUserInfoContainer #edit_userRealname').val(userDetailResult.userRealname);
                        $('#currentUserInfoContainer #edit_userEmail').val(userDetailResult.userEmail);
                        $('#currentUserInfoContainer #edit_userRemarks').val(userDetailResult.userRemarks);

                        $('#currentUserInfoContainer #select_user_Info_userinfo_Sex').val(userDetailResult.user_Info.userinfo_Sex);
                        $('#currentUserInfoContainer #edit_user_Info_userinfo_Idcard_number').val(userDetailResult.user_Info.userinfo_Idcard_number);
                        $('#currentUserInfoContainer #edit_user_Info_userinfo_Department').val(userDetailResult.user_Info.userinfo_Department);
                        $('#currentUserInfoContainer #edit_user_Info_userinfo_Class').val(userDetailResult.user_Info.userinfo_Class);
                        $('#currentUserInfoContainer #edit_user_Info_userinfo_Home_address').val(userDetailResult.user_Info.userinfo_Home_address);
                        $('#currentUserInfoContainer #edit_user_Info_userinfo_Train_station').val(userDetailResult.user_Info.userinfo_Train_station);
                    },
                    'json'
                );
            }

            loadCurrentUserInfoFromBackend();

        }
    );
</script>
</body>
</html>
