<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reply</title>
    <link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body class="standardColor">
<header class="centering">
    <h1><span>Кустарев Иван Павлович P3215<br>
        Вариант 15112</span></h1>
</header>
<table class="centering">
    <tr>
        <td class="menuBlock" width="50%" height="33">
        <span>
            X:
            <%= String.valueOf(request.getParameter("X")) %>
        </span>
        </td>
        <td class="menuBlock" width="50%" height="33">
        <span>
            R:
            <%= String.valueOf(request.getParameter("R")) %>
        </span>
        </td>
    </tr>

    <tr>
        <td class="menuBlock" width="50%" height="33">
        <span>
            Y:
            <%= String.valueOf(request.getParameter("Y")) %>
        </span>
        </td>
        <td class="menuBlock" width="50%" height="33">
        <span>
            Попала:
            <%
                if ((Boolean) request.getAttribute("got")) {
                    out.print("Да");
                } else {
                    out.print("Нет");
                }
            %>
        </span>
        </td>
    </tr>
    <tr>
        <td id="toMainInReply" class="menuBlock" colspan="2" height="34">
            <span class="standardColor">На главную</span>
        </td>
    </tr>
</table>
<script src="js/replyScript.js"></script>
</body>
</html>
