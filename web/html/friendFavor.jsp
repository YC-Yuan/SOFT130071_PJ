<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-FriendFavor</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/repository.css">

</head>
<body>

<!--url process start-->
<%
    if (request.getParameter("page") == null) request.setAttribute("page", (long) 1);
    else request.setAttribute("page", Long.parseLong(request.getParameter("page")));
%>
<%
    if (request.getAttribute("img") == null) request.getRequestDispatcher("/friendFavor").forward(request, response);
%>
<!--url process end-->


<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("userMenu").children[1].children[2].children[0].className = "currentMenu"</script>
    <!--navigation end-->
</header>
<!--repository begin-->
<div id="repository" class="containe bd-form mx-auto my-3 p-0 repository-color justify-content-center">
    <h1 class="title text-big text-center">${requestScope.friend.userName}'s Favor</h1>
    <c:if test="${requestScope.num==0}">
        <div class="repository-box p-2 "><p class="text-big text-info text-center">Try to favor photo you like!<br/>You
            can favor any photo in details page(click the photo)~</p></div>
    </c:if>
    <c:forEach items="${requestScope.img}" varStatus="s">
        <div class="repository-box p-2">
            <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}" class="repository-img">
                <img src="img/travel/${requestScope.img[s.index].path}" alt="myFavor"></a>
            <div class="repository-content container-ellipsis">
                <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}"
                   class="title my-1">${requestScope.img[s.index].title}</a>
                <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}"
                   class="content content-ellipsis my-1">${requestScope.img[s.index].description==null?"The author said nothiing":requestScope.img[s.index].description}</a>
            </div>
        </div>
    </c:forEach>
    <div id="page">
        <%
            long pageCurrent = (long) request.getAttribute("page");
            long pageNum = (long) request.getAttribute("pageNum");
            long pagePrevious = Math.max(1, pageCurrent - 1);
            long pageStart = Math.max(1, Math.min(pagePrevious, pageNum - 4));
            long pageEnd = Math.min(pageStart + 4, pageNum);
            long pageNext = Math.min(pageCurrent + 1, pageEnd);

            String path="html/friendFavor.jsp?friendUID="+request.getParameter("friendUID");
        %>
        <a href="<%=path%>&page=1">First</a>
        <a href="<%=path%>&page=<%=pagePrevious%>">Previous</a>
        <c:forEach varStatus="s" begin="<%=(int)pageStart%>" end="<%=(int)pageEnd%>">
            <c:if test="${s.index==page}"><strong>${page}</strong></c:if>
            <c:if test="${s.index!=page}"><a href="<%=path%>&page=${s.index}">${s.index}</a></c:if>
        </c:forEach>
        <a href="<%=path%>&page=<%=pageNext%>">Next</a>
        <a href="<%=path%>&page=<%=pageNum%>">Last (<%=pageNum%> in all)</a>
    </div>
    <hr>
    <div class="container-fluid mb-3">
        <div class="row justify-content-center"><p class="title text-center">Browse History</p></div>
        <c:forEach varStatus="s" begin="0" end="9">
            <c:if test="${s.index%2==0}"><div class="row"></c:if>
            <c:if test="${requestScope.history[s.index]!=null}">
                <div class="col-6">
                    <span class="text-info text-big">Img${s.index}: </span>
                    <a href="html/details.jsp?imgId=${requestScope.history[s.index].img.imageId}"
                       class="content text-center">${requestScope.history[s.index].img.title}</a>
                </div>
            </c:if>
            <c:if test="${s.index%2==1}"></div></c:if>
        </c:forEach>
    </div>
</div>

<!--repository end-->

<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->
</body>

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/textEllipsis.js"></script>
</html>