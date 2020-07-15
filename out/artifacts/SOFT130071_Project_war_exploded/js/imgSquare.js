//说明：img用百分比设定宽度，则难以在明确规定高度的情况下保持宽高一致
//如何使用：给需要设定的img添加.squareImg
shapeSquare();

setTimeout(shapeSquare, 500);

function shapeSquare() {
    let img = document.getElementsByClassName('squareImg');
    for (let i = 0; i < img.length; i++) {
        let width = parseInt(window.getComputedStyle(img[i]).width);
        img[i].style.height = width.toString() + 'px';

        img[i].style.objectFit = "cover";
    }
}

window.addEventListener("resize", function () {
    shapeSquare();
}, false);
