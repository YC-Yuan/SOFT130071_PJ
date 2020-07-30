<%--
  Created by IntelliJ IDEA.
  User: AAA
  Date: 2020/7/16
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav>
    <div id="navigation">
        <a href="html/home.jsp"><img src="img/icon/3Fish1Tea.png" class="icon-brand" /></a>
        <a href="html/home.jsp">Home</a>
        <a href="html/search.jsp">Searcher</a>
    </div>
    <c:if test="${sessionScope.UID!=null}">
        <div id="userMenu"><span>UserCenter</span>
            <ul>
                <li><a href="html/upload.jsp"><img src="img/icon/upload.png" alt="upload" class="icon">Upload</a>
                </li>
                <li><a href="html/mine.jsp"><img src="img/icon/photo.png" alt="myphoto" class="icon">MyPhoto</a></li>
                <li><a href="html/favor.jsp"><img src="img/icon/favored.png" alt="favor" class="icon">MyFavor</a></li>
                <li><a href="html/friends.jsp"><img src="img/icon/friends.png" alt="friends" class="icon">Friends</a></li>
                <li><a href="logout"><img src="img/icon/logout.png" alt="logout" class="icon">Logout</a></li>
            </ul>
        </div>
    </c:if>
    <c:if test="${sessionScope.UID==null}">
    <div id="userMenu"><a href="html/login.jsp">Login</a>
        </c:if>
        <br>
</nav>