package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import Model.User;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import utils.GooglePojo;
import utils.GoogleUtils;

//@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginGoogleServlet() {
        super();
    }

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
        String code = request.getParameter("code");
        String username = request.getParameter("Username");
        String password = request.getParameter("password");
        String rem = request.getParameter("rem");
        Cookie cuser = new Cookie("cuser", username);
        Cookie cpass = new Cookie("cpass", password);
        Cookie crem = new Cookie("crem", rem);
        if(rem!=null){
            cuser.setMaxAge(60*60*7*24);
            cpass.setMaxAge(60*60*7*24);
            crem.setMaxAge(60*60*7*24);
        }else{
            cuser.setMaxAge(0);
            cpass.setMaxAge(0);
            crem.setMaxAge(0);
        }
        response.addCookie(crem);
        response.addCookie(cuser);
        response.addCookie(cpass);

        if (code != null && !code.isEmpty()) {
            // Xử lý đăng nhập bằng Google
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
            request.setAttribute("id", googlePojo.getId());
            request.setAttribute("name", googlePojo.getName());
            request.setAttribute("email", googlePojo.getEmail());
            UserDAO userDAO = new UserDAO();
            User u = userDAO.loginByGoogle(googlePojo.getEmail());

            if (u == null || u.isStatus() == false) {
                request.setAttribute("mess", "Your account doesn't have permission to login");
                RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
                dis.forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", u);
                session.setMaxInactiveInterval(60 * 60);
                response.sendRedirect("home");
            }
        } else if (username != null && password != null) {
            // Xử lý đăng nhập thông thường
            UserDAO userDAO = new UserDAO();
            User u = userDAO.login(username, password);
            if (u == null) {
                request.setAttribute("mess", "Wrong email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else if (u.isStatus() == false) {
                request.setAttribute("mess", "Your account doesn't have permission to login");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", u);
                session.setMaxInactiveInterval(60 * 60);
                response.sendRedirect("home");
            }
        } else {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
