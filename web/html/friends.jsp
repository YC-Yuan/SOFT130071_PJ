<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Friends</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/friends.css">
</head>
<body>
<!--url process start-->
<%
    //没内容的话，发送请求
    if (request.getAttribute("friends") == null)
        request.getRequestDispatcher("/friends").forward(request, response);
%>
<!--url process end-->
<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("userMenu").children[1].children[3].children[0].className = "currentMenu"</script>
    <!--navigation end-->
</header>
<div class="container-fluid">
    <div class="row">
        <%--搜索好友--%>
        <div class="col-3 p-3">
            <aside class="p-3 bd-form">
                <form id="searcher" action="friends" method="get">
                    <p class="title text-center">Search by username!</p>
                    <div class="input-group my-2">
                        <div class="input-group-prepend">
                            <span class="input-group-text">User Name:</span>
                        </div>
                        <input type="text" class="form-control" aria-label="Search text" name="searchText"
                               <c:if test="${param.searchText!=null}">value="${param.searchText}"</c:if>>
                    </div>
                    <button type="submit" class="btn btn-outline-secondary mx-0">Search</button>
                </form>
                <div class="bd-content mt-3 p-2">
                    <c:if test="${requestScope.users==null}"><span class="text-info text-mid">Try to find your friends!</span></c:if>
                    <c:forEach items="${requestScope.users}" varStatus="s">
                    <div class="justify-content-between">
                        <span class="text-mid">${requestScope.users[s.index].userName}</span>
                        <button type="button" class="btn btn-info ml-auto">Add</button>
                    </div>
                    </c:forEach>
                </div>
            </aside>
        </div>

        <%--好友列表--%>
        <div class="col-9 p-3">

        </div>

    </div>
</div>
<!---->


<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->
</body>

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

</html>
