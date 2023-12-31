/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class ConfirmKey extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConfirmKey</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmKey at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        String email = request.getParameter("email");
        String forgot_key = request.getParameter("forgot_key");
        HttpSession session = request.getSession();
        
        UserDAO dao = new UserDAO();
        if (session.getAttribute("email") == null) {
            request.setAttribute("mess", "Time out");
            request.getRequestDispatcher("forgotPass.jsp").forward(request, response);
        } else {
            if (dao.checkForgotKeyExist(email, forgot_key) == false) {
                request.setAttribute("mess", "Key is not existing on the system");
                request.getRequestDispatcher("confirmForgotKey.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("changePasswordForgot.jsp").forward(request, response);
            }
        }
        System.out.println(email);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String forgot_key = request.getParameter("forgot_key");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        UserDAO dao = new UserDAO();
        if (session.getAttribute("email") == null) {
            request.setAttribute("mess", "Time out");
            request.getRequestDispatcher("forgotPass.jsp").forward(request, response);
        } else {
            if (dao.checkForgotKeyExist(email, forgot_key) == false) {
                request.setAttribute("mess", "Key is not existing on the system");
                request.getRequestDispatcher("confirmForgotKey.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("changePasswordForgot.jsp").forward(request, response);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
