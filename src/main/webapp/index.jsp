<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>WebL2</title>
</head>
<body>
<form action="/ControllerServlet" method="post">

    <img src="areas.png" alt="Здесь должна быть картинка области" id="areaImage">

    <input name="X" type="text">

    <input name="Y" type="radio" value="-5">
    <input name="Y" type="radio" value="-4">
    <input name="Y" type="radio" value="-3">
    <input name="Y" type="radio" value="-2">
    <input name="Y" type="radio" value="-1">
    <input name="Y" type="radio" value="0">
    <input name="Y" type="radio" value="1">
    <input name="Y" type="radio" value="2">
    <input name="Y" type="radio" value="3">

    <input name="R" type="text">

    <button type="submit">submit</button>
</form>
<%
    if (request.getSession().getAttribute("lastRequests") != null) {
        out.print("<table>");
        String lastRequests = (String) (request.getSession().getAttribute("lastRequests"));
        String[] requests = lastRequests.split(";");
        for (String req : requests) {
            out.print("<tr>");
            String[] reqParameters = req.split(",");
            for (String param : reqParameters) {
                out.print("<td>" + param + "</td>");
            }
            out.print("</tr>");
        }
        out.print("</table>");
    }
%>

<script src="js/script.js"></script>
</body>
</html>