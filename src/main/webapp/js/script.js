let areaImage = document.getElementById("areaImage");
areaImage.onclick = function (e) {


    if (document.getElementsByClassName("R")[0].value !== "") {


        let pos = $(this).offset();
        let elem_left = Math.round(pos.left);
        let elem_top = Math.round(pos.top);
        //from left top corner
        let xPix = Math.round(e.pageX - elem_left);
        let yPix = Math.round(e.pageY - elem_top);

        let x = (xPix - areaImage.width / 2) / 140 * (document.getElementsByClassName("R")[0].value);
        let y = (areaImage.height / 2 - yPix) / 140 * (document.getElementsByClassName("R")[0].value);

        x = x.toFixed(2);
        y = y.toFixed(2);

        if (!validation(x, y)) {
            return;
        } else {
            console.log(document.getElementsByClassName("R")[0].value)
            document.getElementsByClassName("X")[0].value = x;
            document.getElementsByClassName("Y")[0].value = y;

            let form = document.getElementById("mainForm");
            form.action = '/ControllerServlet';
            form.method = 'post';
            form.innerHTML = '<input name="X" value="' + x + '"><input name="Y" value="' + y + '"><input name="R" value="' + document.getElementsByClassName("R")[0].value + '">';
            form.submit();
        }
    }
}

function validation() {

    return true;
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