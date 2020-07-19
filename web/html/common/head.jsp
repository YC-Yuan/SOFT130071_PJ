<%--
  Created by IntelliJ IDEA.
  User: AAA
  Date: 2020/7/16
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";%>
<base href="<%=basePath%>"/>

<!--bootstrap4-->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="bootstrap4/css/bootstrap.css">

<!--css-->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/navigation.css">
<link rel="stylesheet" href="css/theme.css">

<!--icon-->
<link rel="Shortcut Icon" href="img/icon/icon.png" type="image/x-icon"/>