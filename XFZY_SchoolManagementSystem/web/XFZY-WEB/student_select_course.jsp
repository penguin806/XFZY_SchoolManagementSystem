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
    <title>XFZY教学管理系统 - 选课</title>
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
                                <i class="fa fa-align-justify"></i> 可选课程
                            </div>
                            <div class="card-body">
                                <div id="snow-allCourseTable-toolbar" class="toolbar">

                                </div>

                                <table id="allCourseTable"
                                       data-side-pagination="client"
                                       data-sortable="true"
                                       data-search="true"
                                       data-pagination="true"
                                       data-page-list="[10, 25, 50, 100, 200, All]"
                                       data-toolbar=".toolbar"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="false" data-field="courseId">ID</th>
                                        <th data-sortable="true" data-field="courseName">课程名</th>
                                        <th data-sortable="true" data-field="courseTeacherUsername">指导老师</th>
                                        <th data-width="10" data-width-unit="%" data-field="courseId" data-formatter="allCourseTableOperationButtonGroupFormatter">操作</th>
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

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <i class="fa fa-align-justify"></i> 已选课程
                            </div>
                            <div class="card-body">
                                <div id="snow-selectedCourseTable-toolbar" class="toolbar">

                                </div>

                                <table id="selectedCourseTable"
                                       data-side-pagination="client"
                                       data-sortable="true"
                                       data-search="true"
                                       data-pagination="true"
                                       data-page-list="[10, 25, 50, 100, 200, All]"
                                       data-toolbar=".toolbar"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="false" data-field="courseId">ID</th>
                                        <th data-sortable="true" data-field="courseName">课程名</th>
                                        <th data-sortable="true" data-field="courseTeacherUsername">指导老师</th>
                                        <th data-width="10" data-width-unit="%" data-field="courseId" data-formatter="selectedCourseTableOperationButtonGroupFormatter">操作</th>
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

            <div class="modal fade" id="confirmDeselectCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-modal="true">
                <div class="modal-dialog modal-danger" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">警告</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请问您真的确定退选该课吗?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">不了</button>
                            <button id="confirmDeselectCourseModalYesButton" class="btn btn-danger" type="button">是的</button>
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
    function allCourseTableOperationButtonGroupFormatter(value, row)
    {
        var $selectCourseButton = $('<button/>', {
                text: '选课',
                id: 'select-' + value,
                class: 'selectButton btn btn-pill btn-block btn-success',
            }
        );

        return $selectCourseButton[0].outerHTML;
    }

    function selectedCourseTableOperationButtonGroupFormatter(value, row)
    {
        var $deselectCourseButton = $('<button/>', {
                text: '退课',
                id: 'deselect-' + value,
                class: 'deselectButton btn btn-pill btn-block btn-danger',
            }
        );

        return $deselectCourseButton[0].outerHTML;
    }

    $(document).ready(
        function () {

            function loadSelectedCourseTableFromBackend()
            {
                /*Callback for post start*/
                $.post('courseSelection', {
                        courseSelectionOperation: 'query'
                    },
                    function (resultJsonArray, status) {
                        console.log('courseSelection', status, resultJsonArray);

                        $('#selectedCourseTable').bootstrapTable({
                            data: resultJsonArray,
                            onPostBody: function (data) {
                                // Button <退课>
                                $('body').on('click', '.deselectButton', function (){
                                        var courseId = $(this).attr('id').replace('deselect-','');
                                        var courseSelectionToDeleteObject = {
                                            studentId: ${currentUserId} ,
                                            courseId: courseId
                                        };

                                        window.courseSelectionToDeleteObject = courseSelectionToDeleteObject;
                                        $('#confirmDeselectCourseModal').find('.modal-title')
                                            .text('警告ID: ' + courseSelectionToDeleteObject.courseId);
                                        $('#confirmDeselectCourseModal').modal('show');
                                    }

                                );

                            }
                        });
                    },
                    'json'
                );
                /*Callback for post end*/
            }

            function loadAllCourseTableFromBackend()
            {
                // Send post request to backend <queryCourse> servlet, download results in json format.
                /*Callback for post start*/
                $.post('queryCourse', function (resultJsonArray, status) {
                        console.log('queryCourse', status, resultJsonArray);

                        $('#allCourseTable').bootstrapTable({
                            data: resultJsonArray,
                            onPostBody: function (data) {
                                // Button <选课>
                                $('body').on('click', '.selectButton', function (){
                                        var courseId = $(this).attr('id').replace('select-','');
                                        var courseSelectionToAddObject = {
                                            studentId: ${currentUserId} ,
                                            courseId: courseId
                                        };

                                        console.log('POST: courseSelection/add + ' + courseId);
                                        $.post('courseSelection',
                                            {
                                                courseSelectionOperation: 'add',
                                                courseSelectionToAdd: JSON.stringify(courseSelectionToAddObject)
                                            },
                                            function(receivedData, status){
                                                console.log('POST: courseSelection/add Recv:', receivedData);
                                                setTimeout(function () {
                                                    $('#allCourseTable').bootstrapTable('destroy');
                                                    loadAllCourseTableFromBackend();
                                                    $('#selectedCourseTable').bootstrapTable('destroy');
                                                    loadSelectedCourseTableFromBackend();
                                                }, 100);
                                            }
                                        );
                                    }

                                );

                            }
                        });
                    },
                    'json'
                );
                /*Callback for post end*/
            }

            loadAllCourseTableFromBackend();
            loadSelectedCourseTableFromBackend();

            $('#confirmDeselectCourseModalYesButton').on('click', function (){
                    var courseSelectionToDeleteObject = window.courseSelectionToDeleteObject;
                    delete window.courseSelectionToDeleteObject;

                    if(isNaN(courseSelectionToDeleteObject.courseId))
                    {
                        alert('Invalid course id');
                        return;
                    }

                    console.log('POST: courseSelection/delete + ' + courseSelectionToDeleteObject.courseId);
                    $.post('courseSelection',
                        {
                            courseSelectionOperation: 'delete',
                            courseSelectionToDelete: JSON.stringify(courseSelectionToDeleteObject)
                        },
                        function(receivedData, status){
                            console.log('POST: courseSelection/delete Recv:', receivedData);
                            setTimeout(function () {
                                $('#allCourseTable').bootstrapTable('destroy');
                                loadAllCourseTableFromBackend();
                                $('#selectedCourseTable').bootstrapTable('destroy');
                                loadSelectedCourseTableFromBackend();
                                $('#confirmDeselectCourseModal').modal('hide');
                            }, 100);
                        }
                    );

                }
            );
        }
    );
</script>
</body>
</html>
