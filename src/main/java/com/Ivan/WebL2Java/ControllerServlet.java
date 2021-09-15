package com.Ivan.WebL2Java;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

//@WebServlet(name = "ControllerServlet", value = "ControllerServlet")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(SentTo.INDEX.toString());
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(isClearRequest(request)){
            HttpSession session = request.getSession();
            session.removeAttribute("lastRequests");
            session.removeAttribute("areaImage");
        }

        if (isValidateRequest(request)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher(SentTo.AREA_CHECK.toString());
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher(SentTo.INDEX.toString());
            dispatcher.forward(request, response);
        }
    }


    private enum SentTo {
        AREA_CHECK {
            @Override
            public String toString() {
                return "AreaCheckServlet";
            }
        },
        INDEX {
            @Override
            public String toString() {
                return "index.jsp";
            }
        }
    }

    private boolean isValidateRequest(HttpServletRequest request) {
        float x = 0;
        float y = 0;
        float r = 0;

        if (request.getParameter("X") != null && request.getParameter("Y") != null && request.getParameter("R") != null) {
            try {
                x = Float.valueOf(request.getParameter("X"));
                y = Float.valueOf(request.getParameter("Y"));
                r = Float.valueOf(request.getParameter("R"));
            } catch (Exception e) {
                return false;
            }
        } else {
            return false;
        }

        return true;
    }

    private boolean isClearRequest(HttpServletRequest request){
        if(request.getParameter("clear") != null){
            if(Boolean.valueOf(request.getParameter("clear"))){
                return true;
            }
        }
        return false;
    }
}
