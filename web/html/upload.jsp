<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Upload</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/upload.css">

</head>
<body>

<!--url process start-->
<%
    if (request.getParameter("imgId") != null && request.getAttribute("imgFull") == null)
        request.getRequestDispatcher("/getFullImg").forward(request, response);
    session.setAttribute("prePage", request.getRequestURL());
%>
<!--url process end-->


<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("userMenu").children[1].children[0].children[0].className = "currentMenu"</script>
    <!--navigation end-->
</header>

<!--upload begin-->
<form enctype="multipart/form-data" action="uploadImg" id="form"
      class="container bd-form p-3 repository-color justify-content-center mt-3" method="post">
    <img class="w-100 mb-3"
         <c:if test="${!empty param.imgId}">src="img/travel/${requestScope.imgFull.img.path}"</c:if> alt="The Photo"
         id="uploadedImg" <c:if test="${empty param.imgId}">style="display: none"</c:if>>
    <c:if test="${!empty param.imgId}">
        <input type="text" style="display: none" name="imgId" value="${param.imgId}">
    </c:if>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100">Photo</span>
            </div>
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="file" name="file">
                <label class="custom-file-label" for="file">
                    <c:if test="${!empty param.imgId}">Change the photo</c:if>
                    <c:if test="${empty param.imgId}">Choose a photo</c:if>
                </label>
            </div>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group  mb-3">
            <div class="input-group-prepend  p-0">
                <span class="input-group-text w-100" id="imgTitle">Title</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="Title here" name="title" id="title" required
            <c:if test="${!empty param.imgId}"> value="${requestScope.imgFull.img.title}"</c:if>>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend  p-0  p-0">
                <span class="input-group-text w-100" id="imgContent">Content</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="Content here" name="content" id="content" required
                    <c:if test="${!empty param.imgId}"> value="${requestScope.imgFull.img.content}"</c:if>/>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100" id="imgCountry">Country</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="Country here" name="country" id="country"
                    <c:if test="${!empty param.imgId}"> value="${requestScope.imgFull.country.countryName}"</c:if>/>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100" id="imgCity">City</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="City here" name="city" id="city"
                    <c:if test="${!empty param.imgId}"> value="${requestScope.imgFull.city.cityName}"</c:if>/>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend  p-0">
                <span class="input-group-text w-100">Description</span>
            </div>
            <textarea class="form-control  p-0" rows="6" placeholder="Description here" id="description"
                      name="description"><c:if
                    test="${!empty param.imgId}">${requestScope.imgFull.img.description}</c:if></textarea>
        </div>
    </div>
    <div class="row p-0 m-0 justify-content-center">
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary mx-auto d-none" data-toggle="modal" data-target="#uploadModal"
                id="modal">
        </button>
        <!-- Modal -->
        <div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Sure to <c:if test="${!empty param.imgId}">modify?</c:if>
                        <c:if test="${empty param.imgId}">upload?</c:if><br>
                        Please check the information!
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="submit" class="btn btn-primary" id="submit">
                            <c:if test="${!empty param.imgId}">Modify</c:if>
                            <c:if test="${empty param.imgId}">Upload</c:if>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <button type="submit" class="btn btn-secondary mx-auto" id="checkValidity">
            <c:if test="${!empty param.imgId}">Modify</c:if>
            <c:if test="${empty param.imgId}">Upload</c:if>
        </button>
    </div>
</form>
<!--upload end-->

<!--footer begin-->
<%@include file="common/footer.jsp" %>
<!--footer end-->


<!--bootstrap4-->
<script src="bootstrap4/jquery-3.5.1.min.js"></script>
<script src="bootstrap4/popper.min.js"></script>
<script src="bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="js/uploadImg.js"></script>
</body>
</html>