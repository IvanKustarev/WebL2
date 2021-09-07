<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>WebL2</title>
</head>
<body>
<form action="/ControllerServlet" method="post">

<%--    <img src="area.png" alt="Здесь должна быть картинка области" id="areaImage">--%>

    <%
//        File file = new File("aaa.txt");
//        out.println(file.getAbsolutePath());

        BufferedImage bImage = null;
        try {
            bImage = ImageIO.read(new File("public_html/wildfly-24.0.1.Final/standalone/resources/area.png"));//give the path of an image
        }catch (IOException e1){
            try {
                bImage = ImageIO.read(new File("area.png"));
            }catch (IOException e2){
                out.println("Problem with areas image loading");
            }
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write( bImage, "png", baos );
        baos.flush();
        byte[] imageInByteArray = baos.toByteArray();
        baos.close();
        String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
    %>

    <img src="data:image/jpg;base64, <%=b64%>" alt="Здесь должна быть картинка области" />

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