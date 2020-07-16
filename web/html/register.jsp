<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Login</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/login.css">

</head>
<body>

<!--url process start-->
<%
    //从POST中获取注册信息（能够POST说明必然符合条件）
    //servlet更新数据库
    //设置session，并跳转到之前的页面（每次进入页面时在HTTPSession中更新，login和register不更新）
%>
<!--url process end-->

<img src="img/icon/3Fish1Tea.png" alt="icon">
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
    <a href="html/home.jsp" class="text-mid info">Browse without account</a>
</form>
<!--registerForm end-->

<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/registerValidity.js"></script>

</body>
</html>