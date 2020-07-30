userName = document.getElementById('userName');
email = document.getElementById('e-mail');
password = document.getElementById("password");
passwordConfirm = document.getElementById("passwordConfirm");
submit = document.getElementById("submit");
strength = document.getElementById("passwordStrength");


let repetition = false;

userName.addEventListener("input", function () {
    //检测用户名重复性
    let xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            let result = xhr.responseText;
            repetition = result==="exist";

            console.log(repetition);
        }
    }
    xhr.open("get", "checkNameExistence?userName=" + userName.value, true);
    xhr.send();
});

email.addEventListener("input", function () {
    this.setCustomValidity('');
});
password.addEventListener("input", function () {
    this.setCustomValidity('');
});

password.addEventListener("input", function () {
    let passValue = password.value;
    let score = 0;
    score += passValue.length;

    let category = 0;
    let reg = /[0-9]/;
    if (reg.test(passValue)) category++;
    reg = /[a-z]/;
    if (reg.test(passValue)) category++;
    reg = /[A-Z]/;
    if (reg.test(passValue)) category++;
    reg = /[^a-zA-Z0-9]/;
    if (reg.test(passValue)) category++;

    score *= Math.pow(2, category - 1);
    if (score <= 12) {//弱
        strength.innerText = 'Weak';
        strength.className = "progress-bar bg-danger";
        strength.style.width = "25%";
    } else if (score <= 24) {//中
        strength.innerText = 'Medium';
        strength.className = "progress-bar bg-warning";
        strength.style.width = "50%";
    } else if (score <= 48) {//强
        strength.innerText = 'Strong';
        strength.className = "progress-bar bg-info";
        strength.style.width = "75%";
    } else {//很强
        strength.innerText = 'Very Safe';
        strength.className = "progress-bar bg-success";
        strength.style.width = "100%";
    }
    console.log(score);

}, false);

submit.addEventListener("click", function () {
//检测用户名合法性
    let text = userName.value;
    let reg = /^\w{4,15}$/;
    if (!reg.test(text)) {
        userName.setCustomValidity('请输入4-15个字母、数字、_组成的用户名');
        return;
    } else
        if (repetition) {
        userName.setCustomValidity('用户名重复，请重新输入');
    } else
        {
        userName.setCustomValidity('');
    }

    //检测密码长度
    text = password.value;
    reg = /^\w{6,12}$/;
    if (!reg.test(text)) {
        password.setCustomValidity('请输入6-12位的密码');
        return;
    } else password.setCustomValidity('');

    //检测密码一致
    if (!(password.value === passwordConfirm.value)) passwordConfirm.setCustomValidity('请确保与密码一致');
    else passwordConfirm.setCustomValidity('');

}, false);

