<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>favor-page</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="../common/head.jsp" %>
    <link rel="stylesheet" href="css/repository.css">

</head>
<body>
<!--url process start-->
<%
    if (request.getParameter("page") == null) request.setAttribute("page", (long) 1);
    else request.setAttribute("page", Long.parseLong(request.getParameter("page")));
%>
<% if (request.getAttribute("img") == null) request.getRequestDispatcher("/favor").forward(request, response);%>
<!--url process end-->

<c:if test="${requestScope.num==0}">
    <div class="repository-box p-2 "><p class="text-big info-img text-center">Try to favor photo you like!<br/>You
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
               class="content content-ellipsis my-1">${requestScope.img[s.index].description}</a>
            <div class="btn-toolbar justify-content-end">
                <div class="btn-group my-1" role="group" aria-label="Basic example">
                    <a href="deleteFavor?deleteId=${requestScope.img[s.index].imageId}">
                        <button type="button" class="btn btn-danger">
                            Delete
                        </button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<div id="page">
    <%
        long pageCurrent = (long) request.getAttribute("page");
        long pageNum = (long) request.getAttribute("pageNum");
        long pagePrevious = Math.max(1, pageCurrent - 1);
        long pageEnd = Math.min(pageCurrent + 4, pageNum);
        long pageNext=Math.min(pageCurrent+1,pageEnd);
    %>
    <a href="html/favor.jsp?page=1">First</a>
    <a href="html/favor.jsp?page=<%=pagePrevious%>">Previous</a>
    <c:forEach varStatus="s" begin="<%=(int)pagePrevious%>" end="<%=(int)pageEnd%>">
        <c:if test="${s.index==page}"><strong>${page}</strong></c:if>
        <c:if test="${s.index!=page}"><a href="html/favor.jsp?page=${s.index}">${s.index}</a></c:if>
    </c:forEach>
    <a href="html/favor.jsp?page=<%=pageNext%>">Next</a>
    <a href="html/favor.jsp?page=<%=pageNum%>">Last (<%=pageNum%> in all)</a>
</div>
<script>
    function iframeSatisfy() {
        let iframe = document.getElementById("iframePage");
        let bHeight = iframe.contentWindow.document.body.scrollHeight;
        let dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
        let height = Math.max(bHeight, dHeight);
        iframe.height = height;
    }

    function tryFun(){
        let iframe = document.getElementById("iframePage");
        iframe.src='html/iframe/favorPage.jsp?page=2';


    }
</script>
</body>
</html>
