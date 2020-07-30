form = document.getElementById("form");
code = document.getElementById("verificationCode");
verificationImg = document.getElementById("verificationImg")
submit = document.getElementById("submit");

let realCode;

input = document.getElementById("password");

form.addEventListener("submit", function (e) {
    let inputCode = code.value;
    // console.log("inputCode=" + inputCode);
    // console.log("realCode=" + realCode);
    // console.log("check：" + (inputCode === realCode))
    if (inputCode !== realCode) {
        e.preventDefault();
        verificationImg.click();
        code.value="";
        alert("Wrong verification code!");
    }else input.value=sha1(input.value);
}, false);

// submit.onclick = function (e) {//提交时检验验证码，正确则继续
//     let inputCode = code.value;
//     console.log("inputCode=" + inputCode);
//     console.log("realCode=" + realCode);
//     console.log("check：" + (inputCode === realCode))
//     if (inputCode !== realCode) {
//         e.preventDefault();
//         verificationImg.click();
//         alert("Wrong verification code!")
//     }
// }

verificationImg.onclick = function changeVerificationImage(e) {
    verificationImg.src = "verificationCode?time=" + new Date().getTime();
}

verificationImg.onload = function () {
    refreshRealCode();
}

function refreshRealCode() {
    let xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            realCode = xhr.responseText;
            console.log("Img changed! RealCode=" + realCode);
        }
    }
    xhr.open("get", "checkVerificationCode", true);
    xhr.send();
}