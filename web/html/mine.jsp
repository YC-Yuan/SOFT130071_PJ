<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>Daddy-MyPhoto</title>

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
<% if (request.getAttribute("img") == null) request.getRequestDispatcher("/mine").forward(request, response);%>
<!--url process end-->

<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("userMenu").children[1].children[1].children[0].className = "currentMenu"</script>
    <!--navigation end-->
</header>
<!--repository begin-->
<div id="repository" class="container bd-form mx-auto my-3 p-0 repository-color">
    <h1 class="title text-big text-center">My Photo</h1>
    <c:if test="${requestScope.num==0}">
        <div class="repository-box p-2 "><p class="text-big info-img text-center">Try to upload your own photo!<br/>You
            can find Upload in UserCenter~</p></div>
    </c:if>

    <c:forEach items="${requestScope.img}" varStatus="s">
        <div class="repository-box p-2">
            <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}" class="repository-img">
                <img src="img/travel/${requestScope.img[s.index].path}" alt="myPhoto"></a>
            <div class="repository-content container-ellipsis">
                <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}"
                   class="title my-1">${requestScope.img[s.index].title}</a>
                <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}"
                   class="content content-ellipsis my-1">${requestScope.img[s.index].description}</a>
                <div class="btn-toolbar justify-content-end">
                    <div class="btn-group my-1" role="group" aria-label="Basic example">
                        <form method="post" action="html/upload.jsp"><input type="hidden" name="imgId"
                                                                            value="${requestScope.img[s.index].imageId}">
                            <button type="submit" class="btn btn-secondary">Modify</button>
                        </form>
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">
                            Delete
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
                             aria-labelledby="deleteModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel">Warning</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        The delete operation is irrevocable!
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close
                                        </button>
                                        <a href="deleteImg?deleteId=${requestScope.img[s.index].imageId}">
                                            <button type="button" class="btn btn-danger">Delete</button>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!--page start-->
    <div id="page">
        <%
            long pageCurrent = (long) request.getAttribute("page");
            long pageNum = (long) request.getAttribute("pageNum");
            long pagePrevious = Math.max(1, pageCurrent - 1);
            long pageEnd = Math.min(pageCurrent + 4, pageNum);
            long pageNext=Math.min(pageCurrent+1,pageEnd);
        %>
        <a href="html/mine.jsp?page=1">First</a>
        <a href="html/mine.jsp?page=<%=pagePrevious%>">Previous</a>
        <c:forEach varStatus="s" begin="<%=(int)pagePrevious%>" end="<%=(int)pageEnd%>">
            <c:if test="${s.index==page}"><strong>${page}</strong></c:if>
            <c:if test="${s.index!=page}"><a href="html/mine.jsp?page=${s.index}">${s.index}</a></c:if>
        </c:forEach>
        <a href="html/mine.jsp?page=<%=pageNext%>">Next</a>
        <a href="html/mine.jsp?page=<%=pageNum%>">Last (<%=pageNum%> in all)</a>
    </div>
    <!--page end-->
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