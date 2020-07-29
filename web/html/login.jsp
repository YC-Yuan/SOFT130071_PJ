<%@ page import="javax.tools.Tool" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Login</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>

    <link rel="stylesheet" href="css/login.css">

    <base href="<%=basePath%>"/>

</head>
<body>
<img src="img/icon/3Fish1Tea.png" alt="login">
<h1 class="title text-big">Welcome to DaddyTravel</h1>
<h3 class="title text-sm">Share photos you love!</h3>

<!--loginForm begin-->
<c:if test="${param.userName!=null}">
    <script>alert("Wrong username or password!");</script>
</c:if>
<form class="bd-form" action="login" method="post" role="form" id="form">
    <div class="form-group">
        <label for="userName" class="info text-mid">UserName/Email</label>
        <input type="text" class="form-control" id="userName" name="userName" placeholder="your UserName here" required
        value="${param.userName}">
    </div>
    <div class="form-group">
        <label for="password" class="info text-mid">Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="your password here" required>
    </div>
    <div class="form-group">
        <label for="verificationCode" class="info text-mid">Verification</label>
        <input type="password" class="form-control" id="verificationCode" name="verificationCode" placeholder="input verification content" required>
        <img src="verificationCode" class="mt-2" id="verificationImg" alt="verificationCode"/>
    </div>
    <button type="submit" id="submit" class="btn btn-light"><span class="info text-mid">Login</span></button>
    <hr>
    <h2 class="text-mid">No account? <a href="html/register.jsp" class="text-mid info">Click to register</a></h2>
    <a href="html/home.jsp" class="text-mid info">Browse without account</a>
</form>
<!--loginForm end-->

<!--footer begin-->
<%@include file="common/footer.jsp"%>
<!--footer end-->


<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>
<script src="js/sha1.js"></script>

<!--js-->
<script src="js/passwordEncrypt.js"></script>
<script src="js/verification&Encrypt.js"></script>

</body>
</html>