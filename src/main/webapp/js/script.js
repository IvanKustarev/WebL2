let areaImage = document.getElementById("areaImage");
areaImage.onclick = function (e) {


    if (document.getElementById("R").value !== "") {

        let x = (e.x - areaImage.x - areaImage.width / 2) / 140 * (document.getElementById("R").value);
        let y = (areaImage.height / 2 - (e.y - areaImage.y)) / 140 * (document.getElementById("R").value);


        if (!validation(x, y)) {
            return;
        } else {
            console.log(document.getElementById("R").value)
            document.getElementById("X").value = x;
            document.getElementById("Y").value = y;

            let form = document.getElementById("mainForm");
            form.action = '/ControllerServlet';
            form.method = 'post';
            form.innerHTML = '<input name="X" value="' + x + '"><input name="Y" value="' + y + '"><input name="R" value="' + document.getElementById("R").value + '">';
            form.submit();
        }
    }
}

function validation() {

    return true;
}