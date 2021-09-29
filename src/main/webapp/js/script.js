let areaImage = document.getElementById("areaImage");

areaImage.onclick = function (e) {
    clearErrFlags();
    if (document.getElementsByClassName("R")[0].value !== "") {
        let pos = $(this).offset();
        let elem_left = Math.round(pos.left);
        let elem_top = Math.round(pos.top);
        //from left top corner
        let xPix = Math.round(e.pageX - elem_left);
        let yPix = Math.round(e.pageY - elem_top);

        let r = document.getElementsByClassName("R")[0].value;
        r = replaceCommaToDot(r);
        document.getElementsByClassName("R")[0].value = r;

        let x = (xPix - areaImage.width / 2) / 140 * (r);
        let y = (areaImage.height / 2 - yPix) / 140 * (r);

        x = x.toFixed(2);
        y = y.toFixed(2);

        if (!validation(x, y, r)) {
            return;
        } else {
            console.log(document.getElementsByClassName("R")[0].value)
            document.getElementsByClassName("X")[0].value = x;
            document.getElementsByClassName("Y")[0].value = y;

            let form = document.getElementById("mainForm");
            form.innerHTML = '<input name="X" value="' + x + '"><input name="Y" value="' + y + '"><input name="R" value="' + document.getElementsByClassName("R")[0].value + '">';
            form.submit();
        }
    } else {
        printToErrOuter("Необходимо задать параметр R \n");
        document.getElementById("rParameterTitle").classList.add("errColor");
    }
}

function validation(x, y, r) {

    clearErrFlags();

    if (x === undefined && y === undefined && r === undefined) {
        x = document.getElementsByClassName('X')[0].value;
        r = document.getElementsByClassName('R')[0].value;
    }

    r = replaceCommaToDot(r);
    x = replaceCommaToDot(x);

    let isXValidate = tryXValidate(x);
    let isYValidate = tryYValidate(y);
    let isRValidate = tryRValidate(r);


    if (isXValidate && isYValidate && isRValidate) {
        return true;
    }
    return false;
}

function replaceCommaToDot(value) {
    let newValue = value.replace(",", ".");
    if (isNaN(newValue)) {
        return value;
    }
    return newValue;
}

function tryXValidate(x) {

    if (x === "") {
        printToErrOuter("Необходимо задать параметр X \n");
        document.getElementById("xParameterTitle").classList.add("errColor");
        return false;
    }
    if (isNaN(x)) {
        printToErrOuter("Параметр X должен являться числом \n");
        document.getElementById("xParameterTitle").classList.add("errColor");
        return false;
    }
    if ((String)(x).length > 17) {
        printToErrOuter("Слишком длинное число в поле X \n");
        document.getElementById("xParameterTitle").classList.add("errColor");
        return false;
    }
    if (!(-3 < parseFloat(x) && parseFloat(x) < 3)) {
        printToErrOuter("Параметр X должен быть в диапазоне (-3;3) \n");
        document.getElementById("xParameterTitle").classList.add("errColor");
        return false;
    }
    return true;
}

function tryYValidate(y) {
    if (y !== undefined) {
        if (!(-5 < parseFloat(y) && parseFloat(y) < 3)) {
            printToErrOuter("Параметр Y должен быть в диапазоне (-5;3) \n");
            document.getElementById("yParameterTitle").classList.add("errColor");
            return false;
        }
        return true;
    } else {
        let yRadios = document.documentElement.getElementsByClassName("Y");
        for (let yRadio of yRadios) {
            if (yRadio.checked) {
                return true;
            }
        }
        printToErrOuter("Необходимо задать параметр Y \n");
        document.getElementById("yParameterTitle").classList.add("errColor");
        return false;
    }
}

function tryRValidate(r) {
    if (r === "") {
        printToErrOuter("Необходимо задать параметр R \n");
        document.getElementById("rParameterTitle").classList.add("errColor");
        return false;
    }
    if (isNaN(r)) {
        printToErrOuter("Параметр R должен являться числом \n");
        document.getElementById("rParameterTitle").classList.add("errColor");
        return false;
    }
    if ((String)(r).length > 17) {
        printToErrOuter("Слишком длинное число в поле R \n");
        document.getElementById("rParameterTitle").classList.add("errColor");
        return false;
    }
    if (!(2 < parseFloat(r) && parseFloat(r) < 5)) {
        printToErrOuter("Параметр R должен быть в диапазоне (2;5) \n");
        document.getElementById("rParameterTitle").classList.add("errColor");
        return false;
    }
    return true;
}

function clearErrFlags() {
    //clear errOuter
    let errOuter = document.getElementById("errOuter");
    errOuter.innerText = "";

    let parameterTitles = document.getElementsByClassName("parameterTitle");
    for (let parameterTitle of parameterTitles) {
        parameterTitle.classList.remove("errColor");
        parameterTitle.classList.add("standardColor")
    }
}

function printToErrOuter(str) {
    let errOuter = document.getElementById("errOuter");
    errOuter.innerText += str;
}

let clearButton = document.getElementById("clearButton");
clearButton.onclick = function (e) {
    let input = document.createElement('input');
    let form = document.getElementById("clearForm");
    input.setAttribute('name', 'clear');
    input.setAttribute('value', 'true');
    input.setAttribute('type', "hidden")
    form.appendChild(input);
    form.submit();
}

let submitBlock = document.getElementById("submitBlock");
submitBlock.onclick = function (e) {
    document.getElementById("submitButton").click();
}

let clearBlock = document.getElementById("clearBlock");
clearBlock.onclick = function (e) {
    document.getElementById("clearButton").click();
}