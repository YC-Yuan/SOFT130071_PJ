form = document.getElementById("form");
input = document.getElementById("password");
input.addEventListener("input", function () {
    console.log(sha1(input.value));
},false);
form.addEventListener("submit", function () {
    input.value=sha1(input.value);
    console.log(input.value);
}, false);