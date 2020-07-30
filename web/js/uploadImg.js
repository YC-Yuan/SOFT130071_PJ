//img.file.title.content.country.city
let img = document.getElementById("uploadedImg");

let file = document.getElementById("file");
file.addEventListener("change", uploadImg, false);

let title = document.getElementById('title');
let content = document.getElementById('content');
let country = document.getElementById('country');
let city = document.getElementById('city');

let checkValidity = document.getElementById('checkValidity');
let modal = document.getElementById('modal');
let submit = document.getElementById('submit');
let form=document.getElementById('form');

let hasCityName = false;
if (city.value !== '') hasCityName = true;
let hasCountryName = false;
if (country.value !== '') hasCountryName = true;

let infoCity = 'Please enter the city';
let infoCountry = 'Please enter the country';

country.addEventListener("input", function () {//检测国家名合法性
    let countryName = country.value;
    if (countryName === '') infoCountry = 'Please enter country';
    else {
        //检测数据库中是否存在
        let request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (request.readyState === 4 && request.status === 200) {
                console.log(request.responseText);
                if (request.responseText === 'true') hasCountryName = true;
                else {//国家名不合法
                    hasCountryName = false;
                    if (request.responseText === 'false') {//不合法，且模糊查询失败
                        infoCountry = 'Unrecognizable country,try again';
                    } else {
                        let infos = request.responseText.split('|');
                        let info = 'You may want:';
                        for (let i = 0; i < infos.length; i++) {
                            info += (i + 1) + ":" + infos[i];
                            if (i + 1 !== infos.length) info += " |or| ";
                        }
                        infoCountry = info;
                        console.log(info);
                    }
                }
            }
        };
        request.open("GET", "checkCountryName?countryName=" + countryName, true);
        request.send();
    }
}, false);

city.addEventListener("input", function () {//检测是城市名合法性
    let countryName = country.value;
    let cityName = city.value;
    if (hasCountryName === false) return;
    if (cityName === '') infoCity = 'Please enter city';
    else {
        //检测数据库中是否存在
        let request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (request.readyState === 4 && request.status === 200) {
                console.log(request.responseText);
                if (request.responseText === 'true') hasCityName = true;
                else {//城市名不合法
                    hasCityName = false;
                    if (request.responseText === 'false') {//不合法，且模糊查询失败
                        infoCity = 'Unrecognizable city,try again';
                    } else {
                        let infos = request.responseText.split('|');
                        let info = 'You may want:';
                        for (let i = 0; i < infos.length; i++) {
                            info += (i + 1) + ":" + infos[i];
                            if ((i + 1) !== infos.length) info += " |or| ";
                        }
                        infoCity = info;
                        console.log(info);
                    }
                }
            }
        };
        request.open("GET", "checkCityName?cityName=" + cityName + "&countryName=" + countryName, true);
        request.send();
    }
}, false);

form.addEventListener("keypress", function (e) {
    if(e.key==="Enter"){
    // console.log("enter pressed!");
    e.preventDefault();
    checkValidity.click();
    }
},false);

checkValidity.addEventListener("click", function (e) {
    //img必须要有
    let imgSrc = img.getAttribute('src');
    if (imgSrc === null) file.setCustomValidity('Please upload a photo');
    else file.setCustomValidity('');

    //Title要有
    let titleName = title.value;
    if (titleName === '') title.setCustomValidity('Please input the title');
    else title.setCustomValidity('');

    //content要有
    let contentName = content.value;
    if (contentName === '') content.setCustomValidity('Please input the content');
    else content.setCustomValidity('');

    //city和country合法
    if (hasCountryName) country.setCustomValidity('');
    else country.setCustomValidity(infoCountry);

    if (hasCityName) city.setCustomValidity('');
    else city.setCustomValidity(infoCity);

    if(img==null||file.validationMessage===''
        &&file.validationMessage===''
        &&title.validationMessage===''
        &&content.validationMessage===''
        &&city.validationMessage===''
        &&country.validationMessage===''){//通过的话，阻止上传，点开模态框
        modal.click();
        e.preventDefault();
    }
}, false);

function uploadImg(e) {
    //input是一个file对象， file对象不能直接展示的
    const input = e.target;
    //console.log(input);
    let photo = input.files[0];
    //console.log(file);
    //用fileReader从file对象读取文件，转成img标签可用格式
    let reader = new FileReader();
    reader.readAsDataURL(photo);
    //因为文件读取是一个耗时操作， 所以它在回调函数中，才能够拿到读取的结果
    reader.onload = function () {
        img.src = reader.result;
        //修改图片与样式#uploadImg
        img.style.display = "block";
        file.innerText = 'Change the photo';
    };
}