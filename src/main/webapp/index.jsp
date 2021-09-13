<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.awt.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>WebL2</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header>
    <div>Кустарев Иван Павлович P3215</div>
    <div>Вариант 15012</div>
</header>
<table>
    <form id="mainForm" action="/ControllerServlet" onsubmit="return validation()" method="post">
        <%
            BufferedImage bImage = null;
            if (session.getAttribute("areaImage") == null) {
                try {
                    bImage = ImageIO.read(new File("public_html/wildfly-24.0.1.Final/standalone/resources/area.png"));
                } catch (IOException e1) {
                    try {
                        bImage = ImageIO.read(new File("area.png"));
                    } catch (IOException e2) {
                        out.println("Problem with areas image loading");
                    }
                }
            } else {
                bImage = (BufferedImage) session.getAttribute("areaImage");
            }

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bImage, "png", baos);
            baos.flush();
            byte[] imageInByteArray = baos.toByteArray();
            baos.close();
            String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
        %>
        <tr>
            <td>
                <img id="areaImage" style="border: 2px solid" src="data:image/jpg;base64, <%=b64%>"
                     alt="Здесь должна быть картинка области"/>
            </td>
        <tr>
        <tr>
            <td>
                <input name="X" class="X" type="text">
            </td>
        </tr>

        <tr>
            <td>
                <input name="Y" class="Y" type="radio" value="-5">
                <input name="Y" class="Y" type="radio" value="-4">
                <input name="Y" class="Y" type="radio" value="-3">
                <input name="Y" class="Y" type="radio" value="-2">
                <input name="Y" class="Y" type="radio" value="-1">
                <input name="Y" class="Y" type="radio" value="0">
                <input name="Y" class="Y" type="radio" value="1">
                <input name="Y" class="Y" type="radio" value="2">
                <input name="Y" class="Y" type="radio" value="3">
            </td>
        </tr>
        <tr>
            <td>
                <input name="R" class="R" type="text">
            </td>
        </tr>
        <tr>
            <td>
                <button type="submit">submit</button>
            </td>
            <td>
                <button type="button" id="clearButton">clear</button>
            </td>
        </tr>
    </form>
    <form id="clearForm" action="/ControllerServlet" method="post">
    </form>
    <%
        if (request.getSession().getAttribute("lastRequests") != null) {
            out.print("<tr><td>");
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
            out.print("</td></tr>");
        }
    %>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="js/script.js"></script>
</table>
</body>
</html>