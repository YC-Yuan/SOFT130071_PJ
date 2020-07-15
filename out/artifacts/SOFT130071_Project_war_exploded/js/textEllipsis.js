//使用说明：将需要省略的文本设定为"content-ellipsis"class,其容器设定为"container-ellipsis"class
changeLine();

window.addEventListener("resize", changeLine, false);

function changeLine() {
    //console.log("changeLine called");
    let container = document.getElementsByClassName('container-ellipsis');
    let content = document.getElementsByClassName('content-ellipsis');
    for (let i = 0; i < content.length; i++) {
        let containerStyle = window.getComputedStyle(container[i]);
        let contentStyle = window.getComputedStyle(content[i]);
        let height = parseInt((containerStyle).height);
        height -= parseInt((containerStyle).paddingTop);
        height -= parseInt((containerStyle).paddingBottom);
        //console.log("height for container is " + height);
        //此时height为容器可用高度
        let children = container[i].children;
        //console.log(children.length);
        for (let j = 0; j < children.length; j++) {
            if (children[j] !== content[i]) {
                let childrenStyle = window.getComputedStyle(children[j]);
                height -= parseInt(childrenStyle.height);
                height -= parseInt(childrenStyle.marginTop);
                height -= parseInt(childrenStyle.marginBottom);
                // console.log("height:"+childrenStyle.height+" m-top:"+childrenStyle.marginTop+" m-bottom:"+childrenStyle.marginBottom);
                // console.log("height after children " + j + children[j].textContent +" considered is " + height);
            }
        }
        //此时height为文本元素可用高度
        height -= (parseInt(contentStyle.marginTop));
        height -= (parseInt(contentStyle.marginBottom));
        height -= (parseInt(contentStyle.paddingTop));
        height -= (parseInt(contentStyle.paddingBottom));
        //console.log("p-top:"+contentStyle.paddingTop+"p-bottom:"+contentStyle.marginBlockEnd+" m-top:"+contentStyle.marginTop+" m-bottom:"+contentStyle.marginBottom);
        //console.log("height for text is " + height);
        //此时高度为文本内容可用高度
        let line = Math.floor(height / parseFloat(contentStyle.lineHeight));
        content[i].style.webkitLineClamp = line.toString();
        //console.log("final line number is " + line);
        content[i].style.margin = "0px";
        content[i].style.paddingBottom="4px";
    }
}