<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-MyPhoto</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/repository.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<?php
session_start();
require_once('../php/query.php');
require_once('../php/changePhoto.php');

$pageNum = 0;
if (isset($_GET['page'])) {
    $page = $_GET['page'];
} else {
    $page = 1;
}
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
                <li><a href="mine.php" class="currentMenu" ><img src="../../img/icon/photo.png" alt="myphoto" class="icon"> MyPhoto</a></li>
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
<!--repository begin-->
<div id="repository" class="container bd-form mx-auto my-3 p-0 repository-color">
    <h1 class="title text-big text-center">My Photo</h1>
    <?php
    if (isset($UID)) {
        if (isset($_GET['delete'])) {//需要进行删除
            deletePhoto($UID, $_GET['delete']);
        }

        $myPhoto = getMyPhoto($UID);
        $myNum = $myPhoto->rowCount();
        if ($myNum == 0) {
            echo '<div class="repository-box p-2 "><p class="text-big info-img text-center">Try to upload your own photo!<br/>You can find Upload in UserCenter~</p></div>';
        } else {
            global $pageNum;
            $pageNum = ceil($myNum / 6.0);
            //翻页
            global $page;
            for ($i = 1; $i <= ($page - 1) * 6; $i++) $myPhoto->fetch();

            for ($j = 1; $j <= 6; $j++) {
                if ($img = $myPhoto->fetch()) {
                    $imgDescription = $img['Description'];
                    if ($imgDescription == '') {
                        $imgDescription = 'You haven\'t described it.<br/>
                    Click the "Modify" button to write one.';
                    }
                    echo '<div class="repository-box p-2">';
                    echo '<a href="details.php?imgId=' . $img['ImageID'] . '" class="repository-img"><img src="../../img/travel/' . $img['PATH'] . '" alt="我的照片1"></a>';
                    echo '<div class="repository-content container-ellipsis">';
                    echo '<a href="details.php?imgId=' . $img['ImageID'] . '" class="title my-1">' . $img['Title'] . '</a>';
                    echo '<a href="details.php?imgId=' . $img['ImageID'] . '" class="content content-ellipsis my-1">' . $imgDescription . '</a>';
                    echo '<div class="btn-toolbar justify-content-end">';
                    echo '<div class="btn-group my-1" role="group" aria-label="Basic example">';
                    echo '<form method="post" action="upload.jsp"><input type="hidden" name="imgId" value="' . $img['ImageID'] . '"><button type="submit" class="btn btn-secondary">Modify</button></form>';
                    echo '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">
 Delete
</button>

<!-- Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <a href="mine.php?delete=' . $img['ImageID'] . '"><button type="button" class="btn btn-danger">Delete</button></a>
      </div>
    </div>
  </div>
</div>';
                    echo '</div>';
                    echo '</div>';
                    echo '</div>';
                    echo '</div>';
                    echo '';
                }
            }
        }
    }

    //页码输出
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
    echo '<a href="mine.php?page=1">First</a>';
    echo '<a href="mine.php?page=' . previousPage($page) . '">Previous</a>';
    for ($i = $start; $i < $end + 1; $i++) {
        if ($i == $page) echo '<strong>' . $page . '</strong>';
        else echo '<a href="mine.php?page=' . $i . '">' . $i . '</a>';
    }
    echo '<a href="mine.php?page=' . nextPage($page, $pageNum) . '">Next</a>';
    echo '<a href="mine.php?page=' . $pageNum . '">Last (' . $pageNum . ' in all)</a>';
    echo '</div>';
    ?>
</div>

<!--repository end-->

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
</body>

<!--bootstrap4-->
<script src="../bootstrap4/jquery-3.5.1.min.js"></script>
<script src="../bootstrap4/popper.min.js"></script>
<script src="../bootstrap4/js/bootstrap.js"></script>

<!--js-->
<script src="../js/textEllipsis.js"></script>
</html>