<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>3Fish1Tea-Home</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/home.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<?php
session_start();
$random = false;
if (isset($_GET['refresh'])) {
    $random = true;
}
require_once('../php/config.php');
require_once('../php/homeQuery.php');
?>
<!--url process end-->

<header>
    <!--navigation begin-->
    <nav>
        <div id="navigation">
            <a class="currentPage" href="home.php">Home</a>
            <a href="browser.php">Browser</a>
            <a href="search.php">Searcher</a>
        </div>
        <?php
        //如果登陆了，正常展示，最后一个为退出登录
        if (isset($_SESSION['UID'])) {
            echo '<div id="userMenu"><span>UserCenter</span>
            <ul>
                <li><a href="upload.php"><img src="../../img/icon/upload.png" alt="upload" class="icon"> Upload</a>
                </li>
                <li><a href="mine.php"><img src="../../img/icon/photo.png" alt="myphoto" class="icon"> MyPhoto</a></li>
                <li><a href="favor.php"><img src="../../img/icon/favored.png" alt="favor" class="icon"> MyFavor</a>
                </li>
                <li><a href="../php/logout.php"><img src="../../img/icon/logout.png" alt="logout" class="icon"> Logout</a>
                </li>
            </ul>
        </div>';
        } //如果没登录，整个改成登录
        else {
            echo '<div id="userMenu"><a href="login.php">Login</a>';
        }
        ?>
        <br>
    </nav>
    <!--navigation end-->

    <!--homeCarousel begin-->
    <div id="homeCarousel" class="carousel slide carousel-fade m-auto w-50" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <?php
                $carousel = getHotRandom(3);
                $img = $carousel->fetch();
                echo '<a href="details.php?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="../../img/travel/<?php
                echo $img['PATH'];
                ?>" alt="First slide"><?php echo '</a>'; ?>
            </div>
            <div class="carousel-item">
                <?php
                $img = $carousel->fetch();
                echo '<a href="details.php?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="../../img/travel/<?php
                echo $img['PATH'];
                ?>" alt="Second slide"><?php echo '</a>'; ?>
            </div>
            <div class="carousel-item">
                <?php
                $img = $carousel->fetch();
                echo '<a href="details.php?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="../../img/travel/<?php
                echo $img['PATH'];
                ?>" alt="Third slide"><?php echo '</a>'; ?>
            </div>
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
<?php
function echoHotDiv($random)
{
    if ($random) $result = getHotRandom(6);
    else $result = getHot();

    for ($i = 1; $i <= 3; $i++) {
        echo '<div class="row  mx-0">';
        echo '<div class="col-12 col-xl-6 my-2">';
        $row = $result->fetch();
        echoHotImg($row);
        echo '</div>';
        echo '<div class="col-12 col-xl-6 my-2">';
        $row = $result->fetch();
        echoHotImg($row);
        echo '</div>';
        echo '</div>';
    }
}

function echoHotImg($img)
{
    $imgPath = $img['PATH'];
    $imgTitle = $img['Title'];
    $imgDescription = $img['Description'];
    $imgId = $img['ImageID'];
    echo '<div class="homeHotImg bd-content">';
    echo '<a href="details.php?imgId=' . $imgId . '"><img src="../../img/travel/' . $imgPath . '" alt="首页热门图1"></a>';
    echo '<div class="hotDiv container-ellipsis">';
    echo '<a href="details.php" class="title">' . $imgTitle . '</a>';
    echo '<a href="details.php" class="hotImgContent content content-ellipsis">';
    echo $imgDescription;
    echo '</a>';
    echo '</div>';
    echo '</div>';
}

?>
<div class="homeHot container-fluid" id="homeHot">
    <?php
    echoHotDiv($random);
    ?>
</div>
<!--hotImages end-->

<!--buttons begin-->
<div class="floatButton-home">
    <a href="home.php?refresh=true">
        <img id="refresh" src="../../img/icon/refresh.png" alt="refreshButton">
    </a>
    <a href="#navigation">
        <img id="toTop" src="../../img/icon/toTop.png" alt="toTopButton">
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

<!--bootstrap4-->
<script src="../bootstrap4/jquery-3.5.1.min.js"></script>
<script src="../bootstrap4/popper.min.js"></script>
<script src="../bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="../js/textEllipsis.js"></script>
</body>
</html>