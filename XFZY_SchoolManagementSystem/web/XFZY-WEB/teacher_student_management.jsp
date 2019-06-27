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
    <title>XFZY教学管理系统 - 学生管理</title>
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
    <link href="css/bootstrap-table.min.css" rel="stylesheet">
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
                                <i class="fa fa-align-justify"></i> 学生列表
                            </div>
                            <div class="card-body">
                                <div id="snow-table-toolbar" class="toolbar">
                                    <button id="addNewUserButton" class="btn btn-primary" data-toggle="modal" data-target="#addNewUserModal" type="button">添加学生</button>
                                </div>

                                <table id="userTable"
                                       data-side-pagination="client"
                                       data-sortable="true"
                                       data-search="true"
                                       data-pagination="true"
                                       data-page-list="[10, 25, 50, 100, 200, All]"
                                       data-toolbar=".toolbar"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="true" data-field="userId">ID</th>
                                        <th data-sortable="true" data-field="userName">用户名</th>
<%--                                        <th data-field="userPassword">密码</th>--%>
                                        <th data-sortable="true" data-field="userRealname">姓名</th>
                                        <th data-field="userEmail">E-mail</th>
<%--                                        <th data-field="userRole">角色</th>--%>
                                        <th data-field="userRemarks">备注</th>
                                        <th data-width="20" data-width-unit="%" data-field="userId" data-formatter="tableOperationButtonGroupFormatter">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-->
                </div>

            </div>

            <div class="modal fade" id="addNewUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">成员</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_userName">用户名</label>
                                        <input class="form-control" id="addnew_userName" type="text" placeholder="lxf2019">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_userPassword">密码</label>
                                        <input class="form-control" id="addnew_userPassword" type="password" placeholder="123456">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_userRealname">姓名</label>
                                        <input class="form-control" id="addnew_userRealname" type="text" placeholder="李雪峰">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_userEmail">E-mail</label>
                                        <input class="form-control" id="addnew_userEmail" type="text" placeholder="a1@xuefeng.space">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <!--Row for RoleSelect-->
<%--                            <div class="row">--%>
<%--                                <div class="col-sm-12">--%>
<%--                                    <div class="form-group">--%>
<%--                                        <label for="addnew_select_userRole">角色</label>--%>
<%--                                        <select class="form-control" id="addnew_select_userRole">--%>
<%--                                            <option value="admin">admin</option>--%>
<%--                                            <option value="teacher">teacher</option>--%>
<%--                                            <option value="student">student</option>--%>
<%--                                        </select>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_userRemarks">备注</label>
                                        <input class="form-control" id="addnew_userRemarks" type="text" placeholder="NULL">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_select_user_Info_userinfo_Sex">性别</label>
                                        <select class="form-control" id="addnew_select_user_Info_userinfo_Sex">
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
                                        <label for="addnew_user_Info_userinfo_Idcard_number">身份证号</label>
                                        <input class="form-control" id="addnew_user_Info_userinfo_Idcard_number" type="text" placeholder="431126200000000000">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_user_Info_userinfo_Department">院系</label>
                                        <input class="form-control" id="addnew_user_Info_userinfo_Department" type="text" placeholder="信息科学与工程学院">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_user_Info_userinfo_Class">班级</label>
                                        <input class="form-control" id="addnew_user_Info_userinfo_Class" type="text" placeholder="计算机科学与技术(师范)">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_user_Info_userinfo_Home_address">家庭地址</label>
                                        <input class="form-control" id="addnew_user_Info_userinfo_Home_address" type="text" placeholder="桃子湖">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_user_Info_userinfo_Train_station">火车站</label>
                                        <input class="form-control" id="addnew_user_Info_userinfo_Train_station" type="text" placeholder="永州">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">用户名、密码、真实姓名、邮箱为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="addNewUserModalSaveButton" class="btn btn-primary" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="modifyUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-success" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">成员</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_userName">用户名</label>
                                        <input class="form-control" id="edit_userName" type="text" placeholder="lxf2019">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_userPassword">密码</label>
                                        <input class="form-control" id="edit_userPassword" type="password" placeholder="123456">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_userRealname">姓名</label>
                                        <input class="form-control" id="edit_userRealname" type="text" placeholder="李雪峰">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_userEmail">E-mail</label>
                                        <input class="form-control" id="edit_userEmail" type="text" placeholder="a1@xuefeng.space">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <!--Row for RoleSelect-->
