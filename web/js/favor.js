button = document.getElementById('button');
favor = document.getElementById('favor');
favorNum = document.getElementById('favorNum');

button.addEventListener("click", function (e) {
        let isFavored = favor.innerText === "Favored";//得到是否已经收藏
        let info = button.getAttribute("name");//name中左边为UID右边为imgId
        let infos = info.split("&");
        let UID = infos[0];
        let imgId = infos[1];
        //根据现有状态，让数据库操作
        let request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (request.readyState === 4 && request.status === 200) {//数据库操作完毕后响应
                info = request.responseText;
                console.log("info=" + info);
                if (isFavored) {//原本收藏，改为未收藏
                    favor.innerText = "Unfavored";
                    favor.className = "glyphicon glyphicon-star-empty";
                } else {
                    favor.innerText = "Favored";
                    favor.className = "glyphicon glyphicon-star";
                }
                favorNum.innerText = "FavorNumber：" + info;
            }
        }
        request.open("GET", "favorButton?change=" + isFavored + "&UID=" + UID + "&imgId=" + imgId, true);
        request.send();
    },
    false);
