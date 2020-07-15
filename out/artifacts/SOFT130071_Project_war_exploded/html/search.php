<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>3Fish1Tea-Searcher</title>

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
    <nav>
        <div id="navigation">
            <a href="home.php">Home</a>
            <a href="browser.php">Browser</a>
            <a class="currentPage" href="search.php">Searcher</a>
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
</header>

<div class="container-fluid">
    <div class="row">
        <div class="col-3 p-3 m-0">
            <!--aside begin-->
            <aside class="bd-form">
                <form id="searcher">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input m-0" type="radio" name="key" id="byTitle" value="title" checked>
                        <label class="form-check-label m-0 content text-mid" for="byTitle">
                            Search by title
                        </label>
                    </div>
                    <input type="text" class="form-control w-100 mx-0 my-2" id="searchTitle" placeholder="Title here"
                           name="title">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input m-0" type="radio" name="key" id="byDescription"
                               value="description">
                        <label class="form-check-label m-0 content text-mid" for="byDescription">
                            Search by description
                        </label>
                    </div>
                    <textarea class="form-control w-100 mx-0 my-2" id="searchDescription" rows="12"
                              placeholder="Description here" name="description"></textarea>
                    <button type="submit" class="btn btn-outline-secondary m-0">Search</button>
                </form>
            </aside>
            <!--aside end-->
        </div>
        <div class="col-9 p-3 m-0">
            <!--browser begin-->
            <div id="content">
                <div id="searcherHot">
                    <?php
                    function echoTable()//在此完成检索
                    {
                        if ($_SERVER['REQUEST_METHOD'] == 'GET') {
                            if (isset($_GET['key'])) {//有搜索条件
                                if ($_GET['key'] == "title") {//按title搜索
                                    if (isset($_GET['title'])) {
                                        $result = getImgByTitle($_GET['title']);
                                    }
                                } elseif (isset($_GET['description'])) {
                                    $result = getImgByDescription($_GET['description']);
                                }
                            }else{echo '<p class="info-img text-big text-center">Search photos by title or description.</p>';}

                            if (isset($result)) {
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
                                // echo '<td><a href="details.php"><img class="tool" src="../../img/icon/3Fish1Tea.png" alt="布局用工具图"></a></td>';
                                echo '</table>';
                            }
                        }
                    }

                    function echoTdImg($img)
                    {
                        $imgPath = $img['PATH'];
                        $imgId = $img['ImageID'];
                        echo '<td>';
                        echo '<a href="details.php?imgId=' . $imgId . '"><img src="../../img/travel/' . $imgPath . '" alt="浏览图片" class="squareImg"></a>';
                        echo '</td>';
                    }

                    echoTable();

                    $pageCapacity = 5;
                    if (!isset($pageNum)) $pageNum = 0;
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
                    echo '<a href="search.php?page=1">First</a>';
                    echo '<a href="search.php?page=' . previousPage($page) . '">Previous</a>';
                    for ($i = $start; $i < $end + 1; $i++) {
                        if ($i == $page) echo '<strong>' . $page . '</strong>';
                        else echo '<a href="search.php?page=' . $i . '">' . $i . '</a>';
                    }
                    echo '<a href="search.php?page=' . nextPage($page, $pageNum) . '">Next</a>';
                    echo '<a href="search.php?page=' . $pageNum . '">Last (' . $pageNum . ' in all)</a>';
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