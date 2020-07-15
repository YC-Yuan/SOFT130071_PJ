<%@ page import="priv.softPj.dao.impl.UserDaoImpl" %>
<%@ page import="priv.softPj.pojo.Imgfavor" %>
<%@ page import="java.util.List" %>
<%@ page import="priv.softPj.dao.impl.ImgfavorDaoImpl" %>
<%@ page import="priv.softPj.dao.impl.ImgDaoImpl" %>
<%@ page import="priv.softPj.pojo.Img" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Login</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/repository.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<%
    int UID = (int) session.getAttribute("UID");//无值赋为0
%>
<!--url process end-->


<header>
    <!--navigation begin-->
    <nav>
        <div id="navigation">
            <a href="home.php">Home</a>
            <a href="browser.php">Browser</a>
            <a href="search.php">Searcher</a>
        </div>
        <%
            //如果登陆了，正常展示，最后一个为退出登录
            if (UID != 0) {
                out.write("<div id=\"userMenu\"><span>UserCenter</span><ul>" +
                        "<li><a href = \"upload.php\" ><img src = \"../img/icon/upload.png\" class=\"icon\" >Upload</a ></li>" +
                        "<li><a href = \"mine.php\" ><img src = \"../img/icon/photo.png\" class=\"icon\" >MyPhoto</a ></li>" +
                        "<li><a class=\"currentMenu\" href = \"favor.php\" ><img src = \"../img/icon/favored.png\" alt = \"favor\" class=\"icon\">MyFavor</a></li>" +
                        "<li><a href = \"../php/logout.php\" ><img src = \"../img/icon/logout.png\" alt = \"logout\" class=\"icon\" >Logout</a></li></ul>" +
                        "</div >");
            } //如果没登录，整个改成登录
            else {
                out.print("<div id=\"userMenu\"><a href=\"login.php\">Login</a>");
            }
        %>
        <br>
    </nav>
    <!--navigation end-->
</header>
<!--repository begin-->
<div id="repository" class="container bd-form mx-auto my-3 p-0 repository-color">
    <h1 class="title text-big text-center">My Favor</h1>
    <%
        if (UID != 0) {//如果登录
            //查询收藏，计算页数
            ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();
            ImgDaoImpl imgDao = new ImgDaoImpl();
            List<Imgfavor> imgfavorList = imgfavorDao.queryFavorByUID(UID);
            for (Imgfavor imgfavor : imgfavorList) {
                //输出一张图
                int imgId = (int) imgfavor.getImageId();
                Img img = imgDao.queryImgById(imgId);

                out.write("<div class=\"repository-box p-2\">" +
                        "<a href=\"details.php?imgId=" + img.getUid() + "\" class=\"repository-img\"><img src=\"../img/travel/" + img.getPath() + "\" alt=\"myFavored\"></a>" +
                        "<div class=\"repository-content container-ellipsis\">" +
                        "<a href=\"details.php?imgId=" + img.getImageId() + "\" class=\"title my-1\">" + img.getTitle() + "</a>" +
                        "<a href=\"details.php?imgId=" + img.getImageId() + "\" class=\"content content-ellipsis my-1\">" + img.getDescription() + "</a>" +
                        "<div class=\"btn-toolbar justify-content-end\">" +
                        "<div class=\"btn-group my-1\" role=\"group\" aria-label=\"Basic example\">" +
                        "<a href=\"favor.php?delete=" + img.getImageId() + "\"><button type=\"button\" class=\"btn btn-danger\">Delete</button></a>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "</div>");
            }
        }
    %>
</div>

<!--repository end-->

<!--buttons begin-->
<div class="floatButton">
    <a href="#navigation">
        <img id="toTop" src="../img/icon/toTop.png" alt="toTopButton">
    </a>
</div>
<!--buttons end-->

<!--footer begin-->
<footer>
    <hr>
    <p>沪私危备案74751号</p>
    <p>版权&copy;2001-2020 3Fish1Tea三鱼一茶 版权所有</p>
    <p>联系我们19302010020@fudan.edu.cn</p>
</footer>
<!--footer end-->
</body>

<!--bootstrap4-->
<script src="../bootstrap4/jquery-3.5.1.min.js"></script>
<script src="../bootstrap4/popper.min.js"></script>
<script src="../bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="../js/textEllipsis.js"></script>
<script src="../js/favor.js"></script>
</html>