<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-Details</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/details.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../../img/icon/icon.png" type="image/x-icon"/>

</head>
<body onresize="changeLine()" onload="changeLine()">

<!--url process start-->
<?php
session_start();
?>
<!--url process end-->

<header>
    <!--navigation begin-->
    <nav>
        <div id="navigation">
            <a href="home.php">Home</a>
            <a href="browser.php">Browser</a>
            <a href="search.jsp">Searcher</a>
        </div>
        <?php
        //如果登陆了，正常展示，最后一个为退出登录
        if (isset($_SESSION['UID'])) {
            $UID = $_SESSION['UID'];
            echo '<div id="userMenu"><span>UserCenter</span>
            <ul>
                <li><a href="upload.jsp"><img src="../../img/icon/upload.png" alt="upload" class="icon"> Upload</a>
                </li>
                <li><a href="mine.jsp"><img src="../../img/icon/photo.png" alt="myphoto" class="icon"> MyPhoto</a></li>
                <li><a href="favor.php"><img src="../../img/icon/favored.png" alt="favor" class="icon"> MyFavor</a>
                </li>
                <li><a href="../php/logout.php"><img src="../../img/icon/logout.png" alt="logout" class="icon"> Logout</a>
                </li>
            </ul>
        </div>';
        } //如果没登录，整个改成登录
        else {
            $UID = '';
            echo '<div id="userMenu"><a href="login.php">Login</a>';
        }
        ?>
        <br>
    </nav>
    <!--navigation end-->
</header>

<!--details begin-->
<?php
require_once('../php/config.php');
require_once('../php/query.php');
$pdo = new PDO(DBCONNSTRING, DBUSER, DBPASS);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//按图片ID搜索图片
$imgId = $_GET['imgId'];
$img = getImg($imgId);

//将img打散为需要的信息
$imgTitle = $img['Title'];
if ($img['Description'] != null) $imgDescription = $img['Description'];
else$imgDescription = 'The author said nothing';
$imgContent = $img['Content'];
$imgPath = $img['PATH'];

//获取城市
$imgCity = getCity($img['CityCode']);

//获取国家
$imgCountry = getCountry($img['Country_RegionCodeISO']);

//由UID获取上传者
$imgAuthor = getUserName($img['UID']);
?>
<div class="container bd-form pt-1 pb-1 repository-color">
    <div class="row my-1 mx-1 justify-content-center">
        <img class="w-100" src="../../img/travel/<?php echo $imgPath ?>" alt="The Photo">
    </div>
    <div class="row my-1 mx-1  justify-content-center">
        <p class="text-mid m-0"><span id="title" class="info-img"><?php echo $imgTitle; ?></span> by <span id="Author"
                                                                                                           class="info-img"><?php echo $imgAuthor ?></span>
        </p>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <?php
        //获取收藏数
        $favorNum = getFavorNum($imgId);
        if ($UID !== '') {
            $isFavored = isFavored($UID, $imgId);
            echo '<button type="button" class="btn btn-default btn-lg" id="button" name="' . $UID . '&' . $imgId . '">';
            echo '<span class="mx-4" id="favorNum">FavorNumber：' . $favorNum . '</span>';
            if ($isFavored) {
                echo '<span class="glyphicon glyphicon-star" aria-hidden="true" id="favor">Favored</span>';
            } else {
                echo '<span class="glyphicon glyphicon-star-empty" aria-hidden="true" id="favor">Unfavored</span>';
            }
            echo '</button>';
        } else {
            echo '<span class="mx-4" id="favorNum">FavorNumber：' . $favorNum . ' | <a href="login.php" class="info">Login</a> to unlock favor</span>';
        }
        ?>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <div class="col-4 justify-content-center text-big">Content：<span
                    class="info-img"><?php echo $imgContent; ?></span>
        </div>
        <div class="col-4 justify-content-center text-big">Country：<span
                    class="info-img"><?php echo $imgCountry; ?></span>
        </div>
        <div class="col-4 justify-content-center text-big">City：<span class="info-img"><?php echo $imgCity; ?></span>
        </div>
    </div>
    <div class="row my-1 mx-1 justify-content-center">
        <p class="title text-mid">Description：</p>
        <div class="col-10 justify-content-center text-mid content mt-2">
            <?php
            if ($imgDescription != null) {
                echo $imgDescription;
            } else {
                echo 'The author said nothing';
            }
            ?>
        </div>
    </div>
</div>
<!--details end-->

<!--footer begin-->
<footer>
    <hr>
    <p>沪私危备案74751号</p>
    <p>版权&copy;2001-2020 3Fish1Tea三鱼一茶 版权所有</p>
    <p>联系我们19302010020@fudan.edu.cn</p>
</footer>
<!--footer end-->

<!--bootstrap4-->
<script src="../bootstrap4/jquery-3.5.1.min.js"></script>
<script src="../bootstrap4/popper.min.js"></script>
<script src="../bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="../js/textEllipsis.js"></script>
<script src="../js/imgSquare.js"></script>
<script src="../js/favor.js"></script>
</body>
</html>