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
    <title>XFZY教学管理系统 - 课程管理</title>
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
                        <i class="nav-icon fa fa-book"></i> 选课</a>
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
                                <i class="fa fa-align-justify"></i> 课程列表
                            </div>
                            <div class="card-body">
                                <div id="snow-table-toolbar" class="toolbar">
                                    <button id="addNewCourseButton" class="btn btn-primary" data-toggle="modal" data-target="#addNewCourseModal" type="button">添加新课程</button>
                                </div>

                                <table id="courseTable"
                                       data-side-pagination="client"
                                       data-sortable="true"
                                       data-search="true"
                                       data-pagination="true"
                                       data-page-list="[10, 25, 50, 100, 200, All]"
                                       data-toolbar=".toolbar"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="true" data-field="courseId">ID</th>
                                        <th data-sortable="true" data-field="courseName">课程名</th>
                                        <th data-sortable="true" data-field="courseTeacherUsername">指导老师</th>
                                        <th data-field="courseId" data-formatter="tableOperationButtonGroupFormatter">操作</th>
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

            <div class="modal fade" id="addNewCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">课程</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_courseName">课程名</label>
                                        <input class="form-control" id="addnew_courseName" type="text" placeholder="Web应用系统设计">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_courseTeacherUsername">指导老师</label>
                                        <input class="form-control" id="addnew_courseTeacherUsername" type="text" placeholder="李重文">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">课程名、指导老师为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="addNewCourseModalSaveButton" class="btn btn-primary" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="modifyCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-success" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">课程</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_courseName">课程名</label>
                                        <input class="form-control" id="edit_courseName" type="text" placeholder="Web应用系统设计">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_courseTeacherUsername">指导老师</label>
                                        <input class="form-control" id="edit_courseTeacherUsername" type="text" placeholder="李重文">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">课程名、指导老师为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="modifyCourseModalSaveButton" class="btn btn-success" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="confirmDeleteCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-modal="true">
                <div class="modal-dialog modal-danger" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">警告</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请问您真的确定删除此课程吗?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">不了</button>
                            <button id="confirmCourseDeleteModalYesButton" class="btn btn-danger" type="button">是的</button>
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
                class: 'modifyButton btn btn-secondary mr-1',
            }
        );
        var deleteButton = $('<button/>', {
                text: '删除',
                id: 'delete-' + value,
                class: 'deleteButton btn btn-danger'
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

            function loadCourseTableFromBackend()
            {
                // Send post request to backend <queryCourse> servlet, download results in json format.
                /*Callback for post start*/
                $.post('queryCourse', function (resultJsonArray, status) {
                        console.log(status, resultJsonArray);

                        $('#courseTable').bootstrapTable({
                            data: resultJsonArray,
                            onAll: function (name, args) {
                                console.log(name, args);
                            },
                            onPostBody: function (data) {
                                $('body').on('click', '.modifyButton', function (){
                                        var courseId = $(this).attr('id').replace('modify-','');
                                        $('#modifyCourseModal').find('.modal-title')
                                            .text('修改课程' + courseId);

                                        console.log('POST: queryCourse + ' + courseId);
                                        $.post('queryCourse',
                                            {
                                                courseId: courseId
                                            },
                                            function(courseDetailResult, status){
                                                console.log('POST: queryCourse + ' + courseId, status);
                                                console.log(courseDetailResult);
                                                $('#modifyCourseModal #edit_courseName').val(courseDetailResult.courseName);
                                                $('#modifyCourseModal #edit_courseTeacherUsername').val(courseDetailResult.courseTeacherUsername);
                                                $('#modifyCourseModal').modal('show');
                                            },
                                            'json'
                                        );

                                    }
                                );

                                $('body').on('click', '.deleteButton', function (){
                                        var courseId = $(this).attr('id').replace('delete-','');
                                        $('#confirmDeleteCourseModal').find('.modal-title').text('警告ID: ' + courseId);
                                        $('#confirmDeleteCourseModal').modal('show');

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

            loadCourseTableFromBackend();

            $('#addNewCourseButton').on('click', function (){
                    $('#addNewCourseButton').find('.modal-title')
                        .text('添加新课程');
                }
            );

            $('#modifyCourseModalSaveButton').on('click', function (){
                    var courseToUpdateObject = {};

                    var courseId = $('#modifyCourseModal').find('.modal-title')
                        .text().replace('修改课程','');
                    console.log(courseId);
                    if(isNaN(courseId))
                    {
                        alert('Invalid course id');
                        return;
                    }
                    courseToUpdateObject.courseId = courseId;
                    courseToUpdateObject.courseName = $('#modifyCourseModal #edit_courseName').val();
                    courseToUpdateObject.courseTeacherUsername = $('#modifyCourseModal #edit_courseTeacherUsername').val();

                    if(courseToUpdateObject.courseId.length === 0 || courseToUpdateObject.courseName.length === 0
                        || courseToUpdateObject.courseTeacherUsername.length === 0 )
                    {
                        $('#modifyCourseModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('updateCourse',
                        {
                            courseToUpdate: JSON.stringify(courseToUpdateObject)
                        },
                        function (data, status) {
                            console.info('#modifyCourseModalSaveButton .click:' + data);
                            $('#modifyCourseModal').modal('toggle');
                            $('#courseTable').bootstrapTable('destroy');
                            loadCourseTableFromBackend();
                        }
                    );

                }
            );

            $('#addNewCourseModalSaveButton').on('click', function (){
                    var courseToAddObject = {};

                    courseToAddObject.courseName = $('#addNewCourseModal #addnew_courseName').val();
                    courseToAddObject.courseTeacherUsername = $('#addNewCourseModal #addnew_courseTeacherUsername').val();

                    if(courseToAddObject.courseName.length === 0 || courseToAddObject.courseTeacherUsername.length === 0 )
                    {
                        $('#addNewCourseModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('addCourse',
                        {
                            courseToAdd: JSON.stringify(courseToAddObject)
                        },
                        function (data, status) {
                            console.info('#addNewCourseModalSaveButton .click:' + data);
                            $('#addNewCourseModal').modal('toggle');
                            $('#courseTable').bootstrapTable('destroy');
                            loadCourseTableFromBackend();
                        }
                    );
                }
            );

            $('#confirmCourseDeleteModalYesButton').on('click', function (){
                    var courseId = $('#confirmDeleteCourseModal').find('.modal-title')
                        .text().replace('警告ID: ','');

                    console.log('POST: deleteCourse + ' + courseId);
                    if(isNaN(courseId))
                    {
                        alert('Invalid course id');
                        return;
                    }

                    $.post('deleteCourse', {
                            courseToDelete: courseId
                        },
                        function (data, status){
                            console.log(status, data);
                            $('#confirmDeleteCourseModal').modal('hide');
                            $('#courseTable').bootstrapTable('destroy');
                            loadCourseTableFromBackend();
                        }
                    );
                }
            );
        }
    );
</script>
</body>
</html>
