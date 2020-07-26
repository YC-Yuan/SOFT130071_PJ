<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Home</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/home.css">

</head>
<body>

<!--url process start-->
<% if (request.getAttribute("imgHot") == null) request.getRequestDispatcher("/home").forward(request, response);%>
<!--url process end-->

<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("navigation").children[1].className = "currentPage"</script>
    <!--navigation end-->

    <!--homeCarousel begin-->
    <div id="homeCarousel" class="carousel slide carousel-fade m-auto w-50" data-ride="carousel">
        <div class="carousel-inner">
            <c:forEach items="${requestScope.imgHot}" varStatus="s">
                <div class="carousel-item <c:if test="${s.index==0}">active</c:if>">
                    <a href="html/details.jsp?imgId=${requestScope.imgHot[s.index].img.imageId}">
                        <img class="m-auto d-block" src="img/travel/${requestScope.imgHot[s.index].img.path}"
                             alt="Second slide">
                    </a>
                </div>
            </c:forEach>
        </div>
        <a class="carousel-control-prev" href="#homeCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#homeCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!--homeCarousel end-->
</header>

<!--hotImages begin-->
<c:forEach items="${requestScope.imgNew}" varStatus="s">
    <c:if test="${s.index%2==0}"><div class="row mx-0"></c:if>
    <div class="col-12 col-xl-6 my-2">
        <div class="homeHotImg bd-content">
            <a href="html/details.jsp?imgId=${requestScope.imgNew[s.index].img.imageId}"><img
                    src="img/travel/${requestScope.imgNew[s.index].img.path}" alt="latestImg"></a>
            <div class="hotDiv container-ellipsis">
                <a href="html/details.jsp?imgId=${requestScope.imgNew[s.index].img.imageId}" class="title text-big">${requestScope.imgNew[s.index].img.title}</a>
                <div class="text-sm">Author:<span class="info-img">${requestScope.imgNew[s.index].user.userName}</span></div>
                <div class="text-sm">Content:<span class="info-img">${requestScope.imgNew[s.index].img.content}</span></div>
                <div class="text-sm">Upload:<span class="info-img"><fmt:formatDate value="${requestScope.imgNew[s.index].img.time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></div>
                <a href="html/details.jsp?imgId=${requestScope.imgNew[s.index].img.imageId}" class="hotImgContent content content-ellipsis text-mid">
                    <c:if test="${requestScope.imgNew[s.index].img.description==''}">The author said nothing</c:if>
                        ${requestScope.imgNew[s.index].img.description}
                </a></div>
        </div>
    </div>
    <c:if test="${s.index%2==1}"></div></c:if>
</c:forEach>
<!--hotImages end-->

<%@include file="common/footer.jsp" %>
<!--footer end-->

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/textEllipsis.js"></script>
</body>
</html>