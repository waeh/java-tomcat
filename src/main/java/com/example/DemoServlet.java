package com.example;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DemoServlet", urlPatterns = {"/", "/home", "/error", "/fault"})
public class DemoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/":
            case "/home":
                handleHome(request, response);
                break;
            case "/error":
                handleError(request, response);
                break;
            case "/fault":
                handleFault(request, response);
                break;
            default:
                handleNotFound(request, response);
                break;
        }
    }

    private void handleHome(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        out.println("<html><body>");
        out.println("<h1>Welcome to the Home Page</h1>");
        out.println("</body></html>");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Simulated Server Error");
    }

    private void handleFault(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        throw new RuntimeException("Simulated Fault");
    }

    private void handleNotFound(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page Not Found");
    }
}
