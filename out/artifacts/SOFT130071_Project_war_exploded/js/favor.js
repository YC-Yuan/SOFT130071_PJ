button = document.getElementById('button');
favor = document.getElementById('favor');
favorNum = document.getElementById('favorNum');

button.addEventListener("click", function () {
    let isFavored = favor.innerText === "Favored";//得到是否已经收藏
    let info = button.getAttribute("name");//name中左边为UID右边为imgId
    let infos = info.split("&");
    let UID = infos[0];
    let imgId = infos[1];
    //根据现有状态，让数据库操作
    let request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === 4 && request.status === 200) {//数据库操作完毕后响应
            console.log(request.responseText);
            info = request.responseText;
            infos = info.split("&");//infos[0]为成功信息，infos[1]为现有收藏数
            console.log(infos[0]);
            if (infos[0] === "true") {//成功，更改收藏图标和信息
                if (isFavored) {//原本收藏，改为未收藏
                    favor.innerText = "Unfavored";
                    favor.className = "glyphicon glyphicon-star-empty";
                } else {
                    favor.innerText = "Favored";
                    favor.className = "glyphicon glyphicon-star";
                }
                favorNum.innerText = "FavorNumber：" + infos[1];
            } else alert('操作失败，请重试');

        }
    };
    console.log("../php/changeFavor.php?change=" + isFavored + "&UID=" + UID + "&imgId=" + imgId);
    request.open("GET", "../php/changeFavor.php?change=" + isFavored + "&UID=" + UID + "&imgId=" + imgId, true);
    request.send();
}, false);
