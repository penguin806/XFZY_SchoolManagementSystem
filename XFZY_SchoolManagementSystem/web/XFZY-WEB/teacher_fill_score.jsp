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
    <title>XFZY教学管理系统 - 成绩录入</title>
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
                                <i class="fa fa-align-justify"></i> 成绩录入
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
                                       data-detail-view="true"
                                       data-detail-view-icon="false"
                                       data-detail-view-by-click="false"
                                       class="table table-responsive-sm table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th data-sortable="true" data-field="courseId">ID</th>
                                        <th data-sortable="true" data-field="courseName">课程名</th>
                                        <th data-sortable="true" data-field="courseTeacherUsername">指导老师</th>
                                        <th data-width="10" data-width-unit="%" data-field="courseId" data-formatter="allCourseTableViewButtonFormatter">操作</th>
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

            <div class="modal fade" id="fillScoreModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">录入成绩</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
<%--                                        <label for="scoreInputBox">成绩</label>--%>
                                        <input class="form-control" id="scoreInputBox" type="text" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <!-- /.row-->

                        </div>
                        <div class="modal-footer">
                            <button id="fillScoreModalSaveButton" class="btn btn-primary" type="button">确定</button>
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
    function allCourseTableViewButtonFormatter(value, row, index, field)
    {
        var $viewButton = $('<button/>', {
                text: '查看',
                id: 'view-' + value,
                class: 'viewButton btn btn-success snow-m-1'
            }
        );

        $viewButton.attr('data-CourseId', value);
        $viewButton.attr('data-RowIndex', index);

        return $viewButton[0].outerHTML;
    }

    function allStudentAndScoreOfOneCourseTable_FillRecordButtonFormatter(value, row, index, field)
    {
        var $viewButton = $('<button/>', {
                text: '录入',
                id: 'fill-' + value,
                class: 'fillButton btn btn-warning snow-m-1'
            }
        );

        $viewButton.attr('data-CourseId', row.studentCourseId);
        $viewButton.attr('data-StudentId', row.studentId);
        $viewButton.attr('data-RowIndex', index);

        return $viewButton[0].outerHTML;
    }

    $(document).ready(
        function () {

            function loadAllStudentAndScoreOfOneCourseTable(allStudentAndScoreOfTheCourseResult, $parentDom, courseId) {
                var $allStudentAndScoreOfOneCourseTable = $('<table></table>', {
                        id: courseId
                    }
                );
                // $allStudentAndScoreOfOneCourseTable.addClass('table table-responsive-sm table-bordered table-striped');
                $allStudentAndScoreOfOneCourseTable.html('<thead>' +
                    '<tr>' +
                    '    <th data-sortable="false" data-field="studentCourseId">课程号</th>' +
                    '    <th data-sortable="true" data-field="studentId">学生ID</th>' +
                    '    <th data-sortable="true" data-field="studentUsername">学号</th>' +
                    '    <th data-sortable="true" data-field="studentRealname">姓名</th>' +
                    '    <th data-sortable="false" data-field="studentCourseScore">成绩</th>' +
                    '    <th data-width="10" data-width-unit="%" data-field="studentCourseId" data-formatter="allStudentAndScoreOfOneCourseTable_FillRecordButtonFormatter">操作</th>' +
                    '</tr>' +
                    '</thead>');

                $allStudentAndScoreOfOneCourseTable.bootstrapTable(
                    {
                        data: allStudentAndScoreOfTheCourseResult,
                        onPostBody: function (data) {
                            $('body').on('click', '.fillButton', function (){
                                    var courseId = $(this).attr('data-CourseId');
                                    var studentId = $(this).attr('data-StudentId');
                                    var rowIndex = $(this).attr('data-RowIndex');
                                    $('#fillScoreModal').attr('data-CourseId', courseId);
                                    $('#fillScoreModal').attr('data-StudentId', studentId);
                                    $('#fillScoreModal').attr('data-RowIndex', rowIndex);
                                    $('#fillScoreModal .modal-title').text('录入成绩 ID:' + courseId + '-' + studentId);

                                    $('#fillScoreModal').modal('toggle');
                                }
                            );
                        }
                    }
                );

                $parentDom.append($allStudentAndScoreOfOneCourseTable);
            }

            function allCourseTableRowExpandedCallback(rowIndex, rowRecord, $domDetail) {
                console.log(rowIndex, rowRecord, $domDetail);
                var courseId = rowRecord.courseId;

                console.log('POST: queryScore + courseId:' + courseId);
                // Send post request to backend <queryScore> servlet, download results in json format.
                /*Callback for post start*/
                $.post('queryScore',
                    {
                        courseId: courseId
                    },
                    function(allStudentAndScoreOfTheCourseResult, status){
                        console.log('POST: queryScore + courseId:' + courseId, status);
                        console.log(allStudentAndScoreOfTheCourseResult);
                        loadAllStudentAndScoreOfOneCourseTable(allStudentAndScoreOfTheCourseResult, $domDetail, courseId);
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
                        console.log(status, resultJsonArray);

                        $('#allCourseTable').bootstrapTable({
                            data: resultJsonArray,
                            onAll: function (name, args) {
                                console.log(name, args);
                            },
                            onPostBody: function (data) {
                                $('body').on('click', '.viewButton', function (){
                                        var rowIndex = $(this).attr('data-RowIndex');
                                        $('#allCourseTable').bootstrapTable('expandRow', rowIndex);
                                        // allCourseTableViewButtonClickedCallback(courseId, rowIndex);
                                    }
                                );
                            },
                            onExpandRow: allCourseTableRowExpandedCallback
                        });
                    },
                    'json'
                );
                /*Callback for post end*/
            }

            $('#fillScoreModalSaveButton').on(
                'click', function (){
                    var courseId = $('#fillScoreModal').attr('data-CourseId');
                    var studentId = $('#fillScoreModal').attr('data-StudentId');
                    var rowIndex = $('#fillScoreModal').attr('data-RowIndex');
                    var studentCourseScore = $('#fillScoreModal #scoreInputBox').val();
                    if(studentCourseScore.length === 0 || isNaN(studentCourseScore))
                    {
                        console.error('Invalid score number.');
                        return;
                    }

                    $.post(
                        'updateScore',
                        {
                            studentId: studentId,
                            courseId: courseId,
                            studentCourseScore: studentCourseScore
                        },
                        function (data, status){
                            console.log('POST: updateScore', data, status);
                            $('#fillScoreModal').attr('data-CourseId', null);
                            $('#fillScoreModal').attr('data-StudentId', null);
                            $('#fillScoreModal').attr('data-RowIndex', null);

                            $('#'+ courseId).bootstrapTable(
                                'updateCell',
                                {
                                    index: rowIndex,
                                    field: 'studentCourseScore',
                                    value: studentCourseScore
                                }
                            );

                            $('#fillScoreModal').modal('toggle');
                        }
                    );
                }
            );

            loadAllCourseTableFromBackend();
        }
    );
</script>
</body>
</html>
