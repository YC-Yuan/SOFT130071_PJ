<%@ page import="priv.softPj.servlet.tools" %><%--
  Created by IntelliJ IDEA.
  User: AAA
  Date: 2020/7/30
  Time: 21:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Daddy-Welcome</title>
</head>
<body>
<script>
    alert("Welcome!  ${requestScope.userName}");

    if (${sessionScope.prePage!=null}) {
        window.location.href = "${sessionScope.prePage.toString()}";
    } else {
        window.location.href = "html/home.jsp";
    }
</script>
</body>
</html>
