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
<div class="container bd-form pt-1 pb-1 repository-color">
    <div class="row my-1 mx-1 justify-content-center">
        <img class="w-100" src="img/travel/${requestScope.imgFull.img.path}" alt="The Photo">
    </div>
    <div class="row my-1 mx-1  justify-content-center">
        <p class="text-mid m-0"><span id="title" class="info-img">${requestScope.imgFull.img.title}</span>
            by
            <span id="Author" class="info-img">${requestScope.imgFull.user.userName}</span>
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
                class="info-img">${requestScope.imgFull.img.content}</span>
        </div>
        <div class="col-4 justify-content-center text-big">Country：<span
                class="info-img">${requestScope.imgFull.country.countryName}</span>
        </div>
        <div class="col-4 justify-content-center text-big">City：<span
                class="info-img">${requestScope.imgFull.city.cityName}</span>
        </div>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <div class="justify-content-center text-big">Upload:<span
                class="info-img">${requestScope.imgFull.img.time}</span></div>
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
</body>
</html>