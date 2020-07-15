<%@ page import="priv.softPj.dao.impl.UserDaoImpl" %>
<%@ page import="priv.softPj.pojo.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<img src="../img/icon/3Fish1Tea.png" alt="登录">
<h1 class="title text-big">Welcome to DaddyTravel</h1>
<h3 class="title text-sm">Share photos you love!</h3>

<!--loginForm begin-->
<%
    String method = request.getMethod();
    System.out.println(method);
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");

    if (userName != null && password != null) {//提交了内容
        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.queryLogin(userName,password);
        if (user != null) {//登陆成功
            int uid = (int) user.getUid();
            session.setAttribute("UID",uid);
            response.sendRedirect("favor.jsp");
        }
        else {//登陆失败
            out.write("<script>alert(\"用户名或密码错误！\");</script>");
        }
    }


%>
<form class="bd-form" method="post" role="form">
    <div class="form-group">
        <label for="userName" class="info text-mid">UserName</label>
        <input type="text" class="form-control" id="userName" name="userName" placeholder="your UserName here" required
            <%if(userName!=null) out.write("value=".concat(userName));%>>
    </div>
    <div class="form-group">
        <label for="password" class="info text-mid">Password</label>
        <input type="text" class="form-control" id="password" name="password" placeholder="your password here" required
            <%if(password!=null) out.write("value=".concat(password));%>>
    </div>
    <button type="submit" id="submit" class="btn btn-light"><span class="info text-mid">Login</span></button>
    <hr>
    <h2 class="text-mid">No account? <a href="register.jsp" class="text-mid info">Click to register</a></h2>
    <a href="home.php" class="text-mid info">Browse without account</a>
</form>
<!--loginForm end-->

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
</body>
</html>