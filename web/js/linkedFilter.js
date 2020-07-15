//拿到国家筛选框，给予事件绑定函数
let countrySelect = document.getElementById('selectCountry');
let citySelect = document.getElementById('selectCity');
countrySelect.addEventListener("change", linkCity, false);

//修改filterButton的链接
let contentSelect = document.getElementById('selectContent');
let filterButton = document.getElementById('filterButton');

contentSelect.addEventListener("change", changeLink, false);
countrySelect.addEventListener("change", changeLink, false);
citySelect.addEventListener("change", changeLink, false);

//函数内容：拿到选择的国家，向ajax请求对应城市，将城市添加到第三个（如果没选则清空）
function linkCity() {
    let index = countrySelect.selectedIndex;
    let country = countrySelect.options[index].value;
    citySelect.length = 1;
    if (index !== 0) {
        let request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (request.readyState === 4 && request.status === 200) {
                let info = request.responseText.split("|");//info为"城市代码&城市名字"
                for (let i = 0; i < info.length; i++) {
                    if (info[i] !== 'null') {
                        let infos = info[i].split('&');
                        let cityCode = infos[0];
                        let cityName = infos[1];
                        citySelect[citySelect.length] = new Option(cityName, cityCode);
                    }
                }
            }
        };
        request.open("GET", "../php/linkedFilter.php?country=" + country, true);
        request.send();
    }
}

function changeLink() {
//拿到筛选框内容
    let content = contentSelect.options[contentSelect.selectedIndex].value;
    let country = countrySelect.options[countrySelect.selectedIndex].value;
    let city = citySelect.options[citySelect.selectedIndex].value;

    let link = 'browser.php?';
    //key首字母小写以与单字段筛选区分
    if (content !== '0') link += 'content=' + content + '&';
    if (country !== '0') link += 'country=' + country + '&';
    if (city !== '0') link += 'city=' + city + '&';

    //alert(link);

    filterButton.onclick = function () {
        window.location.href = link;
    }
}