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
            <aside class="p-3 bd-form w-100">
                <form id="searcher" action="friends" method="get">
                    <span class="title text-center">Search by username!</span>
                    <div class="input-group my-2">
                        <div class="input-group-prepend">
                            <span class="input-group-text">User Name:</span>
                        </div>
                        <input type="text" class="form-control" aria-label="Search text" name="searchText"
                               <c:if test="${param.searchText!=null}">value="${param.searchText}"</c:if>

                        >
                    </div>
                    <button type="submit" class="btn btn-outline-secondary mx-0">Search</button>
                </form>
                <div class="container-fluid bd-content mt-3 p-2">
                    <c:if test="${requestScope.users==null}"><span
                            class="text-info text-mid">Try to find your friends!</span></c:if>
                    <c:if test="${requestScope.users.size()==0}"><span
                            class="text-info text-mid">Find nothing</span></c:if>
                    <c:forEach items="${requestScope.users}" varStatus="s">
                        <div class="row justify-content-between px-3 my-1">
                            <span class="text-center text-info text-mid my-auto">${requestScope.users[s.index].userName}</span>
                            <c:if test="${requestScope.users[s.index].status==0}">
                                <form action="sendRequest" method="get">
                                    <input type="hidden" name="toUID" value="${requestScope.users[s.index].uid}">
                                    <button type="submit" class="btn btn-outline-info">Send</button>
                                </form>
                            </c:if>
                            <c:if test="${requestScope.users[s.index].status==1&&requestScope.users[s.index].sendUid==sessionScope.UID}">
                                <button type="button" class="btn btn-dark disabled">Already sent</button>
                            </c:if>
                            <c:if test="${requestScope.users[s.index].status==1&&requestScope.users[s.index].receiveUid==sessionScope.UID}">
                                <button type="button" class="btn btn-dark disabled">Received</button>
                            </c:if>
                            <c:if test="${requestScope.users[s.index].status==2}">
                                <button type="button" class="btn btn-dark disabled">Added</button>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </aside>
        </div>

        <div class="col-9 p-3">
            <div class="p-3 bd-form w-100">
                <%--好友申请 接受--%>
                <p class="title text-center">Requests Received</p>
                <c:if test="${requestScope.requestReceive.size()==0}"><p
                        class="text-info text-mid text-center">No requests</p></c:if>
                <c:if test="${requestScope.requestReceive.size()!=0}">
                    <div class="row">
                        <div class="col-3 text-center title">Username</div>
                        <div class="col-3 text-center title">Email</div>
                        <div class="col-3 text-center title">Register Time</div>
                        <div class="col-3"></div>
                    </div>
                </c:if>
                <c:forEach varStatus="s" items="${requestScope.requestReceive}">
                    <div class="row my-2">
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestReceive[s.index].userName}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestReceive[s.index].email}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestReceive[s.index].dateJoined}</div>
                        <div class="col-3">
                            <div class="btn-group" role="group">
                                <form action="acceptRequest" method="get">
                                    <input type="hidden" name="acceptId"
                                           value="${requestScope.requestReceive[s.index].requestId}">
                                    <button type="submit" class="btn btn-outline-success">Accept</button>

                                </form>
                                <form action="deleteRequest" method="get">
                                    <input type="hidden" name="deleteId"
                                           value="${requestScope.requestReceive[s.index].requestId}">
                                    <button type="submit" class="btn btn-outline-danger">Reject</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <hr>
                <%--好友申请 送出--%>
                <p class="title text-center">Requests Sent</p>
                <c:if test="${requestScope.requestSend.size()==0}"><p
                        class="text-info text-mid text-center">No requests</p></c:if>
                <c:if test="${requestScope.requestSend.size()!=0}">
                    <div class="row">
                        <div class="col-3 text-center title">Username</div>
                        <div class="col-3 text-center title">Email</div>
                        <div class="col-3 text-center title">Register Time</div>
                        <div class="col-3"></div>
                    </div>
                </c:if>
                <c:forEach varStatus="s" items="${requestScope.requestSend}">
                    <div class="row my-2">
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestSend[s.index].userName}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestSend[s.index].email}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.requestSend[s.index].dateJoined}</div>
                        <div class="col-3">
                            <form action="deleteRequest" method="get">
                                <input type="hidden" name="deleteId"
                                       value="${requestScope.requestSend[s.index].requestId}">
                                <button type="submit" class="btn btn-outline-info">Recall</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <hr>
                <%--好友列表--%>
                <p class="title text-center">Friends List</p>
                <c:if test="${requestScope.friends.size()==0}"><p
                        class="text-info text-mid text-center">Try to search and add friend!</p></c:if>
                <c:if test="${requestScope.friends.size()!=0}">
                    <div class="row">
                        <div class="col-3 text-center title">Username</div>
                        <div class="col-3 text-center title">Email</div>
                        <div class="col-3 text-center title">Register Time</div>
                        <div class="col-3 text-center title">Friend's favor</div>
                    </div>
                </c:if>
                <%--                    需要补充好友收藏页面的跳转链接--%>
                <c:forEach varStatus="s" items="${requestScope.friends}">
                    <div class="row my-2">
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.friends[s.index].userName}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.friends[s.index].email}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">${requestScope.friends[s.index].dateJoined}</div>
                        <div class="col-3 text-center text-info text-mid my-auto">
                            <c:if test="${requestScope.friends[s.index].showFavor==1}">
                                <a href="html/friendFavor.jsp?friendUID=${requestScope.friends[s.index].uid}">
                                    <button type="button" class="btn btn-outline-info">See favor</button>
                                </a>
                            </c:if>
                            <c:if test="${requestScope.friends[s.index].showFavor!=1}">
                                <button type="button" class="btn btn-outline-dark disabled">Disabled</button>
                            </c:if>
                        </div>

                    </div>
                </c:forEach>
            </div>
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
