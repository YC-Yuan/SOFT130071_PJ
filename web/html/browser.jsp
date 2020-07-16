<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-Browser</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/browser.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<?php
session_start();

require_once('../php/browserQuery.php');
require_once('../php/query.php');
$pageNum = 0;
if (isset($_GET['page'])) {
    $page = $_GET['page'];
} else {
    $page = 1;
}

if (isset($_GET['keyword'])) {
    $keyword = $_GET['keyword'];
} else {
    $keyword = '';
}

?>
<!--url process end-->

<header>
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("navigation").children[1].className = "currentPage"</script>
    <!--navigation end-->
</header>

<div class="container-fluid">
    <div class="row">
        <div class="col-3 p-3 m-0">
            <!--aside begin-->
            <aside class="bd-form">
                <form id="searcher">
                    <label class="text-nowrap content" for="searchByTitle">Search by title</label>
                    <form>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="Title" id="searchByTitle"
                                   placeholder="Title here" required>
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="submit" id="searchTitle">Search</button>
                            </div>
                        </div>
                    </form>
                </form>
                <div class="hotSection">
                    <h3 class="text-nowrap content"> Hottest Content</h3>
                    <ul>
                        <?php
                        $hotContent = getHottestContent(4);
                        for ($i = 1; $i <= count($hotContent); $i++) {
                            echo '<li><a href="browser.php?Content=' . $hotContent[$i - 1] . '">' . $hotContent[$i - 1] . '</a></li>';
                        }
                        ?>
                    </ul>
                </div>
                <div class="hotSection">
                    <h3 class="text-nowrap content">Hottest Country</h3>
                    <ul>
                        <?php
                        $hotCountryCode = getHottestCountryISO(4);
                        for ($i = 1; $i <= count($hotCountryCode); $i++) {
                            echo '<li><a href="browser.php?Country=' . $hotCountryCode[$i - 1] . '">' . getCountry($hotCountryCode[$i - 1]) . '</a></li>';
                        }
                        ?>
                    </ul>
                </div>
                <div class="hotSection">
                    <h3 class="text-nowrap content">Hottest City</h3>
                    <ul>
                        <?php
                        $hotCityCode = getHottestCityCode(4);
                        for ($i = 1; $i <= count($hotCityCode); $i++) {
                            echo '<li><a href="browser.php?City=' . $hotCityCode[$i - 1] . '">' . getCity($hotCityCode[$i - 1]) . '</a></li>';
                        }
                        ?>
                    </ul>
                </div>
            </aside>
            <!--aside end-->
        </div>
        <div class="col-9 p-3 m-0">
            <!--browser begin-->
            <div id="content">
                <div id="filter" class="container-fluid">
                    <div class="row justify-content-between">
                        <div class="form-group col-3">
                            <select class="form-control" id="selectContent">
                                <option value="0">Choose content</option>
                                <?php
                                $hotContent = getHottestContent(0);
                                for ($i = 1; $i <= count($hotContent); $i++) {
                                    echo '<option value="' . $hotContent[$i - 1] . '">' . $hotContent[$i - 1] . '</option>';
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-3">
                            <select class="form-control" id="selectCountry">
                                <option value="0">Choose country</option>
                                <?php
                                $hotCountryCode = getHottestCountryISO(0);
                                for ($i = 1; $i <= count($hotCountryCode); $i++) {
                                    echo '<option value="' . $hotCountryCode[$i - 1] . '">' . getCountry($hotCountryCode[$i - 1]) . '</option>';
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-3">
                            <select class="form-control" id="selectCity">
                                <option value="0">Choose city</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-outline-secondary" id="filterButton">Filter</button>
                        </div>
                    </div>
                </div>
                <div id="searcherHot">
                    <?php
                    function echoTable()//在此完成检索
                    {
                        if ($_SERVER['REQUEST_METHOD'] == 'GET') {//条件检索
                            if (isset($_GET['Title'])) {
                                $result = getImgByTitle($_GET['Title']);
                            } elseif (isset($_GET['Content'])) {
                                $result = getImgByContent($_GET['Content']);
                            } elseif (isset($_GET['Country'])) {
                                $result = getImgByCountry($_GET['Country']);
                            } elseif (isset($_GET['City'])) {
                                $result = getImgByCity($_GET['City']);
                            } elseif (isset($_GET['content']) | isset($_GET['country']) | isset($_GET['city'])) {
                                if (isset($_GET['content'])) $content = $_GET['content'];
                                else $content = null;
                                if (isset($_GET['country'])) $country = $_GET['country'];
                                else $country = null;
                                if (isset($_GET['city'])) $city = $_GET['city'];
                                else $city = null;
                                $result = getImgByAll($content, $country, $city);
                            } else $result = getAllImg();//默认检索
                        }

                        //后面为固定的输出和翻页逻辑
                        $rowNum = $result->rowCount();

                        global $pageNum;
                        $pageNum = ceil($rowNum / 16.0);

                        //翻页
                        global $page;
                        for ($i = 1; $i <= ($page - 1) * 16; $i++) $result->fetch();

                        echo '<table>';
                        for ($i = 0; $i < 4; $i++) {
                            echo '<tr>';
                            for ($j = 0; $j < 4; $j++) {
                                if ($row = $result->fetch()) echoTdImg($row);
                                else echo '<td></td>';
                            }
                            echo '</tr>';
                        }
                        // echo '<td><a href="details.jsp"><img class="tool" src="../../img/icon/3Fish1Tea.png" alt="布局用工具图"></a></td>';
                        echo '</table>';
                    }

                    function echoTdImg($img)
                    {
                        $imgPath = $img['PATH'];
                        $imgId = $img['ImageID'];
                        echo '<td>';
                        echo '<a href="details.jsp?imgId=' . $imgId . '"><img src="../../img/travel/' . $imgPath . '" alt="浏览图片" class="squareImg"></a>';
                        echo '</td>';
                    }

                    echoTable();
                    ?>

                    <?php
                    $start = 1;
                    $end = 1;
                    $pageCapacity = 5;
                    //根据当前页数和总页数判断
                    if ($pageNum <= $pageCapacity) {
                        $start = 1;
                        $end = $pageNum;
                    } elseif ($page <= $pageNum - $pageCapacity + 1) {
                        $start = $page;
                        $end = $page + $pageCapacity - 1;
                    } else {
                        $start = $pageNum - $pageCapacity + 1;
                        $end = $pageNum;
                    }

                    function previousPage($page)
                    {
                        if ($page == 1) return 1;
                        else return $page - 1;
                    }

                    function nextPage($page, $pageNum)
                    {
                        if ($page == $pageNum) return $pageNum;
                        else return $page + 1;
                    }

                    echo '<div id="page">';
                    echo '<a href="browser.php?page=1">First</a>';
                    echo '<a href="browser.php?page=' . previousPage($page) . '">Previous</a>';
                    for ($i = $start; $i < $end + 1; $i++) {
                        if ($i == $page) echo '<strong>' . $page . '</strong>';
                        else echo '<a href="browser.php?page=' . $i . '">' . $i . '</a>';
                    }
                    echo '<a href="browser.php?page=' . nextPage($page, $pageNum) . '">Next</a>';
                    echo '<a href="browser.php?page=' . $pageNum . '">Last (' . $pageNum . ' in all)</a>';
                    echo '</div>';
                    ?>
                </div>
            </div>

            <!--browser end-->
        </div>
    </div>
</div>

<!--buttons begin-->
<div class="floatButton">
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
<script src="../js/imgSquare.js"></script>
<script src="../js/linkedFilter.js"></script>
</body>
</html>