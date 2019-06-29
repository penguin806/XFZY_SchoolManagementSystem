<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <base href="./">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="XFZY教学管理系统 - 注册">
    <meta name="author" content="Snow admin@xuefeng.space">
    <meta name="keyword" content="Snow XFZY School Management 教学管理">
    <title>XFZY教学管理系统 - 注册</title>
    <!-- Icons-->
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
<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mx-4">
                <div class="card-body p-4">
                    <h1>Register</h1>
                    <p class="text-muted">申请注册新用户</p>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="icon-user"></i>
                  </span>
                        </div>
                        <input name="username" class="form-control" type="text" placeholder="学号">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">@</span>
                        </div>
                        <input name="email" class="form-control" type="text" placeholder="Email">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="icon-lock"></i>
                  </span>
                        </div>
                        <input name="password" class="form-control" type="password" placeholder="密码">
                    </div>
                    <div class="input-group mb-4">
                        <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="icon-lock"></i>
                  </span>
                        </div>
                        <input class="form-control" type="password" placeholder="重复输入密码">
                    </div>
                    <button id="registerButton" class="btn btn-block btn-success" data-toggle="modal" data-target="#registerNotAllowedModal" type="button">注册</button>
                </div>
            </div>

<%--            暂停注册--%>
            <div class="modal fade" id="registerNotAllowedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">注册暂未开放</h4>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请联系管理员: <a href="mailto:admin@xuefeng.space">admin@xuefeng.space</a></p>
                        </div>
                        <div class="modal-footer">
                            <button id="registerNotAllowedModalCloseButton" class="btn btn-secondary" type="button" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                    <!-- /.modal-content-->
                </div>
                <!-- /.modal-dialog-->
            </div>

        </div>
    </div>
</div>
<!-- CoreUI and necessary plugins-->
<script src="vendors/jquery/js/jquery.min.js"></script>
<script src="vendors/popper.js/js/popper.min.js"></script>
<script src="vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="vendors/pace-progress/js/pace.min.js"></script>
<script src="vendors/perfect-scrollbar/js/perfect-scrollbar.min.js"></script>
<script src="vendors/@coreui/coreui/js/coreui.min.js"></script>
<script src="js/snow_custom.js"></script>
<script>
    $(document).ready(
        function () {
            $('#registerNotAllowedModalCloseButton').on(
                'click',
                function () {
                    window.location.href = 'login.jsp';
                }
            );
        }
    );
</script>
</body>
</html>
