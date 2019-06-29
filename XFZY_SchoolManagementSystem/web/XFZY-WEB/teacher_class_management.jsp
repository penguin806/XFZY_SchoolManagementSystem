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
    <title>XFZY教学管理系统 - 班级管理</title>
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
                                <i class="fa fa-align-justify"></i> 班级列表
                            </div>
                            <div class="card-body">
                                <div id="snow-table-toolbar" class="toolbar">
                                    <button id="addNewClassButton" class="btn btn-primary" data-toggle="modal" data-target="#addNewClassModal" type="button">添加新班级</button>
                                </div>

                                <table id="classTable"
                                       data-side-pagination="client"
                                       data-sortable="true"
                                       data-search="true"
                                       data-pagination="true"
                                       data-page-list="[10, 25, 50, 100, 200, All]"
                                       data-toolbar=".toolbar"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="true" data-field="classId">ID</th>
                                        <th data-sortable="true" data-field="className">班级名称</th>
                                        <th data-sortable="true" data-field="classStudentsNum">人数</th>
                                        <th data-width="20" data-width-unit="%" data-field="classId" data-formatter="classTableOperationButtonGroupFormatter">操作</th>
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

            <div class="modal fade" id="addNewClassModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">班级</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="addnew_className">班级名称</label>
                                        <input class="form-control" id="addnew_className" type="text" placeholder="16计算机科学与技术(师范)">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">班级名称为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="addNewClassModalSaveButton" class="btn btn-primary" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="modifyClassModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-success" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">班级</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="edit_className">班级名称</label>
                                        <input class="form-control" id="edit_className" type="text" placeholder="16计算机科学与技术(师范)">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="someFieldEmptyError alert alert-danger" role="alert">班级名称为必填项</div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                            <button id="modifyClassModalSaveButton" class="btn btn-success" type="button">保存</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>
            <div class="modal fade" id="confirmDeleteClassModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-modal="true">
                <div class="modal-dialog modal-danger" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">警告</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请问您真的确定删除该班级吗?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">不了</button>
                            <button id="confirmClassDeleteModalYesButton" class="btn btn-danger" type="button">是的</button>
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
    function classTableOperationButtonGroupFormatter(value, row)
    {
        var modifyButton = $('<button/>', {
                text: '修改',
                id: 'modify-' + value,
                class: 'modifyButton btn btn-secondary snow-m-1'
            }
        );
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

            function loadClassTableFromBackend()
            {
                // Send post request to backend <queryClass> servlet, download results in json format.
                /*Callback for post start*/
                $.post('queryClass', function (resultJsonArray, status) {
                        console.log(status, resultJsonArray);

                        $('#classTable').bootstrapTable({
                            data: resultJsonArray,
                            onAll: function (name, args) {
                                console.log(name, args);
                            },
                            onPostBody: function (data) {
                                $('body').on('click', '.modifyButton', function (){
                                        var classId = $(this).attr('id').replace('modify-','');
                                        $('#modifyClassModal').find('.modal-title')
                                            .text('修改班级' + classId);

                                        $('#modifyClassModal').modal('show');
                                    }
                                );

                                $('body').on('click', '.deleteButton', function (){
                                        var classId = $(this).attr('id').replace('delete-','');
                                        $('#confirmDeleteClassModal').find('.modal-title').text('警告ID: ' + classId);
                                        $('#confirmDeleteClassModal').modal('show');

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

            loadClassTableFromBackend();

            $('#addNewClassButton').on('click', function (){
                    $('#addNewClassModal').find('.modal-title')
                        .text('添加新班级');
                }
            );

            $('#modifyClassModalSaveButton').on('click', function (){
                    var classToUpdateObject = {};

                    var classId = $('#modifyClassModal').find('.modal-title')
                        .text().replace('修改班级','');
                    console.log(classId);
                    if(isNaN(classId))
                    {
                        alert('Invalid class id');
                        return;
                    }
                    classToUpdateObject.classId = classId;
                    classToUpdateObject.className = $('#modifyClassModal #edit_className').val();

                    if(classToUpdateObject.classId.length === 0 || classToUpdateObject.className.length === 0 )
                    {
                        $('#modifyClassModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('updateClass',
                        {
                            classToUpdate: JSON.stringify(classToUpdateObject)
                        },
                        function (data, status) {
                            console.info('#modifyClassModalSaveButton .click:' + data);
                            $('#modifyClassModal').modal('toggle');
                            $('#classTable').bootstrapTable('destroy');
                            loadClassTableFromBackend();
                        }
                    );

                }
            );

            $('#addNewClassModalSaveButton').on('click', function (){
                    var classToAddObject = {};

                    classToAddObject.className = $('#addNewClassModal #addnew_className').val();

                    if(classToAddObject.className.length === 0)
                    {
                        $('#addNewClassModal .someFieldEmptyError').fadeIn();
                        return;
                    }

                    $.post('addClass',
                        {
                            classToAdd: JSON.stringify(classToAddObject)
                        },
                        function (data, status) {
                            console.info('#addNewClassModalSaveButton .click:' + data);
                            $('#addNewClassModal').modal('toggle');
                            $('#classTable').bootstrapTable('destroy');
                            loadClassTableFromBackend();
                        }
                    );
                }
            );

            $('#confirmClassDeleteModalYesButton').on('click', function (){
                    var classId = $('#confirmDeleteClassModal').find('.modal-title')
                        .text().replace('警告ID: ','');

                    console.log('POST: deleteClass + ' + classId);
                    if(isNaN(classId))
                    {
                        alert('Invalid class id');
                        return;
                    }

                    $.post('deleteClass', {
                            classToDelete: classId
                        },
                        function (data, status){
                            console.log(status, data);
                            $('#confirmDeleteClassModal').modal('hide');
                            $('#classTable').bootstrapTable('destroy');
                            loadClassTableFromBackend();
                        }
                    );
                }
            );
        }
    );
</script>
</body>
</html>
