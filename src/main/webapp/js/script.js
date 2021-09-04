let areaImage = document.getElementById("areaImage");
areaImage.onclick = function (e){
    let imageCoords = getElementCoords(areaImage);
    let xOnImage = e.x - imageCoords.left;
    let yOnImage = e.y - imageCoords.top;

    console.log(xOnImage + " " + yOnImage);
}

function getElementCoords(elem) { // кроме IE8-
    var box = elem.getBoundingClientRect();

    return {
        top: box.top + pageYOffset,
        left: box.left + pageXOffset
    };

}