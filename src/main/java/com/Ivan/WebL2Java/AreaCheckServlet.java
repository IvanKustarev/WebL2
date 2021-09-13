package com.Ivan.WebL2Java;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "AreaCheckServlet", value = "/AreaCheckServlet")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        float x = 0;
        float y = 0;
        float r = 0;
        try {
            x = Float.valueOf(request.getParameter("X"));
            y = Float.valueOf(request.getParameter("Y"));
            r = Float.valueOf(request.getParameter("R"));
        } catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher(SentTo.INDEX.toString());
            dispatcher.forward(request, response);
        }
        boolean got = checkDot(x, y, r);
        addRequestParameters(x, y, r, got, request);
        modifyAreaImage(x, y, r, got, request.getSession());

        RequestDispatcher dispatcher = request.getRequestDispatcher("reply.jsp");
        dispatcher.forward(request, response);
    }

    private enum SentTo {
        AREA_CHECK {
            @Override
            public String toString() {
                return "/AreaCheckServlet";
            }
        },
        INDEX {
            @Override
            public String toString() {
                return "index.jsp";
            }
        }
    }

    private boolean checkDot(double x, double y, double r) {
        if (x > 0 && y > 0) {
            return false;
        }
        if (x <= 0 && y >= 0) {
            if (x >= -r && y <= r) {
                return true;
            } else {
                return false;
            }
        }
        if (x <= 0 && y <= 0) {
            if (-r * x - r - y <= 0) {
                return true;
            } else {
                return false;
            }
        }
        if (((Math.pow(x, 2) + Math.pow(y, 2)) <= r / 2)) {
            return true;
        }
        return false;
    }

    private void addRequestParameters(float x, float y, float r, boolean got, HttpServletRequest request) {
        request.setAttribute("got", got);
        String paramsString = null;
        if(got){
            paramsString = x + "," + y + "," + r + ",Да";
        }else {
            paramsString = x + "," + y + "," + r + ",Нет";
        }
        HttpSession session = request.getSession();
        if (session.getAttribute("lastRequests") == null) {
            session.setAttribute("lastRequests", paramsString);
        } else {
            session.setAttribute("lastRequests", paramsString + ";" + (String)(session.getAttribute("lastRequests")));
        }
    }

    private void modifyAreaImage(float x, float y, float r, boolean got, HttpSession session) {
        BufferedImage bImage = null;
        if (session.getAttribute("areaImage") == null) {
            bImage = loadImage();
        } else {
            bImage = (BufferedImage) session.getAttribute("areaImage");
        }
        if (got) {
            addDotToArea(bImage, x, y, r, Color.decode("#E61B43"));
        } else {
            addDotToArea(bImage, x, y, r, Color.gray);
        }

        session.setAttribute("areaImage", bImage);
    }

    private BufferedImage addDotToArea(BufferedImage bImage, float x, float y, float r, Color color) {
        int xPix = Math.round(140 * x / r);
        int yPix = Math.round(140 * y / r);

        int dotStartX = 0;
        int dotStartY = 0;
        int dotWidth = 0;
        int dotHeight = 0;
        dotStartX = bImage.getWidth() / 2 - 2 + xPix;
        if (bImage.getWidth() % 2 == 1) {
            dotWidth = 5;
        } else {
            dotWidth = 4;
        }
        dotStartY = bImage.getHeight() / 2 - 2 - yPix;
        if (bImage.getHeight() % 2 == 1) {
            dotHeight = 5;
        } else {
            dotHeight = 4;
        }
        Graphics graphics = bImage.getGraphics();
        graphics.setColor(color);
        graphics.fillRect(dotStartX, dotStartY, dotWidth, dotHeight);

        return bImage;
    }

    private BufferedImage loadImage() {
        BufferedImage bImage = null;
        try {
            bImage = ImageIO.read(new File("public_html/wildfly-24.0.1.Final/standalone/resources/area.png"));//give the path of an image
        } catch (IOException e1) {
            try {
                bImage = ImageIO.read(new File("area.png"));
            } catch (IOException e2) {
                System.out.println("Problem with areas image loading");
            }
        }

        return bImage;
    }
}