<%--                            <div class="row">--%>
<%--                                <div class="col-sm-12">--%>
<%--                                    <div class="form-group">--%>
<%--                                        <label for="select_userRole">角色</label>--%>
<%--                                        <select class="form-control" id="select_userRole">--%>
<%--                                            <option value="admin">admin</option>--%>
<%--                                            <option value="teacher">teacher</option>--%>
<%--                                            <option value="student">student</option>--%>
<%--                                        </select>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_userRemarks">备注</label>
                                        <input class="form-control" id="edit_userRemarks" type="text" placeholder="NULL">
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
                                        <input class="form-control" id="edit_user_Info_userinfo_Idcard_number" type="text" placeholder="431126200000000000">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_user_Info_userinfo_Department">院系</label>
                                        <input class="form-control" id="edit_user_Info_userinfo_Department" type="text" placeholder="信息科学与工程学院">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_user_Info_userinfo_Class">班级</label>
                                        <input class="form-control" id="edit_user_Info_userinfo_Class" type="text" placeholder="计算机科学与技术(师范)">
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
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">用户名、密码、真实姓名、邮箱为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="modifyUserModalSaveButton" class="btn btn-success" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="confirmDeleteUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-modal="true">
                <div class="modal-dialog modal-danger" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">警告</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请问您真的确定删除此用户吗?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">不了</button>
                            <button id="confirmUserDeleteModalYesButton" class="btn btn-danger" type="button">是的</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
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
    function tableOperationButtonGroupFormatter(value, row)
    {
        var modifyButton = $('<button/>', {
                text: '修改',
                id: 'modify-' + value,
                class: 'modifyButton btn btn-secondary snow-m-1'
            }
        );
        // modifyButton.attr('data-toggle', 'modal');
        // modifyButton.attr('data-target', '#modifyUserModal');
        var deleteButton = $('<button/>', {
                text: '删除',
                id: 'delete-' + value,
                class: 'deleteButton btn btn-danger snow-m-1'
            }
        );

        var $tableOperationButtonGroup = $('<div></div>').append(
            modifyButton,
            deleteButton
        );
        return $tableOperationButtonGroup.html();
    }

    $(document).ready(
        function () {

            function loadUserTableFromBackend()
            {
                // Send post request to backend <queryUser> servlet, download results in json format.
                /*Callback for post start*/
                $.post('queryUser',{
                        studentOnly: true
                    },
                    function (resultJsonArray, status) {
                        console.log(status, resultJsonArray);

                        $('#userTable').bootstrapTable({
                            data: resultJsonArray,
                            onAll: function (name, args) {
                                console.log(name, args);
                            },
                            onPostBody: function (data) {
                                $('body').on('click', '.modifyButton', function (){
                                        var userId = $(this).attr('id').replace('modify-','');
                                        $('#modifyUserModal').find('.modal-title')
                                            .text('修改成员' + userId);

                                        console.log('POST: queryUser + ' + userId);
                                        $.post('queryUser',
                                            {
                                                userId: userId
                                            },
                                            function(userDetailResult, status){
                                                console.log('POST: queryUser + ' + userId, status);
                                                console.log(userDetailResult);
                                                $('#modifyUserModal #edit_userName').val(userDetailResult.userName);
                                                $('#modifyUserModal #edit_userPassword').val(userDetailResult.userPassword);
                                                $('#modifyUserModal #edit_userRealname').val(userDetailResult.userRealname);
                                                $('#modifyUserModal #edit_userEmail').val(userDetailResult.userEmail);
                                                // $('#modifyUserModal #select_userRole').val(userDetailResult.userRole);
                                                $('#modifyUserModal #edit_userRemarks').val(userDetailResult.userRemarks);

                                                $('#modifyUserModal #select_user_Info_userinfo_Sex').val(userDetailResult.user_Info.userinfo_Sex);
                                                $('#modifyUserModal #edit_user_Info_userinfo_Idcard_number').val(userDetailResult.user_Info.userinfo_Idcard_number);
                                                $('#modifyUserModal #edit_user_Info_userinfo_Department').val(userDetailResult.user_Info.userinfo_Department);
                                                $('#modifyUserModal #edit_user_Info_userinfo_Class').val(userDetailResult.user_Info.userinfo_Class);
                                                $('#modifyUserModal #edit_user_Info_userinfo_Home_address').val(userDetailResult.user_Info.userinfo_Home_address);
                                                $('#modifyUserModal #edit_user_Info_userinfo_Train_station').val(userDetailResult.user_Info.userinfo_Train_station);
                                                $('#modifyUserModal').modal('show');
                                            },
                                            'json'
                                        );

                                    }
                                );

                                $('body').on('click', '.deleteButton', function (){
                                        var userId = $(this).attr('id').replace('delete-','');
                                        $('#confirmDeleteUserModal').find('.modal-title').text('警告ID: ' + userId);
                                        $('#confirmDeleteUserModal').modal('show');

                                    }
                                );
                            }
                        });
                    },
                    'json'
                );
                /*Callback for post end*/
                $('.someFieldEmptyError').hide();
            }

            loadUserTableFromBackend();

            $('#addNewUserButton').on('click', function (){
                    $('#addNewUserButton').find('.modal-title')
                        .text('添加新成员');
                }
            );

            $('#modifyUserModalSaveButton').on('click', function (){
                    var userToUpdateObject = {};

                    var userId = $('#modifyUserModal').find('.modal-title')
                        .text().replace('修改成员','');
                    console.log(userId);
                    if(isNaN(userId))
                    {
                        alert('Invalid user id');
                        return;
                    }
                    userToUpdateObject.userId = userId;
                    userToUpdateObject.userName = $('#modifyUserModal #edit_userName').val();
                    userToUpdateObject.userPassword = $('#modifyUserModal #edit_userPassword').val();
                    userToUpdateObject.userRealname = $('#modifyUserModal #edit_userRealname').val();
                    userToUpdateObject.userEmail = $('#modifyUserModal #edit_userEmail').val();
                    // userToUpdateObject.userRole = $('#modifyUserModal #select_userRole').val();
                    userToUpdateObject.userRole = 'student';
                    userToUpdateObject.userRemarks = $('#modifyUserModal #edit_userRemarks').val();
                    userToUpdateObject.user_Info = { };

                    userToUpdateObject.user_Info.userinfo_Sex = $('#modifyUserModal #select_user_Info_userinfo_Sex').val();
                    userToUpdateObject.user_Info.userinfo_Idcard_number = $('#modifyUserModal #edit_user_Info_userinfo_Idcard_number').val();
                    userToUpdateObject.user_Info.userinfo_Department = $('#modifyUserModal #edit_user_Info_userinfo_Department').val();
                    userToUpdateObject.user_Info.userinfo_Class = $('#modifyUserModal #edit_user_Info_userinfo_Class').val();
                    userToUpdateObject.user_Info.userinfo_Home_address = $('#modifyUserModal #edit_user_Info_userinfo_Home_address').val();
                    userToUpdateObject.user_Info.userinfo_Train_station = $('#modifyUserModal #edit_user_Info_userinfo_Train_station').val();

                    if(userToUpdateObject.userName.length === 0 || userToUpdateObject.userPassword.length === 0
                        || userToUpdateObject.userRealname.length === 0 || userToUpdateObject.userEmail.length === 0)
                    {
                        $('#modifyUserModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('updateUser',
                        {
                            userToUpdate: JSON.stringify(userToUpdateObject)
                        },
                        function (data, status) {
                            console.info('#modifyUserModalSaveButton .click:' + data);
                            $('#modifyUserModal').modal('toggle');
                            $('#userTable').bootstrapTable('destroy');
                            loadUserTableFromBackend();
                        }
                    );

                }
            );

            $('#addNewUserModalSaveButton').on('click', function (){
                    var userToAddObject = {};

                    userToAddObject.userName = $('#addNewUserModal #addnew_userName').val();
                    userToAddObject.userPassword = $('#addNewUserModal #addnew_userPassword').val();
                    userToAddObject.userRealname = $('#addNewUserModal #addnew_userRealname').val();
                    userToAddObject.userEmail = $('#addNewUserModal #addnew_userEmail').val();
                    // userToAddObject.userRole = $('#addNewUserModal #addnew_select_userRole').val();
                    userToAddObject.userRole = 'student';
                    userToAddObject.userRemarks = $('#addNewUserModal #addnew_userRemarks').val();
                    userToAddObject.user_Info = { };

                    userToAddObject.user_Info.userinfo_Sex = $('#addNewUserModal #addnew_select_user_Info_userinfo_Sex').val();
                    userToAddObject.user_Info.userinfo_Idcard_number = $('#addNewUserModal #addnew_user_Info_userinfo_Idcard_number').val();
                    userToAddObject.user_Info.userinfo_Department = $('#addNewUserModal #addnew_user_Info_userinfo_Department').val();
                    userToAddObject.user_Info.userinfo_Class = $('#addNewUserModal #addnew_user_Info_userinfo_Class').val();
                    userToAddObject.user_Info.userinfo_Home_address = $('#addNewUserModal #addnew_user_Info_userinfo_Home_address').val();
                    userToAddObject.user_Info.userinfo_Train_station = $('#addNewUserModal #addnew_user_Info_userinfo_Train_station').val();

                    if(userToAddObject.userName.length === 0 || userToAddObject.userPassword.length === 0
                        || userToAddObject.userRealname.length === 0 || userToAddObject.userEmail.length === 0)
                    {
                        $('#addNewUserModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('addUser',
                        {
                            userToAdd: JSON.stringify(userToAddObject)
                        },
                        function (data, status) {
                            console.info('#addNewUserModalSaveButton .click:' + data);
                            $('#addNewUserModal').modal('toggle');
                            $('#userTable').bootstrapTable('destroy');
                            loadUserTableFromBackend();
                        }
                    );
                }
            );

            $('#confirmUserDeleteModalYesButton').on('click', function (){
                    var userId = $('#confirmDeleteUserModal').find('.modal-title')
                        .text().replace('警告ID: ','');

                    console.log('POST: deleteUser + ' + userId);
                    if(isNaN(userId))
                    {
                        alert('Invalid user id');
                        return;
                    }

                    $.post('deleteUser', {
                            userToDelete: userId
                        },
                        function (data, status){
                            console.log(status, data);
                            $('#confirmDeleteUserModal').modal('hide');
                            $('#userTable').bootstrapTable('destroy');
                            loadUserTableFromBackend();
                        }
                    );
                }
            );
        }
    );
</script>
</body>
</html>
