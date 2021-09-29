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
    <link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body class="standardColor">
<header class="centering">
    <h1><span>Кустарев Иван Павлович P3215<br>
        Вариант 15112</span></h1>
</header>
<table class="centering">
    <form id="mainForm" action="/lab2/ControllerServlet"
          onsubmit="return validation()"
          method="post">
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
            <td class="menuBlock" rowspan="4">
                <img id="areaImage" src="data:image/jpg;base64, <%=b64%>"
                     alt="Здесь должна быть картинка области"/>
            </td>
            <td class="menuBlock" rowspan="1">
                <h2>
                <span id="xParameterTitle" class="parameterTitle">
                    Параметр X
                </span>
                </h2>
                <input name="X" class="X textField" type="text" placeholder="-3;3">
            </td>
            <td class="menuBlock" rowspan="2">
                <h2>
                <span id="yParameterTitle" class="parameterTitle">
                    Параметр Y
                </span>
                </h2>
                <table class="centering">
                    <tr>
                        <td>
                            <h3>-5</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-5">
                        </td>
                        <td>
                            <h3>-2</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-2">
                        </td>
                        <td>
                            <h3>1</h3>
                        </td>
                        <td>
                            <input name="Y" class="Y" type="radio" value="1">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3>-4</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-4">
                        </td>
                        <td>
                            <h3>-1</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-1">
                        </td>
                        <td>
                            <h3>2</h3>
                        </td>
                        <td>
                            <input name="Y" class="Y" type="radio" value="2">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3>-3</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-3">
                        </td>
                        <td>
                            <h3>0</h3>
                        </td>
                        <td class="rightBorder">
                            <input name="Y" class="Y" type="radio" value="-0">
                        </td>
                        <td>
                            <h3>3</h3>
                        </td>
                        <td>
                            <input name="Y" class="Y" type="radio" value="3">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="menuBlock" rowspan="1">
                <h2>
                <span id="rParameterTitle" class="parameterTitle">
                    Параметр R
                </span>
                </h2>
                <% if (request.getSession().getAttribute("R") != null) {
                    out.print("<input name=\"R\" class=\"R textField\" type=\"text\" placeholder=\"2;5\" value=\"" + request.getSession().getAttribute("R") + "\">");
                } else {
                    out.print("<input name=\"R\" class=\"R textField\" type=\"text\" placeholder=\"2;5\">");
                }%>
            </td>
        </tr>
        <tr>
            <td id="submitBlock" class="menuBlock lightMenuBlock" colspan="2">
                <table class="centering">
                    <tr>
                        <td>
                            <div id="errOuter" class="errColor centering"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="submitButton" type="submit" class="buttonWithoutStyle centering standardColor">
                                <h2>Проверить</h2>
                            </button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td id="clearBlock" class="menuBlock lightMenuBlock" colspan="2">
                <button id="clearButton" type="button" id="clearButton"
                        class="buttonWithoutStyle centering standardColor"><h2>
                    Очистить</h2></button>
            </td>
        </tr>
    </form>
    <form id="clearForm" action="/lab2/ControllerServlet " method="post"></form>

    <%
        if (request.getSession().getAttribute("lastRequests") != null) {
            out.print("<tr><td class=\"menuBlock\" colspan = \"3\">");
            out.print("<div class=\"centering fillingAllAreaWidth tableHead\">\n" +
                    "        <h2>Прошлые запросы</h2>\n" +
                    "    </div>");
            out.print("<table class=\"centering fillingAllAreaWidth\">");
            String lastRequests = (String) (request.getSession().getAttribute("lastRequests"));
            String[] requests = lastRequests.split(";");
            out.print("<tr><td><h3>X</h3></td><td><h3>Y</h3></td><td><h3>R</h3></td><td><h3>Изначально попала</h3></td></tr>");
            for (String req : requests) {
                out.print("<tr class=\"centering\">");
                String[] reqParameters = req.split(",");
                for (String param : reqParameters) {
                    out.print("<td><h3>" + param + "</h3></td>");
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