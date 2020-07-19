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
<?php
session_start();
require_once('../php/query.php');
if (isset($_POST['imgId'])) {
    $img = getImg($_POST['imgId']);
    $imgId = $_POST['imgId'];
} else $imgId = "";
$UID = $_SESSION['UID'];
?>
<!--url process end-->


<header>
    <!--navigation begin-->
    <nav>
        <div id="navigation">
            <a href="home.php">Home</a>
            <a href="browser.php">Browser</a>
            <a href="search.php">Searcher</a>
        </div>
        <?php
        echo '<div id="userMenu"><span>UserCenter</span>
            <ul>
                <li><a class="currentMenu" href="upload.php"><img src="../../img/icon/upload.png" alt="upload" class="icon"> Upload</a>
                </li>
                <li><a href="mine.php"><img src="../../img/icon/photo.png" alt="myphoto" class="icon"> MyPhoto</a></li>
                <li><a href="favor.php"><img src="../../img/icon/favored.png" alt="favor" class="icon"> MyFavor</a>
                </li>
                <li><a href="../php/logout.php"><img src="../../img/icon/logout.png" alt="logout" class="icon"> Logout</a>
                </li>
            </ul>
        </div>';
        ?>
        <br>
    </nav>
    <!--navigation end-->
</header>


<!--upload begin-->
<form enctype="multipart/form-data" action="../php/upload.php"
      class="container bd-form p-3 repository-color justify-content-center mt-3" method="post">
    <?php
    //如有id，输出图片,如无id，输出待上传
    if (isset($_POST['imgId'])) echo '<img class="w-100 mb-3" src="../../img/travel/' . $img['PATH'] . '" alt="The Photo" id="uploadedImg">';
    else echo '<img class="w-100 mb-3" src="" alt="The Photo" id="uploadedImg" style="display: none">';
    ?>
    <input type="text" style="display: none" name="imgId" value="<?php echo $imgId ?>">
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100">Photo</span>
            </div>
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="file" name="file">
                <label class="custom-file-label" for="file">
                    <?php
                    if (isset($_POST['imgId'])) echo 'Change the photo';
                    else echo 'Choose a photo';
                    ?>
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
                <?php
                if (isset($_POST['imgId'])) echo 'value="' . $img['Title'] . '"';
                ?>>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend  p-0  p-0">
                <span class="input-group-text w-100" id="imgContent">Content</span>
            </div>
            <?php
            function getSelectedContent($index)
            {
                switch ($index) {
                    case 1:
                        $result = 'scenery';
                        break;
                    case 2:
                        $result = 'city';
                        break;
                    case 3:
                        $result = 'people';
                        break;
                    case 4:
                        $result = 'animal';
                        break;
                    case 5:
                        $result = 'building';
                        break;
                    case 6:
                        $result = 'wonder';
                        break;
                    case 7:
                        $result = 'other';
                        break;
                    default:
                        $result = '';
                }
                return $result;
            }

            ?>
            <select class="form-control  p-0" name="content" id="content">
                <?php
                for ($i = 0; $i < 8; $i++) {
                    $contentText = getSelectedContent($i);
                    echo '<option ';
                    if (isset($img)) if ($img['Content'] == $contentText) echo 'selected ';
                    echo 'value="' . $contentText . '">';
                    if ($i == 0) $contentText = 'Choose content';
                    echo $contentText . '</option>';
                }
                ?>
            </select>
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100" id="imgCountry">Country</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="Country here" name="country" id="country"
            <?php
            if (isset($_POST['imgId'])) echo ' value="' . getCountry($img['Country_RegionCodeISO']) . '"';
            ?>">
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend p-0">
                <span class="input-group-text w-100" id="imgCity">City</span>
            </div>
            <input type="text" class="form-control  p-0" placeholder="City here" name="city" id="city"
            <?php
            if (isset($_POST['imgId'])) echo ' value="' . getCity($img['CityCode']) . '"';
            ?>">
        </div>
    </div>
    <div class="row mx-0 px-0">
        <div class="input-group mb-3">
            <div class="input-group-prepend  p-0">
                <span class="input-group-text w-100">Description</span>
            </div>
            <textarea class="form-control  p-0" rows="6" placeholder="Description here" id="description"
                      name="description"><?php if (isset($_POST['imgId'])) echo $img['Description']; ?></textarea>
        </div>
    </div>

    <div class="row p-0 m-0 justify-content-center">
        <button type="submit" class="btn btn-secondary mx-auto"
                id="submit"><?php if (isset($_POST['imgId'])) echo 'Modify'; else echo 'Upload' ?></button>
    </div>
</form>
<!--upload end-->

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
<script src="../js/uploadImg.js"></script>
</body>
</html>