<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Ivan
  Date: 04.09.2021
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
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
        <td class="menuBlock">
        <span>
            X:
            <%= String.valueOf(request.getParameter("X")) %>
        </span>
        </td>
    </tr>

    <tr>
        <td class="menuBlock">
        <span>
            Y:
            <%= String.valueOf(request.getParameter("Y")) %>
        </span>
        </td>
    </tr>
    <tr>
        <td class="menuBlock">
        <span>
            R:
            <%= String.valueOf(request.getParameter("R")) %>
        </span>
        </td>
    </tr>
    <tr>
        <td class="menuBlock">
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
        <td class="menuBlock">
            <a href="/ControllerServlet"><span>На главную</span></a>
        </td>
    </tr>
</table>
</body>
</html>
