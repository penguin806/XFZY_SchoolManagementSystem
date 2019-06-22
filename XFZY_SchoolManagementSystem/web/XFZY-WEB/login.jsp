<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <base href="./">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="XFZY教学管理系统 - 登录">
    <meta name="author" content="Snow admin@xuefeng.space">
    <meta name="keyword" content="Snow XFZY School Management 教学管理">
    <title>XFZY教学管理系统 - 登录</title>
    <!-- Icons-->
    <link href="vendors/@coreui/icons/css/coreui-icons.min.css" rel="stylesheet">
    <link href="vendors/flag-icon-css/css/flag-icon.min.css" rel="stylesheet">
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application-->
    <link href="css/style.css" rel="stylesheet">
    <link href="vendors/pace-progress/css/pace.min.css" rel="stylesheet">
</head>

<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card-group">
                <div class="card p-4">
                    <div class="card-body">
                        <h1>Login</h1>
                        <p class="text-muted">欢迎使用XFZY教务管理系统</p>

                        <form class="form-horizontal" action="loginServlet" method="post">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                    <span class="input-group-text">
                      <i class="icon-user"></i>
                    </span>
                                </div>
                                <input name="username" class="form-control" type="text" placeholder="学号/工号">
                            </div>
                            <div class="input-group mb-4">
                                <div class="input-group-prepend">
                    <span class="input-group-text">
                      <i class="icon-lock"></i>
                    </span>
                                </div>
                                <input name="password" class="form-control" type="password" placeholder="密码">
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <button id="loginButton" class="btn btn-primary px-4" type="submit">登录</button>
                                </div>
                                <div class="col-6 text-right">
                                    <button id="registerButton" class="btn btn-link px-0" type="button">现在注册</button>
                                </div>
                            </div>
                        </form>
                        <div class="row mt-4">
                            <div class="col-12">
                                <div id="errorMessage" class="alert alert-danger mb-0" role="alert">${error}</div>
                            </div>
                        </div>

                    </div>
                </div>
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
<script>
    $(document).ready(
        function () {
            $('#registerButton').on(
                'click',
                function () {
                    window.location.href = 'register.jsp';
                }
            );

            if($('#errorMessage').text() !== "")
            {
                $('#errorMessage').fadeIn();
            }
            else {
                $('#errorMessage').hide();
            }
        }
    );
</script>
</body>
</html>
