package com.Ivan.WebL2Java;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AreaCheckServlet", value = "/AreaCheckServlet")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double x = Float.valueOf(request.getParameter("X"));
        double y = Float.valueOf(request.getParameter("Y"));
        double r = Float.valueOf(request.getParameter("R"));
        boolean got = checkDot(x, y, r);
        request.setAttribute("got", got);

        String paramsString = x + "," + y + "," + r + "," + got;
        HttpSession session = request.getSession();
        if(session.getAttribute("lastRequests") == null){
            session.setAttribute("lastRequests", paramsString);
        }else {
            session.setAttribute("lastRequests", (String) (session.getAttribute("lastRequests")) + ";" + paramsString);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("reply.jsp");
        dispatcher.forward(request, response);
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
//            y = -Rx -R - уравнение прямой
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
}
