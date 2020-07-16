<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>Daddy-Home</title>

    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/home.css">

</head>
<body>

<!--url process start-->
<!--url process end-->

<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("navigation").children[0].className = "currentPage"</script>
    <!--navigation end-->

    <!--homeCarousel begin-->
    <div id="homeCarousel" class="carousel slide carousel-fade m-auto w-50" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <?php
                $carousel = getHotRandom(3);
                $img = $carousel->fetch();
                echo '<a href="details.jsp?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="img/travel/<?php
                echo $img['PATH'];
                ?>" alt="First slide"><?php echo '</a>'; ?>
            </div>
            <div class="carousel-item">
                <?php
                $img = $carousel->fetch();
                echo '<a href="details.jsp?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="img/travel/<?php
                echo $img['PATH'];
                ?>" alt="Second slide"><?php echo '</a>'; ?>
            </div>
            <div class="carousel-item">
                <?php
                $img = $carousel->fetch();
                echo '<a href="details.jsp?imgId=' . $img['ImageID'] . '">';
                ?>
                <img class="m-auto d-block" src="img/travel/<?php
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
echo '
<div class="col-12 col-xl-6 my-2">';
    $row = $result->fetch();
    echoHotImg($row);
    echo '
</div>
';
echo '
<div class="col-12 col-xl-6 my-2">';
    $row = $result->fetch();
    echoHotImg($row);
    echo '
</div>
';
echo '</div>';
}
}

function echoHotImg($img)
{
$imgPath = $img['PATH'];
$imgTitle = $img['Title'];
$imgDescription = $img['Description'];
$imgId = $img['ImageID'];
echo '
<div class="homeHotImg bd-content">';
    echo '<a href="details.jsp?imgId=' . $imgId . '"><img src="img/travel/' . $imgPath . '" alt="首页热门图1"></a>';
    echo '
    <div class="hotDiv container-ellipsis">';
        echo '<a href="details.jsp" class="title">' . $imgTitle . '</a>';
        echo '<a href="details.jsp" class="hotImgContent content content-ellipsis">';
            echo $imgDescription;
            echo '</a>';
        echo '
    </div>
    ';
    echo '
</div>
';
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
        <img id="refresh" src="img/icon/refresh.png" alt="refreshButton">
    </a>
    <a href="#navigation">
        <img id="toTop" src="img/icon/toTop.png" alt="toTopButton">
    </a>
</div>
<!--buttons end-->

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