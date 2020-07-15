<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Login</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/login.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<%
    //从POST中获取注册信息（能够POST说明必然符合条件）
    //servlet更新数据库
    //设置session，并跳转到之前的页面（每次进入页面时在HTTPSession中更新，login和register不更新）
%>
<!--url process end-->

<img src="../img/icon/3Fish1Tea.png" alt="icon">
<h1 class="title text-big">Welcome to DaddyTravel</h1>
<h3 class="title text-sm">Share photos you love!</h3>

<!--registerForm begin-->
<form class="bd-form" method="post">
    <div class="form-group">
        <label for="userName" class="info text-mid">UserName</label>
        <input type="text" class="form-control" id="userName" name="name" placeholder="your userName here" required>
    </div>
    <div class="form-group">
        <label for="e-mail" class="info text-mid">E-mail</label>
        <input type="email" class="form-control" id="e-mail" name="email" aria-describedby="emailHelp"
               placeholder="your email here"
               required>
    </div>
    <div class="form-group">
        <label for="password" class="info text-mid">Password</label>
        <input type="password" class="form-control" id="password" name="pass" placeholder="your password here" required>
    </div>
    <div class="progress my-2">
        <div id="passwordStrength" class="progress-bar bg-success" role="progressbar" style="width: 0"></div>
    </div>
    <div class="form-group">
        <label for="passwordConfirm" class="info text-mid">ConfirmPassword</label>
        <input type="password" class="form-control" id="passwordConfirm" placeholder="your password again" required>
    </div>
    <button type="submit" id="submit" class="btn btn-light text-mid info">Register</button>
    <div id="div"></div>
    <a href="home.php" class="text-mid info">Browse without account</a>
</form>
<!--registerForm end-->

<!--footer begin-->
<footer>
    <hr>
    <p>沪私危备案74751号</p>
    <p>版权&copy;2001-2020 DaddyTravel 版权所有</p>
    <p>联系我们19302010020@fudan.edu.cn</p>
</footer>
<!--footer end-->

<!--bootstrap4-->
<script src="../bootstrap4/jquery-3.5.1.min.js"></script>
<script src="../bootstrap4/popper.min.js"></script>
<script src="../bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="../js/registerValidity.js"></script>

</body>
</html>