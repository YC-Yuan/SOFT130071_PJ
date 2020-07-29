<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-Details</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/details.css">

</head>
<body onresize="changeLine()" onload="changeLine()">

<!--url process start-->
<%
    session.setAttribute("prePage", request.getRequestURL().append("?imgId=").append(request.getParameter("imgId")));
%>
<% if (request.getAttribute("imgFull") == null)
    request.getRequestDispatcher("/details?imgId?" + request.getParameter("imgId")).forward(request, response);%>
<!--url process end-->

<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <!--navigation end-->
</header>

<!--details begin-->
<div class="container bd-form pt-1 pb-1 repository-color" id="box">
    <%--    <div class="row my-1 mx-1 justify-content-center" id="smallBox">--%>
    <%--        <img class="w-100" src="img/travel/${requestScope.imgFull.img.path}" alt="The Photo">--%>
    <%--    </div>--%>
    <!-- origin img -->
    <div id="small-box" class="m-auto">
        <!-- zoom -->
        <div id="float-box"></div>
        <img src="img/travel/${requestScope.imgFull.img.path}"/>
    </div>
    <!-- zoomed img -->
    <div id="big-box">
        <img src="img/travel/${requestScope.imgFull.img.path}"/>
    </div>
    <%--    <div id="bigBox">--%>
    <%--        <img src="img/travel/${requestScope.imgFull.img.path}">--%>
    <%--    </div>--%>
    <div class="row my-1 mx-1  justify-content-center">
        <p class="text-mid m-0"><span id="title" class="text-info">${requestScope.imgFull.img.title}</span>
            by
            <span id="Author" class="text-info">${requestScope.imgFull.user.userName}</span>
        </p>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <c:if test="${sessionScope.UID!=null}">
            <button type="button" class="btn btn-default btn-lg" id="button"
                    name="${sessionScope.UID}&${requestScope.imgFull.img.imageId}">
                <span class="mx-4" id="favorNum">FavorNumber：${requestScope.imgFull.favorNum}</span>
                <c:if test="${requestScope.isFavored==1}"><span class="glyphicon glyphicon-star" aria-hidden="true"
                                                                id="favor">Favored</span></c:if>
                <c:if test="${requestScope.isFavored==0}"><span class="glyphicon glyphicon-star-empty"
                                                                aria-hidden="true"
                                                                id="favor">Unfavored</span></c:if>
            </button>
        </c:if>
        <c:if test="${sessionScope.UID==null}">
            <span class="mx-4" id="favorNum">FavorNumber：${requestScope.imgFull.favorNum} | <a href="html/login.jsp"
                                                                                               class="info">Login</a> to unlock favor</span>
        </c:if>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <div class="col-4 justify-content-center text-big">Content：<span
                class="text-info">${requestScope.imgFull.img.content}</span>
        </div>
        <div class="col-4 justify-content-center text-big">Country：<span
                class="text-info">${requestScope.imgFull.country.countryName}</span>
        </div>
        <div class="col-4 justify-content-center text-big">City：<span
                class="text-info">${requestScope.imgFull.city.cityName}</span>
        </div>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <div class="justify-content-center text-big">Upload:<span
                class="text-info">${requestScope.imgFull.img.time}</span></div>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <p class="title text-mid">Description：</p>
        <div class="col-10 justify-content-center text-mid content mt-2">
            <c:if test="${empty requestScope.imgFull.img.description}">
                The author said nothing
            </c:if>
            <c:if test="${!empty requestScope.imgFull.img.description}">
                ${requestScope.imgFull.img.description}
            </c:if>
        </div>
    </div>

    <div class="bd-content m-2">
        <h2 class="title text-big text-center">Comments</h2>
        <%--        评论框，登录用户可见（做成登录链接？--%>
            <form action="postComment" method="get" class="text-center p-2">
                <div class="input-group my-2">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Comment:</span>
                    </div>
                    <input type="hidden" name="imgId" value="${requestScope.imgFull.img.imageId}">
                    <input type="hidden" name="userName" value="${requestScope.imgFull.user.userName}">
                    <textarea class="form-control" aria-label="comment" name="postComment"
                              <c:if test="${sessionScope.UID==null}">placeholder="Login to comment" disabled</c:if>
                    ></textarea>
                </div>
                <button type="submit" class="btn btn-outline-dark" <c:if test="${sessionScope.UID==null}">disabled</c:if>>Post</button>
            </form>
        <%--        评论展示--%>
        <c:if test="${requestScope.comments.size()==0}">
            <div class="row justify-content-center">
                <p class="text-info text-mid">No comment yet!</p>
            </div>
        </c:if>
        <%--        排序选择--%>
        <c:if test="${requestScope.comments.size()!=0}">

        </c:if>
        <%--        未登录展示--%>
        <c:if test="${sessionScope.UID==null}">
            <c:forEach items="${requestScope.comments}" varStatus="s">
            </c:forEach>
        </c:if>
        <%--        展示自己的--%>
        <c:if test="${sessionScope.UID!=null&&requestScope.imgFull.user.uid==sessionScope.UID}">
            <c:forEach items="${requestScope.comments}" varStatus="s">

            </c:forEach>
        </c:if>
        <%--        展示别人的--%>
        <c:if test="${sessionScope.UID!=null&&requestScope.imgFull.user.uid!=sessionScope.UID}">
            <c:forEach items="${requestScope.comments}" varStatus="s">
                <hr>
                <div class="row px-4">
                    <p class="text-min">${requestScope.comments[s.index].userName}(${requestScope.comments[s.index].time}):</p>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>
<!--details end-->

<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/textEllipsis.js"></script>
<script src="js/imgSquare.js"></script>
<script src="js/favor.js"></script>
<script src="js/zoom.js"></script>
</body>
</html>