<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>3Fish1tea-Login</title>

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
<img src="../../img/icon/3Fish1Tea.png" alt="登录">
<h1 class="title text-big">Welcome to 3Fish1Tea</h1>
<h3 class="title text-sm">Share photos you love!</h3>

<!--loginForm begin-->
<?php
session_start();
require_once("../php/config.php");
$UID = '';
$login = true;
function validLogin()
{
    $pdo = new PDO(DBCONNSTRING, DBUSER, DBPASS);

    $sql = "SELECT * FROM traveluser WHERE UserName=:name";

    $statement = $pdo->prepare($sql);
    $statement->bindValue(':name', $_POST['name']);
    $statement->execute();

    if ($statement->rowCount() < 1) {
        echo '<script>alert("用户名或密码错误，请重试")</script>';
        return false;
    }
    $user = $statement->fetch();
    $passSalt = $user['Pass'];
    $salt = $user['Salt'];
    $password = $_POST['pass'];

    if ($passSalt == sha1($password . $salt)) {
        global $UID;
        $UID = $user['UID'];
        return true;
    }
    echo '<script>alert("用户名或密码错误，请重试")</script>';
    return false;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {//提交登录
    if (validLogin()) {//成功登陆
        $_SESSION['UID'] = $UID;
        header("Location:./home.php");
    } else {
        $login = false;
    }
}
?>
<form class="bd-form" method="post" role="form">
    <div class="form-group">
        <label for="userName" class="info text-mid">UserName</label>
        <input type="text" class="form-control" id="userName" name="name" placeholder="your userName here" required>
    </div>
    <div class="form-group">
        <label for="password" class="info text-mid">Password</label>
        <input type="password" class="form-control" id="password" name="pass" placeholder="your password here" required>
    </div>
    <button type="submit" id="submit" class="btn btn-light"><span class="info text-mid">Login</span></button>
    <hr>
    <h2 class="text-mid">No account? <a href="register.php" class="text-mid info">Click to register</a></h2>
    <a href="home.php" class="text-mid info">Browse without account</a>
</form>
<!--loginForm end-->

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
</body>
</html>