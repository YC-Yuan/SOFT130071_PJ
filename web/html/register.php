<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-Register</title>

    <!--bootstrap4-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../bootstrap4/css/bootstrap.css">

    <!--css-->
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/navigation.css">
    <link rel="stylesheet" href="../css/theme.css">
    <link rel="stylesheet" href="../css/login.css">

    <!--icon-->
    <link rel="Shortcut Icon" href="../../img/icon/icon.png" type="image/x-icon"/>

</head>
<body>

<!--url process start-->
<?php
session_start();
require_once("../php/pdo.php");
require_once("../php/salt.php");
require_once("../php/query.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $pass = $_POST['pass'];

    $info = encrypt($pass);
    $infos = explode(" ", $info);
    $pass = $infos[0];
    $salt = $infos[1];

    $sql = '
INSERT INTO `traveluser` (`Email`, `UserName`, `Pass`,`Salt`)
VALUES ("' . $email . '", "' . $name . '", "' . $pass . '", "' . $salt . '")';


    if ($result = pdo($sql)) {
        $UID = getUID($name);//拿到刚刚插入时的UID
        $_SESSION['UID'] = $UID;
        header("Location:./home.php");
    }
}
?>
<!--url process end-->

<img src="../../img/icon/3Fish1Tea.png" alt="icon">
<h1 class="title text-big">Welcome to 3Fish1Tea</h1>
<h3 class="title text-sm">Share photos you love!</h3>

<!--registerForm begin-->
<form class="bd-form" method="post">
    <div class="form-group">
        <label for="userName" class="info text-mid">UserName</label>
        <input type="text" class="form-control" id="userName" name="name" placeholder="your userName here" required>
    </div>
    <div class="form-group">
        <label for="e-mail" class="info text-mid">E-mail</label>
        <input type="email" class="form-control" id="e-mail" name="email" aria-describedby="emailHelp"
               placeholder="your email here"
               required>
    </div>
    <div class="form-group">
        <label for="password" class="info text-mid">Password</label>
        <input type="password" class="form-control" id="password" name="pass" placeholder="your password here" required>
    </div>
    <div class="form-group">
        <label for="passwordConfirm" class="info text-mid">ConfirmPassword</label>
        <input type="password" class="form-control" id="passwordConfirm" placeholder="your password again" required>
    </div>
    <button type="submit" id="submit" class="btn btn-light text-mid info">Register</button>
    <div id="div"></div>
    <a href="home.php" class="text-mid info">Browse without account</a>
</form>
<!--registerForm end-->

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
<script src="../js/registerValidity.js"></script>

</body>
</html>