<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Searcher</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/searcher.css">

</head>
<body>
<!--url process start-->
<%
    if (request.getParameter("page") == null) request.setAttribute("page", (long) 1);
    else request.setAttribute("page", Long.parseLong(request.getParameter("page")));
    if (request.getParameter("searchMethod") != null && request.getAttribute("img") == null)
        request.getRequestDispatcher("/searcher").forward(request, response);
%>
<!--url process end-->
<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("navigation").children[2].className = "currentPage"</script><!--navigation end-->
</header>

<div class="container-fluid justify-content-start">
    <div class="row">
        <div class="col-3 p-3 m-0">
            <!--aside begin-->
            <%--表单各项name：
            searchText  searchMethod:byTitle byContent  orderMethod:byTme byHeat--%>
            <aside class="bd-form">
                <form id="searcher" action="searcher" method="get">
                    <input type="text" name="page" value="1" class="d-none"/>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Key word:</span>
                        </div>
                        <input type="text" class="form-control" aria-label="Search text" name="searchText"
                               <c:if test="${param.searchText!=null}">value="${param.searchText}"</c:if>>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="searchMethod" id="methodTitle"
                               value="byTitle"
                               <c:if test="${param.searchMethod!='byContent'}">checked</c:if>>
                        <label class="form-check-label content" for="methodTitle">
                            Search by title
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="searchMethod" id="methodContent"
                               value="byContent"
                               <c:if test="${param.searchMethod=='byContent'}">checked</c:if>>
                        <label class="form-check-label content" for="methodContent">
                            Search by content
                        </label>
                    </div>
                    <hr/>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="orderMethod" id="methodTime"
                               value="byTime"
                               <c:if test="${param.orderMethod!='byHeat'}">checked</c:if>>
                        <label class="form-check-label content" for="methodTime">
                            Order by time
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="orderMethod" id="methodHeat"
                               value="byHeat"
                               <c:if test="${param.orderMethod=='byHeat'}">checked</c:if>>
                        <label class="form-check-label content" for="methodHeat">
                            Order by heat
                        </label>
                    </div>
                    <button type="submit" class="btn btn-outline-secondary mx-0 mt-3">Search</button>
                </form>
            </aside>
            <!--aside end-->
        </div>
        <div class="col-9 p-3 m-0">
            <!--browser begin-->
            <div id="content">
                <c:if test="${requestScope.img==null}"><p class="text-info text-big text-center">
                    Search photos by title or content!</p></c:if>
                <c:if test="${requestScope.num==0}"><p class="text-info text-big text-center">
                    No eligible photo!</p></c:if>
                <table class="w-100">
                    <%--输出9图，三行*3列--%>
                    <c:forEach varStatus="s" begin="0" end="8">
                        <c:if test="${s.index%3==0}">
                            <tr>
                        </c:if>
                        <td>
                            <c:if test="${requestScope.img[s.index]!=null}">
                                <a href="html/details.jsp?imgId=${requestScope.img[s.index].imageId}">
                                    <img src="img/travel/${requestScope.img[s.index].path}" class="squareImg"
                                         alt="searchImg">
                                </a>
                            </c:if>
                        </td>
                        <c:if test="${s.index%3==2}">
                            </tr>
                        </c:if>
                    </c:forEach>
                    </td>
                </table>
            </div>

            <!--page start-->
            <c:if test="${requestScope.img!=null&&requestScope.num!=0}">
                <div id="page">
                    <%
                        long pageCurrent = (long) request.getAttribute("page");
                        long pageNum = (long) request.getAttribute("pageNum");
                        long pagePrevious = Math.max(1, pageCurrent - 1);
                        long pageStart=Math.max(1,Math.min(pagePrevious,pageNum-4));
                        long pageEnd = Math.min(pageStart + 4, pageNum);
                        long pageNext = Math.min(pageCurrent + 1, pageEnd);
                        String selfPath = "html/search.jsp?searchText=" + request.getParameter("searchText") +
                                "&searchMethod=" + request.getParameter("searchMethod") +
                                "&orderMethod=" + request.getParameter("orderMethod");
                    %>
                    <a href="<%=selfPath%>&page=1">First</a>
                    <a href="<%=selfPath%>&page=<%=pagePrevious%>">Previous</a>
                    <c:forEach varStatus="s" begin="<%=(int)pageStart%>" end="<%=(int)pageEnd%>">
                        <c:if test="${s.index==page}"><strong>${page}</strong></c:if>
                        <c:if test="${s.index!=page}"><a href="<%=selfPath%>&page=${s.index}">${s.index}</a></c:if>
                    </c:forEach>
                    <a href="<%=selfPath%>&page=<%=pageNext%>">Next</a>
                    <a href="<%=selfPath%>&page=<%=pageNum%>">Last (<%=pageNum%> in all)</a>
                </div>
            </c:if>
            <!--page end-->

            <!--browser end-->
        </div>
    </div>
</div>
<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->

<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/imgSquare.js"></script>
</body>
</html>